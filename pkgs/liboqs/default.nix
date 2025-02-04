{ stdenv
, fetchFromGitHub
, cmake
, ninja
, openssl
}:
stdenv.mkDerivation rec {
  pname = "liboqs";
  version = "0.8.0";

  # 0.10.0 之后的有问题，需要 patch
  #   https://github.com/NixOS/nixpkgs/commit/4235624542a782a43e3ed3d5acda192cea19949a
  src = fetchFromGitHub {
    owner = "open-quantum-safe";
    repo = pname;
    rev = version;
    sha256 = "sha256-h3mXoGRYgPg0wKQ1u6uFP7wlEUMQd5uIBt4Hr7vjNtA=";
  };

  nativeBuildInputs = [
    cmake
    ninja
  ];

  cmakeFlags = [
    "-DOQS_USE_OPENSSL=OFF"
  ];

  buildInputs = [
    # openssl
  ];
}
