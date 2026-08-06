{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.pi-flake.homeModules.default ];

  options = {
    apps.pi-agent.enable = lib.mkEnableOption "enables pi-agent";
  };

  config = lib.mkIf config.apps.pi-agent.enable {
    # needs docker
    # home.packages = with pkgs; [ openshell ];

    nixpkgs.overlays = [ inputs.pi-flake.overlays.default ];
    programs.pi.coding-agent = {
      enable = true;
      jail.enable = true;
    };

    # keybindings = {
    #   "mode:main:key:ctrl-p" = [ "goto:chat" ];
    # };
    #
    #
    # extraEnv = {
    #   OPENAI_API_KEY = "sk-...";
    # };

    # the entire purpose of pi is that you build it all without mcps
    # home.file.".pi/agent/mcp.json".source = pkgs.writeText "mcp.json" (
    #   builtins.toJSON {
    #     mcpServers = {
    #       context-mode = {
    #         command = "context-mode";
    #       };
    #     };
    #   }
    # );
  };
}
