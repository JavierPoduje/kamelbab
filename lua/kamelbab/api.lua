local M = {}

---Given a string in camelCase, returns the string in kebab-case.
---@param str string
---@return string
M.camel_to_kebab = function(str)
	-- Replace all occurrences of an uppercase letter followed by a lowercase letter or digit
	-- with a hyphen followed by the lowercase version of the uppercase letter.
	local kebab = str:gsub("(%u)(%l)", function(upper, lower)
		return "-" .. upper:lower() .. lower
	end)

	-- Replace all occurrences of a digit followed by an uppercase letter
	-- with the digit followed by a hyphen and the lowercase version of the uppercase letter.
	kebab = kebab:gsub("(%d)(%u)", function(digit, upper)
		return digit .. "-" .. upper:lower()
	end)

	-- Replace any remaining uppercase letters with a hyphen followed by the lowercase version of the letter
	kebab = kebab:gsub("(%u)", function(upper)
		return "-" .. upper:lower()
	end)

	-- Remove any leading hyphen if present
	kebab = kebab:gsub("^-", "")

	return kebab
end

---Given a string in kebab-case, returns the string in camelCase.
---@param str string
---@return string
M.kebab_to_camel = function(str)
	-- Convert kebab case to camel case
	local camel = str:gsub("(%-)(%l)", function(_, letter)
		return letter:upper()
	end)
	return camel
end

---Given a string, returns true if it is in kebab case, false otherwise.
---@param str string
---@return boolean
M.is_kebab_case = function(str)
	return str:match("^[a-z]+%-?[a-z]*$") ~= nil and str:match("%-%-") == nil
end

---Given a string, returns true if it is in camel case, false otherwise.
---@param str string
---@return boolean
M.is_camel_case = function(str)
	return str:match("^[a-z]+[A-Z]") ~= nil
end

return M
