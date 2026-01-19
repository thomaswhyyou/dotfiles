-- TODO: Finish going through and only keep the ones setting to non defaults.
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- https://github.com/NormalNvim/NormalNvim/blob/main/lua/base/1-options.lua

vim.opt.number = true         -- Make line numbers default (default: false)
vim.opt.relativenumber = true -- Set relative numbered lines (default: false)
vim.opt.numberwidth = 2       -- Set number column width to 2 (default: 4)

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Tab & Indent
vim.opt.expandtab = true    -- tabs are spaces
vim.opt.tabstop = 2         -- number of visual spaces per TAB
vim.opt.softtabstop = 2     -- number of spaces in tab when editing
vim.opt.shiftwidth = 2      -- number of spaces to use for each step of (auto)indent
vim.opt.smartindent = true  -- smartindent
vim.opt.shiftround = true   -- round indent to multiple of 'shiftwidth'.
vim.opt.wrap = false        -- disable line wrap
vim.opt.list = true         -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Search
vim.opt.ignorecase = true   -- ignore case when searching
vim.opt.smartcase = true    -- be smart when searching




vim.opt.undofile = true -- Save undo history



vim.opt.signcolumn = 'yes'  -- Reserve a space in the gutter

vim.opt.updatetime = 250 -- Decrease update time (default: 4000)
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)


vim.opt.splitbelow = true -- Force all horizontal splits to go below current window (default: false)
vim.opt.splitright = true -- Force all vertical splits to go to the right of current window (default: false)

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20      -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.opt.sidescrolloff = 8   -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)


vim.opt.backup = false -- Creates a backup file (default: false)
vim.opt.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
vim.opt.swapfile = false -- Creates a swapfile (default: true)

-- Line length marker
vim.opt.colorcolumn = "80"

-- Disable hidden buffers (https://github.com/neovim/neovim/issues/17841)
-- vim.opt.hidden = false

-- Disable hiding of markup (don't hide * markup for bold and italic)
vim.opt.conceallevel = 0

vim.opt.fileencoding = 'utf-8' -- The encoding written to a file (default: 'utf-8')

-- vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore (default: true)
-- vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)
-- vim.o.whichwrap = 'bs<>[]hl' -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
-- vim.o.showtabline = 2 -- Always show tabs (default: 1)
-- vim.o.pumheight = 10 -- Pop up menu height (default: 0)
-- vim.o.cmdheight = 1 -- More space in the Neovim command line for displaying messages (default: 1)
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience (default: 'menu,preview')
-- vim.opt.shortmess:append 'c' -- Don't give |ins-completion-menu| messages (default: does not include 'c')
-- vim.opt.iskeyword:append '-' -- Hyphenated words recognized by searches (default: does not include '-')
-- vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
-- vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)
