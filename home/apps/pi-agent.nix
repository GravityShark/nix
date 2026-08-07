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
    home.packages = with pkgs; [ gh ];

    nixpkgs.overlays = [ inputs.pi-flake.overlays.default ];
    programs.pi.coding-agent = {
      enable = true;
      jail.enable = true;
      jail.permissions =
        combinators: with combinators; [
          # Keep the default capabilities when replacing the permission list.
          network
          mount-cwd

          # Add custom tools and their runtime closures to the jailed PATH.
          (add-pkg-deps [
            pkgs.busybox
            pkgs.jq
            pkgs.gnumake
            pkgs.python3
            pkgs.nodejs
          ])

          # Expose additional host files explicitly.
          # (try-readonly (noescape "~/.gitconfig"))
        ];
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
