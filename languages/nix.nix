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
        type = ["alejandra"];
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

    ui.smartcolumn.setupOpts.custom_colorcolumn.nix = [
      "110"
    ];
  };
}
