{
  fetchzip,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "geared-cursor";
  version = "1.1";

  sourceRoot = ".";
  srcs = fetchzip {
    url = "https://github.com/piraker-grinor/geared-cursor/archive/refs/tags/v${finalAttrs.version}.tar.gz";
    name = "Geared";
    hash = "sha256-zfucSMU3gQwIgySvdh4LYvMMIcSFwOcc13ETb2/Ndao=";
  };

  postInstall = ''
    mkdir -p $out/share/icons
    cp -r Geared/Geared $out/share/icons
  '';

  meta = {
    description = "Custom pre-rendered 3D cursor for Linux ";
    homepage = "https://github.com/piraker-grinor/geared-cursor";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ piraker-grinor ];
  };
})
