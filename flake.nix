{
  description = "This is MY flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.3";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    mango = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwl-grav-flake = {
      url = "github:GravityShark/dwl-grav/spawnorfocus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scroll-flake = {
      url = "github:AsahiRocks/scroll-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser-flake = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      self,
      dwl-grav-flake,
      zen-browser-flake,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      dwl-grav = dwl-grav-flake.packages.${system};
      zen-browser = zen-browser-flake.packages.${system};
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            inputs.mango.nixosModules.mango
            inputs.scroll-flake.nixosModules.default
          ];
          specialArgs = {
            inherit inputs;
            inherit dwl-grav;
          };
        };
      };
      homeConfigurations."gravity" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/configuration.nix ];
        extraSpecialArgs = {
          inherit zen-browser;
        };
      };
    };
}
