{
  description = "This is MY flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-24.11";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser-flake.url = "github:omarcresp/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lanzaboote,
      zen-browser-flake,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      zen-browser = zen-browser-flake.packages.${system};
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            lanzaboote.nixosModules.lanzaboote
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };
      homeConfigurations."gravity" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/home.nix ];
        extraSpecialArgs = {
          inherit zen-browser;
        };
      };
    };
}
