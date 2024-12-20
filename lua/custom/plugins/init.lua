-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
-- Set transparent background for FidgetTitle and FidgetTask
vim.bo.fileformat = 'unix'
vim.opt.shadafile = "NONE"

local opt = vim.opt

opt.encoding = 'utf-8'
-- swapfile off
opt.swapfile = false
opt.clipboard = 'unnamedplus'
opt.termguicolors = true
opt.showtabline = 0

vim.cmd 'language en_US'

-- Disable cursor line and column highlight when leaving a window
vim.api.nvim_create_autocmd('WinLeave', {
  pattern = '*',
  callback = function()
    vim.opt.cursorline = false
    -- vim.opt.cursorcolumn = false
  end,
})

-- Enable cursor line and column highlight when entering a window
vim.api.nvim_create_autocmd('WinEnter', {
  pattern = '*',
  callback = function()
    vim.opt.cursorline = true
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function lsp_names()
  local buf_clients = vim.lsp.buf_get_clients()
  local buf_ft = vim.bo.filetype
  if next(buf_clients) == nil then
    return ' No servers'
  end
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= 'null-ls' then
      table.insert(buf_client_names, client.name)
    end
  end

  local lint_s, lint = pcall(require, 'lint')
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if type(ft_v) == 'table' then
        for _, linter in ipairs(ft_v) do
          if buf_ft == ft_k then
            table.insert(buf_client_names, linter)
          end
        end
      elseif type(ft_v) == 'string' then
        if buf_ft == ft_k then
          table.insert(buf_client_names, ft_v)
        end
      end
    end
  end

  local ok, conform = pcall(require, 'conform')
  local formatters = table.concat(conform.formatters_by_ft[vim.bo.filetype], ' ')
  if ok then
    for formatter in formatters:gmatch '%w+' do
      if formatter then
        table.insert(buf_client_names, formatter)
      end
    end
  end

  local hash = {}
  local unique_client_names = {}

  for _, v in ipairs(buf_client_names) do
    if not hash[v] then
      unique_client_names[#unique_client_names + 1] = v
      hash[v] = true
    end
  end
  local language_servers = table.concat(unique_client_names, ', ')

  return ' ' .. language_servers
end

vim.o.laststatus = 3

local mode_map = {
  ['NORMAL'] = ' 𝗡𝗢𝗥𝗠𝗔𝗟', -- Normal mode
  ['MORE'] = ' 𝗠𝗢𝗥𝗘', -- More mode (pager-like mode)
  ['CONFIRM'] = '  𝗖𝗢𝗡𝗙𝗜𝗥𝗠', -- Confirm mode (e.g., for certain prompts)
  ['O-PENDING'] = ' 𝗢-𝗣𝗘𝗡𝗗𝗜𝗡𝗚', -- Operator-pending mode
  ['V-REPLACE'] = '󰩷 𝗩-𝗥𝗘𝗣𝗟𝗔𝗖𝗘', -- Virtual replace mode
  ['REPLACE'] = '󰩷 𝗥𝗘𝗣𝗟𝗔𝗖𝗘', -- Replace mode
  ['VISUAL'] = '󰩷 𝗩𝗜𝗦𝗨𝗔𝗟', -- Visual mode
  ['V-LINE'] = '󰩷 𝗩-𝗟𝗜𝗡𝗘', -- Visual line mode
  ['V-BLOCK'] = '󰩷 𝗩-𝗕𝗟𝗢𝗖𝗞', -- Visual block mode
  ['SELECT'] = '󰩷 𝗦𝗘𝗟𝗘𝗖𝗧', -- Select mode
  ['S-LINE'] = '󰩷 𝗦-𝗟𝗜𝗡𝗘', -- Select line mode
  ['S-BLOCK'] = '󰩷 𝗦-𝗕𝗟𝗢𝗖𝗞', -- Select block mode
  ['INSERT'] = ' 𝗜𝗡𝗦𝗘𝗥𝗧', -- Insert mode
  ['COMMAND'] = ' 𝗖𝗢𝗠𝗠𝗔𝗡𝗗', -- Command-line editing mode
  ['EX'] = ' 𝗘𝗫', -- Ex mode (extended command-line mode)
  ['SHELL'] = ' 𝗦𝗛𝗘𝗟𝗟', -- Shell mode
  ['TERMINAL'] = ' 𝗧𝗘𝗥𝗠𝗜𝗡𝗔𝗟', -- Terminal mode
}

return {
  {
    'luukvbaal/statuscol.nvim',
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },
  {
    'danymat/neogen',
    config = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = (string.find(vim.g.colors_name, 'lackluster') and 'lackluster') or 'auto',
          -- section_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_show_tabline = false,
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          -- lualine_a = {
          --   function()
          --     return mode_map[vim.api.nvim_get_mode().mode] or '__'
          --   end,
          -- },
          lualine_a = {
            {
              'mode',
              color = { gui = 'none' },
              -- separator = { left = '', right = '' },
              fmt = function(res)
                return mode_map[res] or '__'
              end,
            },
          },
          lualine_b = {
            {
              'tabs',
              symbols = {
                modified = '  ', -- Text to show when the file is modified.
              },
              -- separator = { right = '' },
              tabs_color = {
                -- Same values as the general color option can be used here.
                active = 'StatusLine', -- Color for active tab.
                inactive = 'StatusLineNC', -- Color for inactive tab.
              },
            },
          },
          lualine_c = {
            {
              'windows',
              -- separator = { right = '' },
              windows_color = {
                -- Same values as the general color option can be used here.
                active = 'StatusLine', -- Color for active tab.
                inactive = 'StatusLineNC', -- Color for inactive tab.
              },
            },
          },
          lualine_x = {
            {
              lsp_names,
              separator = '·',
            },
            {
              'diff',
              separator = '·',
              symbols = { added = ' ', modified = ' ', removed = '󰍷 ' },
              source = diff_source,
            },
            {
              'diagnostics',
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            },
          },
          lualine_y = {
            {
              'b:gitsigns_head',
              icon = { '' },
              color = 'StatusLineNC',
              -- separator = { left = '' }
            },
            {
              'encoding',
              -- separator = { left = '' },
            },
            {
              'filetype',
              -- separator = { left = '' },
              color = 'StatusLineNC',
            },
          },

          lualine_z = {
            {
              'fileformat',
              symbols = {
                unix = '', -- e712
                dos = '', -- e70f
                mac = '', -- e711
              },
              -- separator = { right = '', left = '' },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        winbar = {},
        inactive_winbar = {},
      }
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    init = function()
      -- vim.cmd.colorscheme 'carbonfox'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'lackluster-mint'
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'cyberdream'
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- {
      --   'rcarriga/nvim-notify',
      -- },
    },
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    },
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<esc>'] = 'actions.close',
        ['<C-[>'] = 'actions.close',
      },
    },
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'echasnovski/mini.icons',
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      keys = 'etovxqpdygfblzhckisuran',
    },
  },
  {
    'eandrju/cellular-automaton.nvim',
  },
  {
    'pogyomo/winresize.nvim',
  },
  {
    'pogyomo/submode.nvim',
    lazy = true,
  },
  {
    'chrisgrieser/nvim-early-retirement',
    config = true,
    event = 'VeryLazy',
  },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('gitsigns').setup()
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
  {
    'coffebar/neovim-project',
    opts = {
      projects = {
        '~/hogehoge/*',
        '~/adobe-addon/*',
        '~/aws-addon/*',
        '~/csp-addon/*',
        '~/cybozu-addon/*',
        '~/kdsp-addon/*',
        '~/neic-addon/*',
        '~/ot-addon/*',
        '~/sony-payment-addon/*',
      },
      picker = {
        type = 'telescope',
      },
      dashboard_mode = true,
    },
    init = function()
      vim.opt.sessionoptions:append 'globals' -- save global variables
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
      { 'Shatur/neovim-session-manager' },
    },
    lazy = false,
    priority = 100,
  },
  {
    'marcussimonsen/let-it-snow.nvim',
    cmd = 'LetItSnow', -- Wait with loading until command is run
    opts = {},
  },
}
