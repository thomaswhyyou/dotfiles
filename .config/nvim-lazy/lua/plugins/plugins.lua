return {

  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        -- Do not load layzvim default keymaps because..
        keymaps = false,
      },
    },
  },

  -- https://github.com/folke/snacks.nvim
  {
    "folke/snacks.nvim",
    opts = {
      --Don't show the indent line highlights
      indent = { enabled = false },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },

  -- https://github.com/alexghergh/nvim-tmux-navigation
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        },
      })
    end,
  },

  -- https://github.com/echasnovski/mini.hipatterns
  {
    "echasnovski/mini.hipatterns",
    version = false,
    opts = {
      highlighters = {
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsNote" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsNote" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        xxx = { pattern = "%f[%w]()XXX()%f[%W]", group = "MiniHipatternsNote" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "MiniHipatternsNote", {
            bold = true,
            fg = "#ffffff",
          })
        end,
      })
    end,
  },

  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "Green3" })
          vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "Gold" })
          vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "Red" })
          vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "Red" })
          vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "Red" })
          -- vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "Red" })
          -- GitSignsCurrentLineBlame
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    keys = {
      -- https://www.reddit.com/r/neovim/comments/1hsxtke/i_can_change_leadergd_in_lazyvim/
      -- { "gd", false },
    },
    opts = {
      inlay_hints = { enabled = false },
      autoformat = false,
      diagnostics = {
        underline = true,
        virtual_text = false,

        -- update_in_insert = false,
        -- virtual_text = {
        --   spacing = 4,
        --   source = "if_many",
        --   prefix = "●",
        --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        --   -- prefix = "icons",
        -- },
        -- severity_sort = true,
        -- signs = {
        --   text = {
        --     [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
        --     [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
        --     [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
        --     [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
        --   },
        -- },
      },
    },
  },

  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparent = false,
      -- dim_inactive = true,
      -- style = "day",
      -- day_brightness = 0.1,
      styles = {
        -- keywords = { italic = true },
        comments = { italic = false },
        -- functions = { italic = true },
        -- variables = { italic = true, bold = true },
      },
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },

  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slope",
        indicator = { style = "underline" },
      },
    },
  },

  { "RRethy/vim-illuminate", branch = "master" },

  {
    "qpkorr/vim-bufkill",
    branch = "master",
    lazy = false,
    keys = {
      { "<Tab>", "<CMD>BF<CR>", desc = "Find Files (Root Dir)" },
      { "<S-Tab>", "<CMD>BB<CR>", desc = "Find Files (Root Dir)" },
    },
  },

  { "stefandtw/quickfix-reflector.vim", branch = "master" },

  -- https://github.com/tpope/vim-fugitive
  { "tpope/vim-fugitive", branch = "master" },

  -- -- https://github.com/shortcuts/no-neck-pain.nvim
  -- {
  --   "shortcuts/no-neck-pain.nvim",
  --   version = "*",
  --   opts = {
  --     width = 110,
  --     autocmds = {
  --       -- enableOnVimEnter = true,
  --     },
  --   },
  --   init = function()
  --     vim.api.nvim_create_user_command("NNP", function()
  --       vim.cmd("NoNeckPain")
  --     end, {
  --       desc = "Alias for NoNeckPain command",
  --     })
  --   end,
  -- },

  -- https://github.com/mg979/vim-visual-multi
  --
  -- Basic usage:
  -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
  -- create cursors vertically with Ctrl-Down/Ctrl-Up
  -- select one character at a time with Shift-Arrows
  -- press n/N to get next/previous occurrence
  -- press [/] to select next/previous cursor
  -- press q to skip current and get next occurrence
  -- press Q to remove current cursor/selection
  -- start insert mode with i,a,I,A
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      -- XXX: Change to be the same as search?
      vim.g.VM_theme = "sand"
      -- Use normal search highlight for matches
      vim.g.VM_highlight_matches = ""
    end,
  },

  -- {
  --   -- https://github.com/f-person/git-blame.nvim
  --   "f-person/git-blame.nvim",
  --   -- load the plugin at startup
  --   event = "VeryLazy",
  --   -- Because of the keys part, you will be lazy loading this plugin.
  --   -- The plugin wil only load once one of the keys is used.
  --   -- If you want to load the plugin at startup, add something like event = "VeryLazy",
  --   -- or lazy = false. One of both options will work.
  --   opts = {
  --     -- your configuration comes here
  --     -- for example
  --     enabled = true, -- if you want to enable the plugin
  --     message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
  --     date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
  --     virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
  --   },
  -- },

  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     signature = { enabled = true },
  --     keymap = {
  --       preset = "super-tab",
  --     },
  --   },
  -- },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", false },
      { "<leader>p", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    },
    opts = {
      winopts = {
        -- split = "belowright new",
        -- height = 1,
        -- width = 1,
        -- border = "none",
      },
      fzf_opts = {
        ["--layout"] = "default",
      },
      -- fzf_opts = {
      --   -- options are sent as `<left>=<right>`
      --   -- set to `false` to remove a flag
      --   -- set to `true` for a no-value flag
      --   -- for raw args use `fzf_args` instead
      --   ["--ansi"] = true,
      --   -- ["--info"]           = "inline-right", -- fzf < v0.42 = "inline"
      --   ["--height"] = "100%",
      --   ["--layout"] = "default",
      --   ["--border"] = false,
      --   ["--highlight-line"] = true, -- fzf >= v0.53
      -- },
    },
  },

  -- https://github.com/stevearc/oil.nvim
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      -- float = {
      --   padding = 0,
      --   max_width = 0.8,
      --   max_height = 0.8,
      --   preview_split = "right",
      -- },
      keymaps = {
        ["q"] = { callback = "actions.close", mode = "n" },
        ["yy"] = {
          -- https://www.reddit.com/r/neovim/comments/1czp9zr/how_to_copy_file_path_to_clipboard_in_oilnvim/
          desc = "Copy filepath to system clipboard",
          callback = function()
            require("oil.actions").copy_entry_path.callback()
            vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
          end,
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "OilFileHidden", { link = "OilFile" })
          vim.api.nvim_set_hl(0, "OilDirHidden", { link = "OilDir" })
        end,
      })
    end,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },

  -- DISABLED:

  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    enabled = false,
  },
}
