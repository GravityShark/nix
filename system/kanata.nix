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
        extraDefCfg = ''
          process-unmapped-keys no
          concurrent-tap-hold yes'';
        config = ''
          (defsrc
            q    w    e    r    t    y    u    i    o    p   [
            a    s    d    f    g    h    j    k    l    ;   '
            z    x    c    v    b    n    m    ,    .    / 
            lalt spc  <
          )

          (defalias
            nav (layer-toggle nav)
            sym (layer-toggle sym)
            num (layer-toggle num)
            #|
            fn (layer-toggle fn)
            |#

            oss (one-shot 5000 lsft)
            osc (one-shot 5000 lctl)
            osm (one-shot 5000 lmet)
            osa (one-shot 5000 lalt)
          )

          (defchordsv2 
            (lsft rsft) (caps-word 2000) 30 first-release ()
          )

          (deflayer base
            _    _    _    _    _    _    _    _    _    _   _ 
            _    _    _    _    _    _    _    _    _    _   _
            _    _    _    _    _    _    _    _    _    _
            @nav _    @sym
          )

          (deflayer nav
            vold  ret  esc  A-tab volu  home pgdn pgup end  caps   _
            @osm  @osa @oss @osc  C-tab left down up   rght tab    _
            prtsc XX   XX   lmet  bspc  grv  bspc del  menu Insert
            _     ret  @num
          )

          (deflayer sym
            ,    S-grv    S-3    S-4    S-5    S-7  S-[    [    ]    =    _
            S-6    S-'    -    ;    S-8    S-]    @osc   @oss @osa    @osm    _
            S-=    S-\    S-2    /    \    .    S-9    S-,    S-.    S-0
            @num   S--    _
          )

          (deflayer num
            XX  F11 up  C-a     XX XX    7    8    9    _    _
            @osm @osa @oss @osc XX XX    4    5    6    0    _
            F5  XX  XX  down    XX XX    1    2    3    _
            _   XX  _   
          )

          #|
          (deflayer fn
            _    _
            _    _    _    _    _         _    _    _    _    _
            _    _    _    _    _         _    _    _    _    _
            _    _    _    _    _    _    _    _    _    _
            _    _    _    _    @base
          )
          |#
        '';
      };
    };
  };
}
