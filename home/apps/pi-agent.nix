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

      models = {
        providers = {
          llama-cpp = {
            baseUrl = "http://localhost:8080";
            api = "openai-completions";
            apiKey = "bingo";
            # models = [
            #   {
            #     id = "llama3.1:8b";
            #   }
            #   {
            #     id = "qwen2.5-coder:7b";
            #   }
            # ];
          };
        };
      };

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
