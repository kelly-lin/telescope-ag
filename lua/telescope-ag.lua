local M = {}

---Built-in commands.
M.cmds = {
  grep = { "grep", "-rn" },
	ag = { "ag" },
	rg = { "rg", "-n" },
}

local _opts = { cmd = M.cmds.ag }

---Configure telescope-ag.
---@param opts table optional table with the keys:
---{
---  cmd = `table` - command to run, defaults to `telescope_ag.cmds.ag`
---}
function M.setup(opts)
	if opts then
		_opts = vim.tbl_deep_extend("force", _opts, opts)
	end
end

---@private
---Returns options set by user.
function M._get_opts()
	return vim.fn.deepcopy(_opts)
end

return M
