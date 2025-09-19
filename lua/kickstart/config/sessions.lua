local M = {}

function M.get_mappings()
  local folder = vim.fn.expand("~/.config/nvim/sessions")
  local files = vim.fn.glob(folder .. "/*", false, true)
  local entries = {}

  -- collect files with mtime
  for _, file in ipairs(files) do
    local stat = vim.loop.fs_stat(file)
    table.insert(entries, {
      path = file,
      name = vim.fn.fnamemodify(file, ":t"),
      mtime = stat and stat.mtime.sec or 0,
    })
  end

  -- sort by mtime desc, then name desc
  table.sort(entries, function(a, b)
    if a.mtime == b.mtime then
      return a.name > b.name -- descending alphabetical
    end
    return a.mtime > b.mtime
  end)

  -- build mappings
  local mappings = {}
  for i, entry in ipairs(entries) do
    mappings[tostring(i)] = {
      callback = function()
        vim.cmd("source " .. entry.path)
      end,
      desc = entry.name,
    }
  end

  return mappings
end

return M
