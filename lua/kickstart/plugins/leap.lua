-- https://github.com/ggandor/leap.nvim
return {
  'ggandor/leap.nvim',
  config = function()
    -- Apply default mappings first (optional if you want S/gs as well)
    require('leap').set_default_mappings()

    vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
      require('leap').leap {
        target_windows = { vim.api.nvim_get_current_win() },
      }
    end, { desc = 'Leap within current window' })
  end,
}
