{
  fetchurl,
  lib,
  stdenvNoCC,
  _7zz,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "geared-cursor";
  version = "1.1";

  sourceRoot = ".";
  src = fetchurl {
    url = "https://github.com/piraker-grinor/geared-cursor/releases/download/v${finalAttrs.version}/Geared-${finalAttrs.version}.7z";
    name = "Geared-${finalAttrs.version}.7z";
    hash = "sha256-muDO6hNyArC1v4eKryzoE1HIu5WyOsPX+NlR0S+oXk4=";
  };

  unpackPhase = ":";
  installPhase = ''
    mkdir -p $out/share/icons
    ${_7zz}/bin/7zz x Geared-${finalAttrs.version}.7z -oGeared
    cp -r Geared $out/share/icons
  '';

  meta = {
    description = "Custom pre-rendered 3D cursor for Linux ";
    homepage = "https://github.com/piraker-grinor/geared-cursor";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ piraker-grinor ];
  };
})
