{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    service.notes-backup.enable = lib.mkEnableOption "enables daily-ish backups for ~/Notes using restic";
  };

  config = lib.mkIf config.service.notes-backup.enable {
    home.packages = [ pkgs.restic ];
    systemd.user.services.restic-notes-backup = {
      Unit.Description = "Restic Backup for Notes";
      Service = {
        Type = "oneshot";
        ExecStart = "%h/Notes/backups/backup.sh";
      };
      Install.WantedBy = [ "default.target" ];
    };

    systemd.user.timers.restic-notes-backup = {
      Unit.Description = "Daily Restic Backup for Notes";
      Timer = {
        OnCalendar = "*-*-* 04:00:00";
        Persistent = true;
      };
      Install.WantedBy = [ "timers.target" ];
    };

  };
}
