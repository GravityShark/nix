{
  description = "The WORST flake config you will EVER see";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flatpaks.url = "github:gmodena/nix-flatpak/latest";
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v1.0.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    ## we are NOT waiting for this https://github.com/niri-wm/niri/issues/844
    niri-package = {
      url = "github:urayde/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:epireyn/niri-flake";
      # FIX: sodiboo hasnt updated blur options yet
      # url = "github:sodiboo/niri-flake";
      inputs.niri-unstable.follows = "niri-package";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # pi-flake = {
    #   url = "github:lukasl-dev/pi.nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    ppd-dbus-hook = {
      url = "github:GravityShark/ppd-dbus-hook";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcsr-nixos = {
      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      username = "gravity";
      system = "x86_64-linux";
      mkNixOSConfig =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit system;
          modules = [
            ./hosts/${hostname}/configuration.nix
            ./nixos
            {
              config.username = username;
              config.networking.hostName = hostname;
            }
          ];
        };
      mkHomeManagerConfig =
        hostname:
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          pkgs = nixpkgs.legacyPackages."${system}";
          modules = [
            ./hosts/${hostname}/home.nix
            ./home
            {
              home.username = username;
              home.homeDirectory = "/home/${username}";
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        msi = mkNixOSConfig "msi";
        acer = mkNixOSConfig "acer";
      };
      # homeConfigurations."gravity@acer" = mkHomeManagerConfig "acer";
      homeConfigurations."gravity" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [
          ./hosts/acer/home.nix
          ./home
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
        ];
      };
    };
}
