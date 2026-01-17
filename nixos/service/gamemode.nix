{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    service.gamemode.enable = lib.mkEnableOption "enables gamemode";
  };
  config = lib.mkIf config.service.gamemode.enable {

    environment.sessionVariables.GAMEMODERUNEXEC = "nvidia-offload";
    users.users.${config.username}.extraGroups = [ "gamemode" ];

    programs.gamemode = {
      enable = true;
      enableRenice = false;
      settings = {
        general = {
          renice = 10;
          softrealtime = "auto";
        };

        custom =
          # let
          #   start = pkgs.writers.writeDash "start" ''
          #     # cp /etc/tuned/active_profile /tmp/active_profile && ${pkgs.tuned}/bin/tuned-adm profile throughput-performance
          #     STATE_FILE="$\{XDG_RUNTIME_DIR:-/tmp}/gamemode-tuned-prev"
          #
          #     # Save previous profile only once
          #     if [ ! -f "$STATE_FILE" ]; then
          #         # Capture output
          #         out=$(${pkgs.tuned}/bin/tuned-adm active)
          #
          #         # Strip prefix using POSIX shell parameter expansion
          #         prev=$\{out#Current active profile: }
          #
          #         echo "$prev" > "$STATE_FILE"
          #     fi
          #
          #     # Switch to performance-style tuned profile
          #     ${pkgs.tuned}/bin/tuned-adm profile throughput-performance
          #   '';
          #
          #   end = pkgs.writers.writeDash "end" ''
          #     # ${pkgs.tuned}/bin/${pkgs.tuned}/bin/tuned-adm profile $(cat /tmp/active_profile)
          #     STATE_FILE="$\{XDG_RUNTIME_DIR:-/tmp}/gamemode-tuned-prev"
          #
          #     if [ -f "$STATE_FILE" ]; then
          #         prev=$(cat "$STATE_FILE")
          #         ${pkgs.tuned}/bin/tuned-adm profile "$prev"
          #         rm -f "$STATE_FILE"
          #     fi
          #   '';
          # in
          lib.mkIf config.service.power-management.enable {
            start = "${pkgs.tuned}/bin/tuned-adm profile throughput-performance";
            end = "${pkgs.tuned}/bin/tuned-adm profile balanced";
          };
      };
    };
  };
}
