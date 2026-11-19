-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:50:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local Promise = require(scriptParentParentParentParent.Promise)

local module = {}

local Observable = require(script.Parent.Observable).Observable

function module.asyncMap(arg1, func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
    return Observable.new(function(arg2)
        local var1 = nil

        local next = arg2.next
        local error2 = arg2.error
        local complete = arg2.complete
        local num1 = 0
        local bool1 = false

        local tbl1 = {
            andThen = function(_, func3: (...any) -> (...any))
                return Promise.new(function(arg3)
                    return arg3(func3())
                end)
            end
        }

        local function makeCallback(arg3, callback) -- Luacid: Inlined by compiler; 2 call sites recovered
            return if Boolean.toJSBoolean(arg3) then function(_, arg4)
                num1 += 1
                local function both()
                    return arg3(arg4)
                end
                tbl1 = tbl1:andThen(function()
                    return Promise.delay(0)
                end):andThen(both, both):andThen(function(arg5)
                    num1 -= 1
                    if Boolean.toJSBoolean(next) then
                        next(arg2, arg5)
                    end
                    if Boolean.toJSBoolean(bool1) then
                        var1.complete()
                    end
                end, function(arg5)
                    num1 -= 1
                    error(arg5)
                end):catch(function(arg5)
                    if Boolean.toJSBoolean(error2) then
                        return error2(arg2, arg5)
                    end
                end)
            end else function(_, arg4)
                if Boolean.toJSBoolean(callback) then
                    callback(arg2, arg4)
                end
            end
        end

        var1 = {
            next = makeCallback(func1, next),
            error = makeCallback(func2, error2),
            complete = function()
                bool1 = true
                if not Boolean.toJSBoolean(num1) and Boolean.toJSBoolean(complete) then
                    complete(arg2)
                end
            end
        }

        local var2 = arg1:subscribe(var1)
        return function()
            return var2:unsubscribe()
        end
    end)
end

return module
