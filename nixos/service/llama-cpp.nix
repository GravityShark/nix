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
  config = lib.mkIf config.service.llama-cpp.enable (
    let
      llama-cpp = pkgs.llama-cpp-vulkan;
      # llama-cpp = (
      #   pkgs.llama-cpp.override {
      #     cudaSupport = true;
      #     vulkanSupport = true;
      #     blasSupport = true;
      #   }
      # );
    in
    {
      programs.nix-ld.enable = true;
      environment.systemPackages = with pkgs; [
        uv
        llama-cpp
      ];

      services.llama-cpp = {
        enable = true;
        package = llama-cpp;
        openFirewall = true;
        settings = {
          api-key = "bingo";
          models-dir = "caching";
          models-max = 1;
          no-mmproj-offload = "";
          no-models-autoload = "";
          tools = "all";
          ui-mcp-proxy = "";
          # verbosity = 5;
          # mcp-servers-config = (pkgs.formats.json { }).generate "mcp.json" {
          #   mcpServers = {
          #     # free-search-mcp = {
          #     #   command = "${pkgs.uv}/bin/uvx";
          #     #   args = [
          #     #     "free-search-mcp"
          #     #   ];
          #     # };
          #     nixos = {
          #
          #       command = "${pkgs.uv}/bin/uvx";
          #       args = [
          #         "mcp-nixos"
          #       ];
          #     };
          #   };
          # };
          models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
            "*" = {
              # ctx-size = 32768;
              ctx-size = 65536;
              fit-target = "1024,0";
              main-gpu = 1;
              n-gpu-layers = "all";
              # n-gpu-layers = "auto";
              # some models crash if you dont use this. which disables like audio stuff
              # no-mmproj = "true";
              parallel = 1;
              sleep-idle-seconds = 900;
              temp = 1.0;
              top-k = 64;
              top-p = 0.95;
            };
            "unsloth/gemma-4-E2B-it-qat-Q4_K_XL" = {
              alias = "Gemma 4 E2B";
              hf-repo = "unsloth/gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL";
              spec-draft-n-max = 2;
              spec-type = "draft-mtp";
              n-gpu-layers = "auto";
            };
            "unsloth/gemma-4-E4B-it-qat-Q4_K_XL" = {
              alias = "Gemma 4 E4B";
              hf-repo = "unsloth/gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL";
              ctx-size = 32768;
              spec-draft-n-max = 2;
              spec-type = "draft-mtp";
            };
            "fun" = {
              alias = "fun";
              hf-repo = "huihui-ai/Huihui-gemma-4-E4B-it-qat-q4_0-unquantized-abliterated-GGUF";
              # ctx-size = 131072;
              # n-gpu-layers = "auto";
              ctx-size = 16000;
              spec-draft-n-max = 2;
              spec-type = "draft-mtp";
            };
            # "unsloth/gemma-4-12B-it-qat-Q4_K_XL" = {
            #   alias = "Gemma 4 12B";
            #   hf-repo = "unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL";
            #   spec-type = "none";
            #   ctx-size = 32768;
            # };
            "unsloth/gemma-4-26B-A4B-it-qat-Q4_K_XL" = {
              alias = "Gemma 4 26B A4B";
              hf-repo = "unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL";
              n-gpu-layers = "auto";
            };

            "unsloth/Qwen3.5-2B-MTP-Q4_K_XL" = {
              alias = "Qwen 3.5 2B";
              hf-repo = "unsloth/Qwen3.5-2B-MTP-GGUF:UD-Q4_K_XL";
              min-p = 0.00;
              top-k = 20;
              cache-type-k = "q8_0";
              cache-type-v = "q8_0";
              # load-on-startup = "true";
            };
            "unsloth/Qwen3.5-4B-MTP-Q4_K_XL" = {
              alias = "Qwen 3.5 4B";
              hf-repo = "unsloth/Qwen3.5-4B-MTP-GGUF:UD-Q4_K_XL";
              min-p = 0.00;
              top-k = 20;
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
            };
            "unsloth/Qwen3.5-9B-MTP-Q4_K_XL" = {
              alias = "Qwen 3.5 9B";
              hf-repo = "unsloth/Qwen3.5-9B-MTP-GGUF:UD-Q4_K_XL";
              min-p = 0.00;
              top-k = 20;
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
              n-gpu-layers = 15;
              spec-draft-n-max = 2;
              spec-type = "draft-mtp";
            };
            # "unsloth/Qwen3.6-27B-Q4_K_XL" = {
            #   alias = "Qwen 3.6 27B";
            #   hf-repo = "unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL";
            #   min-p = 0.00;
            #   top-k = 20;
            #   cache-type-k = "q8_0";
            #   cache-type-v = "q8_0";
            # };
            # "unsloth/Qwen3.6-35B-A3B-Q4_K_XL" = {
            #   alias = "Qwen 3.6 35B A3B";
            #   hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_XL";
            #   min-p = 0.00;
            #   top-k = 20;
            #   n-gpu-layers = "auto";
            # };
          };
        };
      };
      systemd.services.llama-cpp = {
        environment = {
          MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
          XDG_CACHE_HOME = "/var/cache/llama-cpp";
          XDG_DATA_HOME = "/var/cache/llama-cpp";
        };
      };
    }
  );
}
