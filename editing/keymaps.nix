{lib, ...}: let
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
  mkBind = mode: key: action: desc: {
    inherit mode key action desc;
    silent = true;
  };
  mkNBind = key: action: desc: mkBind "n" key action desc;
  mkVBind = key: action: desc: mkBind "v" key action desc;
  mkAllBind = key: action: desc: mkBind allModes key action desc;
in {
  vim = {
    keymaps = [
      # Buffer Navigation
      (mkNBind "<M-w>" ":bdelete<CR>" "Close buffer")
      (mkNBind "<leader>nn" "<cmd>:enew<CR>" "New buffer")
      (mkNBind "<tab>" "<cmd>:bnext<CR>" "Move to next buffer")
      (mkNBind "<S-tab>" "<cmd>:previous<CR>" "Move to previous buffer")
      # Save/Quit
      (mkAllBind "<C-s>" "<cmd>write<cr>" "Write buffer")
      # Close Buffer
      (mkNBind "<C-x>" "<cmd>:bdelete!<cr>" "Force close buffer")
      # Quit
      (mkNBind "<C-q>" "<cmd>:q!<cr>" "Quit neovim")
      # Save and Quit
      (mkAllBind "<M-q>" "<cmd>write<cr>:q!<cr>" "Write and quit")
      # Remove F1 for help
      (mkAllBind "<F1>" "<Nop>" "Disable F1 key")
      # Move lines
      # Visual Mode (Moving selections)
      (mkVBind "<M-left>" "<Cmd>lua MiniMove.move_selection('left')<CR>" "Move selection left")
      (mkVBind "<M-right>" "<Cmd>lua MiniMove.move_selection('right')<CR>" "Move selection right")
      (mkVBind "<M-Down>" "<Cmd>lua MiniMove.move_selection('down')<CR>" "Move selection down")
      (mkVBind "<M-Up>" "<Cmd>lua MiniMove.move_selection('up')<CR>" "Move selection up")

      # Normal Mode (Moving single lines)
      (mkNBind "<M-left>" "<Cmd>lua MiniMove.move_line('left')<CR>" "Move line left")
      (mkNBind "<M-right>" "<Cmd>lua MiniMove.move_line('right')<CR>" "Move line right")
      (mkNBind "<M-Down>" "<Cmd>lua MiniMove.move_line('down')<CR>" "Move line down")
      (mkNBind "<M-Up>" "<Cmd>lua MiniMove.move_line('up')<CR>" "Move line up")
      # Insert tab characters because tab key is not reliable for it
      (mkBind "i" "<A-t>" "<C-v><Tab>" "Insert tab character")
      # Open Neotree
      (mkNBind "<leader>e" "<cmd>:Neotree focus<CR>" "Open neotree")
      (mkNBind "x" "<nop>" "Disable x key")
      # Open JJ
      (mkNBind "jj" ":J<CR>" "Open jujutsu")
      (mkNBind "j" "<nop>" "Disable j key")
      (mkNBind "<Esc>" ":noh<CR>" "Clear highlights/selection")
      {
        mode = "n";
        key = "<A-Left>";
        action = "ge";
        silent = true;
        desc = "Go to end of previous word";
      }
    ];
    # disable nvim 11.0 quickfix <C-Q> binds
    luaConfigRC = {
      remove-default-qf-maps = lib.nvim.dag.entryAnywhere ''
        for _, key in ipairs({ "q", "Q", "<C-Q>" }) do
          for _, prefix in ipairs({ "[", "]" }) do
            pcall(vim.keymap.del, "n", prefix .. key)
          end
        end
      '';
    };
    tabline = {nvimBufferline = {mappings = {closeCurrent = "<leader>bx";};};};
  };
}
