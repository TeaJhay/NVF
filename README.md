# NVF Flake

Originally forked from [Jet's config](https://github.com/Michael-C-Buckley/nvf).

<sub>before he changed configs again, traitor</sub>

This is my customized Neovim setup via [NVF](https://github.com/NotAShelf/nvf)
and has had alot of configurations done for how I like to use nvim.

This includes using tack for plugins, being a standalone setup for use outside
of my config/system and custom lua slop, primarily so nixd can see the inputs of
the profile and nix users flake to provide definitions and completions.

also a recursive import function (assimilate) written by
[Clémentine](https://github.com/eConnah/nix-dots), I've just added a filter to
match import-tree behaviour.

For an overview of the keybinds/functions, check
[the keybind page](./nvim_keys_sorted_v2.md) or the included pandoc PDF.

NVF is a Neovim framework in Nix. It trivialized creating and maintaining a
custom nvim setup.
