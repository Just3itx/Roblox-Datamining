-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createShallowEqualAndTables(tbl1)
    local tbl2 = ({})
    for _, value in tbl1 do
        tbl2[value] = true
    end

    return function(arg1, arg2)
        for value, value2 in arg1 do
            local var1 = arg2[value]

            if tbl2[value] then
                if typeof(value2) ~= "table" or typeof(var1) ~= "table" then
                    return false
                end

                for value3, value4 in value2 do
                    if value4 ~= var1[value3] then
                        return false
                    end
                end

                for value3, _ in var1 do
                    if value2[value3] == nil then
                        return false
                    end
                end
            elseif value2 ~= var1 then
                return false
            end
        end

        for value, _ in arg2 do
            if arg1[value] == nil then
                return false
            end
        end

        return true
    end
end

return createShallowEqualAndTables
