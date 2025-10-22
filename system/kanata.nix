{ ... }:

{
  boot.kernelModules = [ "uinput" ];
  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Replace the paths below with the appropriate device paths for your setup.
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys no";
        config = ''
          (defsrc
            lsft rsft
            q    w    e    r    t         u    i    o    p    [ 
            a    s    d    f    g         j    k    l    ;    '
            z    x    c    v    b    n    m    ,    .    / 
            lalt spc < ralt rctl
          )

          (defalias
            @nav (layer-toggle nav)
            @sym (layer-toggle sym)
            @num (layer-toggle num)
            @fn (layer-toggle fn)
            @qwerty (layer-switch qwerty)
            @base (layer-switch base)


            oss (one-shot 5000 lsft)
            osc (one-shot 5000 lctl)
            osm (one-shot 5000 lmet)
            osa  (one-shot 5000 lalt)
          )

          (deflayer base
            lsft rsft
            f    p    l    k    j         '    g    o    u    q
            s    n    h    t    v         y    c    a    i    e
            b    m    d    z    !    ?    x    w    .    ,  
            @nav r    spc  @sym @qwerty
          )

          (deflayer qwerty
            _    _
            _    _    _    _    _         _    _    _    _    _
            _    _    _    _    _         _    _    _    _    _
            _    _    _    _    _    _    _    _    _    _
            _    _    _    _    @base
          )

          (defchords cw 30
            (lsft rsft) (caps-word 2000)
          )
        '';
      };
    };
  };
}
