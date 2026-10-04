{
  vim = {
    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        filesystem = {
          filtered_items = {
            visible = "true";
            hide_dotfiles = "false";
            hide_gitignored = "true";
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>nt";
        action = ":Neotree toggle<CR>";
      }
    ];
  };
}
