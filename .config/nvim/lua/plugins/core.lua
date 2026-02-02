return {
  -- ===========================================================================
  -- UIs

  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    -- keys = {
    --   {
    --     "<leader>?",
    --     function()
    --       require("which-key").show({ global = false })
    --     end,
    --     desc = "Buffer Local Keymaps (which-key)",
    --   },
    -- },
  },

  -- https://github.com/folke/noice.nvim
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      opts.presets = {
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "94%",
                col = "50%",
              },
              size = {
                min_width = 80,
                width = "auto",
                height = "auto",
              },
            },

            -- cmdline_popupmenu = {
            --   position = {
            --     row = "80%",
            --     col = "50%",
            --   },
            -- },

            -- popupmenu = {
            --   relative = "editor",
            --   position = {
            --     row = 23,
            --     col = "50%",
            --   },
            --   size = {
            --     width = 60,
            --     height = "auto",
            --     max_height = 15,
            --   },
            --   border = {
            --     style = "rounded",
            --     padding = { 0, 1 },
            --   },
            --   win_options = {
            --     winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
            --   },
            -- },
          },
        },
      }
      -- opts.lsp.signature = {
      --   opts = { size = { max_height = 15 } },
      -- }
    end,
  },

  -- {
  --   "rebelot/heirline.nvim",
  --   dependencies = { "Zeioth/heirline-components.nvim" },
  --   opts = {},
  --   config = function(_, opts)
  --     local heirline = require("heirline")
  --     local heirline_components = require("heirline-components.all")
  --
  --     -- Setup
  --     heirline_components.init.subscribe_to_events()
  --     heirline.load_colors(heirline_components.hl.get_colors())
  --     heirline.setup(opts)
  --   end,
  -- },

  -- https://github.com/dstein64/nvim-scrollview
  {
    "dstein64/nvim-scrollview",
    config = function()
      require("scrollview").setup({
        -- excluded_filetypes = {'nerdtree'},
        current_only = true,
        -- base = 'buffer',
        -- column = 80,
        -- signs_on_startup = {'all'},
        -- diagnostics_severities = {vim.diagnostic.severity.ERROR}
      })
    end,
  },

  -- ===========================================================================
  -- Navigation

  -- https://github.com/folke/flash.nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- https://github.com/qpkorr/vim-bufkill
  {
    "qpkorr/vim-bufkill",
    branch = "master",
    lazy = false,
    keys = {
      { "<Tab>", "<CMD>BF<CR>", desc = "Bufkill move forward" },
      { "<S-Tab>", "<CMD>BB<CR>", desc = "Bufkill move backward" },
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


  -- -- https://github.com/mg979/vim-visual-multi
  -- --
  -- -- Basic usage:
  -- -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
  -- -- create cursors vertically with Ctrl-Down/Ctrl-Up
  -- -- select one character at a time with Shift-Arrows
  -- -- press n/N to get next/previous occurrence
  -- -- press [/] to select next/previous cursor
  -- -- press q to skip current and get next occurrence
  -- -- press Q to remove current cursor/selection
  -- -- start insert mode with i,a,I,A
  -- {
  --   "mg979/vim-visual-multi",
  --   branch = "master",
  --   init = function()
  --     vim.g.VM_theme = "neon"
  --     -- Use normal search highlight for matches
  --     vim.g.VM_highlight_matches = ""
  --   end,
  -- },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { "<leader>e", "<Cmd>Neotree reveal=true toggle=true<CR>", desc = "Neotree toggle" },
    },
  },

  -- -- https://github.com/b0o/incline.nvim
  -- -- TODO: Make it so the label fades if it covers the first line? Make it toggle-able
  -- -- TODO: Remove in zen mode
  -- -- Also highlight when in focus
  -- {
  --   'b0o/incline.nvim',
  --   event = 'VeryLazy',
  --   config = function()
  --     require('incline').setup({
  --       window = {
  --         padding = 0,
  --         margin = { horizontal = 0 },
  --       },
  --       render = function(props)
  --
  --         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
  --         local modified = vim.bo[props.buf].modified
  --         return {
  --           ' ',
  --           filename,
  --           modified and { ' *', guifg = '#888888', gui = 'bold' } or '',
  --           ' ',
  --           guibg = '#111111',
  --           guifg = '#eeeeee',
  --         }
  --       end
  --     })
  --   end,
  -- },

  -- ===========================================================================
  -- Git

  -- https://github.com/lewis6991/gitsigns.nvim
  -- TODO: https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/gitsigns.lua
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
      signs_staged = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
    },
  },

  -- https://github.com/tpope/vim-fugitive
  {
    "tpope/vim-fugitive",
    branch = "master",
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- ===========================================================================
  --

  -- {
  --   "nvim-mini/mini.pairs",
  --   -- event = "VeryLazy",
  --   opts = {
  --     -- modes = { insert = true, command = true, terminal = false },
  --     -- -- skip autopair when next character is one of these
  --     -- skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  --     -- -- skip autopair when the cursor is inside these treesitter nodes
  --     -- skip_ts = { "string" },
  --     -- -- skip autopair when next character is closing pair
  --     -- -- and there are more closing pairs than opening pairs
  --     -- skip_unbalanced = true,
  --     -- -- better deal with markdown code blocks
  --     -- markdown = true,
  --   },
  --   -- config = function(_, opts)
  --   --   LazyVim.mini.pairs(opts)
  --   -- end,
  -- },

  -- {
  --   "catgoose/nvim-colorizer.lua",
  --   event = "BufReadPre",
  --   opts = {
  --     user_default_options = {
  --       names = false,
  --     },
  --   },
  --   -- config = function()
  --   --   require("colorizer").setup({
  --   --     user_commands = { "ColorizerToggle", "ColorizerReloadAllBuffers" },
  --   --   })
  --   -- end
  --   -- opts = { -- set to setup table
  --   -- },
  -- },

  -- -- https://github.com/stefandtw/quickfix-reflector.vim
  -- {
  --   "stefandtw/quickfix-reflector.vim",
  --   branch = "master",
  -- },

  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    opts = {
      borders = {
        vert = "|",
      },
    },
    keys = {
      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },
    -- init = function ()
    --   vim.keymap.set("n", "<leader>q", function()
    --     require("quicker").toggle()
    --   end, {
    --     desc = "Toggle quickfix",
    --   })
    --   vim.keymap.set("n", "<leader>l", function()
    --     require("quicker").toggle({ loclist = true })
    --   end, {
    --     desc = "Toggle loclist",
    --   })
    -- end
  },

  -- ===========================================================================
  -- Misc

  -- https://github.com/folke/zen-mode.nvim
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>uz",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Toggle zen mode",
      },
    },
    opts = {
      on_open = function()
        if package.loaded["nvim-tmux-navigation"] then
          vim.keymap.set("n", "<C-h>", "<nop>")
          vim.keymap.set("n", "<C-j>", "<nop>")
          vim.keymap.set("n", "<C-k>", "<nop>")
          vim.keymap.set("n", "<C-l>", "<nop>")
        end
      end,
      on_close = function()
        if package.loaded["nvim-tmux-navigation"] then
          local nav = require("nvim-tmux-navigation")
          vim.keymap.set("n", "<C-h>", nav.NvimTmuxNavigateLeft)
          vim.keymap.set("n", "<C-j>", nav.NvimTmuxNavigateDown)
          vim.keymap.set("n", "<C-k>", nav.NvimTmuxNavigateUp)
          vim.keymap.set("n", "<C-l>", nav.NvimTmuxNavigateRight)
        end
      end,
    },
  },

  -- XXX: Remove when not in current buffer
  -- https://github.com/nvim-mini/mini.cursorword
  -- {
  --   "nvim-mini/mini.cursorword",
  --   version = false,
  --   config = function()
  --     require("mini.cursorword").setup()
  --   end,
  -- },

  -- -- https://github.com/akinsho/toggleterm.nvim
  -- {
  --   "akinsho/toggleterm.nvim",
  --   version = "*",
  --   -- config = function()
  --   --   require("toggleterm").setup({
  --   --     -- open_mapping = [[<leader>o]],
  --   --     hide_number = true,
  --   --     persist_mode = true,
  --   --     start_in_insert = true,
  --   --     direction = "float", -- vertical | float | tab
  --   --   })
  --   --
  --   --   vim.keymap.set("n", "<leader>o", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })
  --   -- end,
  --
  --   config = function()
  --     require("toggleterm").setup({
  --       -- open_mapping = [[<c-\>]],
  --       open_mapping = [[<f3>]],
  --       hide_number = true,
  --       persist_mode = true,
  --       -- close_on_exit = false,
  --       start_in_insert = true,
  --       direction = "horizontal", -- vertical | float | tab
  --       size = 50,
  --     })
  --
  --     -- local Terminal  = require('toggleterm.terminal').Terminal
  --     --
  --     -- local lazygit = Terminal:new({
  --     --   cmd = "lazygit",
  --     --   dir = "git_dir",
  --     --   direction = "float",
  --     --   float_opts = {
  --     --     border = "double",
  --     --   },
  --     --   -- function to run on opening the terminal
  --     --   on_open = function(term)
  --     --     vim.cmd("startinsert!")
  --     --     vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  --     --   end,
  --     --   -- function to run on closing the terminal
  --     --   on_close = function(term)
  --     --     vim.cmd("startinsert!")
  --     --   end,
  --     -- })
  --     --
  --     -- function _lazygit_toggle()
  --     --   lazygit:toggle()
  --     -- end
  --     --
  --     -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
  --   end,
  --
  --   -- opts = {
  --   --   -- open_mapping = [[<leader>o]],
  --   --   open_mapping = [[<c-\>]],
  --   --   hide_number = true,
  --   --   persist_mode = true,
  --   --   -- close_on_exit = false,
  --   --   start_in_insert = true,
  --   --   direction = "horizontal", -- vertical | float | tab
  --   --   -- float_opts = {
  --   --   --   -- The border key is *almost* the same as 'nvim_open_win'
  --   --   --   -- see :h nvim_open_win for details on borders however
  --   --   --   -- the 'curved' border is a custom border type
  --   --   --   -- not natively supported but implemented in this plugin.
  --   --   --   -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
  --   --   --   -- border = 'double',
  --   --   --   -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
  --   --   --   -- width = 160,
  --   --   --   -- height = function()
  --   --   --   --   return vim.o.rows - 10
  --   --   --   -- end,
  --   --   --   -- row = <value>,
  --   --   --   -- col = <value>,
  --   --   --   -- winblend = 3,
  --   --   --   -- zindex = <value>,
  --   --   --   -- title_pos = 'left' | 'center' | 'right', position of the title of the floating window
  --   --   -- },
  --   --   size = 50,
  --   -- },
  -- },
}
