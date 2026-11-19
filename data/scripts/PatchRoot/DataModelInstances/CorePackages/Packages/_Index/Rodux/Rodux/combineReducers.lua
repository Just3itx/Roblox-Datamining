-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:01:28Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function combineReducers(arg1)
    return function(arg2, arg3)
        arg2 = arg2 == nil and {} or arg2

        local result = ({})

        for k, value in pairs(arg1) do
            result[k] = value(arg2[k], arg3)
        end

        return result
    end
end

return combineReducers
