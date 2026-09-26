{pkgs, ...}: {
  vim = {
    extraPlugins.transparent-nvim = {
      package = pkgs.vimPlugins.transparent-nvim;
      setup =
        # lua
        ''
          local function apply_transparency(enabled)
            local groups = {
              "Normal", "NormalNC", "SignColumn", "EndOfBuffer",
              "StatusLine", "StatusLineNC", "NormalFloat", "LineNr",
              "CursorLineNr", "VertSplit", "WinSeparator",
            }
            for _, group in ipairs(groups) do
              local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
              if enabled then
                hl.bg = nil
                hl.ctermbg = nil
              end
              vim.api.nvim_set_hl(0, group, hl)
            end
          end

          _G.MyTransparentApply = apply_transparency
          vim.g.my_transparent = true -- transparent by default
        '';
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>tt";
        lua = true;
        action = ''
          function()
            vim.g.my_transparent = not vim.g.my_transparent
            package.loaded["matugen"] = nil
            require("matugen").setup()
            _G.MyTransparentApply(vim.g.my_transparent)
          end
        '';
      }
    ];
  };
}
