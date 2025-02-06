{ stdenv
, fetchFromGitHub
, libsForQt5
, makeDesktopItem
, copyDesktopItems
}:
stdenv.mkDerivation rec {
  pname = "PonyOCR";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "thebesttv";
    repo = pname;
    rev = "35ff4170e5fdfc69d60c8fd9cb5d3c964d55cc21";
    sha256 = "sha256-hmFSi4sjyZbJxL/IXYce+NluwF2ADCTEX5euQw4lLr8=";
  };

  nativeBuildInputs = [
    libsForQt5.qmake
    libsForQt5.wrapQtAppsHook
    libsForQt5.qt5.qtwebengine

    copyDesktopItems
  ];

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = pname;
      comment = meta.description;
      icon = pname;
    })
  ];

  postInstall = ''
    mkdir -p $out/bin
    install -m755 ${pname} $out/bin

    for RES in 32 64 128 256 512; do
      mkdir -p $out/share/icons/hicolor/"$RES"x"$RES"/apps
      cp img/icon-"$RES".png $out/share/icons/hicolor/"$RES"x"$RES"/apps/"$pname".png
    done

    mkdir -p $out/share/dbus-1/system-services
    cp files/org.thebesttv.PonyOCR.service $out/share/dbus-1/system-services/org.thebesttv.PonyOCR.service
    substituteInPlace $out/share/dbus-1/system-services/org.thebesttv.PonyOCR.service \
      --replace-fail /home/thebesttv/bin/$pname $out/bin/$pname
  '';

  meta = {
    homepage = "https://github.com/thebesttv/${pname}";
    description = "OCR with ease";
  };
}
