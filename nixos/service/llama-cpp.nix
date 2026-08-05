{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    service.llama-cpp.enable = lib.mkEnableOption "enables llama-cpp";
  };
  config = lib.mkIf config.service.llama-cpp.enable {
    programs.nix-ld.enable = true;
    environment.systemPackages = with pkgs; [ uv ];

    services.llama-cpp = {
      enable = true;
      package = pkgs.llama-cpp-vulkan;
      # package = (pkgs.llama-cpp.override { cudaSupport = true; });
      settings = {
        api-key = "bingo";
        models-autoload = "";
        tools = "all";
        # BUG: I think mcp servers are broken  https://github.com/ggml-org/llama.cpp/issues/26497
        # mcp-servers-config = (pkgs.formats.json { }).generate "mcp.json" {
        #   mcpServers = {
        #     free-search-mcp = {
        #       command = "${pkgs.uv}/bin/uvx";
        #       args = [
        #         "free-search-mcp"
        #       ];
        #     };
        #     nixos = {
        #       type = "stdio";
        #       command = "nix";
        #       args = [
        #         "run"
        #         "github:utensils/mcp-nixos"
        #         "--"
        #       ];
        #     };
        #   };
        # };
        models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
          "*" = {
            ctx-size = 12000;
            parallel = 1;
          };
          "unsloth/gemma-4-E4B-it-qat-GGUF" = {
            hf-repo = "unsloth/gemma-4-E4B-it-qat-GGUF";
            hf-file = "gemma-4-E4B-it-qat-UD-Q4_K_XL.gguf";
            n-gpu-layers = -1;
          };
        };
        models-max = 1;
        # no-mmproj = "";
        sleep-idle-seconds = 900;
        ui-mcp-proxy = "";
        verbosity = 5;
      };
    };
    systemd.services.llama-cpp = {
      environment = {
        XDG_CACHE_HOME = "/var/cache/llama-cpp";
        MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
      };
    };
  };
}
