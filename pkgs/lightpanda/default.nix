{
  lib,
  callPackage,
  system,
}:
callPackage ../build-support/prebuilt-binary.nix {
  inherit system;
  pname = "lightpanda";
  sourcesFile = ./sources.json;
  meta = {
    description = "Lightweight browser engine for AI agents and web automation";
    homepage = "https://github.com/lightpanda-io/browser";
    license = lib.licenses.agpl3Only;
    mainProgram = "lightpanda";
  };
}
