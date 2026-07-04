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
  pkg-config,
  oniguruma,
  sources,
}:
rustPlatform.buildRustPackage {
  inherit (sources.leaf) pname version src;

  cargoHash = "sha256-JXmyjeEBi8Ej8TBLD7Nwq+k8SYwR2LTwFgdBwjc6nzU=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ oniguruma ];

  meta = {
    description = "A friendly terminal Markdown previewer";
    homepage = "https://github.com/RivoLink/leaf";
    license = lib.licenses.mit;
    mainProgram = "leaf";
    platforms = lib.platforms.all;
  };
}
