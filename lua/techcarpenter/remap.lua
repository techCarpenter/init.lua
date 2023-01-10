-- [[ Basic Keymaps ]]
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

---Insert single line string at cursor location
---@param str string
function InsertAtCursor(str)
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. str .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys(str:len() .. 'l', 'n', true)
end

---Inserts formatted date at cursor location
function Date()
  local date = os.date('%m.%d.%y')
  InsertAtCursor(tostring(date))
end

vim.keymap.set('n', '<leader>dd', Date, { desc = 'Insert Date' })

---Create slug of a string
---@param str string
---@return string
function Slugify(str)
  local allowedChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'
  local tmpSub = str:lower()
  tmpSub = tmpSub:gsub('%s+', '-')
  tmpSub = tmpSub:gsub('%%', '')

  local sub = ''
  for value in tmpSub:gmatch(".") do
    if allowedChars:find(value) then
      sub = sub .. value
    end
  end
  sub = sub:gsub('%-+', '-')
  return sub
end

function DailyNote()
  local journalDir = 'C:/GitRepos/lftm/personal/journal/'
  local dayOfWeek = os.date('%A')
  local fileDate = os.date('%Y%m%d')
  local fileName = fileDate .. '.md'
  local filePath = journalDir .. fileName

  -- Check if file exists in file system
  if vim.fn.globpath(journalDir, fileName) ~= '' then
    vim.cmd(':edit ' .. filePath)
    return
  end

  vim.cmd(':enew')
  local template = {
    "---",
    "tags:",
    "  - journal",
    "---",
    "",
    "# " .. dayOfWeek .. ' - ' .. os.date('%m.%d.%Y'),
  }

  local line = vim.fn.line(0)
  vim.fn.append(line, template)

  vim.cmd(':file ' .. filePath)
  vim.cmd(':w')
  vim.cmd(':setlocal filetype=markdown')
  vim.api.nvim_feedkeys('Go', 'n', true)
end

vim.keymap.set('n', '<leader>dn', DailyNote, { desc = 'Create daily note' })

function JournalNote()
  local journalDir = 'C:/GitRepos/lftm/personal/notes/'
  local fileDate = os.date('%Y%m%d%H%M%S')
  local title = vim.fn.input({ prompt = 'File name: ', cancelreturn = '' })
  title = Slugify(title)

  if title == '' then return end

  vim.cmd(':enew')
  vim.cmd(':file ' .. journalDir .. fileDate .. title .. '.md')
end

vim.keymap.set('n', '<leader>dj', JournalNote, { desc = 'Create journal note' })
