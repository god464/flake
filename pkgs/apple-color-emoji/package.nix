{ stdenv, fetchurl }:

stdenv.mkDerivation {
  pname = "apple-color-emoji";
  version = "20.4d5e1";

  src = fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-26-20260219-2aa12422/AppleColorEmoji-Linux.ttf";
    hash = "sha256:535a043af04706d24471059e64745bfc80d6617ada2eea3435dc5620dc0f5318";
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
