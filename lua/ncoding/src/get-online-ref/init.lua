local M = {}

local function get_cmd_output(cmd)
  local handle = io.popen(cmd)
  if not handle then
    return nil
  end
  local result = handle:read '*a'
  handle:close()
  return vim.trim(result)
end

local function get_git_info()
  local repo_root = get_cmd_output 'git rev-parse --show-toplevel'
  if not repo_root or repo_root == '' then
    vim.notify('Not inside a git repository', vim.log.levels.ERROR)
    return
  end

  local remote_url = get_cmd_output 'git remote get-url origin'
  if not remote_url or remote_url == '' then
    vim.notify('No remote origin found', vim.log.levels.ERROR)
    return
  end

  local branch = get_cmd_output 'git rev-parse --abbrev-ref HEAD'
  local commit = get_cmd_output 'git rev-parse HEAD'
  local file = vim.fn.expand '%:p'
  local relative_path = file:sub(#repo_root + 2)
  local line = vim.fn.line '.'

  return {
    remote_url = remote_url,
    branch = branch,
    commit = commit,
    relative_path = relative_path,
    line = line,
  }
end

local function ssh_to_https(url)
  -- Convert SSH to HTTPS for GitHub-like URLs
  url = url:gsub('%.git$', '')
  url = url:gsub('git@github.com:', 'https://github.com/')
  return url
end

function M.copy_github_ref()
  local info = get_git_info()
  if not info then
    return
  end

  local remote = ssh_to_https(info.remote_url)
  local url = string.format('%s/blob/%s/%s#L%d', remote, info.branch, info.relative_path, info.line)

  vim.fn.setreg('+', url)
  vim.notify('Copied GitHub URL: ' .. url, vim.log.levels.INFO)
end

function M.chrome_code_search()
  local info = get_git_info()
  if not info then
    return
  end

  local url = string.format(
    'https://source.chromium.org/chromium/chromium//src/+/%s:third_party/devtools-frontend/src/%s;l=%d',
    info.branch,
    info.relative_path,
    info.line
  )

  vim.fn.setreg('+', url)
  vim.notify('Copied Source URL: ' .. url, vim.log.levels.INFO)
end

function M.setup()
  vim.api.nvim_create_user_command('CopyGithubRef', M.copy_github_ref, {})
  vim.api.nvim_create_user_command('CopySourceRef', M.chrome_code_search, {})
end

return M
