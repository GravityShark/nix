{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    scripts.enable = lib.mkEnableOption "enables scripts";
  };
  config = lib.mkIf config.scripts.enable {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "my-script" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Hello, world! Today is $DATE.
      '')
    ];
  };
}
