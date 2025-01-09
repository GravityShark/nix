{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    zen-browser-flake.url = "github:jayden-chan/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      emacs-overlay,
      home-manager,
      lanzaboote,
      zen-browser-flake,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs-unstable.legacyPackages.${system};
      unstable = pkgs;
      emacs = emacs-overlay.packages.${system};
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
            inherit emacs;
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
