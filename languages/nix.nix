{pkgs, ...}: {
  vim = {
    extraPackages = [pkgs.alejandra];
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
      -- All flake refs recorded in the user's nix profile (live refs, local ones first)
      local function profile_refs()
        local f = io.open(vim.fn.expand("~/.nix-profile/manifest.json"), "r")
        if not f then
          return {}
        end
        local ok, data = pcall(vim.json.decode, f:read("*a"))
        f:close()
        if not ok or type(data) ~= "table" then
          return {}
        end

        local seen, locals, remotes = {}, {}, {}
        for _, e in pairs(data.elements or {}) do
          local ref = e.originalUrl or e.url
          if type(ref) == "string" and not seen[ref] then
            seen[ref] = true
            if ref:match("^path:") or ref:match("^git%+file:") then
              table.insert(locals, ref)
            else
              table.insert(remotes, ref)
            end
          end
        end
        table.sort(locals)
        table.sort(remotes)
        vim.list_extend(locals, remotes)
        return locals
      end

      -- Nix expr: first profile flake that has an input starting with "nixpkgs";
      -- if the flake is itself nixpkgs, use it directly; else fall back to the registry.
      local function profile_nixpkgs_expr()
        local refs = {}
        for _, r in ipairs(profile_refs()) do
          table.insert(refs, vim.json.encode(r))
        end
        return "let "
          .. "refs = [ "
          .. table.concat(refs, " ")
          .. " ]; "
          .. "pick = ref: let "
          .. "f = builtins.getFlake ref; "
          .. 'ns = builtins.filter (k: builtins.substring 0 7 k == "nixpkgs") '
          .. "(builtins.attrNames (f.inputs or {})); "
          .. "in if ns != [ ] then builtins.getAttr (builtins.head ns) f.inputs "
          .. "else if f ? legacyPackages then f else null; "
          .. "try = ref: let r = builtins.tryEval (pick ref); in if r.success then r.value else null; "
          .. "found = builtins.filter (x: x != null) (map try refs); "
          .. 'in import (if found != [ ] then builtins.head found else builtins.getFlake "nixpkgs") { }'
      end

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
          local host = vim.fn.hostname()
          local settings = {}

          if root then
            local flake = string.format('(builtins.getFlake "%s")', root)
            settings.nixpkgs = {
              expr = string.format("import ((import %s/.tack) { }).nixpkgs { }", root),
            }
            settings.options = {
              nixos = {
                expr = string.format(
                  "let c = %s.nixosConfigurations or {}; in "
                    .. "if c == {} then {} else "
                    .. '(builtins.getAttr (if c ? "%s" then "%s" else builtins.head (builtins.attrNames c)) c).options',
                  flake,
                  host,
                  host
                ),
              },
              nvf = {
                expr = string.format("%s.config.options", flake),
              },
            }
          else
            settings.nixpkgs = { expr = profile_nixpkgs_expr() }
          end

          client.settings = vim.tbl_deep_extend("force", client.settings or {}, { nixd = settings })
          client:notify("workspace/didChangeConfiguration", { settings = client.settings })
        end,
      })
    '';
    ui.smartcolumn.setupOpts.custom_colorcolumn.nix = [
      "110"
    ];
  };
}
