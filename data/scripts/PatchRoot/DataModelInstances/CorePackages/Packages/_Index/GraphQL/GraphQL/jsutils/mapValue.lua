-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _ObjMap = require(script.Parent.ObjMap)

return {
    mapValue = function(arg1, func1: (...any) -> (...any))
        local result = ({})
        for k, value in pairs(arg1) do
            result[k] = func1(value, k)
        end
        return result
    end
}
