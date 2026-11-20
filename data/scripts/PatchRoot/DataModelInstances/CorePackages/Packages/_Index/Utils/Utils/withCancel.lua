-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Boolean = require((nil).LuauPolyfill).Boolean

local Promise = require((nil).Promise)
local tbl1 = {}
local _expect = require((nil).Dev.JestGlobals).expect

local function defaultAsyncIteratorReturn(value)
    return Promise.resolve():andThen(function()
        return { value = value, done = true }
    end)
end

local var1 = require(script.Parent["memoize.js"]).memoize2(function(arg1, arg2)
    return function(...)
        return Reflect:apply(arg2, arg1, { ... })
    end
end)

local function getAsyncIteratorWithCancel(arg1, func1: (...any) -> (...any))
    return Proxy.new(arg1, {
        has = function(_, arg2, arg3)
            if arg3 == "return" then
                return true
            end
            return Reflect:has(arg2, arg3)
        end,
        get = function(_, arg2, arg3, arg4)
            local var2 = Reflect:get(arg2, arg3, arg4)
            if arg3 == "return" then
                local var3 = Boolean.toJSBoolean(var2) and var2 or defaultAsyncIteratorReturn
                return function(arg5)
                    return Promise.resolve():andThen(function()
                        local var4 = func1(arg5):expect()
                        return Reflect:apply(var3, arg2, { var4 })
                    end)
                end
            elseif typeof(var2) == "function" then
                return var1(arg2, var2)
            else
                return var2
            end
        end
    })
end

tbl1.getAsyncIteratorWithCancel = getAsyncIteratorWithCancel

local function getAsyncIterableWithCancel(arg1, func1: (...any) -> (...any))
    return Proxy.new(arg1, {
        get = function(_, arg2, asyncIterator, arg3)
            local var2 = Reflect:get(arg2, asyncIterator, arg3)
            if Symbol.asyncIterator == asyncIterator then
                return function()
                    local var3 = Reflect:apply(var2, arg2, {})
                    return getAsyncIteratorWithCancel(var3, func1)
                end
            elseif typeof(var2) == "function" then
                return var1(arg2, var2)
            end
            return var2
        end
    })
end
tbl1.getAsyncIterableWithCancel = getAsyncIterableWithCancel
tbl1.withCancel = getAsyncIterableWithCancel
return tbl1
