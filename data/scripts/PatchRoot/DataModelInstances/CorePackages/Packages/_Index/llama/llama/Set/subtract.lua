-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function subtract(arg1, ...)
    local result = ({})

    for k, _ in pairs(arg1) do
        result[k] = true
    end

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        result[select(i, ...)] = nil
    end

    return result
end

return subtract
