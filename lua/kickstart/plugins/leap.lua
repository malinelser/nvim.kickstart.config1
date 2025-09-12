-- https://github.com/ggandor/leap.nvim

return {
  'ggandor/leap.nvim',
  config = function()
    require('leap').set_default_mappings()
  end,
}
