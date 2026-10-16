{
  vim = {
    utility.ccc = {
      enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>cc";
        action = "<CMD>CccPick<CR>";
        desc = "Color picker";
      }
    ];
  };
}
