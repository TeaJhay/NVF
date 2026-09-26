{
  description = "NVF Flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixd = {
      #nixd language server
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixd,
    nixpkgs,
    nvf,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    p = forAllSystems (system: import nixpkgs {inherit system;});

    mkNvf = pkgs:
      nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [./nvf.nix];
      };
  in {
    # For Config Sampling
    config = mkNvf p.x86_64-linux;
    packages = forAllSystems (
      system: let
        pkgs = p.${system};
        neovimPkg = (mkNvf pkgs).neovim;
        mkAlias = name:
          pkgs.writeShellApplication {
            inherit name;
            text = ''exec "${pkgs.lib.getExe neovimPkg}" "$@";'';
          };
      in {
        default = pkgs.symlinkJoin {
          name = "nvf";
          paths = [
            (mkAlias "nvf")
            (mkAlias "vi")
            (mkAlias "nvim")
            (mkAlias "vim")
          ];
        };
        nvf-unwrapped = neovimPkg;
        shell = import ./shellEnv.nix {inherit pkgs;};
      }
    );
  };
}
