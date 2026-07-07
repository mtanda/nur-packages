{
  lib,
  callPackage,
  system,
}:
callPackage ../build-support/prebuilt-binary.nix {
  inherit system;
  pname = "hunk";
  sourcesFile = ./sources.json;
  unpack = true;
  meta = {
    description = "Review-first terminal diff viewer for agentic coders";
    homepage = "https://github.com/modem-dev/hunk";
    license = lib.licenses.mit;
    mainProgram = "hunk";
  };
}
