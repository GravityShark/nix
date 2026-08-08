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
      # llama-cpp = pkgs.llama-cpp-vulkan;
      llama-cpp = (
        pkgs.llama-cpp.override {
          cudaSupport = true;
          vulkanSupport = true;
          blasSupport = true;
        }
      );
    in
    {
      environment.systemPackages = [ llama-cpp ];

      services.llama-cpp = {
        enable = true;
        package = llama-cpp;
        openFirewall = true;
        settings = {
          api-key = "bingo";
          models-max = 1;
          no-mmproj-offload = "";
          port = 9931;
          # ui-mcp-proxy = "";
          verbosity = 5;
          models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
            "*" = {
              # fit-ctx = 16384;
              # fit-ctx = 32768;
              # fit-ctx = 65536;
              # ctx-size = 32768;
              ctx-size = 65536;
              # ctx-size = 131072;

              batch-size = 512;
              ubatch-size = 512;

              device = "CUDA0";
              fit-target = "0";
              flash-attn = "on";
              n-gpu-layers = "all";
              parallel = 1;
              sleep-idle-seconds = 300;
              temp = 1.0;
              top-k = 64;
              top-p = 0.95;
            };
            "Main/gemma-4-E2B-it-qat-Q4_K_XL" = {
              hf-repo = "unsloth/gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL";
              cache-type-k = "q8_0";
              cache-type-v = "q8_0";
            };
            "Main/gemma-4-26B-A4B-it-qat-Q4_K_XL" = {
              hf-repo = "unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL";
              n-gpu-layers = "auto";
            };

            # QWENN
            "Main/Qwen3.5-2B-Q4_K_XL" = {
              hf-repo = "unsloth/Qwen3.5-2B-GGUF:UD-Q4_K_XL";
              cache-type-k = "q8_0";
              cache-type-v = "q8_0";
              min-p = 0.00;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              top-k = 20;
            };
            "Main/Qwen3.5-2B-Q4_K_XL-Coding" = {
              hf-repo = "unsloth/Qwen3.5-2B-GGUF:UD-Q4_K_XL";
              cache-type-k = "q8_0";
              cache-type-v = "q8_0";
              min-p = 0.00;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              temperature = 0.6;
              top-k = 20;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };
            "Main/Qwen3.5-2B-Q4_K_XL-GeneralInstruct" = {
              hf-repo = "unsloth/Qwen3.5-2B-GGUF:UD-Q4_K_XL";
              cache-type-k = "q8_0";
              cache-type-v = "q8_0";
              min-p = 0.00;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              temperature = 0.8;
              top-k = 20;
              top-p = 0.8;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };

            "Main/Qwen3.5-4B-Q4_K_XL" = {
              hf-repo = "unsloth/Qwen3.5-4B-GGUF:UD-Q4_K_XL";
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
              min-p = 0.00;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              top-k = 20;
              ctx-size = 32768;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };
            "Main/Qwen3.5-4B-Q4_K_XL-Coding" = {
              hf-repo = "unsloth/Qwen3.5-4B-GGUF:UD-Q4_K_XL";
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
              min-p = 0.00;
              temperature = 0.6;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              top-k = 20;
              ctx-size = 32768;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };
            "Main/Qwen3.5-4B-Q4_K_XL-GeneralInstruct" = {
              hf-repo = "unsloth/Qwen3.5-4B-GGUF:UD-Q4_K_XL";
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
              min-p = 0.00;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              temperature = 0.8;
              top-k = 20;
              top-p = 0.8;
              ctx-size = 32768;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };

            "Main/Qwen3.5-4B-IQ4_XS" = {
              hf-repo = "unsloth/Qwen3.5-4B-GGUF:IQ4_XS";
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
              min-p = 0.00;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              top-k = 20;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };
            "Main/Qwen3.5-4B-IQ4_XS-Coding" = {
              hf-repo = "unsloth/Qwen3.5-4B-GGUF:IQ4_XS";
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
              min-p = 0.00;
              temperature = 0.6;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              top-k = 20;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };
            "Main/Qwen3.5-4B-IQ4_XS-GeneralInstruct" = {
              hf-repo = "unsloth/Qwen3.5-4B-GGUF:IQ4_XS";
              cache-type-k = "q4_0";
              cache-type-v = "q4_0";
              min-p = 0.00;
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              temperature = 0.8;
              top-k = 20;
              top-p = 0.8;
              chat-template-kwargs = "{\"enable_thinking\":true}";
            };

            "Main/Qwen3.6-35B-A3B-IQ4_XS" = {
              hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-IQ4_XS";
              min-p = 0.00;
              n-gpu-layers = "auto";
              presence-penalty = 1.5;
              repeat-penalty = 1.0;
              top-k = 20;
            };
          };
        };
      };
      systemd.services.llama-cpp = {
        environment = {
          MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
          XDG_CACHE_HOME = "/var/cache/llama-cpp";
          XDG_DATA_HOME = "/var/cache/llama-cpp";
        };
        # serviceConfig = {
        #   WorkingDirectory = lib.mkForce "/var/empty";
        #   Environment = lib.mkForce [ "LLAMA_CACHE=/var/lib/llama-cpp" ];
        # };
      };
    }
  );
}

