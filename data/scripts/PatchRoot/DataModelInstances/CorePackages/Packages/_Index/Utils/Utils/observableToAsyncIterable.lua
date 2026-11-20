-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Boolean = require((nil).LuauPolyfill).Boolean

local module = {}

function module.observableToAsyncIterable(tbl1)
    local tbl2 = {}
    local tbl3 = {}
    local bool1 = true
    local function pushValue(value)
        if tbl2.length ~= 0 then
            table.remove(tbl2, 1)({ value = value, done = false })
            return
        end

        table.insert(tbl3, { value = value, done = false })
    end

    local function pushError(arg1)
        if tbl2.length ~= 0 then
            table.remove(tbl2, 1)({ value = { errors = { arg1 } }, done = false })
            return
        end

        table.insert(tbl3, { value = { errors = { arg1 } }, done = false })
    end

    local function pushDone()
        if tbl2.length ~= 0 then
            table.remove(tbl2, 1)({ done = true })
            return
        end
        table.insert(tbl3, { done = true })
    end

    local function pullValue() -- Luacid: Inlined by compiler; 1 call site recovered
        return Promise.new(function(callback)
            if tbl3.length ~= 0 then
                callback(table.remove(tbl3, 1))
                return
            end
            table.insert(tbl2, callback)
        end)
    end

    local var1 = tbl1:subscribe({
        next = function(_, arg1)
            pushValue(arg1)
        end,
        error = function(_, arg1)
            pushError(arg1)
        end,
        complete = function(_)
            pushDone()
        end
    })
    local function emptyQueue()
        if not Boolean.toJSBoolean(bool1) then
            return
        end

        bool1 = false
        var1:unsubscribe()
        for _, value in tbl2 do
            value({ value = nil, done = true })
        end
        tbl2.length = 0
        tbl3.length = 0
    end

    local module2 = {
        next = function(arg1)
            if Boolean.toJSBoolean(bool1) then
                return (pullValue())
            end

            return (arg1["return"]())
        end,
        ["return"] = function(_)
            emptyQueue()
            return Promise.resolve({ value = nil, done = true })
        end,
        throw = function(_, arg1)
            emptyQueue()
            return Promise.reject(arg1)
        end
    }

    local asyncIterator = Symbol.asyncIterator

    module2[tostring(asyncIterator)] = function<T>(arg1: T): T
        return arg1
    end

    return module2
end

return module
