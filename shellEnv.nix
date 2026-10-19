{
  pkgs ? import <nixpkgs> {},
  extraPkgs ? [],
}:
pkgs.buildEnv {
  name = "nvf-shell-tools";
  pathsToLink = ["/bin"];
  paths = with pkgs;
    [
      deno
      nixfmt
      treefmt
      lefthook
      deadnix
      statix
      typos
      nixd
      alejandra
      rustc
    ]
    ++ extraPkgs;
}
