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
  inherit (sources.difit) pname version src;

  nativeBuildInputs = [
    nodejs
    pnpm
    pnpmConfigHook
    makeWrapper
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-usFNABztdR24zn+CQ/w8CnpFpY7DQEDrNmNzmGhZgD4=";
    fetcherVersion = 4;
  };

  buildPhase = ''
    runHook preBuild
    pnpm run build
    pnpm run build:cli
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/node_modules/difit
    cp -r dist node_modules package.json $out/lib/node_modules/difit/

    # node_modules links to workspace packages (e.g. packages/vscode) that
    # aren't copied into $out, leaving dangling symlinks; drop them.
    find $out/lib/node_modules/difit/node_modules -xtype l -delete

    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/difit \
      --add-flags "$out/lib/node_modules/difit/dist/cli/index.js"

    runHook postInstall
  '';

  meta = {
    description = "A lightweight CLI tool to display Git diffs in GitHub-style web viewer";
    homepage = "https://github.com/yoshiko-pg/difit";
    license = lib.licenses.mit;
    mainProgram = "difit";
    platforms = lib.platforms.all;
  };
})
