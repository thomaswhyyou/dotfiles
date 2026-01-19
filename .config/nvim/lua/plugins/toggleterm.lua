-- toggleterm.nvim configuration
-- For use with lazy.nvim (adjust if using a different plugin manager)

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.5
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.5
        end
      end,
      open_mapping = nil, -- We'll handle this manually
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        winblend = 3,
      },
    })

    -- Track terminal state
    local Terminal = require("toggleterm.terminal").Terminal
    local main_term = nil
    local is_float = false

    -- Create or get the main terminal
    local function get_main_term(direction)
      if main_term == nil then
        main_term = Terminal:new({
          direction = direction,
          on_exit = function()
            main_term = nil
            is_float = false
          end,
        })
      end
      return main_term
    end

    -- F3: Open terminal in bottom horizontal split
    vim.keymap.set({ "n", "t" }, "<F3>", function()
      local term = get_main_term("horizontal")
      if term:is_open() then
        term:close()
      else
        is_float = false
        term.direction = "horizontal"
        term:open()
      end
    end, { desc = "Toggle terminal (horizontal)" })

    -- F2: Toggle between horizontal and float (only in terminal)
    vim.keymap.set("t", "<F2>", function()
      if main_term and main_term:is_open() then
        main_term:close()
        if is_float then
          -- Switch to horizontal
          main_term.direction = "horizontal"
          is_float = false
        else
          -- Switch to float
          main_term.direction = "float"
          is_float = true
        end
        main_term:open()
      end
    end, { desc = "Toggle terminal between horizontal/float" })

    -- F4: Exit insert mode in terminal (enter normal mode for scrolling)
    vim.keymap.set("t", "<F4>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })

    -- Ctrl+h/j/k/l: Navigate to neighboring windows (only when not floating)
    local function term_nav(direction)
      return function()
        if main_term and main_term:is_open() and not is_float then
          -- Exit terminal mode and move to the specified window
          vim.cmd("stopinsert")
          vim.cmd("wincmd " .. direction)
        end
      end
    end

    -- vim.keymap.set("t", "<C-h>", term_nav("h"), { desc = "Move to left window" })
    -- vim.keymap.set("t", "<C-j>", term_nav("j"), { desc = "Move to bottom window" })
    -- vim.keymap.set("t", "<C-k>", term_nav("k"), { desc = "Move to top window" })
    -- vim.keymap.set("t", "<C-l>", term_nav("l"), { desc = "Move to right window" })
  end,
}
