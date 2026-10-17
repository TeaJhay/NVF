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
    autocmds = [
      # Example 1: Using a Lua callback
      {
        event = ["CursorHold"];
        desc = "Notify after saving Lua file";
        callback = mkLuaInline ''
          function()
              local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
              }
              vim.diagnostic.open_float(nil, opts)
              vim.lsp.buf.hover()
            end
        '';
      }
    ];
  };
}
