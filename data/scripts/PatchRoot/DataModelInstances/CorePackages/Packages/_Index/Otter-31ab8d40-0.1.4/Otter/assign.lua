-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function assign(arg1, ...)
    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var1 = select(i, ...)

        for k, value in pairs(var1) do
            arg1[k] = value
        end
    end

    return arg1
end

return assign
