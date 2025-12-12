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
          process-unmapped-keys yes
          concurrent-tap-hold yes'';
        config = ''
          (defsrc
                 q    w    e    r    t    y    u    i    o    p   [
                 a    s    d    f    g    h    j    k    l    ;   '
            lsft z    x    c    v    b    n    m    ,    .    /   rsft
            lalt spc  <    ralt rctl
          )

          (defalias
            base (layer-switch base)
            ruckus   (layer-switch ruckus)
            mc   (layer-switch mc)
            nav  (layer-toggle nav)
            sym  (layer-toggle sym)
            num  (layer-toggle num)
            fun  (layer-toggle fun)

            oss (one-shot 5000 lsft)
            osrs (one-shot 5000 rsft)
            osc (one-shot 5000 lctl)
            osm (one-shot 5000 lmet)
            osa (one-shot 5000 lalt)

            cw (caps-word 2000)
          )

          (defchordsv2 
            (lsft rsft) @cw 200 first-release (nav sym num)
          )

          (defoverrides
            (lsft .) (-)
            (lsft ,) (=)
            (-) (lsft .)
            (=) (lsft ,)
            ;; (lsft @osrs) (lsft /)
            ;; (rsft @oss) (lsft 1)

            (lsft spc) (lsft -)
            (rsft spc) (rsft -)
          )

          (deflocalkeys-linux
           brup 233
           brdn 232)

          (deflayer base
            _    _    _    _    _    _    _    _    _    _   _ 
            _    _    _    _    _    _    _    _    _    _   _
            _    _    _    _    _    _    _    _    _    _   _   _
            @nav    _    @sym    @mc    @ruckus
          )

          (deflayer ruckus
            lsft p    l    k    j    XX        '    g    o    u    rsft
            s    n    h    t    v    XX        y    c    a    i    e   
            f    b    m    d    z    XX   XX   x    w    .    ,    q 
            @nav r    spc    @sym     @base
          )

          (deflayer mc
            _    _    _    _    _    _    _    _    _    _   _ 
            _    _    _    _    _    _    _    _    _    _   _
            _    _    _    _    _    _    _    _    _    _   _   _
            _    _    _    @base    _
          )

          (deflayer nav
            _     ret   esc   A-tab  _       home  pgdn  pgup  end   caps   _
            @osm   @osa  @oss  @osc   C-tab      left  down  up    rght  tab    _
            prtsc  brdn    brup    C-esc   _   XX  grv   bspc  del   menu  Insert _
            _     ret @num XX XX
          )

          (deflayer sym
            S-grv  S-2   S-3   S-4  S-5      S-7  [     S-[   S-]   ]     _
            S-6    S-'   S-.   ;    S-8      \    @osc  @oss  @osa  @osm  _
            +      S-\   S-,   /    ,    XX  .    S-9   =     -    S-0   _
            @num   S-;   _     XX XX
          )

          (deflayer num
            XX  F11 up  C-a     XX XX    7    8    9    _    _
            @osm @osa @oss @osc XX XX    4    5    6    0    _
            F5  XX  XX  down XX XX XX    1    2    3    _    _
            _   XX  XX _   XX
          )

          (deflayer fun
            XX   XX   XX   XX   XX       F12    F7    F8    F9    _    _ 
            @osm @osa @oss @osc XX       F11    F4    F5    F6    _    _
            XX   XX   XX   XX   XX  XX   F10    F1    F2    F3    _    _
            _   XX  XX _   XX
          )
        '';
      };
    };
  };
}
