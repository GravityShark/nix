{ lib, config, ... }:

{
  options = {
    service.kanata.enable = lib.mkEnableOption "enables kanata";
  };
  config = lib.mkIf config.service.kanata.enable {
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
            "/dev/input/by-id/usb-LIZHI_Flash_IC_USB_Keyboard-event-kbd"
            "/dev/input/by-id/usb-LIZHI_Flash_IC_USB_Keyboard-if01-event-kbd"
          ];
          # https://github.com/jtroo/kanata/blob/main/parser/src/keys/mod.rs
          extraDefCfg = ''
            process-unmapped-keys yes
            concurrent-tap-hold yes'';
          config = ''
            (defsrc
              4 5 6 7
                   q    w    e    r    t    y    u    i    o    p   [
              caps a    s    d    f    g    h    j    k    l    ;   '
              lsft z    x    c    v    b    n    m    ,    .    /   rsft
              lalt spc  <    ralt rctl
            )

            (defalias
              base (layer-switch base)
              ruckus   (layer-switch ruckus)
              mc   (layer-switch mc)
              rblx   (layer-switch rblx)
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

              cm (tap-hold-press 200 200 caps lmet)
            )

            (defchordsv2 
              (lsft rsft) @cw 200 first-release (nav sym num fun)
              (voldwn volu) mute 200 first-release (base ruckus mc sym num fun)
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

            (deflayer base
              _ _ _ _
              _    _    _    _    _    _    _    _    _    _   _ 
              @cm    _    _    _    _    _    _    _    _    _   _   _
              _    _    _    _    _    _    _    _    _    _   _   _
              @nav    _    @sym    @mc    @ruckus
            )

            (deflayer ruckus
              _ _ _ _
                   lsft p    l    k    j    XX        '    g    o    u    rsft
              _    s    n    h    t    v    XX        y    c    a    i    e   
                   f    b    m    d    z    XX   XX   x    w    .    ,    q 
              @nav r    spc    @sym     @base
            )

            (deflayer mc
                  p s 4 5
                   o    _    _    _    _    _    _    _    _    _   _ 
              k    _   d    i    _    _    _    _    _    _    _   _
              _    x    f3    _    n    _    0    _    _    _   _   _
              _    _    _    @base    @rblx
            )

            (deflayer rblx
              _ _ _ _
                   _    _    a    _    _    _    _    _    _    _   _ 
              _    e    _    _    _    _    _    _    _    _    _   _
              _    _    _    _    _    _    _    _    _    _   _   _
              _    _    _    @base    @base
            )

            (deflayer nav
              _ _ _ _
              voldwn     ret   esc   A-tab  volu       home  pgdn  pgup  end   caps   _
              _ @osm   @osa  @oss  @osc   C-tab      left  down  up    rght  tab    _
              prtsc  brdown    brup    C-esc   del   XX  grv   bspc  del   menu  Insert _
              _     ret @num XX XX
            )

            (deflayer sym
              _ _ _ _
              S-grv  S-2   S-3   S-4  S-5      S-7  [     S-[   S-]   ]     _
              _ S-6    S-'   S-.   ;    S-8      \    @osc  @oss  @osa  @osm  _
              +      S-\   S-,   /    ,    XX  .    S-9   =     -    S-0   _
              @num   S-;   _     XX XX
            )

            (deflayer num
              _ _ _ _
              XX  XX up  XX     XX XX    7    8    9    _    _
              _ @osm @osa @oss @osc @fun XX    4    5    6    0    _
              XX  XX  XX  down XX XX XX    1    2    3    _    _
              _   XX  XX _   XX
            )

            (deflayer fun
              _ _ _ _
              XX   XX   XX   XX   XX     _    F7    F8    F9    F12   _    
              _ @osm @osa @oss @osc XX     _    F4    F5    F6    F11   _  
              XX   XX   XX   XX   XX  XX _    F1    F2    F3    F10   _    
              _   XX  XX _   XX
            )
          '';
        };
      };
    };
  };
}
