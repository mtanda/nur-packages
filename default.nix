# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  pkgs ? import <nixpkgs> { },
}:
let
  sources = pkgs.callPackage ./_sources/generated.nix { };
in
{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  deck = pkgs.callPackage ./pkgs/deck { inherit sources; };
  difit = pkgs.callPackage ./pkgs/difit { inherit sources; };
  diffyml = pkgs.callPackage ./pkgs/diffyml { inherit sources; };
  github-comment = pkgs.callPackage ./pkgs/github-comment { inherit sources; };
  leaf = pkgs.callPackage ./pkgs/leaf { inherit sources; };
  tfcmt = pkgs.callPackage ./pkgs/tfcmt { inherit sources; };
  vde-layout = pkgs.callPackage ./pkgs/vde-layout { inherit sources; };

  inherit (pkgs.callPackage ./pkgs/yashiki { inherit sources; })
    yashiki
    yashiki-layout-tatami
    yashiki-layout-byobu
    ;

  fff-mcp = pkgs.callPackage ./pkgs/fff-mcp { inherit (pkgs.stdenv.hostPlatform) system; };
  mo = pkgs.callPackage ./pkgs/mo { inherit (pkgs.stdenv.hostPlatform) system; };
}
