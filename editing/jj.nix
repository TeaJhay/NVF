{ pkgs, ... }:
let
  localPlugins = import ../vimPlugins.nix { inherit pkgs; };
in
{
  vim = {
    extraPlugins = {
      # Becomes the default theme
      jj = {
        package = localPlugins.jj-nvim;
        setup =
          # lua
          ''
            require("jj").setup({})
          '';
      };
    };
  };
}
