-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local getExpectedPartSize = require(scriptParentParent.util.getExpectedPartSize)

return function(tbl1, func1: (...any) -> (...any), arg1)
    local result = ({})
    for _, value in tbl1 do
        local var1 = func1(value)
        result[value] = getExpectedPartSize(var1, arg1) / getExpectedPartSize(var1, arg1, true)
    end

    return result
end
