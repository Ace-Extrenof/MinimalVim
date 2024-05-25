vim.g.mapleader = ' '

local keymap = vim.keymap

keymap.set("n", '<leader>e', ":Ex<CR>")

keymap.set('n', 'K', ':vim.lsp.buf.definition()')

keymap.set('n', '<leader>zm', ':ZenMode<CR>')
