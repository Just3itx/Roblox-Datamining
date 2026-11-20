-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function join(...)
    local result = ({})

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)
        if var1 == nil then
            continue
        end

        for k, value in pairs(var1) do
            result[k] = value
        end
    end

    return result
end

return join
