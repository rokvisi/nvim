-- Map leader key to SPACE.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable inlay hints.
vim.lsp.inlay_hint.enable(true)

-- Fix windows context nvim shells when using powershell.
vim.opt.shellcmdflag = '-c'
vim.opt.shellxquote = ''

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- KASPARAS: We want to enable text wraps, because we have a cool and sneaky remap for j and k to comfortably move around wraps
vim.opt.wrap = true
vim.opt.breakindent = true

-- KASPRAS: better wrapping option
vim.cmd("set whichwrap+=<,>,[,],h,l")

-- Set line numbers (current line abosulte, others relative)
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.virtualedit = "block" -- Allow cursor to move anywhere in visual block mode
vim.opt.cursorline = true     -- Highlight current line
vim.opt.termguicolors = true  -- Enable 24 bit color support
vim.g.have_nerd_font = true   -- Enable Nerd-font support
vim.opt.ignorecase = true     -- Ignore case when typing commands

vim.opt.expandtab = true      -- expand tab input with spaces characters
vim.opt.tabstop = 4           -- num of space characters per tab
vim.opt.shiftwidth = 4        -- spaces per indentation level
vim.opt.smartindent = true    -- syntax aware indentations for newline inserts
vim.opt.expandtab = true      -- expand tab input with spaces characters

vim.g.html_indent_script1 = "inc"
vim.g.html_indent_style1 = "inc"
vim.g.html_indent_inctags = "html,body,head,tbody"

-- Split new windows below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable the native status line.
vim.opt.showmode = false -- disable text
vim.opt.laststatus = 3   -- disable the line

-- Stop filling empty lines after the buffer with '~'.
vim.opt.fillchars:append({ eob = '~' })

vim.opt.hlsearch = true
vim.opt.incsearch = true
