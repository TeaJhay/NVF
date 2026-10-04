{pkgs, ...}: let
  localPlugins = import ../vimPlugins.nix {inherit pkgs;};
in {
  vim = {
    extraPlugins = {
      # Becomes the default theme
      sshfs = {
        package = localPlugins.sshfs-nvim;
        setup =
          # lua
          ''
            require("sshfs").setup({
              connections = {
                ssh_configs = { -- Table of ssh config file locations to use
                  "~/.ssh/config",
                  "/etc/ssh/ssh_config",
                },
                -- SSHFS mount options (table of key-value pairs converted to sshfs -o arguments)
                -- Boolean flags: set to true to include, false/nil to omit
                -- String/number values: converted to key=value format
                sshfs_options = {
                  reconnect = true, -- Auto-reconnect on connection loss
                  ConnectTimeout = 5, -- Connection timeout in seconds
                  compression = "yes", -- Enable compression
                  ServerAliveInterval = 15, -- Keep-alive interval (15s × 3 = 45s timeout)
                  ServerAliveCountMax = 3, -- Keep-alive message count
                  dir_cache = "yes", -- Enable directory caching
                  dcache_timeout = 300, -- Cache timeout in seconds
                  dcache_max_size = 10000, -- Max cache size
                  -- allow_other = true,        -- Allow other users to access mount
                  -- uid = "1000,gid=1000",     -- Set file ownership (use string for complex values)
                  -- follow_symlinks = true,    -- Follow symbolic links
                },
                control_persist = "10m", -- How long to keep ControlMaster connection alive after last use
                socket_dir = vim.fn.expand("$HOME/.ssh/sockets"), -- Directory for ControlMaster sockets
              },
              mounts = {
                base_dir = vim.fn.expand("$HOME") .. "/Dev/vfs", -- where remote mounts are created
              },
              global_paths = {
                -- Optionally define default mount paths for ALL hosts
                -- These appear as options when connecting to any host
                -- Examples:
                -- "~/.config",
                -- "/var/www",
                -- "/srv",
                -- "/opt",
                -- "/var/log",
                -- "/etc",
                -- "/tmp",
                -- "/usr/local",
                -- "/data",
                -- "/var/lib",
              },
              host_paths = {
                -- Optionally define default mount paths for specific hosts
                -- These are shown in addition to global_paths
                -- Single path (string):
                -- ["my-server"] = "/var/www/html"
                --
                -- Multiple paths (array):
                -- ["dev-server"] = { "/var/www", "~/projects", "/opt/app" }
              },
              hooks = {
                on_exit = {
                  auto_unmount = true, -- auto-disconnect all mounts on :q or exit
                  clean_mount_folders = true, -- optionally clean up mount folders after disconnect
                },
                on_mount = {
                  auto_change_to_dir = true, -- auto-change current directory to mount point
                  auto_run = "find", -- "find" (default), "grep", "live_find", "live_grep", "terminal", "none", or a custom function(ctx)
                },
              },
              ui = {
                local_picker = {
                  preferred_picker = "auto", -- one of: "auto", "snacks", "fzf-lua", "mini", "telescope", "oil", "neo-tree", "nvim-tree", "yazi", "lf", "nnn", "ranger", "netrw"
                  fallback_to_netrw = true, -- fallback to netrw if no picker is available
                  netrw_command = "Explore", -- netrw command: "Explore", "Lexplore", "Sexplore", "Vexplore", "Texplore"
                },
                remote_picker = {
                  preferred_picker = "auto", -- one of: "auto", "snacks", "fzf-lua", "telescope", "mini"
                },
              },
              debug = {
                enabled = false, -- write SSH/SSHFS diagnostics to a log file
                log_file = vim.fn.stdpath("log") .. "/sshfs.nvim.log",
                max_size = 1048576, -- rotate to <log_file>.1 past this size (0 disables)
              },
              lead_prefix = "<leader>m", -- change keymap prefix (default: <leader>m)
              keymaps = {
                mount = "<leader>mm", -- creates an ssh connection and mounts via sshfs
                unmount = "<leader>mu", -- disconnects an ssh connection and unmounts via sshfs
                unmount_all = "<leader>mU", -- disconnects all ssh connections and unmounts via sshfs
                explore = "<leader>me", -- explore an sshfs mount using your native editor
                change_dir = "<leader>md", -- change dir to mount
                command = "<leader>mo", -- run command on mount
                config = "<leader>mc", -- edit ssh config
                reload = "<leader>mr", -- manually reload ssh config
                files = "<leader>mf", -- browse files using chosen picker
                grep = "<leader>mg", -- grep files using chosen picker
                terminal = "<leader>mt", -- open ssh terminal session
              },
            })
          '';
      };
    };
  };
}
