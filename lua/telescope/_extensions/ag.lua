local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")

local M = {}

---Execute picker search with `pattern`.
---@param pattern string pattern to search with configured cmd.
function M.ag(pattern)
	local opts = {
		entry_maker = function(entry)
			local entry_components = vim.split(entry, ":")
			local rel_filepath = entry_components[1]
			return {
				value = entry,
				display = function(display_entry)
					local display, hl_group = utils.transform_devicons(
						display_entry.path,
						utils.transform_path({}, display_entry.value),
						false
					)
					if hl_group then
						return display, { { { 1, 3 }, hl_group } }
					else
						return display
					end
				end,
				ordinal = rel_filepath,
				filename = rel_filepath,
				path = vim.loop.fs_realpath(rel_filepath),
				lnum = tonumber(entry_components[2]),
			}
		end,
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				vim.cmd(":e " .. "+" .. selection.lnum .. " " .. selection.path)
			end)
			return true
		end,
	}

	local cmd = require("telescope-ag")._get_opts().cmd
	table.insert(cmd, pattern)
	pickers
		.new(opts, {
			prompt_title = "Any Grep - " .. cmd[1],
			finder = finders.new_oneshot_job(cmd, opts),
			previewer = conf.grep_previewer(opts),
			sorter = conf.file_sorter(opts),
		})
		:find()
end

return require("telescope").register_extension({
	exports = {
		search = M.ag,
	},
})
