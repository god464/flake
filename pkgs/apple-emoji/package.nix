{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
  ...
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
  nativeBuildInputs = with pkgs; [
    which
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        fonttools
        nototools
      ]
    ))
    optipng
    zopfli
    pngquant
    imagemagick
    nototools
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    cp ./AppleColorEmoji.ttf $out/share/fonts/truetype
    runHook postInstall
  '';
  meta = {
    description = "Brings Apple's vibrant emojis to your Linux experience";
    homepage = "https://github.com/samuelngs/apple-emoji-linux";
    license = lib.licenses.asl20;
    mainProgram = "apple-emoji";
    platforms = lib.platforms.all;
  };
}
