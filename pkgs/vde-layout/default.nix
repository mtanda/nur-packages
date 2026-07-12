# Version Update Flow:
#
# Auto-updated:
#   - nvfetcher.toml src.manual (version) - by Renovate
#   - _sources/generated.nix (source hash) - by nvfetcher
#   - README.md packages table - by sync-readme
#
# Manual update required:
#   - pnpmDeps.hash below - only when pnpm-lock.yaml changes
#   - If unchanged: CI passes, auto-merge
#   - If changed: CI fails, manually update hash
{
  lib,
  stdenv,
  nodejs,
  pnpm,
  pnpmConfigHook,
  fetchPnpmDeps,
  makeWrapper,
  sources,
}:
stdenv.mkDerivation (finalAttrs: {
  inherit (sources.vde-layout) pname version src;

  nativeBuildInputs = [
    nodejs
    pnpm
    pnpmConfigHook
    makeWrapper
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-1Y7u0SfQS1tRTiwrM+/lCnP24d/Ye+tum2UtLO9jmMI=";
    fetcherVersion = 4;
  };

  buildPhase = ''
    runHook preBuild
    pnpm run build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vde-layout
    cp -r dist node_modules package.json bin $out/lib/vde-layout/

    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/vde-layout \
      --add-flags "$out/lib/vde-layout/bin/vde-layout"

    runHook postInstall
  '';

  meta = {
    description = "CLI that reproduces tmux or WezTerm terminal layouts from YAML presets";
    homepage = "https://github.com/yuki-yano/vde-layout";
    license = lib.licenses.mit;
    mainProgram = "vde-layout";
    platforms = lib.platforms.all;
  };
})
