return {
  -- https://github.com/loctvl842/monokai-pro.nvim
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comment = { italic = false },
        -- keyword = { italic = true }, -- any other keyword
        -- type = { italic = true }, -- (preferred) int, long, char, etc
        -- storageclass = { italic = true }, -- static, register, volatile, etc
        -- structure = { italic = true }, -- struct, union, enum, etc
        -- parameter = { italic = true }, -- parameter pass in function
        -- annotation = { italic = true },
        -- tag_attribute = { italic = false }, -- attribute of tag in reactjs
      },
      filter = "machine", -- classic | octagon | pro | machine | ristretto | spectrum
      background_clear = {
        -- "float_win",
        -- "toggleterm",
        -- "telescope",
        "which-key",
        -- "renamer",
        -- "notify",
        -- "nvim-tree",
        "neo-tree",
        -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
      },
      override = function(c)
        -- https://github.com/loctvl842/monokai-pro.nvim/blob/master/lua/monokai-pro/colorscheme/palette/machine.lua
        -- dark2 = "#161b1e"
        -- dark1 = "#1d2528"
        -- background = "#273136"
        -- text = "#f2fffc"
        -- accent1 = "#ff6d7e"
        -- accent2 = "#ffb270"
        -- accent3 = "#ffed72"
        -- accent4 = "#a2e57b"
        -- accent5 = "#7cd5f1"
        -- accent6 = "#baa0f8"
        -- dimmed1 = "#b8c4c3"
        -- dimmed2 = "#8b9798"
        -- dimmed3 = "#6b7678"
        -- dimmed4 = "#545f62"
        -- dimmed5 = "#3a4449"

        -- https://github.com/loctvl842/monokai-pro.nvim/blob/master/lua/monokai-pro/colorscheme/init.lua
        -- cs.base = {
        --   dark = p.dark2, -- "#19181a"
        --   black = p.dark1, --"#221f22",
        --   red = p.accent1, -- "#ff6188",
        --   green = p.accent4, -- "#a9dc76",
        --   yellow = p.accent3, -- "#ffd866",
        --   blue = p.accent2, -- "#fc9867",
        --   magenta = p.accent6, -- "#ab9df2",
        --   cyan = p.accent5, -- "#78dce8",
        --   white = p.text, -- "#fcfcfa",
        --   dimmed1 = p.dimmed1, -- "#c1c0c0",
        --   dimmed2 = p.dimmed2, -- "#939293",
        --   dimmed3 = p.dimmed3, -- "#727072",
        --   dimmed4 = p.dimmed4, -- "#5b595c",
        --   dimmed5 = p.dimmed5, -- "#403e41",
        -- }

        -- local hp = require("monokai-pro.color_helper")
        --
        -- local common_fg = hp.lighten(c.sideBar.foreground, 30)

        return {
          -- Custom
          -- ColorColumn = { bg = hp.lighten(c.editor.background, -2) },

          -- Don't highlight the current cursor line.
          CursorLine = { bg = c.editor.background },
          ["@markup.raw.block.markdown"] = { bg = c.editor.background },

          -- -- Snacks (https://github.com/loctvl842/monokai-pro.nvim/issues/143)
          -- SnacksPicker = { bg = c.editor.background, fg = common_fg },
          -- SnacksPickerBorder = { bg = c.editor.background, fg = c.tab.unfocusedActiveBorder },
          -- SnacksPickerTree = { fg = c.editorLineNumber.foreground },
          -- NonText = { fg = c.base.dimmed3 }, -- not sure if this should be broken into all hl groups importing NonText

          -- Search
          Search = { bg = c.base.dimmed3 },

          -- Other plugins

          -- mini.cursorword
          MiniCursorword = { bg = c.base.dimmed4 },

          -- https://github.com/folke/flash.nvim
          -- https://github.com/folke/flash.nvim/blob/3c942666f115e2811e959eabbdd361a025db8b63/lua/flash/highlight.lua#L12
          -- TODO: Tweak this to blend better into monokai
          -- FlashBackdrop = { fg = "#545c7e" },

          FlashBackdrop = { fg = c.base.dimmed3, bg = c.editor.background },
          FlashCurrent = { bg = "#ff966c", fg = "#1b1d2b" },
          FlashLabel = { bg = "#ff007c", bold = true, fg = "#c8d3f5" },
          FlashMatch = { bg = "#3e68d7", fg = "#c8d3f5" },
          FlashCursor = { reverse = true },

          -- FlashBackdrop	Comment	backdrop
          -- FlashMatch = { bg = c.base.dimmed1, fg = c.base.dark },
          -- FlashCurrent IncSearch	current match
          -- FlashLabel	Substitute -- jump label
          -- FlashPrompt	MsgArea -- prompt
          -- FlashPromptIcon Special -- prompt icon
          -- FlashCursor Cursor -- cursor

          -- https://github.com/nvim-mini/mini.hipatterns
          MiniHipatternsNote = { bold = true, fg = "#ffffff" },
        }
      end,
    },
    init = function()
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },

  -- https://github.com/folke/tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
}
