-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ============================================================================
-- Override lazyvim defaults
-- ============================================================================

-- Globally disable all snacks animations
vim.g.snacks_animate = false

-- Change lazyvim root dir detection to .git or just use cwd
vim.g.root_spec = { ".git", "cwd" }

-- Disable hiding of markup (don't hide * markup for bold and italic)
vim.opt.conceallevel = 0

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- ============================================================================
-- Custom options
-- ============================================================================

-- Enable break indent
vim.opt.breakindent = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Line length marker
vim.opt.colorcolumn = "80"

-- Disable hidden buffers (https://github.com/neovim/neovim/issues/17841)
vim.opt.hidden = false

-- XXX: Disable lazyVim auto format for now
-- vim.g.autoformat = true

-- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#FFC0CB" })

-- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "Green" })
-- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#ffffff", bg = "#333333" })
-- vim.cmd([[:highlight GitSignsAdd guifg=Green]])
