{
  fetchurl,
  stdenvNoCC,
  p7zip,
}:
stdenvNoCC.mkDerivation {
  pname = "apple-sf-mono";
  version = "20.0d10e1";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "sha256-bUoLeOOqzQb5E/ZCzq0cfbSvNO1IhW1xcaLgtV2aeUU=";
  };
  nativeBuildInputs = [ p7zip ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    mkdir $TMPDIR/fonts
    7z e $src -y -otmp/
    cd tmp
    7z x -txar "SF Mono Fonts.pkg" -y
    cd SFMonoFonts.pkg/
    7z x Payload -y
    7z x Payload\~ -y
    mv Library/Fonts/* $TMPDIR/fonts
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/opentype $TMPDIR/fonts/*.otf

    runHook postInstall
  '';
}
