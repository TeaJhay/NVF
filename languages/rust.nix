{pkgs, ...}: {
  vim = {
    extraPackages = [pkgs.rustc pkgs.cargo pkgs.rustfmt];
    languages.rust = {
      enable = true;
      dap.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      extensions.crates-nvim = {
        enable = true;
        setupOpts.lsp.enabled = true;
      };
    };
  };
}
