-- Set <space> as the leader key, first and foremost.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load other configs and then plugins, in that order.
require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lazy")

-- Configure LSPs
vim.lsp.enable({
  "lua_ls", -- Lua
  "lexical", -- Elixir
  -- "expert", -- Elixir
  "ts_ls", -- TS
  -- "biome", -- Biome = Eslint + Prettier
  -- "json", -- JSON
  -- "tailwindcss", -- Tailwind CSS
})

-- https://lsp-zero.netlify.app/blog/lsp-client-features.html
-- Default keymaps
-- <Ctrl-]> jump to definition.
-- gq format lines of code. This is an operator, is not "gq formats the whole file."
-- gO lists all symbols in the current buffer.
-- <Ctrl-x><Ctrl-o> will trigger code completion menu.
-- K display the available documentation for the symbol under the cursor.
-- <Ctrl-w>d opens a floating window showing the error/warning message in the line under the cursor.
-- [d and ]d can be used to move the cursor to the previous and next errors/warnings of the current file.

-- Check overall Neovim health:
-- :check
-- Verify LSP configuration:
-- :check lsp
-- For formatting issues, check conform.nvim status:
-- :ConformInfo

-- References:
-- https://github.com/jellydn/tiny-nvim
-- https://github.com/jellydn/my-nvim-ide
-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/CosmicNvim/CosmicNvim
-- https://github.com/NormalNvim/NormalNvim
-- https://github.com/AstroNvim/AstroNvim
-- https://github.com/LunarVim/LunarVim

-- XXX: 0.11 lsp configs
-- https://gpanders.com/blog/whats-new-in-neovim-0-11/
-- https://gitlab.com/thomas3081/nvim
-- https://www.youtube.com/watch?v=ZiH59zg59kg
-- XXX: https://lsp-zero.netlify.app/blog/lsp-client-features.html#opt-in-features

-- TODO:
-- Copy over util from https://github.com/jellydn/tiny-nvim
-- Finish going over the old vim.init
-- heirline.nvim: set up with components

-- TODO:
-- Set up lsp keybindings (LspAttach?), toggle virtual text vs virtual lines vs inlay?
-- Set up vim-test
-- https://github.com/rest-nvim/rest.nvim
-- treesitter

-- Git
-- Set up gitblame toggle with gitsigns
-- Make git stuff better.. lazygit?
-- gitsigns change colors? https://github.com/lewis6991/gitsigns.nvim/issues/169

-- REST
-- https://github.com/rest-nvim/rest.nvim

-- show diagnostics view in a pop over?
-- colors: column color, search highlight color, multi selector color
-- configure git control, viewing git diffs in vim.

-- configure DAP?? https://github.com/mfussenegger/nvim-dap
-- configure linters and formatter?? https://github.com/williamboman/mason.nvim?tab=readme-ov-file#how-to-use-installed-packages

-- -- XXX
-- -- https://github.com/omerxx/dotfiles/commit/3f1c01c076acd846b29f27e6a0c7dc6cad792d0b

-- https://github.com/stevearc
-- https://github.com/exosyphon/nvim

-- Configure picker

-- https://monsterlessons-academy.com/posts/neovim-complete-setup-setting-up-neovim-from-scratch
-- https://www.josean.com/posts/how-to-setup-neovim-2024

-- TODO
-- Finish going through typescraft tutorial: https://typecraft.dev/tutorial/how-well-do-you-know-vim-registers

-- Make the diagnostic popover show on cursor

-- how change surrounds 'foo' -> "foo"
-- * Tweak search color and multi select color, make it brighter

-- https://github.com/stevearc/quicker.nvim

-- * Try setting up https://github.com/yetone/avante.nvim
-- * https://github.com/milanglacier/minuet-ai.nvim
-- * https://github.com/frankroeder/parrot.nvim
-- * https://github.com/Robitx/gp.nvim

--  XXX https://github.com/GeorgesAlkhouri/nvim-aider?tab=readme-ov-file
