# Version Update Flow:
#
# Auto-updated:
#   - nvfetcher.toml src.manual (version) - by Renovate
#   - _sources/generated.nix (source hash) - by nvfetcher
#   - README.md packages table - by sync-readme
#
# Manual update required:
#   - cargoHash below - only when Cargo.lock changes
#   - If unchanged: CI passes, auto-merge
#   - If changed: CI fails, manually update hash
{
  lib,
  rustPlatform,
  sources,
}:
let
  inherit (sources.yashiki) version src;
  cargoHash = "sha256-3JxtsSipMbMxQO58ZLJbQVrOFFC7FoVguNpqdoL+ziQ=";

  mkPkg =
    {
      pname,
      description,
      mainProgram,
    }:
    rustPlatform.buildRustPackage {
      inherit
        pname
        version
        src
        cargoHash
        ;

      cargoBuildFlags = [
        "-p"
        pname
      ];
      cargoTestFlags = [
        "-p"
        pname
      ];

      meta = {
        inherit description mainProgram;
        homepage = "https://github.com/typester/yashiki";
        license = lib.licenses.mit;
        platforms = lib.platforms.darwin;
      };
    };
in
{
  yashiki = mkPkg {
    pname = "yashiki";
    description = "macOS tiling window manager daemon and CLI";
    mainProgram = "yashiki";
  };

  yashiki-layout-tatami = mkPkg {
    pname = "yashiki-layout-tatami";
    description = "Master-stack layout engine for yashiki";
    mainProgram = "yashiki-layout-tatami";
  };

  yashiki-layout-byobu = mkPkg {
    pname = "yashiki-layout-byobu";
    description = "Accordion layout engine for yashiki";
    mainProgram = "yashiki-layout-byobu";
  };
}
