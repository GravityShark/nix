{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.pi-flake.homeManagerModules.default ];

  options = {
    apps.pi-agent.enable = lib.mkEnableOption "enables pi-agent";
  };

  config = lib.mkIf config.apps.pi-agent.enable {
    # needs docker
    # home.packages = with pkgs; [ openshell ];

    nixpkgs.overlays = [ inputs.pi-flake.overlays.default ];
    programs.pi-coding-agent = {
      package = pkgs.pi;
      enable = true;
      mutableDir = true;
      extensions = [
        "npm:pi-web-access"
        "npm:pi-token-speed"
      ];

      # models = {
      #   default = {
      #     provider = "llama-cpp";
      #     model = "Main/Qwen3.5-2B-MTP-Q4_K_X";
      #     baseUrl = "http://127.0.0.1:8080";
      #   };
      # };

      # keybindings = {
      #   "mode:main:key:ctrl-p" = [ "goto:chat" ];
      # };
      #
      #
      # extraEnv = {
      #   OPENAI_API_KEY = "sk-...";
      # };
    };
  };
}
