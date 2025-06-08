{ ... }:

{
  systemd.user.services.restic-notes-backup = {
    Unit = {
      Description = "Restic Backup for Notes";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "%h/Notes/backups/backup.sh";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.restic-notes-backup = {
    Unit = {
      Description = "Daily Restic Backup for Notes";
    };
    Timer = {
      OnCalendar = "*-*-* 04:00:00";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
