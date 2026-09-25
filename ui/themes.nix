{
  pkgs,
  lib,
  ...
}: let
  localPlugins = import ../vimPlugins.nix {inherit pkgs;};
in {
  vim = {
    theme.enable = false;

    # base16-nvim just needs to be on the runtime path — matugen's generated
    # file is the one that calls require('base16-colorscheme').setup(...)
    startPlugins = [pkgs.vimPlugins.base16-nvim];

    luaConfigRC.matugen = lib.nvim.dag.entryAfter ["pluginConfigs"] ''
      vim.opt.rtp:prepend(vim.fn.expand('~/.config/nvim'))
      require('matugen').setup()
    '';
    lazy.plugins =
      (with pkgs.vimPlugins; {
        "neovim-ayu".package = neovim-ayu;
        "kanso.nvim".package = kanso-nvim;
        "kanagawa.nvim".package = kanagawa-nvim;
        "gruvbox.nvim".package = gruvbox-nvim;
        "vague.nvim".package = vague-nvim;
        "edge".package = edge;
        "lackluster.nvim".package = lackluster-nvim;
      })
      // (with localPlugins; {
        "aquavium.nvim".package = aquavium-nvim;
      });
  };
}
