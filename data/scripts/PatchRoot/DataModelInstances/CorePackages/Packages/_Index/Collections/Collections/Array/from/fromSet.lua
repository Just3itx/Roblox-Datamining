-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParentParent.ES7Types)

return function(arg1, func1: ((...any) -> (...any))?, arg2)
    if not func1 then
        return (table.clone(arg1._array))
    end

    local result = ({})
    for value, value2 in arg1 do
        if arg2 ~= nil then
            result[value] = func1(arg2, value2, value)
        else
            result[value] = func1(value2, value)
        end
    end

    return result
end
