{
  lib,
  callPackage,
  system,
}:
callPackage ../build-support/prebuilt-binary.nix {
  inherit system;
  pname = "fff-mcp";
  sourcesFile = ./sources.json;
  meta = {
    description = "The fastest and most accurate file search toolkit for AI agents (MCP server)";
    homepage = "https://github.com/dmtrKovalenko/fff";
    license = lib.licenses.mit;
    mainProgram = "fff-mcp";
  };
}
