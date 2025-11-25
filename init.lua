-- filter which-key warnings
local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
  if msg:match 'which%-key' and level == vim.log.levels.WARN then
    return
  end
  orig_notify(msg, level, opts)
end
--
-- Fix normal! gg=G for correct indentation
-- run this to check all indentation / formatting settings
-- :set autoindent? | set smartindent? | set cindent? | set cinoptions? | set cinwords? | set shiftwidth? | set tabstop? | set softtabstop? | set expandtab? | set smarttab? | set indentexpr? | set filetype? | set formatoptions?
-- Use spaces instead of tabs
vim.o.expandtab = true
-- Number of spaces per tab
vim.o.tabstop = 3
-- Number of spaces per indentation level
vim.o.shiftwidth = 3
-- Number of spaces for <Tab> in insert mode
vim.o.softtabstop = 3
-- Enable filetype-based indentation
vim.cmd 'filetype plugin indent on'
--
vim.opt.smartindent = true
--[[

=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.keymap.set('n', '<Leader>ts', function()
  if (vim.o.scrolloff == 10) then
    vim.o.scrolloff = 0
  else
    vim.o.scrolloff = 10
  end
end, { noremap = true, silent = true, desc = 'Toggle minimal visible lines above/below' }) -- //Malin

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signs_staged = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 10000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
      }
    end,
  },
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  -- { -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.
  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
        on_colors = function(colors)
          colors.comment = '#626C9C'
          colors.fg_gutter = '#547287'
        end,
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'gsa', -- Add surrounding
          delete = 'gsd', -- Delete surrounding
          find = 'gsf', -- Find right surrounding
          find_left = 'gsF', -- Find left surrounding
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsr', -- Replace surrounding
          update_n_lines = 'gsn',
        },
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  require 'kickstart.plugins.whichkey', -- thought all the plugins in the plugins folder ran automatically but apperantly not //Malin
  require 'kickstart.plugins.telescope', -- thought all the plugins in the plugins folder ran automatically but apperantly not //Malin
  require 'kickstart.plugins.lspconfig', -- thought all the plugins in the plugins folder ran automatically but apperantly not //Malin
  require 'kickstart.plugins.treesitter', -- thought all the plugins in the plugins folder ran automatically but apperantly not //Malin
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  require 'kickstart.plugins.bufferline', -- thought all the plugins in the plugins folder ran automatically but apperantly not //Malin
  require 'kickstart.plugins.leap', -- thought all the plugins in the plugins folder ran automatically but apperantly not //Malin
  require 'kickstart.plugins.spectre', -- thought all the plugins in the plugins folder ran automatically but apperantly not //Malin
  --
  --
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- show path
vim.opt.winbar = '%=%m %f'

-- Disable LazyVim auto format
vim.g.autoformat = false

vim.opt.sessionoptions:append { 'buffers', 'tabpages', 'winsize' } -- only save this to session

