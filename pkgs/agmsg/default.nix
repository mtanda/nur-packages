# Version Update Flow:
#
# Auto-updated:
#   - nvfetcher.toml src.manual (version) - by Renovate
#   - _sources/generated.nix (source hash) - by nvfetcher
#   - README.md packages table - by sync-readme
#
# agmsg has no compiled binary: upstream ships install.sh + scripts/ (Bash +
# sqlite3) and normally fetches itself at runtime via `curl | bash` (see
# setup.sh / npm's bin/agmsg.js). That is unreproducible and fetches
# unpinned code on every invocation, so this package instead vendors the
# tagged source tree and wraps install.sh directly — `agmsg` here is
# equivalent to running `./install.sh` from a pinned git checkout, with no
# network fetch of the installer itself.
#
# Note: what install.sh *does* when run is itself broad by design — it
# writes into $HOME (~/.agents/skills/<cmd>/, ~/.claude/commands/,
# ~/.codex/config.toml, ~/.copilot/skills/, etc.) to wire up cross-agent
# messaging. That side effect is unchanged from upstream's own usage.
{
  lib,
  stdenvNoCC,
  makeWrapper,
  bash,
  sqlite,
  sources,
}:
stdenvNoCC.mkDerivation {
  inherit (sources.agmsg) pname version src;

  nativeBuildInputs = [ makeWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/agmsg
    cp -R install.sh uninstall.sh openai.yaml scripts plugins LICENSE VERSION $out/share/agmsg/

    makeWrapper ${bash}/bin/bash $out/bin/agmsg \
      --add-flags "$out/share/agmsg/install.sh" \
      --prefix PATH : ${lib.makeBinPath [ sqlite ]}

    runHook postInstall
  '';

  meta = {
    description = "Cross-vendor messaging for CLI AI coding agents — let Claude Code, Codex, Gemini & Copilot talk to each other in one team";
    homepage = "https://github.com/fujibee/agmsg";
    license = lib.licenses.mit;
    mainProgram = "agmsg";
    platforms = lib.platforms.all;
  };
}
