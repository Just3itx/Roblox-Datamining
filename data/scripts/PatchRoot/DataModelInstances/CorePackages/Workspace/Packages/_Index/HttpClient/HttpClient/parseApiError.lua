-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function parseApiError(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end
    local code = arg1.code
    local message = arg1.message
    return if typeof(code) == "number" and typeof(message) == "string" then {
        code = code,
        message = message,
        details = arg1.details
    } else nil
end

return parseApiError
