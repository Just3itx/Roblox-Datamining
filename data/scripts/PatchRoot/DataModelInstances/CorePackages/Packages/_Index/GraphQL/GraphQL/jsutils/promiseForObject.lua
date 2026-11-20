-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Promise = require(scriptParentParentParent.Promise)
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local _ObjMap = require(script.Parent.ObjMap)

return {
    promiseForObject = function(arg1)
        local var1 = Object.keys(arg1)
        local var2 = Array.map(var1, function(arg2)
            local var2 = arg1[arg2]
            if Promise.is(var2) then
                return var2
            end
            return Promise.resolve(var2)
        end)

        return Promise.all(var2):andThen(function(arg2)
            return Array.reduce(arg2, function(arg3, arg4, arg5)
                arg3[var1[arg5]] = arg4
                return arg3
            end, {})
        end)
    end
}
