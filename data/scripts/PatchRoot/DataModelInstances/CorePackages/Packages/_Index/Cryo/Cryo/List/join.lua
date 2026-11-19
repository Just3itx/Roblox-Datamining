-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:42Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local None = require(script.Parent.Parent.None)

local function join(...)
    local result = {}

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)
        local resultLen = #result

        for j = 1, #var1 do
            if var1[j] == None then
                resultLen -= 1
            else
                result[resultLen + j] = var1[j]
            end
        end
    end

    return result
end

return join
