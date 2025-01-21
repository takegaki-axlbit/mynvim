local keymap = vim.keymap
local wk = require 'which-key'

-- Map Y to y$
keymap.set('n', 'Y', 'y$')

-- tab
keymap.set('n', 'H', 'gT')
keymap.set('n', 'L', 'gt')
keymap.set('n', '<C-h>', '<CMD>wincmd h<CR>')
keymap.set('n', '<C-l>', '<CMD>wincmd l<CR>')
keymap.set('n', '<C-j>', '<CMD>wincmd j<CR>')
keymap.set('n', '<C-k>', '<CMD>wincmd k<CR>')

-- v
keymap.set('n', '<leader>v', '<C-v>', { noremap = true, silent = true, desc = '[V]isual block mode' })

-- terminal mode escape
keymap.set('t', '<esc>', [[<C-\><C-n>]])
keymap.set('t', '<C-[>', [[<C-\><C-n>]])
keymap.set('t', '<C-[>', [[<C-\><C-n>]])

keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open exploerer' })

-- aerial
keymap.set('n', '<leader>ta', '<cmd>AerialToggle!<CR>', { desc = 'Toggle [A]erial' })

-- telescope
keymap.set('n', '<Leader>lc', require('telescope.builtin').command_history, { desc = '[C]ommand log' })
keymap.set('n', '<Leader>ls', require('telescope.builtin').search_history, { desc = '[S]earch log' })
keymap.set('n', '<leader>lm', ':Telescope noice<CR>', { desc = '[M]essage log' })
keymap.set('n', '<leader>wc', ':Telescope colorscheme<CR>', { desc = '[C]olorscheme' })

-- hop
keymap.set('', 'M', ':HopWordMW<CR>', { desc = '[M]ove to word' })

-- neogen
keymap.set('n', '<leader>cd', ':Neogen<CR>', { desc = 'Add [D]ocument' })

-- fullpath copy to clipboard
keymap.set(
  'n',
  '<leader>y',
  [[:lua print("yanked fullpath: " .. vim.fn.expand('%:p')); vim.fn.setreg('+', vim.fn.expand('%:p'))<CR>]],
  { noremap = true, silent = true, desc = '[Y]ank fullpath' }
)

keymap.set('n', '<leader>tm', ':MarkdownPreviewToggle<CR>', { desc = 'Toggle [M]arkdown preview' })

wk.add {
  { '<leader>l', group = '[L]og' },
}

wk.add {
  { '<leader>wt', group = '[T]erminal' },
}
-- toggle term (lazy git)
keymap.set("n", "<leader>wl", function()
  vim.cmd("tabnew")
  vim.cmd("setlocal nonumber norelativenumber")
  vim.cmd("terminal lazygit")
end, { noremap = true, silent = true, desc = "[L]azygit" })

keymap.set("n", "<leader>wts", function()
  vim.cmd("split | resize 15 | terminal")
end, { noremap = true, silent = true, desc = "[S]plit" })

keymap.set("n", "<leader>wtv", function()
  vim.cmd("vsplit | vertical resize 90 | terminal")
end, { noremap = true, silent = true, desc = "[V]ertical split" })

keymap.set("n", "<leader>wtt", function()
  vim.cmd("tabnew | terminal")
end, { noremap = true, silent = true, desc = "in new [T]ab" })

wk.add {
  { '<leader>wx', group = '[X] mode' },
}
-- cellular-automation
keymap.set('n', '<leader>wxr', '<cmd>CellularAutomaton make_it_rain<CR>', { noremap = true, silent = true, desc = '[R]ain' })
keymap.set('n', '<leader>wxs', '<cmd>LetItSnow<CR>', { noremap = true, silent = true, desc = '[S]now' })

-- winresize

wk.add {
  { '<leader>wr', group = '[R]esize' },
}
local submode = require 'submode'
local resize = require('winresize').resize
submode.create('WinMove', {
  mode = 'n',
  enter = '<Leader>wr',
  leave = { 'q', '<ESC>' },
  default = function(register)
    register('h', function()
      resize(0, 2, 'left')
    end)
    register('j', function()
      resize(0, 2, 'down')
    end)
    register('k', function()
      resize(0, 2, 'up')
    end)
    register('l', function()
      resize(0, 2, 'right')
    end)
  end,
})

return {}
