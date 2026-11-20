-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function equalObjects(...)
    local select2 = select

    for i = 1, select2("#", ...) - 1 do
        local select3 = select
        local var1 = select3(i, ...)
        local num1 = i + 1
        local select = select

        if var1 ~= select(num1, ...) then
            return false
        end
    end

    return true
end

return equalObjects
