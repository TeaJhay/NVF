{
  pkgs,
  inputs ? import ./.tack,
  ...
}: let
  mkPlugin = name: extra: let
    meta = inputs._meta.${name};
  in
    pkgs.vimUtils.buildVimPlugin ({
        pname = name;
        src = inputs.${name};
        version = meta.version or meta.tag or meta.rev or "git";
      }
      // extra);
in rec {
  aquavium-nvim = mkPlugin "aquavium.nvim" {};
  oasis-nvim = mkPlugin "oasis.nvim" {};
  jj-nvim = mkPlugin "jj.nvim" {};
  matugen-nvim = mkPlugin "matugen.nvim" {};
  sshfs-nvim = mkPlugin "sshfs.nvim" {};
  plenary-nvim = mkPlugin "plenary.nvim" {
    nvimSkipModules = ["plenary.neorocks.init"];
  };
  rustlings-nvim = mkPlugin "rustlings.nvim" {
    dependencies = [
      plenary-nvim
    ];

    # fallback if it still fails, e.g. modules that need the rustlings binary
    # nvimSkipModules = [ "rustlings" "rustlings.cli" ... ];
  };
}
