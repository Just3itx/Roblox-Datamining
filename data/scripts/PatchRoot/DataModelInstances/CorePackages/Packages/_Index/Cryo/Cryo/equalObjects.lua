-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function equalObjects(...)
    local select2 = select
    local var1 = select2(1, ...)

    local select3 = select

    for i = 2, select3("#", ...) do
        local select = select

        if var1 ~= select(i, ...) then
            return false
        end
    end

    return true
end

return equalObjects
