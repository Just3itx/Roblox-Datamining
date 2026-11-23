-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatError(arg1): string
    if typeof(arg1) ~= "table" or not arg1.errorMessage then
        return tostring(arg1)
    end

    local responseCode = arg1.responseCode
    return `HTTP {tostring(responseCode)}: {arg1.errorMessage}`
end

return formatError
