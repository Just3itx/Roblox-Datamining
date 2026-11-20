-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Promise = require(scriptParentParent.Promise)
local instanceof = LuauPolyfill.instanceof
local Boolean = LuauPolyfill.Boolean
local Error = LuauPolyfill.Error
local setTimeout = LuauPolyfill.setTimeout
local Array = LuauPolyfill.Array
local Symbol = LuauPolyfill.Symbol

local var1 = nil
local var2 = nil
local notifySubscription = nil

local function isCallable(arg1) -- Luacid: Inlined by compiler; 10 call sites recovered
    if typeof(arg1) == "function" then
        return true
    end
    if typeof(arg1) == "table" then
        local var3 = getmetatable(arg1)
        if var3 and rawget(var3, "__call") then
            return true
        end
        if arg1._isMockFunction then
            return true
        end
    end
    return false
end

local function hasSymbols(): boolean -- Luacid: Inlined by compiler; 8 call sites recovered
    return typeof(Symbol) == "table" and typeof(getmetatable(Symbol).__call) == "function"
end

local function hasSymbol(str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    return hasSymbols() and Boolean.toJSBoolean(Symbol[str1])
end

local function getSymbol(str1: string) -- Luacid: unused: defined but never referenced
    return if hasSymbol(str1) then Symbol[str1] else "@@" .. str1
end

if hasSymbols() and not hasSymbol("observable") then
    Symbol.observable = Symbol("observable")
end

if hasSymbol("iterator") then
    local _iterator = Symbol.iterator
end

local symbol = if hasSymbol("observable") then Symbol.observable else "@@observable"
local var4 = if hasSymbol("species") then Symbol.species else "@@species"

local function getMethod(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var5 = arg1[arg2]
    if var5 == nil then
        return nil
    end

    if not isCallable(var5) then
        error(Error.new(tostring(var5) .. " is not a function"))
    end

    return var5
end

local function getSpecies(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    local var5 = arg1[var4]
    return if var5 == nil then var1 else var5
end

local function isObservable(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return instanceof(arg1, var1)
end

local var5 = nil
var5 = setmetatable({}, {
    __call = function(_, arg1)
        if var5.log then
            var5:log(arg1)
            return
        end
        setTimeout(function()
            error(arg1)
        end, 0)
    end
})

local function enqueue(callback) -- Luacid: Inlined by compiler; 3 call sites recovered
    Promise.delay(0):doneCall(function()
        xpcall(callback, function(arg1)
            var5(arg1)
        end)
    end)
end

local function cleanupSubscription(tbl1)
    local _cleanup = tbl1._cleanup
    if _cleanup == nil then
        return
    end

    tbl1._cleanup = nil

    if not _cleanup then
        return
    end

    local success = true
    local result = nil

    if isCallable(_cleanup) then
        success, result = pcall(_cleanup)
    else
        local method = getMethod(_cleanup, "unsubscribe")

        if method then
            success, result = pcall(method, _cleanup)
        end
    end
    if not success then
        var5(result)
    end
end

local function closeSubscription(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    tbl1._observer = nil
    tbl1._queue = nil
    tbl1._state = "closed"
end

local function flushSubscription(_subscription)
    local _queue = _subscription._queue
    if not Boolean.toJSBoolean(_queue) then
        return
    end

    _subscription._queue = nil
    _subscription._state = "ready"

    for i = 1, #_queue do
        notifySubscription(_subscription, _queue[i].type, _queue[i].value)
        if _subscription._state == "closed" then
            break
        end
    end
end

notifySubscription = function(tbl1, arg1, arg2)
    tbl1._state = "running"
    local _observer = tbl1._observer

    local result = nil
    local success, result2 = pcall(getMethod, _observer, arg1)
    if not success then
        var5(result2)
        return
    end
    if arg1 == "next" then
        if result2 then
            success, result = pcall(result2, _observer, arg2)
        end
    elseif arg1 == "error" then
        closeSubscription(tbl1)

        if result2 then
            success, result = pcall(result2, _observer, arg2)
        else
            var5(arg2)
        end
    elseif arg1 == "complete" then
        closeSubscription(tbl1)

        if result2 then
            success, result = pcall(result2, _observer, arg2)
        end
    end
    if not success then
        var5(result)
    end

    if tbl1._state == "closed" then
        cleanupSubscription(tbl1)
    elseif tbl1._state == "running" then
        tbl1._state = "ready"
    end
end

local function onNotify(_subscription, type: string, value)
    if _subscription._state == "closed" then
        return
    elseif _subscription._state == "buffering" then
        assert(_subscription._queue, "observable subscription queue nil during onNotify")
        table.insert(_subscription._queue, { type = type, value = value })
        return
    elseif _subscription._state == "ready" then
        notifySubscription(_subscription, type, value)
        return
    end

    _subscription._state = "buffering"

    _subscription._queue = {{ type = type, value = value }}
    enqueue(function()
        return flushSubscription(_subscription)
    end)
end

local tbl1 = {}

function tbl1.__index(arg1, arg2)
    if arg2 == "closed" then
        return arg1._state == "closed"
    elseif rawget(arg1, arg2) then
        return rawget(arg1, arg2)
    elseif rawget(tbl1, arg2) then
        return rawget(tbl1, arg2)
    end
    return nil
end

function tbl1.__newindex(arg1, arg2, arg3)
    if arg2 == "closed" then
        error("setting getter-only property 'closed'")
    end
    rawset(arg1, arg2, arg3)
end

function tbl1.new(_observer, callback: (...any) -> (...any))
    local var6 = (setmetatable({}, tbl1))

    var6._cleanup = nil
    var6._observer = _observer
    var6._queue = nil
    var6._state = "initializing"

    local var7 = var2.new(var6)

    local success, result = pcall(callback, var7)

    if success then
        var6._cleanup = result
    else
        var7:error(result)
    end

    if var6._state == "initializing" then
        var6._state = "ready"
    end

    return var6
end

function tbl1.unsubscribe(arg1)
    if arg1._state ~= "closed" then
        closeSubscription(arg1)
        cleanupSubscription(arg1)
    end
end

var2 = {}
function var2.__index(arg1, arg2)
    if arg2 == "closed" then
        return arg1._subscription._state == "closed"
    elseif rawget(var2, arg2) then
        return rawget(var2, arg2)
    end
    return rawget(arg1, arg2)
end

function var2.__newindex(arg1, arg2, arg3)
    if arg2 == "closed" then
        error("setting getter-only property 'closed'")
    end
    rawset(arg1, arg2, arg3)
end

function var2.new(_subscription)
    return (setmetatable({ _subscription = _subscription }, var2))
end

function var2.next(arg1, arg2)
    onNotify(arg1._subscription, "next", arg2)
end

function var2.error(arg1, arg2)
    onNotify(arg1._subscription, "error", arg2)
end

function var2.complete(arg1)
    onNotify(arg1._subscription, "complete")
end

var1 = {}
var1.__index = var1

local function isObservableClass(arg1): boolean
    return typeof(arg1) == "table" and arg1[symbol] == var1[symbol] and typeof(rawget(arg1, "new")) == "function"
end

function var1.new(_subscriber: (...any) -> (...any))
    if not isCallable(_subscriber) then
        error("Observable initializer must be a function")
    end

    return (setmetatable({ _subscriber = _subscriber }, var1))
end

function var1:subscribe(next, error: ((...any) -> (...any))?, complete: ((...any) -> (...any))?)
    next = (typeof(next) ~= "table" or next == nil) and {
        start = nil,
        next = next,
        error = error,
        complete = complete
    } or next

    return (tbl1.new(next, self._subscriber))
end

function var1.forEach(tbl2, callback: (...any) -> (...any))
    return Promise.new(function(callback2, callback3)
        if not isCallable(callback) then
            callback3(Error.new(tostring(callback) .. " is not a function"))
            return
        end

        local var6 = nil
        local function done()
            var6:unsubscribe()
            callback2()
        end

        var6 = tbl2:subscribe({
            next = function(_, arg1)
                local success, result = pcall(callback, arg1, done)

                if not success then
                    callback3(result)
                    var6:unsubscribe()
                end
            end,
            error = function(_, arg1)
                callback3(arg1)
            end,
            complete = function(_)
                callback2()
            end
        })
    end)
end

function var1.map(tbl2, callback: (...any) -> (...any))
    if not isCallable(callback) then
        error(Error.new(tostring(callback) .. " is not a function"))
    end

    return getSpecies(tbl2).new(function(arg1)
        return tbl2:subscribe({
            next = function(_, arg2)
                local success
                success, arg2 = pcall(callback, arg2)
                if not success then
                    arg1:error(arg2)
                    return
                end

                arg1:next(arg2)
            end,
            error = function(_, arg2)
                arg1:error(arg2)
            end,
            complete = function(_)
                arg1:complete()
            end
        })
    end)
end

function var1.filter(tbl2, callback: (...any) -> (...any))
    if not isCallable(callback) then
        error(Error.new(tostring(callback) .. " is not a function"))
    end

    return getSpecies(tbl2).new(function(tbl3)
        return tbl2:subscribe({
            next = function(_, arg1)
                local success, result = xpcall(callback, function(arg2)
                    tbl3:error(arg2)
                end, arg1)

                if (not success or Boolean.toJSBoolean(result)) and success then
                    tbl3:next(arg1)
                end
            end,
            error = function(_, arg1)
                tbl3:error(arg1)
            end,
            complete = function(_)
                tbl3:complete()
            end
        })
    end)
end

function var1.reduce(tbl2, callback: (...any) -> (...any), ...)
    local bool1 = isCallable(callback)
    local tbl3 = { callback, ... }

    if not bool1 then
        error(Error.new(tostring(callback) .. " is not a function"))
    end

    local species = getSpecies(tbl2)
    local bool2 = #tbl3 > 1
    local bool3 = false
    local var6 = tbl3[2]

    return species.new(function(tbl4)
        return tbl2:subscribe({
            next = function(_, arg1)
                local bool4 = not bool3
                bool3 = true
                if bool4 and not bool2 then
                    var6 = arg1

                    return
                end

                local _success, result = xpcall(callback, function(arg2)
                    tbl4:error(arg2)
                end, var6, arg1)

                var6 = result
            end,
            error = function(_, arg1)
                tbl4:error(arg1)
            end,
            complete = function(_)
                if not (bool3 or bool2) then
                    tbl4:error(Error.new("Cannot reduce an empty sequence"))
                end
                tbl4:next(var6)
                tbl4:complete()
            end
        })
    end)
end

function var1.concat(arg1, ...)
    local species = getSpecies(arg1)
    local tbl2 = { ... }

    return species.new(function(arg2)
        local var6 = nil
        local num1 = 1
        local function startNext(arg3)
            var6 = arg3:subscribe({
                next = function(_, arg4)
                    arg2:next(arg4)
                end,
                error = function(_, arg4)
                    arg2:error(arg4)
                end,
                complete = function(_)
                    if num1 == #tbl2 + 1 then
                        var6 = nil
                        arg2:complete()
                        return
                    end
                    local var7 = startNext
                    local from = species.from
                    local tbl3 = tbl2
                    local num2 = num1
                    num1 += 1
                    var7(from(tbl3[num2]))
                end
            })
        end

        startNext(arg1)

        return function()
            if Boolean.toJSBoolean(var6) then
                var6:unsubscribe()
                var6 = nil
            end
        end
    end)
end

function var1.flatMap(tbl2, callback: (...any) -> (...any))
    local completeIfDone = nil

    if not isCallable(callback) then
        error(Error.new(tostring(callback) .. " is not a function"))
    end

    local species = getSpecies(tbl2)

    return species.new(function(arg1)
        local tbl3 = {}
        local var6 = tbl2:subscribe({
            next = function(_, arg2)
                if Boolean.toJSBoolean(callback) then
                    local _success

                    _success, arg2 = xpcall(callback, function(arg3)
                        arg1:error(arg3)
                    end, arg2)
                end

                local var6 = nil
                var6 = species.from(arg2):subscribe({
                    next = function(_, arg3)
                        arg1:next(arg3)
                    end,
                    error = function(_, arg3)
                        arg1:error(arg3)
                    end,
                    complete = function(_)
                        local var7 = Array.indexOf(tbl3, var6)

                        if var7 >= 1 then
                            Array.splice(tbl3, var7, 1)
                        end
                        completeIfDone()
                    end
                })

                table.insert(tbl3, var6)
                return nil
            end,
            error = function(_, arg2)
                arg1:error(arg2)
            end,
            complete = function(_)
                completeIfDone()
            end
        })

        completeIfDone = function()
            if var6.closed and #tbl3 == 0 then
                arg1:complete()
            end
        end

        return function()
            Array.forEach(tbl3, function(arg2)
                return arg2:unsubscribe()
            end)
            var6:unsubscribe()
        end
    end)
end

var1[symbol] = function<T>(arg1: T): T
    return arg1
end

function var1.from(arg1, arg2)
    local var6, var7

    if isObservableClass(arg1) then
        var6 = arg2
        var7 = arg1
    else
        var7 = var1
        var6 = arg1
    end

    if var6 == nil then
        error(Error.new(tostring(var6) .. " is not an object"))
    end

    local method = getMethod(var6, symbol)
    if method then
        local var8 = method(var6)

        if isObservable(var8) and var8.new == var7.new then
            return var8
        end

        return var7.new(function(arg3)
            return var8:subscribe(arg3)
        end)
    end

    if not Array.isArray(var6) then
        error(Error.new(tostring(var6) .. " is not observable"))
        return
    end

    return var1.new(function(arg3)
        enqueue(function()
            if arg3.closed then
                return
            end

            for _, value in pairs(var6) do
                arg3:next(value)
                if arg3.closed then
                    return
                end
            end

            arg3:complete()
        end)
    end)
end

function var1.of(arg1, ...)
    local tbl2, var6

    if isObservableClass(arg1) then
        tbl2 = { ... }
        var6 = arg1
    else
        var6 = var1
        tbl2 = { arg1, ... }
    end

    return var6.new(function(arg2)
        enqueue(function()
            if arg2.closed then
                return
            end
            for _, value in ipairs(tbl2) do
                arg2:next(value)
                if arg2.closed then
                    return
                end
            end
            arg2:complete()
        end)
    end)
end

if hasSymbols() then
    local var6 = Symbol("extensions")
    var1[var6] = { symbol = symbol, hostReportError = var5 }
end

return { Observable = var1 }
