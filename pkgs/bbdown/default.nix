{ lib
, fetchFromGitHub
, buildDotnetModule
, dotnetCorePackages
, stdenv
, ffmpeg
}: let
  pname = "BBDown";
  version = "1.6.2";

  bbdown = buildDotnetModule {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "thebesttv";
      repo = pname;
      rev = "36663925b0e002c81359a15c893b035e5e308418";
      sha256 = "sha256-U3JpouYl/4ChdTgEa5JgGPsRnjg3mrBoTt2jfXPv9f0=";
    };

    dotnet-sdk = dotnetCorePackages.sdk_9_0;
    dotnet-runtime = dotnetCorePackages.runtime_9_0;

    projectFile = "BBDown/BBDown.csproj";
    nugetDeps = ./deps.nix;

    selfContainedBuild = true;
    dotnetFlags = [
      "-p:PublishTrimmed=true"
    ];
    executables = [
      "BBDown"
    ];

    nativeBuildInputs = [
      stdenv.cc
    ];

    runtimeDeps = [
      ffmpeg # ffmpeg_7-headless
    ];
  };
in
  # https://github.com/CrackTC/nur-packages/blob/b4ad20eaefbd5aca48d979aaca4c5406acc95e0e/pkgs/bbdown/default.nix
  bbdown.overrideAttrs (attrs: {
    postFixup = ''
      wrapProgram $out/bin/${pname} \
        --prefix PATH : "${lib.makeBinPath [ ffmpeg ]}"
    '';
  })
