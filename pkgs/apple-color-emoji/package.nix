{ stdenv, fetchurl }:

stdenv.mkDerivation {
  pname = "apple-color-emoji";
  version = "20.4d5e1";

  src = fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-26-20260218-4989e498/AppleColorEmoji-Linux.ttf";
    hash = "sha256:e3d83e32a6a0a878de8c16b0eea0925a135be427557ec4721d2e1d520f99c44a";
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
