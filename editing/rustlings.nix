{pkgs, ...}: let
  localPlugins = import ../vimPlugins.nix {inherit pkgs;};
in {
  vim = {
    extraPackages = [pkgs.rustlings];
    extraPlugins = {
      plenary = {
        package = localPlugins.plenary-nvim;
      };
      rustlings = {
        package = localPlugins.rustlings-nvim;
        setup =
          # lua
          ''
            require("rustlings").setup({
              -- Path to rustlings directory (auto-detected if nil)
              rustlings_path = nil,

              keymaps = {
                next = "<leader>rn", -- Set to false to disable
              },

              progress = {
                show_in_statusline = true,
              },

              telescope = {
                show_completed = true,
                show_pending = true,
                layout_strategy = "vertical",
              },
            })'';
      };
    };
  };
}
