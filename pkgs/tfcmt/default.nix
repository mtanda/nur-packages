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
  inherit (sources.tfcmt) pname version src;

  vendorHash = "sha256-m3BofzogEWESOskTQfibm56QHJNf7sHbvA7Q1DDwno4=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Tfcmt enhances mercari/tfnotify in many ways, including Terraform >= v0.15 support and advanced formatting options";
    homepage = "https://github.com/suzuki-shunsuke/tfcmt";
    license = lib.licenses.mit;
    mainProgram = "tfcmt";
    platforms = lib.platforms.all;
  };
}
