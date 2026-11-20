-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function union(...)
    local result = ({})

    local select2 = select

    for i = 1, select2("#", ...) do
        for k, _ in pairs(select(i, ...)) do
            result[k] = true
        end
    end

    return result
end

return union
