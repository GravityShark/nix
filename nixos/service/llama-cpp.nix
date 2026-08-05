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
        ctx-size = 16384;
        # BUG: I think mcp servers are broken  https://github.com/ggml-org/llama.cpp/issues/26497
        mcp-servers-config = (pkgs.formats.json { }).generate "mcp.json" {
          mcpServers = {
            free-search-mcp = {
              command = "${pkgs.uv}/bin/uvx";
              args = [
                "free-search-mcp"
              ];
            };
            nixos = {
              type = "stdio";
              command = "nix";
              args = [
                "run"
                "github:utensils/mcp-nixos"
                "--"
              ];
            };
          };
        };
        models-autoload = "";
        models-max = 1;
        models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
          "unsloth/gemma-4-E4B-it-Q8_K_XL" = {
            hf-repo = "unsloth/gemma-4-E4B-it-GGUF:UD-Q8_K_XL";
            top-k = 64;
          };
          "unsloth/gemma-4-E2B-it-qat-UD-Q4_K_XL" = {
            hf-repo = "unsloth/gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL";
            top-k = 64;
          };
          "unsloth/gemma-4-E4B-it-qat-UD-Q4_K_XL" = {
            hf-repo = "unsloth/gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL";
            top-k = 64;
          };
          "unsloth/gemma-4-12B-it-qat-Q4_K_XL" = {
            hf-repo = "unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL";
            top-k = 64;
          };
          "unsloth/gemma-4-26B-A4B-it-qat-Q4_K_XL" = {
            hf-repo = "unsloth/gemma-4-26B-A4B-it-qat:UD-Q4_K_XL";
            n-gpu-layers = "auto";
            top-k = 64;
          };
          "unsloth/Qwen3.5-9B-Q4_K_XL" = {
            hf-repo = "unsloth/Qwen3.5-9B-GGUF:UD-Q4_K_XL";
            top-k = 20;
            min-p = 0.00;
          };
        };

        n-gpu-layers = -1;
        # some models crash if you dont disable this
        no-mmproj = "";
        parallel = 1;
        sleep-idle-seconds = 900;
        spec-draft-n-max = 2;
        spec-type = "draft-mtp";
        temp = 1.0;
        tools = "all";
        top-p = 0.95;
        ui-mcp-proxy = "";
        verbosity = 5;
      };
    };
    systemd.services.llama-cpp = {
      environment = {
        MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
        XDG_CACHE_HOME = "/var/cache/llama-cpp";
      };
    };
  };
}
