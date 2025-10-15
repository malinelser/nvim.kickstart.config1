return {
    'folke/which-key.nvim',
    event = 'vimenter', -- sets the loading event to 'vimenter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a nerd font
        mappings = vim.g.have_nerd_font,
        -- if you are using a nerd font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined nerd font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          up = '<up> ',
          down = '<down> ',
          left = '<left> ',
          right = '<right> ',
          c = '<c-…> ',
          m = '<m-…> ',
          d = '<d-…> ',
          s = '<s-…> ',
          cr = '<cr> ',
          esc = '<esc> ',
          scrollwheeldown = '<scrollwheeldown> ',
          scrollwheelup = '<scrollwheelup> ',
          nl = '<nl> ',
          bs = '<bs> ',
          space = '<space> ',
          tab = '<tab> ',
          f1 = '<f1>',
          f2 = '<f2>',
          f3 = '<f3>',
          f4 = '<f4>',
          f5 = '<f5>',
          f6 = '<f6>',
          f7 = '<f7>',
          f8 = '<f8>',
          f9 = '<f9>',
          f10 = '<f10>',
          f11 = '<f11>',
          f12 = '<f12>',
        },
      },

      -- document existing key chains
      spec = {
        { '<leader>s', group = '[s]earch' },
        { '<leader>s', group = "[s]earch grandparent's folder" },
        { '<leader>t', group = '[t]oggle' },
        { '<leader>c', group = '[c]lose' }, -- //malin
        { '<leader>q', group = '[q]uickfixlist opts' }, -- //malin
        { '<leader>p', group = 's[p]lit screen' }, -- //malin
        { '<leader>g', group = 'treesitter/lsp motions' }, -- //malin
        { '<leader>n', group = '[n]ode selection' }, -- //malin
        { '<leader>w', group = '[w]rite/save/open' }, -- //malin
        { '<leader>d', group = '[d]iagnostics' }, -- //malin
        { '<leader>h', group = 'git [h]unk', mode = { 'n', 'v' } },
      },
    },
  }
