#
let
  allModes = [
    "n"
    "i"
    "v"
    "c"
    "t"
    "o"
    "x"
    "s"
  ];
  mkBind = mode: key: action: {
    inherit mode key action;
    silent = true;
  };
  mkNBind = key: action: mkBind "n" key action;
  mkVBind = key: action: mkBind "v" key action;
  mkAllBind = key: action: mkBind allModes key action;
in {
  vim.keymaps = [
    # Buffer Navigation
    (mkNBind "<M-w>" ":bdelete<CR>")
    (mkNBind "<leader>nn" "<cmd>:enew<CR>")
    (mkNBind "<tab>" "<cmd>:bprevious<CR>")
    (mkNBind "<S-tab>" "<cmd>:bnext<CR>")
    # Save/Quit
    (mkAllBind "<C-S>" "<cmd>write<cr>")
    # Close Buffer
    (mkAllBind "<C-X>" "<cmd>:bdelete!<cr>")
    # Quit
    (mkAllBind "<C-Q>" "<cmd>:q!<cr>")
    # Save and Quit
    (mkAllBind "<M-q>" "<cmd>write<cr>:q!<cr>")
    # Remove F1 for help
    (mkAllBind "<F1>" "<Nop>")
    # Move lines
    (mkVBind "J" ":m '>+1<cr>gv=gv")
    (mkVBind "K" ":m '<-2<cr>gv=gv")
    # Insert tab characters because tab key is not reliable for it
    (mkBind "i" "<A-t>" "<C-v><Tab>")
    # Open Neotree
    (mkNBind "<leader>e" "<cmd>:Neotree focus<CR>")
    (mkNBind "x" "<nop>")
    # Open JJ
    (mkNBind "jj" ":J<CR>")
    (mkNBind "j" "<nop>")
    (mkNBind "<Esc>" ":noh<CR>")
    {
      mode = "n";
      key = "<A-Left>";
      action = "ge";
      silent = true;
      desc = "Go to end of previous word";
    }
  ];
  vim.tabline.nvimBufferline.mappings.closeCurrent = "<leader>bx";
}
