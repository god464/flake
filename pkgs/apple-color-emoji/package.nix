{ stdenv, fetchurl }:

stdenv.mkDerivation {
  pname = "apple-color-emoji";
  version = "20.4d5e1";

  src = fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-26-20260613-f1fc560b/AppleColorEmoji-Linux.ttf";
    hash = "sha256:b8c8ed97f642b89ba4a36a3e096619f0805d06cc25ae1116e6953b98142ae20c";
  };

  dontConfigure = true;
  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" $out/share/fonts/truetype/AppleColorEmoji-Linux.ttf

    runHook postInstall
  '';
}
