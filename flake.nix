{
  description = "NVF Flake";

  outputs = {self, ...} @ args: let
    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };
    inherit (nixpkgs) lib;
    assimilate = d:
      builtins.readDir d
      |> builtins.mapAttrs (name: type:
        if lib.hasPrefix "_" name
        then []
        else if type == "directory"
        then assimilate (d + "/${name}")
        else if lib.hasSuffix ".nix" name
        then [(d + "/${name}")]
        else [])
      |> builtins.attrValues
      |> builtins.concatLists;

    inherit (inputs) nixpkgs nvf;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
    p = forAllSystems (system: import nixpkgs {inherit system;});

    mkNvf = pkgs:
      nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [./nvf.nix] ++ lib.concatMap assimilate [./editing ./languages ./ui];
        extraSpecialArgs = {inherit assimilate;};
      };
  in {
    lib.assimilate = assimilate;
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
