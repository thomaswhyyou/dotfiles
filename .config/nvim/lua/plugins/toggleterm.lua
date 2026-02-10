-- https://github.com/akinsho/toggleterm.nvim
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<F3>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
    { "<F3>", "<cmd>ToggleTerm<cr>", mode = "t", desc = "Toggle floating terminal" },
  },
  opts = function()
    -- Track fullscreen state
    local is_fullscreen = false

    -- Default dimensions
    local default_width_ratio = 0.4
    local default_height_ratio = 1
    local fullscreen_width_ratio = 0.95

    -- Toggle fullscreen function
    _G.toggle_term_fullscreen = function()
      is_fullscreen = not is_fullscreen
      local term = require("toggleterm.terminal").get(1)
      if term and term:is_open() then
        term:close()
        term:open()
      end
    end

    -- Set up F2 keymap
    vim.keymap.set({ "n", "t" }, "<F2>", function()
      _G.toggle_term_fullscreen()
    end, { desc = "Toggle terminal fullscreen" })

    return {
      -- direction = "float",
      float_opts = {
        border = "curved",
        width = function()
          local ratio = is_fullscreen and fullscreen_width_ratio or default_width_ratio
          return math.floor(vim.o.columns * ratio)
        end,
        height = vim.o.lines * default_height_ratio,
        -- height = function()
        --   local ratio = is_fullscreen and fullscreen_ratio or default_height_ratio
        --   return math.floor(vim.o.lines * ratio)
        -- end,
      },
      shade_terminals = true,
      shading_factor = -30,
      persist_mode = true,
      close_on_exit = true,
      auto_scroll = true,
    }
  end,
}
