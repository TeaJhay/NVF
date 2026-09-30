{
  vim = {
    languages.nix = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = ["statix"];
      };
      format = {
        enable = true;
        type = ["alejandra" "injected"];
      };
      lsp.servers = ["nixd"];
    };

    lsp.servers = {
      nixd = {
        settings.nixd = {
          formatting.command = ["alejandra"];
        };
      };
    };
    luaConfigRC.snix-filetype = ''
      vim.filetype.add({
        extension = {
          snix = "nix",
        },
      })
    '';
    ui.smartcolumn.setupOpts.custom_colorcolumn.nix = [
      "110"
    ];
  };
}
