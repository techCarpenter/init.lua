local utils = require('techcarpenter.utils')

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'open file explorer' })
vim.keymap.set('n', '<leader>.', function() vim.cmd.edit(vim.fn.stdpath 'config' .. '/init.lua') end,
  { desc = 'open config' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', [["_dP]])

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set({ 'n', 'v', 'i' }, '<C-c>', '<Esc>')
vim.keymap.set('n', '<A-F>', function() vim.cmd(':Format') end)

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous [D]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'next [D]iagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set('i', '<C-H>', '<ESC>lcb>') --<C-H> maps to backspace in the terminal

-- LFTM shortcuts
vim.keymap.set('n', '<leader>kd', utils.insertDate, { desc = 'Insert Date' })
vim.keymap.set('n', '<leader>kn', utils.openDailyNote, { desc = 'Create daily note' })
vim.keymap.set('n', '<leader>kj', utils.createJournalNote, { desc = 'Create journal note' })
vim.keymap.set('n', '<leader>ks', utils.openStandupNote, { desc = 'Create standup note' })

