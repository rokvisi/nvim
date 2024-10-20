-- This file is loaded before initializing lazy.nvim
----------------------------------------------------

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable line wrapping
vim.opt.wrap = false

-- Merge system clipboard with vim clipboard
vim.opt.clipboard = "unnamedplus"

-- Set line numbers (current line abosulte, others relative)
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Use spaces instead of tabs
vim.opt.expandtab = true -- expand tab input with spaces characters
vim.opt.smartindent = true -- syntax aware indentations for newline inserts
vim.opt.tabstop = 4 -- num of space characters per tab
vim.opt.shiftwidth = 4 -- spaces per indentation level
vim.opt.shiftwidth = 4 -- spaces per indentation level

-- Allow cursor to move anywhere in visual block mode
vim.opt.virtualedit = "block" 

-- Split new windows below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable 24 bit color support
vim.opt.termguicolors = true

-- Ignore case when typing commands
vim.opt.ignorecase = true

-- Disable default statu line (since we are using lualine)
vim.opt.showmode = false -- disable text
vim.opt.laststatus = 3 -- disable the line