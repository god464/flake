{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "apple-emoji";
  version = "18.4";
  src = fetchFromGitHub {
    owner = "samuelngs";
    repo = "apple-emoji-linux";
    rev = "v${version}";
    hash = "sha256-Cw4zl9Trb+yVjVajdG2KxG/pozti6IHZB2nR89ZUExM=";
  };
  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;
  installPhase = ''
    install -D -m644 $src $out/share/fonts/truetype/AppleColorEmoji.ttf
  '';
  meta = {
    description = "Brings Apple's vibrant emojis to your Linux experience";
    homepage = "https://github.com/samuelngs/apple-emoji-linux";
    license = lib.licenses.asl20;
    mainProgram = "apple-emoji";
    platforms = lib.platforms.all;
  };
}
