{
  pkgs,
  lib,
  ...
}: {
  vim = {
    extraPlugins.transparent-nvim = {
      package = pkgs.vimPlugins.transparent-nvim;
      setup =
        # lua
        ''
          require("transparent").setup({})
        '';
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>tt";
        action = ":TransparentToggle<CR>:lua require('matugen').setup()<CR>";
      }
    ];
  };
}
