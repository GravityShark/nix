# https://github.com/NixOS/nixpkgs/blob/d351d0653aeb7877273920cd3e823994e7579b0b/pkgs/by-name/ca/caprine-bin/package.nix
{
  fetchurl,
  appimageTools,
  xorg,
  metaCommon ? { },
}:

let
  pname = "caprine";
  version = "2.60.3";
  src = fetchurl {
    url = "https://github.com/Alex313031/caprine-ng/releases/download/v${version}/caprine_${version}_x64.AppImage";
    name = "caprine_${version}_x64.AppImage";
    sha256 = "sha256-hGubEDt2WusmeCloYSLwhxKDb47UBfmYAD8NBQbZKoo=";
  };
  extracted = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  passthru = {
    inherit pname version src;
  };

  profile = ''
    export LC_ALL=C.UTF-8
  '';

  extraInstallCommands = ''
    mkdir -p $out/share
    "${xorg.lndir}/bin/lndir" -silent "${extracted}/usr/share" "$out/share"
    ln -s ${extracted}/caprine.png $out/share/icons/caprine.png
    mkdir $out/share/applications
    cp ${extracted}/caprine.desktop $out/share/applications/
    substituteInPlace $out/share/applications/caprine.desktop \
        --replace AppRun caprine
  '';

  meta = metaCommon // {
    platforms = [ "x86_64-linux" ];
  };
}
