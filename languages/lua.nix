{
  vim = {
    languages.lua = {
      enable = true;
      format.enable = true;
    };

    lsp = {
      enable = true;
      # Use the direct servers map to supply lua_ls configuration configurations
      servers.lua_ls = {
        enable = true;
        settings = ''
          {
            Lua = {
              workspace = {
                library = {
                  "/run/current-system/sw/share/hypr/stubs"
                },
                checkThirdParty = false
              },
              diagnostics = {
                globals = { "hl", "vim" }
              }
            }
          }
        '';
      };
    };
  };
}
