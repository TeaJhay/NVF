{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  vim = {
    languages = {
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      bash.enable = true;
      yaml.enable = true;
    };
    treesitter = {
      enable = true;
      context.enable = false;
      fold = true;
    };
    lsp = {
      enable = true;
      formatOnSave = false;
      lightbulb.enable = true; # Shows a lightbulb when code actions are available
      otter-nvim.enable = true; # Runs proper LSP inside codeblocks
      inlayHints.enable = true;
      trouble.enable = true;
    };
    luaConfigRC.hoverDocs = lib.nvim.dag.entryAnywhere ''
      vim.g.hover_docs = false

      local function toggle_hover_docs()
        vim.g.hover_docs = not vim.g.hover_docs
        vim.notify("Hover docs: " .. (vim.g.hover_docs and "on" or "off"))
      end

      vim.api.nvim_create_user_command("HoverDocsToggle", toggle_hover_docs, {})
      vim.keymap.set("n", "<leader>k", toggle_hover_docs, { desc = "Toggle hover docs" })
    '';

    augroups = [
      {
        name = "Docs";
        clear = true;
      }
    ];

    autocmds = [
      {
        group = "Docs";
        event = ["CursorHold"];
        desc = "Show attribute documentation";
        callback = mkLuaInline ''
          function()
            if not vim.g.hover_docs then return end
            vim.diagnostic.open_float(nil, {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = "rounded",
              source = "always",
              prefix = " ",
              scope = "cursor",
            })
            vim.lsp.buf.hover()
          end
        '';
      }
    ];
  };
}
