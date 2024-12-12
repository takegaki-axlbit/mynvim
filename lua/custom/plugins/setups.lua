local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new {
  cmd = 'lazygit',
  direction = 'float',
  hidden = true,
}

function _lazygit_toggle()
  lazygit:toggle()
end
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'lazygit' })

require('hlchunk').setup {
  chunk = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

require('gitsigns').setup {
  signs = {
    add = { text = ' ▎' },
    change = { text = ' ▎' },
    delete = { text = ' ' },
    topdelete = { text = ' ' },
    changedelete = { text = '~' },
    untracked = { text = '▎ ' },
  },
  signs_staged = {
    add = { text = ' ▎' },
    change = { text = ' ▎' },
    delete = { text = ' ' },
    topdelete = { text = ' ' },
    changedelete = { text = '~' },
    untracked = { text = '▎ ' },
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Next [C]hange hunk' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Previous [C]hange hunk' })

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]eset hunk' })
    map('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = '[S]tage hunk' })
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = '[R]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[U]ndo stage hunk' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review hunk' })
    map('n', '<leader>hb', function()
      gitsigns.blame_line { full = true }
    end, { desc = '[B]lame line' })
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle current line [B]lame' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = '[D]iff' })
    map('n', '<leader>hD', function()
      gitsigns.diffthis '~'
    end, { desc = '[D]iff compared to the last commit' })
    map('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'Toggle [D]eleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'inner hunk' })
    map({ 'o', 'x' }, 'ah', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'hunk' })
  end,
}

local icon = {
  '           -mh.                           h.    `Ndho               ',
  '           hmh+                          oNm.   oNdhh               ',
  '          `Nmhd`                        /NNmd  /NNhhd               ',
  '          -NNhhy                      `hMNmmm`+NNdhhh               ',
  '          .NNmhhs              ```....`..-:/./mNdhhh+               ',
  '           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ',
  '           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ',
  '      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ',
  ' .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ',
  ' h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ',
  ' hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ',
  ' /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ',
  '  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ',
  '   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ',
  '     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ',
  '       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ',
  '       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ',
  '       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ',
  '       //+++//++++++////+++///::--                 .::::-------::   ',
  '       :/++++///////////++++//////.                -:/:----::../-   ',
  '       -/++++//++///+//////////////               .::::---:::-.+`   ',
  '       `////////////////////////////:.            --::-----...-/    ',
  '        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ',
  '         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ',
  '           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ',
  '            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``',
  '           s-`::--:::------:////----:---.-:::...-.....`./:          ',
  '          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ',
  '         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ',
  '        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ',
  '                        .-:mNdhh:.......--::::-`                    ',
}

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

math.randomseed(os.time())

local function pick_color()
  local colors = { 'String', 'Identifier', 'Keyword', 'Number' }
  return colors[math.random(#colors)]
end

dashboard.section.header.val = icon
dashboard.section.header.opts.hl = pick_color()
dashboard.section.buttons.val = {
  dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
  dashboard.button('x', '󰙅  > Open Neotree', ':Neotree toggle<CR>'),
  dashboard.button('f', '󰈞  > Find file', ':Telescope find_files<CR>'),
  dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>'),
  dashboard.button('s', '  > Settings', ':e $MYVIMRC<CR>'),
  dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
}

alpha.setup(dashboard.opts)

require('satellite').setup {
  current_only = false,
  winblend = 50,
  zindex = 40,
  excluded_filetypes = {},
  width = 2,
  handlers = {
    cursor = {
      enable = true,
      -- Supports any number of symbols
      symbols = { '⎺', '⎻', '⎼', '⎽' }
      -- symbols = { '⎻', '⎼' }
      -- Highlights:
      -- - SatelliteCursor (default links to NonText
    },
    search = {
      enable = true,
      -- Highlights:
      -- - SatelliteSearch (default links to Search)
      -- - SatelliteSearchCurrent (default links to SearchCurrent)
    },
    diagnostic = {
      enable = true,
      signs = {'-', '=', '≡'},
      min_severity = vim.diagnostic.severity.HINT,
      -- Highlights:
      -- - SatelliteDiagnosticError (default links to DiagnosticError)
      -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
      -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
      -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
    },
    gitsigns = {
      enable = true,
      signs = { -- can only be a single character (multibyte is okay)
        add = "│",
        change = "│",
        delete = "-",
      },
      -- Highlights:
      -- SatelliteGitSignsAdd (default links to GitSignsAdd)
      -- SatelliteGitSignsChange (default links to GitSignsChange)
      -- SatelliteGitSignsDelete (default links to GitSignsDelete)
    },
    marks = {
      enable = true,
      show_builtins = false, -- shows the builtin marks like [ ] < >
      key = 'm'
      -- Highlights:
      -- SatelliteMark (default links to Normal)
    },
    quickfix = {
      signs = { '-', '=', '≡' },
      -- Highlights:
      -- SatelliteQuickfix (default links to WarningMsg)
    }
  },
}

return {}
