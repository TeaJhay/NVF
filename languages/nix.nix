{
  vim = {
    languages.nix = {
      enable = true;
      extraDiagnostics = {
        enable = true;
        types = ["statix"];
      };
      format = {
        enable = true;
        type = ["alejandra" "injected"];
      };
      lsp.servers = ["nixd"];
    };

    lsp.servers.nixd.settings.nixd = {
      formatting.command = ["alejandra"];
    };
    luaConfigRC.nixd-dynamic = ''
      local function flake_root(client)
        if client.root_dir and vim.uv.fs_stat(client.root_dir .. "/flake.nix") then
          return client.root_dir
        end
        local found = vim.fs.find("flake.nix", { upward = true, path = vim.fn.getcwd() })[1]
        return found and vim.fs.dirname(found) or nil
      end

      vim.lsp.config("nixd", {
        on_init = function(client)
          local root = flake_root(client)
          if not root then return end

          local host = vim.fn.hostname()

          client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
            nixd = {
              nixpkgs = {
                expr = string.format(
                  'import (builtins.getFlake "%s").inputs.nixpkgs { }', root),
              },
              options = {
                nixos = {
                  expr = string.format(
                    'let c = (builtins.getFlake "%s").nixosConfigurations; in '
                    .. '(builtins.getAttr (if c ? "%s" then "%s" else builtins.head (builtins.attrNames c)) c).options',
                    root, host, host),
                },
              },
            },
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.settings })
        end,
      })'';
    ui.smartcolumn.setupOpts.custom_colorcolumn.nix = [
      "110"
    ];
  };
}
