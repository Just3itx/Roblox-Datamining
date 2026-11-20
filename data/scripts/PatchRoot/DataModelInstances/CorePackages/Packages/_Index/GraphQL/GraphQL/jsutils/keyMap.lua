-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

local _ObjMap = require(script.Parent.ObjMap)

return {
    keyMap = function(arg1, func1: (...any) -> (...any))
        local result = {}
        for _, value in ipairs(arg1) do
            result[func1(value)] = value
        end
        return result
    end
}
