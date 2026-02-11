-- https://github.com/nvim-mini/mini.nvim/
return {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    -- require("mini.notify").setup()
    -- require("mini.ai").setup()


    -- require('mini.indentscope').setup({
    --   symbol = '╎',
    --   draw = {
    --     -- Delay (in ms) between event and start of drawing scope indicator
    --     delay = 100,
    --     animation = require('mini.indentscope').gen_animation.none(),
    --
    --     -- Symbol priority. Increase to display on top of more symbols.
    --     priority = 2,
    --   },
    -- })

    -- require("mini.bracketed").setup()

    -- require("mini.git").setup()
    -- require("mini.diff").setup({
    --   view = {
    --     -- TODO: Look into changing colors?
    --     style = "sign",
    --     signs = { add = "+", change = "~", delete = "_" },
    --   },
    -- })

    --- mini.hipatterns ---

    -- require('mini.hipatterns').setup({
    --   highlighters = {
    --     -- Highlight markdown horizontal rules (3+ dashes)
    --     markdown_hr = {
    --       pattern = '^%-%-%-+%s*$',
    --       group = 'MiniHipatternsMarkdownHR',
    --     },
    --   },
    -- })
    -- -- Define the highlight group with blue color
    -- vim.api.nvim_set_hl(0, 'MiniHipatternsMarkdownHR', { fg = '#6495ED', bold = true })

    -- require('mini.hipatterns').setup({
    --   highlighters = {
    --     triple_dash = {
    --       pattern = function(buf_id)
    --         return '^[%s#/]*()%-%-%-()'
    --       end,
    --       group = '',
    --       extmark_opts = function(buf_id, match, data)
    --         return {
    --           end_row = data.line - 1,
    --           end_col = 0,
    --           hl_eol = true,
    --           hl_group = 'MiniHipatternsTripleDash',
    --           line_hl_group = 'MiniHipatternsTripleDash',
    --           priority = 200,
    --         }
    --       end,
    --     },
    --   },
    -- })
    -- vim.api.nvim_set_hl(0, 'MiniHipatternsTripleDash', { fg = '#6495ED' })

    --- mini.statusline ---
    require("mini.statusline").setup()

    require("mini.jump").setup()

    -- MiniBracketed.buffer("forward", { wrap = false })
    -- MiniBracketed.

    -- require('mini.indentscope').setup({
    --   draw = {
    --     animation = require('mini.indentscope').gen_animation.none()
    --   }
    -- })
  end,
}
