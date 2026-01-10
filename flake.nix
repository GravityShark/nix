{
  description = "The WORST flake config you will EVER see";

  inputs = {
    # self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixcraft = {
    #   url = "github:GravityShark/nixcraft";
    #   # url = "github:loystonpais/nixcraft";
    #   # url = "github:flammablebunny/nixcraft";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v3.8.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ppd-dbus-hook = {
      url = "github:GravityShark/ppd-dbus-hook";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit/";
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
      self,
      ...
    }@inputs:
    let
      username = "gravity";
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./hosts/msi/configuration.nix
            ./nixos
            { config.username = username; }
          ];
        };
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./hosts/msi/home.nix
          ./home
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
        ];
      };
    };
}
