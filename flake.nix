{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    zen-browser-flake.url = "github:omarcresp/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      zen-browser-flake,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs-unstable.legacyPackages.${system};
      unstable = pkgs;
      zen-browser = zen-browser-flake.packages.${system};
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system/configuration.nix ];
          specialArgs = {
            inherit unstable;
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
