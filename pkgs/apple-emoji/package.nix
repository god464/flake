{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation (finalAttrs: {
  pname = "apple-emoji";
  version = "18.4";

  src = fetchFromGitHub {
    owner = "samuelngs";
    repo = "apple-emoji-linux";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Cw4zl9Trb+yVjVajdG2KxG/pozti6IHZB2nR89ZUExM=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype $src/AppleColorEmoji.ttf 

    runHook postInstall
  '';
})
