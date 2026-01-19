-- earttps://github.com/jellydn/tiny-nvim/blob/22d8e485653c17670244e204bc611bac58654cfd/lua/plugins/extra/codecompanion.lua#L135

-- lsp & treesitter
-- formatter (conform)
-- completion (blink)
-- runner
-- diagnostic
-- outline
-- ai
-- hilights

return {

  -- {
  --   'nvimdev/indentmini.nvim',
  --   event = 'BufEnter',
  --   config = function()
  --     require('indentmini').setup({
  --       char = '│',
  --       only_current = true,
  --     })
  --
  --     vim.cmd.highlight('default link IndentLine Comment')
  --   end,
  -- },

  -- https://github.com/nvim-mini/mini.hipatterns
  {
    "nvim-mini/mini.hipatterns",
    version = false,
    config = function()
      require("mini.hipatterns").setup({
        highlighters = {
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsNote" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsNote" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          xxx = { pattern = "%f[%w]()XXX()%f[%W]", group = "MiniHipatternsNote" },
        },
      })
      vim.api.nvim_set_hl(0, "MiniHipatternsNote", { bold = true, fg = "#ffffff" })
    end,
  },

  {
    "vim-test/vim-test",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    init = function()
      -- vim.g["test#custom_strategies"] = {
      --   zellij = function(cmd)
      --     if os.getenv("ZELLIJ") == nil then
      --       vim.notify("Cannot create Zellij pane to run tests. You are not in Zellij context.", "error")
      --       return
      --     end
      --
      --     local pipe_file_path = "/tmp/zellij-nvim-test-fifo"
      --
      --     local pgrepHandle = io.popen("ps aux | grep '[t]ail -f " .. pipe_file_path .. "'")
      --     local pgrepOutput = pgrepHandle:read("*a")
      --     pgrepHandle:close()
      --
      --     local is_pane_already_listening = pgrepOutput ~= ""
      --
      --     if not is_pane_already_listening then
      --       vim.notify("Running tests in new Zellij pane", "info")
      --       os.execute("rm -f" .. pipe_file_path)
      --       os.execute("mkfifo -m 600 " .. pipe_file_path)
      --       os.execute("zellij run -d down -c -n Tests -- bash -c 'tail -f " .. pipe_file_path .. " | bash' &")
      --       -- Resize new panel
      --       for _ = 0, 3 do
      --         os.execute("zellij action resize decrease up")
      --       end
      --       -- Focus back to Neovim
      --       os.execute("zellij action focus-previous-pane")
      --       -- A small delay to ensure `tail` has started (maybe not necessary?)
      --       os.execute("sleep 0.05")
      --     else
      --       vim.notify("Running tests in existing Zellij pane", "info")
      --     end
      --
      --     local escaped_cmd = cmd:gsub('"', '\\"')
      --     os.execute("echo '" .. escaped_cmd .. "' > " .. pipe_file_path)
      --   end,
      -- }

      vim.g["test#strategy"] = "toggleterm"
    end,
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
    },
    keys = {
      { "<leader>tn", "<cmd>TestNearest<CR>" },
      -- { "<leader>tf", "<cmd>TestFile<CR>" },
      -- { "<leader>ts", "<cmd>TestSuite<CR>" },
      -- { "<leader>tl", "<cmd>TestLast<CR>" },
      -- { "<leader>tg", "<cmd>TestVisit<CR>" },
    },
  },

  -- https://github.com/nvim-neotest/neotest
  --
  -- References:
  -- https://tamerlan.dev/setting-up-a-testing-environment-in-neovim/
  -- {
  --   "nvim-neotest/neotest",
  --   event = { "BufReadPost", "BufNewFile" },
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --
  --     -- "folke/trouble.nvim",
  --
  --     -- Runners
  --     "jfpedroza/neotest-elixir",
  --   },
  --   -- keys = {
  --   --   -- {
  --   --   --   "<leader>tn",
  --   --   --   "<cmd>lua require('neotest').run.run()<cr>",
  --   --   --   desc = "Run nearest test",
  --   --   -- },
  --   --   {
  --   --     "<leader>tn",
  --   --     function()
  --   --       require("neotest").run.run()
  --   --     end,
  --   --     desc = "Run nearest test",
  --   --   },
  --   --   {
  --   --     "<leader>ta",
  --   --     function()
  --   --       -- require("neotest").run.run()
  --   --       require("neotest").run.attach()
  --   --       -- require("neotest").run.run({ vim.fn.expand("%") })
  --   --     end,
  --   --     desc = "Run nearest test",
  --   --   },
  --   -- },
  --   -- opts = {
  --   --   status = { virtual_text = true },
  --   --   output = { open_on_run = true },
  --   --   -- quickfix = {
  --   --   --   open = function()
  --   --   --     require("trouble").open({ mode = "quickfix", focus = false })
  --   --   --   end,
  --   --   -- },
  --   -- },
  --   -- config = function()
  --   --   require("neotest").setup({
  --   --     adapters = {
  --   --       require("neotest-elixir"),
  --   --     }
  --   --   })
  --   -- end
  --   config = function()
  --     -- local neotest_ns = vim.api.nvim_create_namespace("neotest")
  --     -- vim.diagnostic.config({
  --     --   virtual_text = {
  --     --     format = function(diagnostic)
  --     --       -- Replace newline and tab characters with space for more compact diagnostics
  --     --       local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
  --     --       return message
  --     --     end,
  --     --   },
  --     -- }, neotest_ns)
  --
  --     -- opts.consumers = opts.consumers or {}
  --     --
  --     -- -- Refresh and auto close trouble after running tests
  --     -- opts.consumers.trouble = function(client)
  --     --   client.listeners.results = function(adapter_id, results, partial)
  --     --     if partial then
  --     --       return
  --     --     end
  --     --     local tree = assert(client:get_position(nil, { adapter = adapter_id }))
  --     --
  --     --     local failed = 0
  --     --     for pos_id, result in pairs(results) do
  --     --       if result.status == "failed" and tree:get_key(pos_id) then
  --     --         failed = failed + 1
  --     --       end
  --     --     end
  --     --     vim.schedule(function()
  --     --       local trouble = require("trouble")
  --     --       if trouble.is_open() then
  --     --         trouble.refresh()
  --     --         if failed == 0 then
  --     --           trouble.close()
  --     --         end
  --     --       end
  --     --     end)
  --     --     return {}
  --     --   end
  --     -- end
  --
  --     -- if opts.adapters then
  --     --   local adapters = {}
  --     --   for name, config in pairs(opts.adapters or {}) do
  --     --     if type(name) == "number" then
  --     --       if type(config) == "string" then
  --     --         config = require(config)
  --     --       end
  --     --       adapters[#adapters + 1] = config
  --     --     elseif config ~= false then
  --     --       local adapter = require(name)
  --     --       if type(config) == "table" and not vim.tbl_isempty(config) then
  --     --         local meta = getmetatable(adapter)
  --     --         if adapter.setup then
  --     --           adapter.setup(config)
  --     --         elseif adapter.adapter then
  --     --           adapter.adapter(config)
  --     --           adapter = adapter.adapter
  --     --         elseif meta and meta.__call then
  --     --           adapter = adapter(config)
  --     --         else
  --     --           error("Adapter " .. name .. " does not support setup")
  --     --         end
  --     --       end
  --     --       adapters[#adapters + 1] = adapter
  --     --     end
  --     --   end
  --     --   opts.adapters = adapters
  --     -- end
  --
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-elixir"),
  --       },
  --       -- status = { virtual_text = true },
  --       output = { open_on_run = true },
  --     })
  --   end,
  --
  --   -- keys = {
  --   --   { "<leader>t", "", desc = "+test"},
  --   --   { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
  --   --   { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
  --   --   { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
  --   --   { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
  --   --   { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
  --   --   { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
  --   --   { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
  --   --   { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
  --   --   { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  --   -- },
  -- },

  -- https://github.com/folke/ts-comments.nvim
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  -- -- https://github.com/stevearc/aerial.nvim
  -- {
  --   "stevearc/aerial.nvim",
  --   config = function()
  --     require("aerial").setup({
  --
  --       layout = {
  --         -- default_direction = "left",
  --
  --         min_width = 40,
  --         placement = "edge",
  --       },
  --
  --       attach_mode = "global",
  --
  --       -- layout = {
  --       --   default_direction = "float",
  --       --   min_width = 20,
  --       -- },
  --       -- float = {
  --       --   -- TODO: Dynamically measure the window and put in the top right corner.
  --       --
  --       --   -- https://github.com/stevearc/aerial.nvim/issues/107
  --       --   relative = "win",
  --       --   override = function(conf, source_winid)
  --       --     conf.anchor = 'NE'
  --       --     conf.row = 1
  --       --     conf.col = 85
  --       --     return conf
  --       --   end,
  --       -- },
  --       -- on_attach = function(bufnr)
  --       --   -- Jump forwards/backwards with '{' and '}'
  --       --   vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
  --       --   vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  --       -- end,
  --     })
  --     -- You probably also want to set a keymap to toggle aerial
  --     vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
  --
  --     -- vim.api.nvim_create_autocmd({ "WinLeave" }, {
  --     --   callback = function()
  --     --     vim.cmd("AerialClose<CR>")
  --     --   end,
  --     -- })
  --   end,
  --   -- Optional dependencies
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  -- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        elixir = { "mix" },
      },
      format_on_save = function()
        return {
          -- Only run these basic formatters automatically on save.
          formatters = {
            "trim_whitespace",
            "trim_newlines",
          },
          timeout_ms = 500,
          lsp_format = "never",
        }
      end,
    },
    init = function()
      -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command
      vim.api.nvim_create_user_command("Conform", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })
    end,
  },

  -- XXX: https://www.youtube.com/watch?v=Q0cvzaPJJas
  -- https://github.com/Saghen/blink.cmp
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      -- keymap = { preset = 'default' },
      keymap = {
        -- preset = "enter",
        preset = "super-tab",
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      },

      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },


      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },

  -- https://github.com/tjdevries/advent-of-nvim?tab=readme-ov-file
  -- https://github.com/martinsione/dotfiles/tree/main/src/.config/nvim

  -- TODO: Use nvim-lspconfig server configs over lsp/lua_ls.lua when it's ready:
  -- https://github.com/neovim/nvim-lspconfig/issues/3494
  --
  -- References:
  -- https://gpanders.com/blog/whats-new-in-neovim-0-11
  {
    "neovim/nvim-lspconfig",
    -- XXX: https://github.com/neovim/nvim-lspconfig/issues/4015
    commit = "63a0164",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- It's important that you set up the plugins in the following order:
      -- `mason` to install LSPs/DAPs/linters/formatters etc.
      -- `mason-lspconfig` to use lspconfig names vs mason.nvim package names
      --  (e.g. lua_ls <-> lua-language-server).
      -- `mason-tool-installer` to automatically install mason packages.
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Lua
          "lua_ls",
          "stylua",
          -- Elixir
          "lexical",
          -- "expert",
          -- TS/JS
          "ts_ls",
        },
      })

      vim.diagnostic.config({
        severity_sort = true,
        underline = false,

        -- -- virtual_text = true
        virtual_text = {
          current_line = true,
        },

        -- Use the default configuration
        -- virtual_lines = true

        -- Alternatively, customize specific options
        -- virtual_lines = {
        --  -- Only show virtual line diagnostics for the current cursor line
        --   current_line = true,
        -- },
      })
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    -- dependencies = {
    --   "nvim-treesitter/nvim-treesitter-textobjects",
    -- },
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    opts = {
      highlight = { enable = true },
      indent = { enable = true },

      -- Autoinstall languages that are not installed
      auto_install = true,

      -- ensure_installed = {
      --   -- "bash",
      --   -- "c",
      --   -- "diff",
      --   -- "html",
      --
      --   -- Required by codecompanion?
      --   -- https://codecompanion.olimorris.dev/installation.html#installation
      --   "markdown",
      --   "markdown_inline",
      --
      --   -- "printf",
      --   -- "python",
      --   -- "query",
      --   -- "regex",
      --   -- "toml",
      --   -- "vim",
      --   -- "vimdoc",
      --   -- "xml",
      --   -- "yaml",
      --   -- -- Lua
      --   -- "lua",
      --   -- "luadoc",
      --   -- "luap",
      --   -- -- JS/TS
      --   -- "javascript",
      --   -- "typescript",
      --   -- "tsx",
      --   -- "jsdoc",
      --   -- "json",
      --   -- "jsonc",
      --   -- -- Elixir
      --   -- "elixir",
      --   -- "heex",
      --   -- "eex"
      -- },

      -- https://www.josean.com/posts/nvim-treesitter-and-textobjects
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-space>",
      --     node_incremental = "<C-space>",
      --     scope_incremental = false,
      --     node_decremental = "<bs>",
      --   },
      -- },
    },

    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- XXX: https://github.com/coder/claudecode.nvim ??

  -- https://github.com/greggh/claude-code.nvim
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        command = "claude --dangerously-skip-permissions",
        window = {
          position = "vertical",
          -- float = {
          --   width = "30%",      -- Take up 90% of the editor width
          --   height = "90%",     -- Take up 90% of the editor height
          --   row = "center",     -- Center vertically
          --   col = "100%",     -- Center horizontally
          --   relative = "editor",
          --   -- border = "rounded",  -- Use double border style
          -- },
        },
      })

      vim.api.nvim_create_user_command("CC", "ClaudeCode", {})
    end,
  },

  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = vim.fn.has("win32") ~= 0
  --       and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --       or "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   opts = {
  --     -- add any opts here
  --     -- for example
  --     provider = "claude",
  --     providers = {
  --       claude = {
  --         endpoint = "https://api.anthropic.com",
  --         model = "claude-sonnet-4-20250514",
  --         timeout = 30000, -- Timeout in milliseconds
  --           extra_request_body = {
  --             temperature = 0.75,
  --             max_tokens = 20480,
  --           },
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     -- optional
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "folke/snacks.nvim", -- for input provider snacks
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- }

  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here

      nes = { enabled = false },
      cli = {
        mux = {
          backend = "zellij",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
        desc = "Sidekick Toggle Claude",
      },
    },
  }
}
