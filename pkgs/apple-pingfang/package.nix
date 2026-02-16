{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation (finalAttrs: {
  pname = "apple-pingfang";
  version = "20.0d4e1-static";

  src = fetchFromGitHub {
    owner = "ACT-02";
    repo = "PingFang-for-Windows";
    tag = finalAttrs.version;
    hash = "sha256-mYllLHMqWwFjG0Wtg+Vzh5Hmk8zu0uGVe2wBNaxcS/A=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 -t $out/share/fonts/opentype $src/*.otf

    runHook postInstall
  '';
})
