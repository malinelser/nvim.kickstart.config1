-- https://github.com/ggandor/leap.nvim
return {
  'nvim-pack/nvim-spectre',
  config = function()
    -- Apply default mappings first (optional if you want S/gs as well)
    require('spectre').setup {
      mapping = {
        ['tab'] = {
          map = '<Tab>',
          cmd = "<cmd>lua require('spectre').tab()<cr>",
          desc = 'next query',
        },
        ['shift-tab'] = {
          map = '<S-Tab>',
          cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
          desc = 'previous query',
        },
        ['toggle_line'] = {
          map = '<leader>rd',
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = 'toggle item',
        },
        ['enter_file'] = {
          map = '<cr>',
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = 'open file',
        },
        ['send_to_qf'] = {
          map = '<M>q',
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = 'send all items to quickfix',
        },
        ['replace_cmd'] = {
          map = '<leader>rrc',
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = 'input replace command',
        },
        ['show_option_menu'] = {
          map = '<leader>ro',
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = 'show options',
        },
        ['run_current_replace'] = {
          map = '<leader>rc',
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = 'replace current line',
        },
        ['run_replace'] = {
          map = '<leader>ra',
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = 'replace all',
        },
        ['change_view_mode'] = {
          map = '<leader>rv',
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = 'change result view mode',
        },
        ['change_replace_sed'] = {
          map = '<leader>rtrs',
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = 'use sed to replace',
        },
        ['change_replace_oxi'] = {
          map = '<leader>rtro',
          cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
          desc = 'use oxi to replace',
        },
        ['toggle_live_update'] = {
          map = '<leader>rtu',
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = 'update when vim writes to file',
        },
        ['toggle_ignore_case'] = {
          map = '<leader>rti',
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = 'toggle ignore case',
        },
        ['toggle_ignore_hidden'] = {
          map = '<leader>rth',
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = 'toggle search hidden',
        },
        ['resume_last_search'] = {
          map = '<leader>rl',
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = 'repeat last search',
        },
        ['select_template'] = {
          map = '<leader>rp',
          cmd = "<cmd>lua require('spectre.actions').select_template()<CR>",
          desc = 'pick template',
        },
        ['delete_line'] = {
          map = '<leader>rD0',
          cmd = "<cmd>lua require('spectre.actions').run_delete_line()<CR>",
          desc = 'delete whole line from file',
        },
        -- you can put your mapping here it only use normal mode
      },
      default = {
        find = {
          --pick one of item in find_engine
          cmd = 'rg',
          options = {},
        },
        replace = {
          --pick one of item in replace_engine
          cmd = 'sed',
        },
      },
    }
  end,
}
