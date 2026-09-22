{
  vim = {
    languages.lua = {
      enable = true;
      format.enable = true; # registers stylua into conform for .lua files
    };

    formatter.conform-nvim = {
      setupOpts = {
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "never"; # conform only, never falls back to an LSP formatter
        };
      };
    };

    lsp = {
      enable = true;
      servers.lua_ls = {
        enable = true;
        settings = {
          Lua = {
            format.enable = false; # belt-and-suspenders: lua_ls won't even offer to format
            workspace = {
              library = [ "/run/current-system/sw/share/hypr/stubs" ];
              checkThirdParty = false;
            };
            diagnostics.globals = [
              "hl"
              "vim"
            ];
          };
        };
      };
    };
  };
}
