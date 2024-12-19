local palette = require('nightfox.palette').load 'nightfox'


require("cyberdream").setup({
    -- Enable transparent background
    transparent = true,
})

-- fajfjwao
require('hlchunk').setup {
  chunk = {
    enable = true,
    priority = 15,
    style = {
      { fg = palette.white.dim },
      { fg = palette.red.normal },
    },
    use_treesitter = true,
    chars = {
      horizontal_line = '─',
      vertical_line = '│',
      left_top = '╭',
      left_bottom = '╰',
      right_arrow = '>',
    },
    error_sign = true,
    -- animation related
    duration = 0,
    delay = 0,
  },
  indent = {
    enable = true,
  },
}

require('gitsigns').setup {
  signs = {
    add = { text = '│' },
    change = { text = '│' },
    delete = { text = '│' },
    topdelete = { text = '-│' },
    changedelete = { text = '-│' },
    untracked = { text = '│' },
  },
  signs_staged = {
    add = { text = '││' },
    change = { text = '││' },
    delete = { text = '││' },
    topdelete = { text = '-││' },
    changedelete = { text = '-││' },
    untracked = { text = '││' },
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal { ']h', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Next change [H]unk' })

    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal { '[h', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Previous change [H]unk' })

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

  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '                               ',
  '-------------------------------',
  '| $ git push origin master -f |',
  '______________________,________',
  '⠸⣷⣦⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⠀⠀⠀ ',
  '⠀⠙⣿⡄⠈⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⠊⠉⣿⡿⠁⠀⠀⠀ ',
  '⠀⠀⠈⠣⡀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠁⠀⠀⣰⠟⠀⠀⠀⣀⣀ ',
  '⠀⠀⠀⠀⠈⠢⣄⠀⡈⠒⠊⠉⠁⠀⠈⠉⠑⠚⠀⠀⣀⠔⢊⣠⠤⠒⠊⠉⠀⡜ ',
  '⠀⠀⠀⠀⠀⠀⠀⡽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⡔⠊⠁⠀⠀⠀⠀⠀⠀⠇ ',
  '⠀⠀⠀⠀⠀⠀⢀⠇⠹⠿⠟⠀⠀⠤⠀⠀⠻⠿⠟⠀⣇⠀⠀⡀⠠⠄⠒⠊⠁⠀ ',
  '⠀⠀⠀⠀⠀⠀⢸⣿⣿⡆⠀⠰⠤⠖⠦⠴⠀⢀⣶⣿⣿⠀⠙⢄⠀⠀⠀⠀⠀⠀ ',
  '⠀⠀⠀⠀⠀⠀⠀⢸⠈⠓⠦⠀⣀⣀⣀⠀⡠⠴⠊⠹⡞⣁⠤⠒⠉⠀⠀⠀⠀⠀ ',
  '⠀⠀⠀⠀⠀⠀⣠⠃⠀⠀⠀⠀⡌⠉⠉⡤⠀⠀⠀⠀⢻⠿⠆⠀⠀⠀⠀⠀⠀⠀ ',
  '⠀⠀⠀⢶⣗⠧⡀⢳⠀⠀⠀⠀⢸⣀⣸⠀⠀⠀⢀⡜⠀⣸⢤⣶⠀⠀⠀⠀⠀⠀ ',
  '⠀⠀⠀⠈⠻⣿⣦⣈⣧⡀⠀⠀⢸⣿⣿⠀⠀⢀⣼⡀⣨⣿⡿⠁⠀⠀⠀⠀⠀⠀ ',
  '⠀⠀⠀⠀⠀⠈⠻⠿⠿⠓⠄⠤⠘⠉⠙⠤⢀⠾⠿⣿⠟⠋         ',
}

local icon2 = {
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
  dashboard.button('p', '󱠒  > Open project', ':Telescope projects<CR>'),
  dashboard.button('f', '󰈞  > Find file', ':Telescope find_files<CR>'),
  dashboard.button('r', '  > Recent', ':Telescope oldfiles<CR>'),
  dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
}

alpha.setup(dashboard.opts)

return {}
