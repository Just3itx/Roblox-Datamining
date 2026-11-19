-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

return function(arg1)
    if arg1 == nil then
        error("cannot extract values from a nil value")
    end
    local str1 = typeof(arg1)

    local var1 = nil
    if str1 == "table" then
        local result = {}
        for _, value in pairs(arg1) do
            table.insert(result, value)
        end

        return result
    end
    if str1 == "string" then
        local var2 = arg1:len()
        var1 = table.create(var2)
        for i = 1, var2 do
            var1[i] = arg1:sub(i, i)
        end
    end

    return var1
end
