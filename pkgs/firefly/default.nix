{ stdenv
, fetchFromGitHub
, libsForQt5
}:
stdenv.mkDerivation rec {
  pname = "firefly";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "thebesttv";
    repo = pname;
    rev = "e80dc1e0eefcd8ca93215fbbd22f193ca0604268";
    sha256 = "sha256-M0J2YzJqUMsktDp/V3tO6JRpu7epjm1xA9SajK//9pU=";
  };

  nativeBuildInputs = [
    libsForQt5.qmake
    libsForQt5.wrapQtAppsHook
  ];

  installPhase = ''
    mkdir -p $out/bin
    install -m755 ${pname} $out/bin
  '';
}
