-- https://github.com/ggandor/leap.nvim
return {
  'ggandor/leap.nvim',
  config = function()
    -- Apply default mappings first (optional if you want S/gs as well)
    require('leap').set_default_mappings()

    -- Override `s` in normal/visual/operator-pending modes
    vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
      require('leap').leap {
        target_windows = vim.tbl_filter(function(win)
          return vim.api.nvim_win_get_config(win).relative == ''
        end, vim.api.nvim_tabpage_list_wins(0)),
      }
    end, { desc = 'Leap across windows with s' })
  end,
}
