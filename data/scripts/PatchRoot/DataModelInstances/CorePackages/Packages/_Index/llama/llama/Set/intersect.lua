-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function intersect(...)
    local result = ({})
    local select2 = select
    local var1 = select2("#", ...)
    local select3 = select
    local var2 = select3(1, ...)

    for k, _ in pairs(var2) do
        local bool1 = true

        for i = 2, var1 do
            local select = select

            if select(i, ...)[k] == nil then
                bool1 = false
                break
            end
        end

        if bool1 then
            result[k] = true
        end
    end

    return result
end

return intersect
