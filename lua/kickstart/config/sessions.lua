local M = {}

function M.get_mappings()
  local folder = vim.fn.expand("~/.config/nvim/sessions")
  local files = vim.fn.glob(folder .. "/*", false, true)
  local mappings = {}

  for i, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t")
    mappings[tostring(i)] = {
      callback = function()
        vim.cmd("source " .. file)
      end,
      desc = name,
    }
  end

  return mappings
end

return M
