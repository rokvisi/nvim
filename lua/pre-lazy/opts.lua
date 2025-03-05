-- Map leader key to SPACE.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable inlay hints.
vim.lsp.inlay_hint.enable(true)

-- Fix windows context nvim shells when using powershell.
vim.o.shellcmdflag = '-c'
vim.o.shellxquote = ''

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable text wraps (we have a remap for j/k to comfortably move around wraps)
vim.o.wrap = true
vim.o.breakindent = true

-- KASPRAS: better wrapping options
vim.cmd("set whichwrap+=<,>,[,],h,l")

-- Set line numbers (current line abosulte, others relative)
vim.o.number = true
vim.o.relativenumber = true

vim.o.virtualedit = "block" -- Allow cursor to move anywhere in visual block mode
vim.o.cursorline = true     -- Highlight current line
vim.o.termguicolors = true  -- Enable 24 bit color support
vim.g.have_nerd_font = true -- Enable Nerd-font support
vim.o.ignorecase = true     -- Ignore case when typing commands

vim.o.expandtab = true      -- expand tab input with spaces characters
vim.o.tabstop = 4           -- num of space characters per tab
vim.o.shiftwidth = 4        -- spaces per indentation level
vim.o.smartindent = true    -- syntax aware indentations for newline inserts
vim.o.expandtab = true      -- expand tab input with spaces characters

vim.g.html_indent_script1 = "inc"
vim.g.html_indent_style1 = "inc"
vim.g.html_indent_inctags = "html,body,head,tbody"

-- Split new windows below and to the right
vim.o.splitbelow = true
vim.o.splitright = true

-- Disable the native status line.
vim.o.showmode = false -- disable text
vim.o.laststatus = 3   -- disable the line

-- Set fill characters for various elements.
vim.opt.fillchars = { eob = ' ', fold = ' ', foldopen = '', foldsep = ' ', foldclose = '' }

vim.o.hlsearch = false -- disable search match highlights after exiting search mode.

-- folds
vim.o.foldmethod = "manual" -- needed for ufo
vim.o.foldenable = true     -- Enable folding.
vim.o.foldcolumn = '1'      -- Don't show fold column in the gutter.
vim.o.foldlevel = 99        -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 2
