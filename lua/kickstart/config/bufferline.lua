local status_ok, plugin = pcall(require, 'bufferline')
if not status_ok then
  print 'No bufferline found when configuring..'
  return
end

local function right_align_name(buf)
  local name = vim.fn.fnamemodify(buf.name, ":t")
  local max_len = 25 -- if update, also update  "max_name_length"!

  if #name > max_len then
    local ext = name:match("%.[^%.]+$") or ""  -- extension (e.g. ".lua")
    local base = name:gsub("%.[^%.]+$", "")    -- strip extension
    local keep = max_len - #ext - 1            -- -1 for "…"
    if keep < 1 then keep = 1 end
    name = "…" .. string.sub(base, -keep) .. ext
  end

  return name
end

local setup = {
  highlights = {
    buffer_selected = {
      bold = true,
      italic = true,
    },
  },
  options = {
    name_formatter = right_align_name,
    pick = {
      alphabet = 'abcdefghijklmopqrstuvwxyz',
    },
    indicator = {
      style = 'underline',
    },
    numbers = 'ordinal',
    modified_icon = '●',
    max_name_length = 25, -- if update, also update "local max_len"!
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    diagnostics = 'false',
    tab_size = 18,
    show_buffer_icons = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = 'slant',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'insert_at_end',
  },
}

plugin.setup(setup)
-- Lua function to jump to buffer by ordinal number
local function jump_to_buffer_by_ordinal(ordinal)
  require('bufferline').go_to_buffer(tonumber(ordinal), true)
end

-- Register the Lua function as a Vim command
vim.api.nvim_create_user_command('JumpBufferByOrdinal', function(opts)
  jump_to_buffer_by_ordinal(opts.args)
end, { nargs = 1 })
