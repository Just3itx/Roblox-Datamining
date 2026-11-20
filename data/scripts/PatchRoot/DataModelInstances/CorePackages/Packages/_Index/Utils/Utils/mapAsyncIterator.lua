-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Boolean = require(scriptParentParent.LuauPolyfill).Boolean

local Promise = require(scriptParentParent.Promise)

local asyncMapValue = nil
local iteratorResult = nil

local module = {}

function module.mapAsyncIterator(tbl1, func1: (...any) -> (...any), arg1)
    local var1 = nil
    local var2 = nil
    if typeof(tbl1["return"]) == "function" then
        var1 = tbl1["return"]
        var2 = function(arg2)
            local function rethrow()
                return Promise.reject(arg2)
            end
            return var1(tbl1):andThen(rethrow, rethrow)
        end
    end

    local function mapResult(arg2)
        if Boolean.toJSBoolean(arg2.done) then
            return arg2
        end

        return (asyncMapValue(arg2.value, func1):andThen(iteratorResult, var2))
    end

    local var3 = nil

    var3 = arg1 and function(arg2)
        return asyncMapValue(arg2, arg1):andThen(iteratorResult, var2)
    end or var3

    return {
        next = function(_)
            return tbl1:next():andThen(mapResult, var3)
        end,
        ["return"] = function(_)
            if Boolean.toJSBoolean(var1) then
                return (var1(tbl1):andThen(mapResult, var3))
            end
            return (Promise.resolve({ value = nil, done = true }))
        end,
        throw = function(_, arg2)
            if typeof(tbl1.throw) == "function" then
                return tbl1.throw(tbl1, arg2):andThen(mapResult, var3)
            end

            return Promise.reject(arg2):catch(var2)
        end
    }
end

asyncMapValue = function(arg1, func1: (...any) -> (...any))
    return Promise.new(function(arg2)
        return arg2(func1(arg1))
    end)
end

iteratorResult = function(value)
    return { value = value, done = false }
end
return module
