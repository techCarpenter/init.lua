require('zen-mode').setup({
  window = {
    width = 80
  }
})

vim.keymap.set('n', '<leader>zz', ':ZenMode<CR>', { desc = 'Toggle ZenMode' })