-- Malins own keymaps --
--
vim.keymap.set('n', '<Leader>cb', ':bp | bd#<CR>', { noremap = true, silent = true, desc = 'Delete current buffer' })
vim.keymap.set('n', '<Leader>cq', ':q<CR>', { noremap = true, silent = true, desc = 'Close current screen' })
vim.keymap.set('n', '<Leader>ca', ':qa<CR>', { noremap = true, silent = true, desc = 'Close all' })
vim.keymap.set('n', '<Leader>co', ':only<CR>', { noremap = true, silent = true, desc = 'Only keep current screen, close rest' })
vim.keymap.set('n', '<Leader>cf', ':fc<CR>', { noremap = true, silent = true, desc = 'Close float' })
vim.keymap.set('n', '<Leader>på', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Open split vertical' })
vim.keymap.set('n', '<Leader>pö', ':split<CR>', { noremap = true, silent = true, desc = 'Open split horisontal' })
vim.keymap.set('n', '<Leader>ww', ':noautocmd w<CR>', { noremap = true, silent = true, desc = 'Write' })
vim.keymap.set('n', '<C-right>', ':vertical resize +1<CR>', { noremap = true, silent = true, desc = 'Increase vertical size' })
vim.keymap.set('n', '<C-left>', ':vertical resize -1<CR>', { noremap = true, silent = true, desc = 'Decrease vertical size' })
vim.keymap.set('n', '<C-up>', ':resize +1<CR>', { noremap = true, silent = true, desc = 'Increase vertical size' })
vim.keymap.set('n', '<C-down>', ':resize -1<CR>', { noremap = true, silent = true, desc = 'Decrease vertical size' })
vim.keymap.set('n', '<Leader>v', '<C-v>', { noremap = true, silent = true, desc = 'Block visualizing' })
vim.keymap.set('n', '<leader>/', ':/<C-r>+<CR>', { noremap = true, silent = true, desc = 'Search in file for yanked word' }) -- search in file for last yanked word
vim.keymap.set('n', '<Leader>qs', ':cfdo vsplit<CR>:q<CR>', { noremap = true, silent = true, desc = 'Open all in splits' })
vim.keymap.set('n', '<Leader>qb', ':cfdo badd %<CR>', { noremap = true, silent = true, desc = 'Open all as buffers' })
vim.keymap.set('n', '<Leader>qq', ':cclose<CR>', { noremap = true, silent = true, desc = 'Close QFlist' })
vim.keymap.set(
  'n',
  '<leader>qr',
  [[:cfdo %s/\C<C-r>+/new/g | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
  { noremap = true, silent = true, desc = 'Search/Replace all in QFlist files, case sensitive' }
)
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic quickfix list' }) -- //Malin
--
vim.keymap.set('n', '<leader>dw', function()
  vim.diagnostic.open_float()
end, { desc = 'Show diagnostics under the cursor' })
--
vim.keymap.set('n', '<Leader>tw', function()
  if vim.wo.wrap then
    vim.wo.wrap = false
  else
    vim.wo.wrap = true
  end
end, { noremap = true, silent = true, desc = 'Toggle wrap' })
--
vim.keymap.set('n', '<Leader>tb', ':Gitsigns toggle_current_line_blame<CR>', { noremap = true, silent = true, desc = 'Toggle git [B]lame line' })
--
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')

vim.keymap.set('n', '<Leader>f', ':normal! gg=G<CR>', { noremap = true, silent = true, desc = 'Formatting indent' })

-- keymaps for choosing buffer by number
vim.keymap.set('n', '<leader>1', ':JumpBufferByOrdinal 1<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>2', ':JumpBufferByOrdinal 2<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>3', ':JumpBufferByOrdinal 3<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>4', ':JumpBufferByOrdinal 4<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>5', ':JumpBufferByOrdinal 5<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>6', ':JumpBufferByOrdinal 6<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>7', ':JumpBufferByOrdinal 7<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>8', ':JumpBufferByOrdinal 8<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>9', ':JumpBufferByOrdinal 9<CR>', { noremap = true, silent = true, desc = 'Pick buffer by num' })
vim.keymap.set('n', '<leader>bb', ':BufferLinePick<CR>', { noremap = true, silent = true, desc = 'Pick buffer by letter' })
vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { noremap = true, silent = true, desc = 'Delete buffer by letter' })
require 'kickstart.config.bufferline' -- the config function needs to be run after the keymaps //Malin
--
-- Primeagens keymaps //Malin
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- move visual text
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'J', 'mzJ`z') -- when appending line below to upper line the cursor stays at 0
vim.keymap.set('n', '<leader>rf', [[:%s/<C-r>+/<C-r>+/gI<Left><Left><Left>]], { noremap = true, silent = true, desc = 'Replace yanked word in file' }) -- standing on a word, replace it
vim.keymap.set('n', '<leader>rl', [[:s/<C-r>+//gI<Left><Left><Left>]], { noremap = true, silent = true, desc = 'Replace yanked characters on line' }) -- standing on a word, replace it
--
-- save / open saved sessions
vim.keymap.set(
  'n',
  '<leader>ws',
  [[:mksession ~/.config/nvim/sessions/25.vim<Left><Left><Left><Left>]],
  { noremap = true, silent = true, desc = 'Save session OBS CLOSE EXPLORER' }
) -- save session
vim.keymap.set(
  'n',
  '<leader>wo',
  [[:source ~/.config/nvim/sessions/25.vim<Left><Left><Left><Left>]],
  { noremap = true, silent = true, desc = 'open saved session' }
) -- open saved session
-- run the which-key session config and add the keymap
local wk = require 'which-key'
local sessions = require 'kickstart.config.sessions' -- match the file name
wk.register({
  wd = vim.tbl_extend('force', { name = 'Display saved sessions' }, sessions.get_mappings()),
}, { prefix = '<leader>' })
--
-- turn of default vim motion cmd for making visualized text in lower/upper case, since it often unintentionally does it when I think I just do "undo" cmd
vim.keymap.set("v", "u", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>u", "u", { noremap = true, silent = true }) -- Map <leader>u to lowercase operator (same as pressing 'u')
vim.keymap.set("v", "U", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>U", "U", { noremap = true, silent = true }) -- Map <leader>U to uppercase operator
--
---- ======================================
-- "Y-only Yanks" Neovim config (with <C-x> as old delete+yank)
--  - all delete/change/replace ops → black hole
--  - <C-x> gives you the old yank+delete if you want it
--  - visual paste won't clobber your yank
-- ======================================
--
--
-- Normal + Visual + Operator-pending: delete/change/replace → black hole
vim.keymap.set({ 'n', 'x', 'o' }, 'd', '"_d', { noremap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'dd', '"_dd', { noremap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'D', '"_D', { noremap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'c', '"_c', { noremap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'C', '"_C', { noremap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'x', '"_x', { noremap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'X', '"_X', { noremap = true })

-- Replace (character-wise) → black hole safe
vim.keymap.set('n', 'r', '"_r', { noremap = true })
vim.keymap.set('n', 'R', '"_R', { noremap = true })
vim.keymap.set('n', 'gr', '"_gr', { noremap = true })
vim.keymap.set('n', 'gR', '"_gR', { noremap = true })

-- Visual mode paste: don't yank replaced text
vim.keymap.set('x', 'p', '"_dP', { noremap = true, silent = true })
vim.keymap.set('x', 'P', '"_dP', { noremap = true, silent = true })

-- <C-x> → behave like classic 'd' (delete + yank)
vim.keymap.set({ 'n', 'x', 'o' }, '<C-x>', 'd', { noremap = true })
--
-- save to clipboard history win+v, first you need to download it from https://github.com/equalsraf/win32yank/releases and then put it in C:\win32yank-x64 (no setup in windows required)
vim.g.clipboard = {
  name = 'win32yank-wsl',
  copy = {
    ['+'] = '/mnt/c/win32yank-x64/win32yank.exe -i --crlf',
    ['*'] = '/mnt/c/win32yank-x64/win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = '/mnt/c/win32yank-x64/win32yank.exe -o --lf',
    ['*'] = '/mnt/c/win32yank-x64/win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}
-- make the yank history as the delete history
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    local yank = vim.fn.getreg '"'
    -- shift numbered registers like deletes
    for i = 9, 2, -1 do
      vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
    end
    -- store yank in "1
    vim.fn.setreg('1', yank)
  end,
})
-- Spectre keymaps
vim.keymap.set('n', '<leader>rs', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
vim.keymap.set('n', '<leader>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('v', '<leader>rv', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = 'Search current word',
})
-- vim.keymap.set('n', '<leader>rf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--   desc = 'Search on current file',
-- })
--

-- === Auto-fix rightmost splits when more than 3 are open ===

local function fix_rightmost_splits()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if #wins > 3 then
    -- Get window positions
    local win_positions = {}
    for _, win in ipairs(wins) do
      local pos = vim.api.nvim_win_get_position(win)
      table.insert(win_positions, {win = win, col = pos[2]})
    end
    table.sort(win_positions, function(a, b)
      return a.col < b.col
    end)

    -- Reset all windows first
    for _, w in ipairs(wins) do
      vim.api.nvim_win_set_option(w, "winfixwidth", false)
    end

    -- Desired fixed width (set this to your liking)
    local fixed_width = 141

    -- Fix the two rightmost splits
    for i = #win_positions - 1, #win_positions do
      local w = win_positions[i]
      if w then
        -- Set width and fix it
        vim.api.nvim_win_set_width(w.win, fixed_width)
        vim.api.nvim_win_set_option(w.win, "winfixwidth", true)
      end
    end
  else
    -- When 3 or fewer splits, unfix all
    for _, w in ipairs(wins) do
      vim.api.nvim_win_set_option(w, "winfixwidth", false)
    end
  end
end

-- Auto-run when windows change
vim.api.nvim_create_autocmd({"WinNew", "WinClosed", "VimResized"}, {
  callback = function()
    vim.defer_fn(fix_rightmost_splits, 100)
  end,
})
--
--
-- The line beneath this is called `modeline`. See `:help modeline
-- vim: ts=2 sts=2 sw=2 et
