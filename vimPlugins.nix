{
  pkgs,
  inputs ? import ./.tack,
  ...
}: let
  mkPlugin = name: let
    meta = inputs._meta.${name};
  in
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      src = inputs.${name};
      version = meta.version or meta.tag or meta.rev or "git";
    };
in {
  aquavium-nvim = mkPlugin "aquavium.nvim";
  oasis-nvim = mkPlugin "oasis.nvim";
  jj-nvim = mkPlugin "jj.nvim";
  matugen-nvim = mkPlugin "matugen.nvim";
  sshfs-nvim = mkPlugin "sshfs.nvim";
}
