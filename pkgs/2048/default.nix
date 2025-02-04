{ stdenv
, fetchFromGitHub
}:
stdenv.mkDerivation rec {
  pname = "2048";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "mevdschee";
    repo = "2048.c";
    rev = "v${version}";
    sha256 = "sha256-ohpHkxPytxH+De/OT0wY7Y2saJeQaT9NIujiOajOz0Y=";
  };

  installPhase = ''
    # mkdir -p $out/bin
    # install -m755 2048 $out/bin
    install -m755 2048 $out
  '';
}
