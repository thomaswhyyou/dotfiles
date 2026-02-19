-- https://github.com/loctvl842/monokai-pro.nvim
return {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- filter = classic | octagon | pro | machine | ristretto | spectrum
    day_night = {
      enable = true,
      day_filter = "machine",
      night_filter = "machine",
    },
    background_clear = {
      "which-key",
    },
    override = function(c)
      -- print(vim.inspect(c))

      -- TODO: Not sure if this needs to be included as deps?
      local mc = require("mini.colors")

      return {
        -- vim.o.colorcolumn, slightly darker than the bg color
        ColorColumn = {
          bg = mc.modify_channel(c.editor.background, "lightness", function(l)
            return l - 1
          end),
        },
        --
        Directory = { fg = c.base.cyan, bg = c.editor.background, bold = true },
      }
    end,
  },
  init = function()
    vim.cmd([[colorscheme monokai-pro]])
  end,
}
