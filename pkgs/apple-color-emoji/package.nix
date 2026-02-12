{
  lib,
  stdenv,
  python3,
  optipng,
  zopfli,
  pngquant,
  imagemagick,
  which,
  nototools ? null,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "apple-color-emoji";
  version = "18.4";

  src = fetchFromGitHub {
    owner = "samuelngs";
    repo = "apple-emoji-linux";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Cw4zl9Trb+yVjVajdG2KxG/pozti6IHZB2nR89ZUExM=";
  };

  nativeBuildInputs = [
    which
    (python3.withPackages (
      python-pkgs:
      [
        python-pkgs.fonttools
      ]
      ++ lib.optional (nototools == null) python-pkgs.nototools
    ))
    optipng
    zopfli
    pngquant
    imagemagick
  ]
  ++ lib.optional (nototools != null) nototools;

  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    cp ./AppleColorEmoji.ttf $out/share/fonts/truetype
    runHook postInstall
  '';
})
