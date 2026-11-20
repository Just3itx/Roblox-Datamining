-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local None = require(script.Parent.Parent.None)

local function join(...)
    local result = ({})

    local num1 = 1

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)

        if not var1 then
            continue
        end

        for j = 1, #var1 do
            if var1[j] ~= None then
                result[num1] = var1[j]
                num1 += 1
            end
        end
    end

    return result
end

return join
