-- https://github.com/ibhagwan/fzf-lua
return {
  "ibhagwan/fzf-lua",
    -- stylua: ignore
    keys = {
      -- Shortcuts
      { "<leader>p", function() require("fzf-lua").files() end, desc = "Fzf files" },
      { "<leader>/", function() require("fzf-lua").grep() end, desc = "Fzf grep" },

      -- { "<leader>\\", function() require("fzf-lua").buffers() end, desc = "Fzf buffers" },

      -- Search
      { "<leader>sg", function() require("fzf-lua").live_grep() end, desc = "Fzf live grep" },

      -- find
      -- { "<leader>sb", ":FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    },
  opts = {
    winopts = {
      height = 0.90,
      width = 0.50,
      row = 0.5,

      fullscreen = false,
      preview = {
        hidden = true,
        horizontal = "right:50%",
      },
      border = "rounded",
      -- treesitter = { enabled = true },
      --
    },
    fzf_opts = {
      ["--layout"] = "default",
    },

    -- https://github.com/gennaro-tedesco/dotfiles/blob/master/nvim/lua/plugins/fzf.lua
    files = {
      -- formatter = "path.filename_first",
      -- git_icons = false,
      -- no_header = true,
      -- cwd_header = false,
      cwd_prompt = false,
      -- cwd = require("utils").git_root(),
      actions = {
        -- ["ctrl-d"] = {
        --   fn = function(...)
        --     require("fzf-lua").actions.file_vsplit(...)
        --     vim.cmd("windo diffthis")
        --     local switch = vim.api.nvim_replace_termcodes("<C-w>h", true, false, true)
        --     vim.api.nvim_feedkeys(switch, "t", false)
        --   end,
        --   desc = "diff-file",
        -- },

        -- ["shift-tab"] = function(_, _)
        --   -- open buffers picker
        --   require("fzf-lua").buffers()
        -- end,
      },
    },
    grep = {
      winopts = {
        fullscreen = true,
        preview = {
          hidden = false,
        },
      },
    },
  },
  -- config = function()
  --   local fzflua = require("fzf-lua");
  --
  --   fzflua.setup({
  --     winopts = {
  --       height = 0.90,
  --       width = 0.50,
  --       row = 0.5,
  --
  --       fullscreen = false,
  --       preview = {
  --         hidden = true,
  --         horizontal = "right:50%"
  --       },
  --       border = "rounded",
  --       -- treesitter = { enabled = true },
  --       --
  --     },
  --     fzf_opts = {
  --       ["--layout"] = "default",
  --     },
  --
  --     -- https://github.com/gennaro-tedesco/dotfiles/blob/master/nvim/lua/plugins/fzf.lua
  --     files = {
  --       -- formatter = "path.filename_first",
  --       -- git_icons = false,
  --       -- no_header = true,
  --       -- cwd_header = false,
  --       cwd_prompt = false,
  --       -- cwd = require("utils").git_root(),
  --       -- actions = {
  --       --   ["ctrl-d"] = {
  --       --     fn = function(...)
  --       --       require("fzf-lua").actions.file_vsplit(...)
  --       --       vim.cmd("windo diffthis")
  --       --       local switch = vim.api.nvim_replace_termcodes("<C-w>h", true, false, true)
  --       --       vim.api.nvim_feedkeys(switch, "t", false)
  --       --     end,
  --       --     desc = "diff-file",
  --       --   },
  --       -- },
  --
  --     },
  --     grep = {
  --       winopts = {
  --         fullscreen = true,
  --         preview = {
  --           hidden = false
  --         },
  --       },
  --     },
  --   })
  --
  --   -- Set up fzf-vim user commands like Rg and RG.
  --   -- https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/profiles/fzf-vim.lua
  --   fzflua.setup_fzfvim_cmds()
  -- end,
  dependencies = { "nvim-mini/mini.icons" },
  -- config = function()
  --   require("fzf-lua").setup({ "telescope" })
  -- end,
}
