local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local utils = require("telescope.utils")

local M = {}

function M.rg(text_to_find)
	local default_opts = {
		entry_maker = function(entry)
			local split = vim.split(entry, ":")
			local rel_filepath = split[1]
			local abs_filepath = vim.fn.getcwd() .. "/" .. rel_filepath
			local line_num = tonumber(split[2])
			return {
				value = entry,
				display = function(display_entry)
					local hl_group
					local display = utils.transform_path({}, display_entry.value)

					display, hl_group = utils.transform_devicons(display_entry.path, display, false)

					if hl_group then
						return display, { { { 1, 3 }, hl_group } }
					else
						return display
					end
				end,
				ordinal = rel_filepath,
				path = abs_filepath,
				lnum = line_num,
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
	local opts = default_opts

	local args = { "rg", text_to_find }
	pickers.new(opts, {
		prompt_title = "RIPGREP",
		finder = finders.new_oneshot_job(args, opts),
		previewer = conf.grep_previewer(opts),
		sorter = conf.file_sorter(opts),
	}):find()
end

return require("telescope").register_extension({
	exports = {
		search = M.rg,
	},
})
