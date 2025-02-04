{ stdenv
, fetchFromGitHub
, autoconf
, zlib
, openssl
, curl
, expat
, gettext
}:
stdenv.mkDerivation rec {
  pname = "git";
  version = "2.48.1";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-YGtLvgV0cnivWQ/gJiuOd6OEYAz7tGAh5RW6Nw9WfIo=";
  };

  nativeBuildInputs = [
    autoconf
  ];

  buildInputs = [
    zlib
    openssl
    curl
    expat
    gettext
  ];

  enableParallelBuilding = true;

  preConfigure = ''
    make configure
  '';

  makeFlags = [
    "NO_PERL=YesPlease"
    "NO_TCLTK=YesPlease"
  ];
}
