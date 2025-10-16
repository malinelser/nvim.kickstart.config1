-- https://github.com/ggandor/leap.nvim
return {
{ -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'printf',
        'python',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
      auto_install = true,
      highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
      indent = { enable = false }, -- Malin disabled all, but it's also possible to only disbale some, disable = { 'c', 'cpp', 'ruby' }
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<leader>ni',
          node_incremental = '<leader>nn',
          scope_incremental = '<leader>gs',
          node_decremental = '<leader>nb',
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ['<leader>gnf'] = '@function.outer',
            ['<leader>gnc'] = '@class.outer',
            ['<leader>gna'] = '@parameter.inner',
          },
          goto_next_end = {
            ['<leader>gF'] = '@function.outer',
            ['<leader>gC'] = '@class.outer',
            ['<leader>gA'] = '@parameter.inner',
          },
          goto_previous_start = {
            ['<leader>gf'] = '@function.outer',
            ['<leader>gc'] = '@class.outer',
            ['<leader>ga'] = '@parameter.inner',
          },
          goto_previous_end = {
            ['<leader>gpF'] = '@function.outer',
            ['<leader>gpC'] = '@class.outer',
            ['<leader>gpA'] = '@parameter.inner',
          },
        },
      },
      refactor = {
        navigation = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
          keymaps = {
            goto_definition = false,
            list_definitions = false,
            list_definitions_toc = false,
            goto_next_usage = '<leader>.',
            goto_previous_usage = '<leader>,',
          },
        },
      },
    },
  },
{
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        --   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
    end,
  }
}
