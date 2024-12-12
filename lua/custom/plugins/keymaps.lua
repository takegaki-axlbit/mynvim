local keymap = vim.keymap

-- Map Y to y$
keymap.set('n', 'Y', 'y$')

-- tab
keymap.set('n', 'H', 'gT')
keymap.set('n', 'L', 'gt')
keymap.set('n', '<C-h>', '<CMD>bp<CR>')
keymap.set('n', '<C-l>', '<CMD>bn<CR>')

-- clear highlight by esc
keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>')

-- terminal mode escape
keymap.set('t', '<esc>', [[<C-\><C-n>]])
keymap.set('t', '<C-[>', [[<C-\><C-n>]])
keymap.set('t', '<C-[>', [[<C-\><C-n>]])

keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open exploerer' })

-- -- toggle term
keymap.set('n', '<leader>ts', '<cmd>ToggleTerm direction=horizontal name=desktop<CR>', { desc = 'Toggle terminal in [S]plit window' })
keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical name=desktop<CR>', { desc = 'Toggle terminal in [V]ertical window' })
keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float name=desktop<CR>', { desc = 'Toggle terminal in [F]loat window' })
keymap.set('n', '<leader>tt', '<cmd>ToggleTerm direction=tab name=desktop<CR>', { desc = 'Toggle terminal in new [T]ab' })

-- aerial
keymap.set('n', '<leader>ta', '<cmd>AerialToggle!<CR>', { desc = 'Toggle [A]erial' })

-- telescope
keymap.set('n', '<Leader>lc', require('telescope.builtin').command_history, { desc = '[C]ommand log' })
keymap.set('n', '<Leader>ls', require('telescope.builtin').search_history, { desc = '[S]earch log' })
keymap.set('n', '<leader>lm', ':Telescope noice<CR>', { desc = '[M]essage log' })
keymap.set('n', '<leader>wc', ':Telescope noice<CR>', { desc = '[W]orkspace [C]olorscheme' })

-- hop
keymap.set('', 'M', ':HopWordMW<CR>', { desc = '[M]ove to word' })

-- neogen
keymap.set('n', '<leader>cd', ':Neogen<CR>', { desc = 'Add [D]ocument' })

-- fullpath copy to clipboard
keymap.set(
  'n',
  '<space>y',
  [[:lua print("yanked fullpath: " .. vim.fn.expand('%:p')); vim.fn.setreg('+', vim.fn.expand('%:p'))<CR>]],
  { noremap = true, silent = true, desc = '[Y]ank fullpath' }
)

local wk = require 'which-key'
wk.add {
  { '<leader>l', group = '[L]og' },
}

return {}  -- Add this line to return an empty table