# "Main/fun" = {
#   hf-repo = "huihui-ai/Huihui-gemma-4-E4B-it-qat-q4_0-unquantized-abliterated-GGUF";
# };
# "Main/gemma-4-E2B-it-MTP-qat-Q4_K_XL" = {
#   hf-repo = "unsloth/gemma-4-E2B-it-qat-GGUF:UD-Q4_K_XL";
#   spec-draft-n-max = 2;
#   spec-type = "draft-mtp";
# };
# "Main/gemma-4-E4B-it-MTP-qat-Q4_K_XL" = {
#   hf-repo = "unsloth/gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL";
#   spec-draft-n-max = 2;
#   spec-type = "draft-mtp";
# };
# "Main/gemma-4-12B-it-qat-Q4_K_XL" = {
#   alias = "Gemma 4 12B";
#   hf-repo = "unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL";
#   spec-draft-n-max = 2;
#   spec-type = "draft-mtp";
# };
# "Main/Qwen3.5-2B-MTP-Q4_K_XL" = {
#   hf-repo = "unsloth/Qwen3.5-2B-MTP-GGUF:UD-Q4_K_XL";
#   min-p = 0.00;
#   top-k = 20;
#   cache-type-k = "q8_0";
#   cache-type-v = "q8_0";
#   spec-draft-n-max = 2;
#   spec-type = "draft-mtp";
# };
# "Main/Qwen3.5-4B-MTP-Q4_K_XL" = {
#   hf-repo = "unsloth/Qwen3.5-4B-MTP-GGUF:UD-Q4_K_XL";
#   min-p = 0.00;
#   top-k = 20;
#   cache-type-k = "q8_0";
#   cache-type-v = "q8_0";
#   spec-draft-n-max = 2;
#   spec-type = "draft-mtp";
# };
# "Main/Qwen3.5-9B-MTP-Q4_K_XL" = {
#   alias = "Qwen 3.5 9B";
#   hf-repo = "unsloth/Qwen3.5-9B-MTP-GGUF:UD-Q4_K_XL";
#   min-p = 0.00;
#   top-k = 20;
#   cache-type-k = "q4_0";
#   cache-type-v = "q4_0";
#   n-gpu-layers = 15;
#   spec-draft-n-max = 2;
#   spec-type = "draft-mtp";
# };
# "unsloth/Qwen3.6-27B-Q4_K_XL" = {
#   alias = "Qwen 3.6 27B";
#   hf-repo = "unsloth/Qwen3.6-27B-GGUF:UD-Q4_K_XL";
#   min-p = 0.00;
#   top-k = 20;
#   cache-type-k = "q8_0";
#   cache-type-v = "q8_0";
# };
