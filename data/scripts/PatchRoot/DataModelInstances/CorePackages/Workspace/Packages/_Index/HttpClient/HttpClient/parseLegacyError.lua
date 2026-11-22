-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function parseLegacyError(arg1)
    if typeof(arg1) ~= "table" or typeof(arg1.errors) ~= "table" then
        return nil
    end
    local errors = {}
    for _, error in arg1.errors do
        if typeof(error) ~= "table" or typeof(error.code) ~= "number" or typeof(error.message) ~= "string" then
            continue
        end

        table.insert(
            errors,
            {
                code = error.code,
                message = error.message,
                userFacingMessage = error.userFacingMessage,
                field = error.field
            }
        )
    end
    return if #errors == 0 then nil else { errors = errors }
end

return parseLegacyError
