{
  lib,
  callPackage,
  system,
}:
callPackage ../build-support/prebuilt-binary.nix {
  inherit system;
  pname = "mo";
  sourcesFile = ./sources.json;
  unpack = true;
  meta = {
    description = "CLI tool that opens .md files in a browser with live-reload, syntax highlighting, Mermaid and LaTeX support";
    homepage = "https://github.com/k1LoW/mo";
    license = lib.licenses.mit;
    mainProgram = "mo";
  };
}
