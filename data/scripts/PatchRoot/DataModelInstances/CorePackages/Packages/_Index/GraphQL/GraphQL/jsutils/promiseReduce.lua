-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local _PromiseOrValue = require(scriptParent.PromiseOrValue)

local isPromise = require(scriptParent.isPromise).isPromise

return {
    promiseReduce = function(arg1, func1: (...any) -> (...any), arg2)
        return Array.reduce(arg1, function(arg3, arg4)
            if isPromise(arg3) then
                return arg3:andThen(function(arg5)
                    return func1(arg5, arg4)
                end)
            end
            return func1(arg3, arg4)
        end, arg2)
    end
}
