# Version Update Flow:
#
# Auto-updated:
#   - nvfetcher.toml src.manual (version) - by Renovate
#   - _sources/generated.nix (source hash) - by nvfetcher
#   - README.md packages table - by sync-readme
#
# Manual update required:
#   - vendorHash below - only when go.sum changes
#   - If unchanged: CI passes, auto-merge
#   - If changed: CI fails, manually update hash
{
  lib,
  buildGoModule,
  sources,
}:
buildGoModule {
  inherit (sources.github-comment) pname version src;

  vendorHash = "sha256-+zHpV95wIzkBSUnMiFBBB/Je26sFfCqLmk6804JQU/U=";

  ldflags = [
    "-s"
    "-w"
  ];

  postInstall = ''
    rm $out/bin/gen-jsonschema
  '';

  meta = {
    description = "CLI to create and hide GitHub comments";
    homepage = "https://github.com/suzuki-shunsuke/github-comment";
    license = lib.licenses.mit;
    mainProgram = "github-comment";
    platforms = lib.platforms.all;
  };
}
