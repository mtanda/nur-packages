# 共通: GitHub Release のプリビルドバイナリを取得して $out/bin に置く。
# sources.json (repo / tag / platforms.<system>.{binary,hash}) を解釈する。
# version は tag から先頭 v を除いて算出し、binary 内の ${version} を置換する。
{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  # --- 以下は callPackage 呼び出し側が渡す ---
  system,
  pname,
  sourcesFile,
  installName ? pname, # $out/bin に置く実行ファイル名
  unpack ? false, # true: tarball を展開 / false: 素のバイナリ
  binaryInArchive ? installName, # unpack=true のとき tarball 内のファイル名
  meta ? { },
}:
let
  sources = lib.importJSON sourcesFile;
  tag = sources.tag; # release tag そのまま（例: v0.6.0 / 0.3.2）
  version = lib.removePrefix "v" tag; # pname-version と ${version} 置換に使う
  subst = builtins.replaceStrings [ "\${version}" ] [ version ];
  platform = sources.platforms.${system} or (throw "${pname}: unsupported system ${system}");
  binary = subst platform.binary;
  url = "https://github.com/${sources.repo}/releases/download/${tag}/${binary}";
in
stdenvNoCC.mkDerivation (
  {
    inherit pname version;

    src = fetchurl {
      inherit url;
      inherit (platform) hash;
    };

    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = lib.optionals stdenvNoCC.hostPlatform.isLinux [ autoPatchelfHook ];

    installPhase =
      if unpack then
        "install -Dm755 ${binaryInArchive} $out/bin/${installName}"
      else
        "install -Dm755 $src $out/bin/${installName}";

    meta = {
      platforms = builtins.attrNames sources.platforms;
    }
    // meta;
  }
  // (if unpack then { sourceRoot = "."; } else { dontUnpack = true; })
)
