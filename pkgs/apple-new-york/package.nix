{
  fetchurl,
  stdenvNoCC,
  p7zip,
}:
stdenvNoCC.mkDerivation {
  pname = "apple-new-york";
  version = "20.0d10e1";
  src = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
    sha256 = "sha256-W0sZkipBtrduInk0oocbFAXX1qy0Z+yk2xUyFfDWx4s=";
  };
  nativeBuildInputs = [ p7zip ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    mkdir $TMPDIR/fonts
    7z e $src -y -otmp/
    cd tmp
    7z x -txar "NY Fonts.pkg" -y
    cd NYFonts.pkg/
    7z x Payload -y
    7z x Payload\~ -y
    mv Library/Fonts/* $TMPDIR/fonts
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/truetype $TMPDIR/fonts/*.ttf
    install -Dm644 -t $out/share/fonts/opentype $TMPDIR/fonts/*.otf

    runHook postInstall
  '';
}
