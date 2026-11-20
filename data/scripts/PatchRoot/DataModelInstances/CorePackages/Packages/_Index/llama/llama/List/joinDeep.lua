-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local None = require(script.Parent.Parent.None)
local copyDeep = require(script.Parent.copyDeep)

local function joinDeep(...)
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
            if type(var1[j]) == "table" then
                if result[num1] == nil or type(result[num1] ~= "table") then
                    result[num1] = copyDeep(var1[j])
                else
                    result[num1] = joinDeep(result[num1], var1[j])
                end
            elseif var1[j] ~= None then
                result[num1] = var1[j]
            end

            num1 += 1
        end
    end

    return result
end

return joinDeep
