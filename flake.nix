{
  description = "mtanda's NUR repository";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs =
    { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      legacyPackages = forAllSystems (
        system: import ./default.nix { pkgs = import nixpkgs { inherit system; }; }
      );
      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );

      overlays.default = final: prev: import ./. { pkgs = final; };

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          nvfetcher = {
            type = "app";
            program = "${pkgs.nvfetcher}/bin/nvfetcher";
          };
          sync-readme = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "sync-readme" ''
                set -euo pipefail
                TABLE=$(${pkgs.nix}/bin/nix eval --raw .#packagesTable)
                ${pkgs.gawk}/bin/awk -v table="$TABLE" '
                  /<!-- packages-table-start -->/ { print; print table; skip=1; next }
                  /<!-- packages-table-end -->/ { skip=0 }
                  !skip { print }
                ' README.md > README.md.tmp
                mv README.md.tmp README.md
              ''
            );
          };
        }
      );

      packagesTable =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          nurAttrs = import ./. { inherit pkgs; };
          packages = builtins.removeAttrs nurAttrs [
            "lib"
            "modules"
            "overlays"
          ];
          header = ''
            | Package | Version | Description |
            |---------|---------|-------------|'';
          rows = builtins.concatStringsSep "\n" (
            builtins.attrValues (
              builtins.mapAttrs (
                name: drv: "| ${name} | ${drv.version or "N/A"} | ${drv.meta.description or ""} |"
              ) packages
            )
          );
        in
        header + "\n" + rows;

      formatter = forAllSystems (
        system:
        nixpkgs.legacyPackages.${system}.nixfmt-tree.override {
          settings.global.excludes = [ "_sources/*" ];
        }
      );
    };
}
