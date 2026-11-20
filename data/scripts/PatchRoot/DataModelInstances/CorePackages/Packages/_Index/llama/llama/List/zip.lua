-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function zip(...)
    local result = ({})
    local select2 = select
    local var1 = select2("#", ...)
    local select3 = select
    local num1 = #select3(1, ...)

    for i = 2, var1 do
        local select = select
        local num2 = #select(i, ...)

        if num2 < num1 then
            num1 = num2
        end
    end

    for i = 1, num1 do
        result[i] = {}

        for j = 1, var1 do
            local var2 = result[i]
            local select = select
            var2[j] = select(j, ...)[i]
        end
    end

    return result
end

return zip
