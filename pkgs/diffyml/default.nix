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
buildGoModule (finalAttrs: {
  inherit (sources.diffyml) pname version src;

  vendorHash = "sha256-QE/EwVzMqUO24ZAl0WBibGx6x0kNo1AUTZtfnQvX50k=";

  subPackages = [ "." ];

  # upstream's test/property suite shells out to `go mod verify`/`go mod tidy`,
  # which need network access unavailable in the Nix sandbox (GOPROXY=off).
  doCheck = false;

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${finalAttrs.version}"
  ];

  meta = {
    description = "A fast, structural YAML diff tool";
    homepage = "https://github.com/szhekpisov/diffyml";
    license = lib.licenses.mit;
    mainProgram = "diffyml";
    platforms = lib.platforms.all;
  };
})
