{
  vim = {
    languages.markdown = {
      enable = true;
      format.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      extensions = {
        markview-nvim.enable = true;
      };
    };
    ui.smartcolumn.setupOpts.custom_colorcolumn.go = ["120"];
  };
}
