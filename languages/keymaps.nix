{
  vim.keymaps = [
    {
      mode = "n";
      key = "f<leader>";
      action = ":lua vim.lsp.buf.format()<CR>";
      silent = true;
    }
    {
      mode = "n";
      key = "<leader>d";
      action = ":lua vim.diagnostic.open_float()<CR>";
      silent = true;
    }
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<CR>";
      silent = true;
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
      silent = true;
    }
    {
      mode = "n";
      key = "<leader>xL";
      action = "<cmd>Trouble loclist toggle<CR>";
      silent = true;
    }
    {
      mode = "n";
      key = "<leader>xQ";
      action = "<cmd>Trouble qflist toggle<CR>";
      silent = true;
    }
    {
      key = "K";
      mode = "n";
      lua = true;
      silent = true;
      desc = "Toggle LSP hover";
      action = ''
        function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_config(win).relative ~= "" then
              vim.api.nvim_win_close(win, true)
              return
            end
          end
          vim.lsp.buf.hover()
        end
      '';
    }
  ];
}
