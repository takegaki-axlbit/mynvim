-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--

vim.bo.fileformat = 'unix'

local opt = vim.opt

opt.encoding = 'utf-8'
-- swapfile off
opt.swapfile = false
opt.clipboard = 'unnamedplus'
opt.termguicolors = true


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

return {
  {
    'lewis6991/satellite.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
          theme = 'auto',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            {
              'filename',
              newfile_status = true,
              path = 1,
              shorting_target = 24,
              symbols = { modified = '_󰷥', readonly = ' ', newfile = '󰄛' },
            },
          },
          lualine_c = {},

          lualine_x = {
            'encoding',
          },
          lualine_y = {
            'filetype',
          },

          lualine_z = {
            { 'fileformat', icons_enabled = true, separator = { left = '', right = '' } },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = {
            {
              'buffers',
              symbols = { modified = '_󰷥', alternate_file = ' ', directory = ' ' },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {
            { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' }, source = diff_source },
          },
          lualine_y = {
            { 'b:gitsigns_head', icon = { ' ' } },
          },
          lualine_z = {
            'tabs',
          },
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    init = function()
      vim.cmd.colorscheme 'terafox'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- 'rcarriga/nvim-notify',
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        else
          return 20 -- Default size if direction is not horizontal or vertical
        end
      end,
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
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
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
}
