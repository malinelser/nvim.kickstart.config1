-- https://github.com/ggandor/leap.nvim
return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = { -- 👈 only horizontal pickers get these sizes
              width = 0.999,
              height = 0.999,
              preview_width = 0.45,
            },
          },
        },
        --
        pickers = {
          live_grep = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            additional_args = function(_)
              return { '--hidden' }
            end,
          },
          find_files = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv' },
            hidden = true,
          },
        },
        --
        --
        --
        --
        --
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'live_grep_args')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      -- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' }) -- having function further down to open in normal mode
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      --
      vim.keymap.set(
        'n',
        '<leader>sb',
        [[:Telescope live_grep grep_open_files=true<CR>]],
        { desc = '[s]earch by grep in [b]uffers' }
      )
      --
      vim.keymap.set(
        'n',
        '<leader>sg',
        [[:lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>'' --hidden<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
        { desc = '[S]earch by [G]rep' }
      )
      vim.keymap.set(
        'n',
        '<leader>sp',
        [[:lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>'<connect produce="yes" signal-reference="' --glob 'bazel-out/ems-opt/bin/software/tl-ccm/**' -txml -L --no-ignore --hidden<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
        { desc = '[S]earch [P]roducing SignalObject in _out' }
      )
      vim.keymap.set(
        'n',
        '<leader>so',
        [[:lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>'' --glob 'bazel-out/ems-opt/bin/software/signal/src/**' -txml -L --no-ignore --hidden<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
        { desc = '[S]earch Signal[O]bject unit in _out' }
      )
      vim.keymap.set(
        'n',
        '<leader>sw',
        [[:lua require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()<CR>--hidden<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
        { desc = '[S]earch current [W]ord' }
      )

      vim.keymap.set('n', '<leader>sr', function()
        builtin.resume { initial_mode = 'normal' }
      end, { desc = '[S]earch [R]esume' })

      -- telescope function to search file name under cursor
      vim.keymap.set('n', '<leader>sn', function()
        require('telescope.builtin').find_files {
          default_text = vim.fn.expand '<cword>', -- word under cursor
          -- initial_mode = 'normal', -- start in normal mode
        }
      end, { desc = '[S]earch file [N]ame under cursor' })
      --
      -- Search files in parent folder ---------------------------------------------------------------
      vim.keymap.set('n', '<Leader>sF', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h'),
        }
      end, { noremap = true, silent = true, desc = 'Search files in parent folder' })

      -- Live Grep in parent folder
      vim.keymap.set('n', '<Leader>sG', function()
        require('telescope.builtin').live_grep {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h'),
        }
      end, { noremap = true, silent = true, desc = 'Search Grep in parent folder' })

      -- Grep word in parent folder
      vim.keymap.set('n', '<Leader>sW', function()
        require('telescope.builtin').grep_string {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h'),
          -- initial_mode = 'normal', -- start in normal mode
        }
      end, { noremap = true, silent = true, desc = 'Search Word in parent folder' })
      -- telescope function to search file name under cursor
      vim.keymap.set('n', '<leader>sN', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h'),
          default_text = vim.fn.expand '<cword>', -- word under cursor
          -- initial_mode = 'normal', -- start in normal mode
        }
      end, { desc = '[S]earch file [N]ame under cursor in parent folder' })

      -- Search files in grandparent folder ----------------------------------------------------------
      vim.keymap.set('n', '<Leader>Sf', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h'),
        }
      end, { noremap = true, silent = true, desc = '[S]earch [f]iles in grandparent folder' })

      -- Live Grep in parent folder
      vim.keymap.set('n', '<Leader>Sg', function()
        require('telescope.builtin').live_grep {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h'),
        }
      end, { noremap = true, silent = true, desc = '[S]earch [g]rep in grandparent folder' })

      -- Grep word in parent folder
      vim.keymap.set('n', '<Leader>Sw', function()
        require('telescope.builtin').grep_string {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h'),
          -- initial_mode = 'normal', -- start in normal mode
        }
      end, { noremap = true, silent = true, desc = '[S]earch [w]ord in grandparent folder' })

      vim.keymap.set('n', '<leader>Sn', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h'),
          default_text = vim.fn.expand '<cword>', -- word under cursor
          -- initial_mode = 'normal', -- start in normal mode
        }
      end, { desc = '[S]earch file [n]ame under cursor in grandparent folder' })

      -- Search files in grandparent's parent's folder -----------------------------------------------
      vim.keymap.set('n', '<Leader>SF', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h:h'),
        }
      end, { noremap = true, silent = true, desc = '[S]earch [F]iles in grandparent parent folder' })

      -- Live Grep in parent folder
      vim.keymap.set('n', '<Leader>SG', function()
        require('telescope.builtin').live_grep {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h:h'),
        }
      end, { noremap = true, silent = true, desc = '[S]earch [G]rep in grandparent parent folder' })

      -- Grep word in parent folder
      vim.keymap.set('n', '<Leader>SW', function()
        require('telescope.builtin').grep_string {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h:h'),
          -- initial_mode = 'normal', -- start in normal mode
        }
      end, { noremap = true, silent = true, desc = '[S]earch [W]ord in grandparent parent folder' })

      vim.keymap.set('n', '<leader>SN', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.fnamemodify(vim.fn.expand '%:p:h', ':h:h:h'),
          default_text = vim.fn.expand '<cword>', -- word under cursor
          -- initial_mode = 'normal', -- start in normal mode
        }
      end, { desc = '[S]earch file [N]ame under cursor in grandparent parent folder' })
      --
      -- Slightly advanced example of overriding default behavior and theme
      -- vim.keymap.set('n', '<leader>/', function() -- //Malin created my own keymap instead
      --   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      --   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
      --
    end,
  },
}
