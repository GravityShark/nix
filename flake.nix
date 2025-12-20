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
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v3.7.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser-flake = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      noctalia,
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
          modules = [ ./system/configuration.nix ];
          specialArgs = {
            inherit inputs;
          };
        };
      };
      homeConfigurations."gravity" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/configuration.nix ];
        extraSpecialArgs = {
          inherit noctalia;
          inherit zen-browser;
        };
      };
    };
}
