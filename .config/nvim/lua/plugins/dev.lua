-- https://github.com/jellydn/tiny-nvim/blob/22d8e485653c17670244e204bc611bac58654cfd/lua/plugins/extra/codecompanion.lua#L135

return {

  -- -- https://github.com/nvim-mini/mini.hipatterns
  -- {
  --   "nvim-mini/mini.hipatterns",
  --   version = false,
  --   config = function()
  --     require("mini.hipatterns").setup({
  --       highlighters = {
  --         hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsNote" },
  --         todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsNote" },
  --         note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
  --         xxx = { pattern = "%f[%w]()XXX()%f[%W]", group = "MiniHipatternsNote" },
  --       },
  --     })
  --     vim.api.nvim_set_hl(0, "MiniHipatternsNote", { bold = true, fg = "#ffffff" })
  --   end,
  -- },

  -- -- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
  -- {
  --   "folke/trouble.nvim",
  --   opts = {}, -- for default options, refer to the configuration section for custom setup.
  --   cmd = "Trouble",
  --   keys = {
  --     {
  --       "<leader>xx",
  --       "<cmd>Trouble diagnostics toggle<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>xX",
  --       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --       desc = "Buffer Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>cs",
  --       "<cmd>Trouble symbols toggle focus=false<cr>",
  --       desc = "Symbols (Trouble)",
  --     },
  --     {
  --       "<leader>cl",
  --       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --       desc = "LSP Definitions / references / ... (Trouble)",
  --     },
  --     {
  --       "<leader>xL",
  --       "<cmd>Trouble loclist toggle<cr>",
  --       desc = "Location List (Trouble)",
  --     },
  --     {
  --       "<leader>xQ",
  --       "<cmd>Trouble qflist toggle<cr>",
  --       desc = "Quickfix List (Trouble)",
  --     },
  --   },
  -- },

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
}
