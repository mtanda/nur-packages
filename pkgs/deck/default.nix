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
  inherit (sources.deck) pname version src;

  vendorHash = "sha256-yrUCrC/12fNZO7AkuBhSIqglD5ReT3uql0VET2DnYk4=";

  # Some tests (e.g. TestToSlidesCodeBlockToImageCommand) spawn external `go`
  # commands and need network/module access, which is unavailable in the Nix
  # build sandbox.
  doCheck = false;

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Create presentations by combining Markdown content with Google Slides design";
    homepage = "https://github.com/k1LoW/deck";
    license = lib.licenses.mit;
    mainProgram = "deck";
    platforms = lib.platforms.all;
  };
}
