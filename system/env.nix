{ pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
      GSK_RENDERER = "ngl";
    };
    # currengly making chromium run on wayland makes it load much slower
    sessionVariables.NIXOS_OZONE_WL = "1"; # Make chromium run on wayland
    sessionVariables.QT_QPA_PLATFORM = "wayland";
    shells = with pkgs; [
      bash
      dash
      mksh
      fish
    ];
    binsh = "${pkgs.dash}/bin/dash";
  };

  # Long live the better posix shell
  users.defaultUserShell = pkgs.mksh;
}
