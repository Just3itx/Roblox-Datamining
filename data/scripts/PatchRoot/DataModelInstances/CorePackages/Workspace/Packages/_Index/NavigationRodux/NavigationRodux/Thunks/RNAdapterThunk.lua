-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRoduxParent = script:FindFirstAncestor("NavigationRodux").Parent

local ArgCheck = require(NavigationRoduxParent.ArgCheck)

local module = {}
local var1 = require(NavigationRoduxParent.AppCommonLib).Symbol.named("RNAdapterThunkTag")

function module.middleware(arg1)
    ArgCheck.isType(arg1, "function", "rnDispatcher")

    return function(arg2, arg3)
        return function(arg4)
            if typeof(arg4) == "table" and arg4[var1] == true then
                return arg4(arg3, arg1)
            end
            return arg2(arg4)
        end
    end
end

function module.new(type, callback)
    ArgCheck.isNonEmptyString(type, "name")
    ArgCheck.isType(callback, "function", "onInvoke")

    return (setmetatable({
        [var1] = true,
        type = type
    }, {
        __call = function(_, ...)
            callback(...)
        end
    }))
end

function module.test(arg1, arg2, arg3)
    ArgCheck.assert(type(arg1) == "table" and arg1[var1] == true, "'thunk' must be a valid RNAdapterThunk")

    return arg1(arg2, arg3)
end

function module.is(arg1): boolean
    return type(arg1) == "table" and arg1[var1] == true
end

return module
