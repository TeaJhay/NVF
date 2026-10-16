{pkgs, ...}: {
  vim = {
    #extraPackages = [pkgs.rustc pkgs.cargo pkgs.rustfmt];
    languages = {
      css = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        format.enable = true;
      };
      typescript = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        format.enable = true;
      };
      astro = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        format.enable = true;
      };
    };
    luaConfigRC.astro-tsdk = ''
      vim.lsp.config('astro', {
        before_init = function(_, config)
          local root = config.root_dir or vim.fn.getcwd()
          config.init_options = config.init_options or {}
          config.init_options.typescript = {
            tsdk = root .. '/node_modules/typescript/lib',
          }
        end,
      })
    '';
  };
}
