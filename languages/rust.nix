{pkgs, ...}: {
  vim = {
    extraPackages = [pkgs.rustc pkgs.cargo pkgs.rustfmt];
    languages.rust = {
      enable = true;
      dap.enable = false;
      lsp.enable = false;
      treesitter.enable = true;
      extensions = {
        crates-nvim = {
          enable = true;
          setupOpts.lsp.enabled = true;
        };
        rustaceanvim = {
          enable = true;
        };
      };
    };
  };
}
