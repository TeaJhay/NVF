{
  vim = {
    utility.oil-nvim = {
      enable = true;
      gitStatus.enable = true;
      setupOpts = {
        keymaps = {
          "-" = "actions.parent";
          "<BS>" = "actions.parent";
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
        desc = "Open Oil file navigation";
        silent = true;
      }
    ];
  };
}
