local lftmDir = 'C:/GitRepos/lftm/'

---Insert single line string at cursor location
---
---Note: str cannot be more than 1 line
---@param str string
local function insertAtCursor(str)
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. str .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys(str:len() .. 'l', 'n', true)
end

---Append lines or list of lines to beginning of currently selected buffer
---@param strList string|string[]
local function appendBufferStart(strList)
  local line = vim.fn.line(0)
  vim.fn.append(line, strList)
end

---Inserts formatted date at cursor location
local function insertDate()
  local date = os.date('%m.%d.%y')
  insertAtCursor(tostring(date))
end

---Create slug of a string
---@param str string
---@return string
local function slugify(str)
  local allowedChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'
  local tmpSub = str:lower()
  tmpSub = tmpSub:gsub('%s+', '-')
  tmpSub = tmpSub:gsub('%%', '')

  local sub = ''
  for value in tmpSub:gmatch('.') do
    if allowedChars:find(value) then
      sub = sub .. value
    end
  end
  sub = sub:gsub('%-+', '-') --No consecutive dashes
  sub = sub:gsub('-$', '') --Remove trailing dashes
  return sub
end

local function openDailyNote()
  local journalDir = lftmDir .. 'personal/journal/'
  local dayOfWeek = os.date('%A')
  local fileDate = os.date('%Y%m%d')
  local fileName = fileDate .. '.md'
  local filePath = journalDir .. fileName

  -- Check if file exists in file system
  if vim.fn.globpath(journalDir, fileName) ~= '' then
    vim.cmd(':edit ' .. filePath)
    vim.api.nvim_feedkeys('G', 'n', true)
    return
  end

  -- Create file
  vim.cmd(':enew')
  local template = {
    '---',
    'tags:',
    '  - journal',
    '---',
    '',
    '# ' .. dayOfWeek .. ' - ' .. os.date('%m.%d.%Y'),
  }

  appendBufferStart(template)

  vim.cmd(':file ' .. filePath)
  vim.cmd(':w')
  vim.cmd(':setlocal filetype=markdown')
  vim.api.nvim_feedkeys('Go', 'n', true)
end

local function createJournalNote()
  local notesDir = lftmDir .. 'personal/notes/'
  local fileDate = os.date('%Y%m%d%H%M%S')
  local ogTitle = vim.fn.input({ prompt = 'File name: ', cancelreturn = '' })
  local title = slugify(ogTitle)

  if title == '' then
    print('Invalid title')
    return
  end

  local fileName = fileDate .. '-' .. title .. '.md'
  vim.cmd(':enew')
  local template = {
    '---',
    'tags:',
    '  - notes',
    '---',
    '',
    '# ' .. ogTitle
  }

  appendBufferStart(template)

  vim.cmd(':file ' .. notesDir .. fileName)
  vim.cmd(':w')
  vim.cmd(':setlocal filetype=markdown')
  vim.api.nvim_feedkeys('Go', 'n', true)
end

local Utils = {
  openDailyNote = openDailyNote,
  insertDate = insertDate,
  createJournalNote = createJournalNote,
}

return Utils
