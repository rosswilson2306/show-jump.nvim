local M = {}

M.setup = function()
  --
end

local contains_only_char = function(str, char)
  return str:match("^" .. char .. "+$") ~= nil
end

local get_current_line_blame_commit = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local line = vim.api.nvim_win_get_cursor(0)[1]

  local git_dir = vim.fn.system("git rev-parse --show-toplevel")

  -- Send warning and return if not in a git repo
  if vim.v.shell_error ~= 0 then
    vim.notify("Not a git repository", vim.log.levels.WARN)
    return
  end

  local blame_cmd = string.format("git blame -L %d,%d --porcelain %s", line, line, filepath)
  local blame_output = vim.fn.systemlist(blame_cmd)

  if vim.v.shell_error ~= 0 or #blame_output == 0 then
    vim.notify("No blame information found", vim.log.levels.WARN)
    return
  end

  local commit_hash = blame_output[1]:match("^(%x+)")

  if contains_only_char(commit_hash, "0") then
    vim.notify("Current line not commited", vim.log.levels.WARN)
    return
  end

  return { commit_hash = commit_hash, filepath = filepath }
end

M.show_commit = function()
  local result = get_current_line_blame_commit()

  if result == nil then
    return
  end

  local commit_hash = result.commit_hash
  local filepath = result.filepath

  local show_cmd = string.format("git show %s", commit_hash)
  local show_output = vim.fn.systemlist(show_cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("Error fetching commit details", vim.log.levels.WARN)
    return
  end

  -- TODO handle boundary (initial commit) functionality

  local buffer = vim.api.nvim_create_buf(true, true)
  local bufname = string.format("blame-jump://%s", commit_hash)
  vim.bo[buffer].filetype = "git"
  vim.api.nvim_buf_set_name(buffer, bufname)
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, show_output)
  -- Set the buffer to be wiped (removed) when hidden
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buffer })
  vim.api.nvim_win_set_buf(0, buffer)
end

M.show_commit()

M._contains_only_char = contains_only_char

return M
