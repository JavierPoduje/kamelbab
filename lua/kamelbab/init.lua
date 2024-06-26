local api = require("kamelbab.api")

local M = {
	toggle_key = "K",
}

---Get the selected string in visual mode
---@return string
M.get_visual_selection = function()
	-- Get the current visual selection
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local lines = vim.fn.getline(s_start[2], s_end[2])

	-- Convert the selection to a single string if it's multiline
	if #lines > 1 then
		for i = 2, #lines do
			lines[1] = lines[1] .. "\n" .. lines[i]
		end
	end

	return lines[1]:sub(s_start[3], s_end[3])
end

M.execute = function()
	local selectedString = M.get_visual_selection()

	if api.is_camel_case(selectedString) then
		vim.fn.setreg("v", api.camel_to_kebab(selectedString))
		vim.cmd('normal! gv"vp')
	elseif api.is_kebab_case(selectedString) then
		vim.fn.setreg("v", api.kebab_to_camel(selectedString))
		vim.cmd('normal! gv"vp')
	else
		print("Selected string is not camelCase or kebab-case...")
	end
end

M.setup = function(config)
	local key = config.toggle_key or M.toggle_key
	vim.api.nvim_create_user_command(key, M.execute, { range = true })
end

return M
