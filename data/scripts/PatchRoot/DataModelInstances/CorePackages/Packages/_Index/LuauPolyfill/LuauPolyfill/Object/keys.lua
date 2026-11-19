-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:51:19Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Set = require(scriptParentParent.Set)
local instanceof = require(scriptParentParent.instanceof)
local _types = require(scriptParentParent.types)

return function(arg1)
    if arg1 == nil then
        error("cannot extract keys from a nil value")
    end

    local str1 = typeof(arg1)

    local var1 = nil
    if str1 ~= "table" then
        if str1 == "string" then
            local var2 = arg1:len()
            var1 = table.create(var2)
            for i = 1, var2 do
                var1[i] = tostring(i)
            end
        end

        return var1
    end

    local result = {}
    if instanceof(arg1, Set) then
        return result
    end

    for k in pairs(arg1) do
        table.insert(result, k)
    end

    return result
end
