-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local None = require(script.Parent.Parent.None)

local function join(...)
    local result = ({})

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)

        if not var1 then
            continue
        end

        for k, value in pairs(var1) do
            if value == None then
                result[k] = nil
            else
                result[k] = value
            end
        end
    end

    return result
end

return join
