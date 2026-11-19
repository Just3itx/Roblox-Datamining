-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { __mode = "k" }

local function isCallable(arg1) -- Luacid: Inlined by compiler; 17 call sites recovered
    if type(arg1) == "function" then
        return true
    end

    if type(arg1) == "table" then
        local var1 = getmetatable(arg1)
        if var1 and type(rawget(var1, "__call")) == "function" then
            return true
        end
    end

    return false
end

local function makeEnum(str1: string, arg1)
    local tbl2 = ({})

    for _, value in ipairs(arg1) do
        tbl2[value] = value
    end

    return (setmetatable(tbl2, {
        __index = function(_, arg2)
            error(string.format("%s is not in %s!", arg2, str1), 2)
        end,
        __newindex = function()
            error(string.format("Creating new members in %s is not allowed!", str1), 2)
        end
    }))
end

local Error = {
    Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
}

Error.__index = Error

function Error.new(arg1, parent)
    arg1 = arg1 or {}
    return (setmetatable({
        error = tostring(arg1.error) or "[This error has no error text.]",
        trace = arg1.trace,
        context = arg1.context,
        kind = arg1.kind,
        parent = parent,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    }, Error))
end

function Error.is(arg1)
    if type(arg1) == "table" then
        local var1 = getmetatable(arg1)

        if type(var1) == "table" then
            return not (rawget(arg1, "error") == nil) and type(rawget(var1, "extend")) == "function"
        end
    end

    return false
end

function Error.isKind(arg1, kind)
    assert(kind ~= nil, "Argument #2 to Promise.Error.isKind must not be nil")

    return Error.is(arg1) and arg1.kind == kind
end

function Error:extend(arg1)
    arg1 = arg1 or {}

    arg1.kind = arg1.kind or self.kind

    return Error.new(arg1, self)
end

function Error:getErrorChain()
    local tbl3 = { self }

    while tbl3[#tbl3].parent do
        table.insert(tbl3, tbl3[#tbl3].parent)
    end

    return tbl3
end

function Error:__tostring(): string
    local tbl3 = { string.format("-- Promise.Error(%s) --", self.kind or "?") }

    for _, value in ipairs(self:getErrorChain()) do
        table.insert(tbl3, table.concat({ value.trace or value.error, value.context }, "\n"))
    end

    return table.concat(tbl3, "\n")
end

local function pack(...)
    local select = select
    return select("#", ...), { ... }
end

local function packResult<T>(arg1: T, ...)
    local select = select
    return arg1, select("#", ...), { ... }
end

local function makeErrorHandler(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    assert(arg1 ~= nil, "traceback is nil")

    return function(error)
        if type(error) == "table" then
            return error
        end

        return Error.new({
            error = error,
            kind = Error.Kind.ExecutionError,
            trace = debug.traceback(tostring(error), 2),
            context = "Promise created at:\n\n" .. arg1
        })
    end
end

local function runExecutor(arg1, callback, ...)
    return packResult(xpcall(callback, makeErrorHandler(arg1), ...))
end

local function createAdvancer(arg1, callback, callback2, callback3) -- Luacid: Inlined by compiler; 3 call sites recovered
    return function(...)
        local var1, var2, tbl3 = runExecutor(arg1, callback, ...)

        if var1 then
            callback2(unpack(tbl3, 1, var2))
            return
        end
        callback3(tbl3[1])
    end
end

local function isEmpty(_queuedReject): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return next(_queuedReject) == nil
end

local module = {
    Error = Error,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {}
}
module.prototype = {}
module.__index = module.prototype

function module._new(_source, callback, _parent)
    if _parent ~= nil and not module.is(_parent) then
        error("Argument #2 to Promise.new must be a promise or nil", 2)
    end

    local tbl3 = {
        _thread = nil,
        _source = _source,
        _status = module.Status.Started,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _cancellationHook = nil,
        _parent = _parent,
        _consumers = setmetatable({}, tbl1)
    }

    if _parent and _parent._status == module.Status.Started then
        _parent._consumers[tbl3] = true
    end

    setmetatable(tbl3, module)

    local function resolve(...)
        tbl3:_resolve(...)
    end

    local function reject(...)
        tbl3:_reject(...)
    end

    local function onCancel(_cancellationHook): boolean
        if _cancellationHook then
            if tbl3._status == module.Status.Cancelled then
                _cancellationHook()
            else
                tbl3._cancellationHook = _cancellationHook
            end
        end

        return tbl3._status == module.Status.Cancelled
    end

    tbl3._thread = coroutine.create(function()
        local var1, _, tbl4 = runExecutor(tbl3._source, callback, resolve, reject, onCancel)

        if not var1 then
            reject(tbl4[1])
        end
    end)

    task.spawn(tbl3._thread)

    return tbl3
end

function module.new(arg1)
    return module._new(debug.traceback(nil, 2), arg1)
end

function module.__tostring(arg1): string
    return string.format("Promise(%s)", arg1._status)
end

function module.defer(callback)
    local var1 = debug.traceback(nil, 2)

    return (module._new(var1, function(arg1, callback2, arg2)
        local connection = nil
        connection = module._timeEvent:Connect(function()
            connection:Disconnect()
            local var2, _, tbl3 = runExecutor(var1, callback, arg1, callback2, arg2)

            if not var2 then
                callback2(tbl3[1])
            end
        end)
    end))
end

module.async = module.defer

function module.resolve(...)
    local var1, tbl3 = pack(...)
    return module._new(debug.traceback(nil, 2), function(callback)
        callback(unpack(tbl3, 1, var1))
    end)
end

function module.reject(...)
    local var1, tbl3 = pack(...)
    return module._new(debug.traceback(nil, 2), function(_, callback)
        callback(unpack(tbl3, 1, var1))
    end)
end

function module._try(arg1, arg2, ...)
    local var1, tbl3 = pack(...)

    return module._new(arg1, function(callback)
        callback(arg2(unpack(tbl3, 1, var1)))
    end)
end

function module.try(arg1, ...)
    return module._try(debug.traceback(nil, 2), arg1, ...)
end

function module._all(arg1, arg2, arg3)
    if type(arg2) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3)
    end

    for k, value in pairs(arg2) do
        if not module.is(value) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", tostring(k)), 3)
        end
    end

    if #arg2 == 0 or arg3 == 0 then
        return module.resolve({})
    end

    return module._new(arg1, function(callback, callback2, callback3)
        local tbl3 = ({})
        local tbl4 = ({})

        local num1 = 0
        local num2 = 0
        local bool1 = false

        local function cancel() -- Luacid: Inlined by compiler; 3 call sites recovered
            for _, value in ipairs(tbl4) do
                value:cancel()
            end
        end

        local function resolveOne(arg4, ...)
            if bool1 then
                return
            end

            num1 += 1

            if arg3 == nil then
                tbl3[arg4] = ...
            else
                tbl3[num1] = ...
            end

            if num1 >= (arg3 or #arg2) then
                bool1 = true
                callback(tbl3)
                cancel()
            end
        end

        callback3(cancel)

        for i, value in ipairs(arg2) do
            tbl4[i] = value:andThen(function(...)
                resolveOne(i, ...)
            end, function(...)
                num2 += 1

                if arg3 == nil or #arg2 - num2 < arg3 then
                    cancel()
                    bool1 = true

                    callback2(...)
                end
            end)
        end

        if bool1 then
            cancel()
        end
    end)
end

function module.all(...)
    local tbl3 = { ... }

    if type(tbl3[1]) == "table" and not module.is(tbl3[1]) then
        tbl3 = tbl3[1]
    end

    return module._all(debug.traceback(nil, 2), tbl3)
end

function module.fold(arg1, arg2, arg3)
    assert(type(arg1) == "table", "Bad argument #1 to Promise.fold: must be a table")
    assert(isCallable(arg2), "Bad argument #2 to Promise.fold: must be a function")

    local var1 = module.resolve(arg3)
    return module.each(arg1, function(arg4, arg5)
        var1 = var1:andThen(function(arg6)
            return arg2(arg6, arg4, arg5)
        end)
    end):andThen(function()
        return var1
    end)
end

function module.some(arg1, num1: number)
    assert(type(num1) == "number", "Bad argument #2 to Promise.some: must be a number")

    return module._all(debug.traceback(nil, 2), arg1, num1)
end

function module.any(arg1)
    return module._all(debug.traceback(nil, 2), arg1, 1):andThen(function<T>(tbl3: {T}): T
        return tbl3[1]
    end)
end

function module.allSettled(arg1)
    if type(arg1) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2)
    end

    for k, value in pairs(arg1) do
        if not module.is(value) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", tostring(k)), 2)
        end
    end

    if #arg1 == 0 then
        return module.resolve({})
    end

    return module._new(debug.traceback(nil, 2), function(callback, _, callback2)
        local tbl3 = ({})
        local tbl4 = ({})

        local num1 = 0

        local function resolveOne(arg2, ...)
            num1 += 1

            tbl3[arg2] = ...

            if num1 >= #arg1 then
                callback(tbl3)
            end
        end

        callback2(function()
            for _, value in ipairs(tbl4) do
                value:cancel()
            end
        end)

        for i, value in ipairs(arg1) do
            tbl4[i] = value:finally(function(...)
                resolveOne(i, ...)
            end)
        end
    end)
end

function module.race(arg1)
    assert(type(arg1) == "table", string.format("Please pass a list of promises to %s", "Promise.race"))

    for k, value in pairs(arg1) do
        assert(module.is(value), string.format("Non-promise value passed into %s at index %s", "Promise.race", tostring(k)))
    end

    return module._new(debug.traceback(nil, 2), function(arg2, arg3, arg4)
        local tbl3 = ({})
        local bool1 = false

        local function cancel() -- Luacid: Inlined by compiler; 5 call sites recovered
            for _, value in ipairs(tbl3) do
                value:cancel()
            end
        end

        local function finalize(arg5) -- Luacid: Inlined by compiler; 3 call sites recovered
            return function(...)
                cancel()
                bool1 = true
                return arg5(...)
            end
        end

        if arg4((finalize(arg3))) then
            return
        end

        for i, value in ipairs(arg1) do
            tbl3[i] = value:andThen(finalize(arg2), (finalize(arg3)))
        end

        if bool1 then
            cancel()
        end
    end)
end

function module.each(arg1, arg2)
    assert(type(arg1) == "table", string.format("Please pass a list of promises to %s", "Promise.each"))
    assert(isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise.each"))

    return module._new(debug.traceback(nil, 2), function(callback, arg3, callback2)
        local tbl3 = ({})
        local tbl4 = {}

        local bool1 = false

        local function cancel() -- Luacid: Inlined by compiler; 5 call sites recovered
            for _, value in ipairs(tbl4) do
                value:cancel()
            end
        end

        callback2(function()
            bool1 = true
            cancel()
        end)

        local tbl5 = ({})

        for i, value in ipairs(arg1) do
            if module.is(value) then
                if value:getStatus() == module.Status.Cancelled then
                    cancel()
                    return arg3(
                        Error.new({
                            error = "Promise is cancelled",
                            kind = Error.Kind.AlreadyCancelled,
                            context = string.format(
                                "The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s",
                                i,
                                value._source
                            )
                        })
                    )
                end

                if value:getStatus() == module.Status.Rejected then
                    cancel()
                    return arg3(select(2, value:await()))
                end

                local var1 = value:andThen(function(...)
                    return ...
                end)

                table.insert(tbl4, var1)
                tbl5[i] = var1
            else
                tbl5[i] = value
            end
        end

        for i, value in ipairs(tbl5) do
            if module.is(value) then
                local var1
                var1, value = value:await()

                if not var1 then
                    cancel()
                    return arg3(value)
                end
            end

            if bool1 then
                return
            end

            local var1 = module.resolve(arg2(value, i))

            table.insert(tbl4, var1)

            local var2, var3 = var1:await()

            if not var2 then
                cancel()
                return arg3(var3)
            end

            tbl3[i] = var3
        end

        callback(tbl3)
    end)
end

function module.is(arg1)
    if type(arg1) ~= "table" then
        return false
    end

    local var1 = getmetatable(arg1)

    if var1 == module then
        return true
    end

    if var1 == nil then
        return isCallable(arg1.andThen)
    end
    if type(var1) == "table" and type(rawget(var1, "__index")) == "table" then
        local var2 = rawget(var1, "__index")

        if isCallable(rawget(var2, "andThen")) then
            return true
        end
    end
    return false
end

function module.promisify(arg1)
    return function(...)
        return module._try(debug.traceback(nil, 2), arg1, ...)
    end
end

local var1 = nil
local connection = nil

function module.delay(arg1)
    assert(type(arg1) == "number", "Bad argument #1 to Promise.delay, must be a number.")

    arg1 = (not (arg1 >= 1 / 60) or arg1 == math.huge) and 1 / 60 or arg1

    return module._new(debug.traceback(nil, 2), function(resolve, _, callback)
        local startTime = module._getTime()
        local endTime = startTime + arg1

        local tbl3 = { resolve = resolve, startTime = startTime, endTime = endTime }

        if connection == nil then
            var1 = tbl3
            connection = module._timeEvent:Connect(function()
                local var4 = module._getTime()

                while var1 ~= nil and var1.endTime < var4 do
                    local var5 = var1
                    var1 = var5.next

                    if var1 == nil then
                        connection:Disconnect()
                        connection = nil
                    else
                        var1.previous = nil
                    end

                    var5.resolve(module._getTime() - var5.startTime)
                end
            end)
        elseif var1.endTime < endTime then
            local var4 = var1
            local next = var4.next

            while next ~= nil and next.endTime < endTime do
                local next2 = next.next
                var4 = next
                next = next2
            end

            var4.next = tbl3
            tbl3.previous = var4

            if next ~= nil then
                tbl3.next = next
                next.previous = tbl3
            end
        else
            tbl3.next = var1
            var1.previous = tbl3
            var1 = tbl3
        end

        callback(function()
            local next = tbl3.next

            if var1 ~= tbl3 then
                local previous = tbl3.previous

                previous.next = next

                if next ~= nil then
                    next.previous = previous
                end

                return
            end

            if next == nil then
                connection:Disconnect()
                connection = nil
            else
                next.previous = nil
            end
            var1 = next
        end)
    end)
end

function module.prototype.timeout(arg1, arg2, arg3)
    local var2 = debug.traceback(nil, 2)

    return module.race({
        module.delay(arg2):andThen(function()
            return module.reject(
                arg3 == nil
                    and Error.new({
                        kind = Error.Kind.TimedOut,
                        error = "Timed out",
                        context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", arg2, var2)
                    })
                    or arg3
            )
        end),
        arg1
    })
end

function module.prototype:getStatus()
    return self._status
end

function module.prototype:_andThen(arg1, callback, callback2)
    self._unhandledRejection = false

    return module._new(arg1, function(arg2, callback3)
        local var2 = if callback then createAdvancer(arg1, callback, arg2, callback3) else arg2
        local var3 = if callback2 then createAdvancer(arg1, callback2, arg2, callback3) else callback3

        if self._status == module.Status.Started then
            table.insert(self._queuedResolve, var2)
            table.insert(self._queuedReject, var3)
            return
        end

        if self._status == module.Status.Resolved then
            var2(unpack(self._values, 1, self._valuesLength))
            return
        end

        if self._status == module.Status.Rejected then
            var3(unpack(self._values, 1, self._valuesLength))
            return
        end

        if self._status ~= module.Status.Cancelled then
            return
        end

        callback3(
            Error.new(
                {
                    error = "Promise is cancelled",
                    kind = Error.Kind.AlreadyCancelled,
                    context = "Promise created at\n\n" .. arg1
                }
            )
        )
    end, self)
end

function module.prototype.andThen(arg1, arg2, arg3)
    assert(arg2 == nil or isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:andThen"))
    assert(arg3 == nil or isCallable(arg3), string.format("Please pass a handler function to %s!", "Promise:andThen"))

    return arg1:_andThen(debug.traceback(nil, 2), arg2, arg3)
end

function module.prototype.andThenAsync(arg1, arg2, arg3)
    assert(arg2 == nil or isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:andThenAsync"))
    assert(arg3 == nil or isCallable(arg3), string.format("Please pass a handler function to %s!", "Promise:andThenAsync"))

    return arg1:_andThen(debug.traceback(nil, 2), function(...)
        local var2, tbl3 = pack(...)
        return module.defer(function(callback)
            callback(unpack(tbl3, 1, var2))
        end)
    end, function(...)
        local var2, tbl3 = pack(...)
        return module.defer(function(_, callback)
            callback(unpack(tbl3, 1, var2))
        end)
    end):andThen(arg2, arg3)
end

function module.prototype.catch(arg1, arg2)
    assert(arg2 == nil or isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:catch"))
    return arg1:_andThen(debug.traceback(nil, 2), nil, arg2)
end

function module.prototype.tap(arg1, arg2)
    assert(isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:tap"))
    return arg1:_andThen(debug.traceback(nil, 2), function(...)
        local var2 = arg2(...)

        if not module.is(var2) then
            return ...
        end

        local var3, tbl3 = pack(...)
        return var2:andThen(function()
            return unpack(tbl3, 1, var3)
        end)
    end)
end

function module.prototype.andThenCall(arg1, arg2, ...)
    assert(isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:andThenCall"))
    local var2, tbl3 = pack(...)
    return arg1:_andThen(debug.traceback(nil, 2), function()
        return arg2(unpack(tbl3, 1, var2))
    end)
end

function module.prototype.andThenReturn(arg1, ...)
    local var2, tbl3 = pack(...)
    return arg1:_andThen(debug.traceback(nil, 2), function()
        return unpack(tbl3, 1, var2)
    end)
end

function module.prototype:cancel()
    if self._status ~= module.Status.Started then
        return
    end

    self._status = module.Status.Cancelled

    if self._cancellationHook then
        self._cancellationHook()
    end

    coroutine.close(self._thread)

    if self._parent then
        self._parent:_consumerCancelled(self)
    end

    for k in pairs(self._consumers) do
        k:cancel()
    end

    self:_finalize()
end

function module.prototype:_consumerCancelled(arg1)
    if self._status ~= module.Status.Started then
        return
    end

    self._consumers[arg1] = nil

    if next(self._consumers) == nil then
        self:cancel()
    end
end

function module.prototype:_finally(arg1, callback, arg2)
    if not arg2 then
        self._unhandledRejection = false
    end

    return module._new(arg1, function(arg3, arg4)
        local var2 = if callback then createAdvancer(arg1, callback, arg3, arg4) else arg3

        local func1 = if arg2 then function(...)
            if self._status == module.Status.Rejected then
                return arg3(self)
            end

            return var2(...)
        end else var2

        if self._status == module.Status.Started then
            table.insert(self._queuedFinally, func1)
            return
        end

        func1(self._status)
    end, self)
end

function module.prototype:finally(arg1)
    assert(arg1 == nil or isCallable(arg1), string.format("Please pass a handler function to %s!", "Promise:finally"))
    return self:_finally(debug.traceback(nil, 2), arg1)
end

function module.prototype.finallyCall(arg1, arg2, ...)
    assert(isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:finallyCall"))
    local var2, tbl3 = pack(...)
    return arg1:_finally(debug.traceback(nil, 2), function()
        return arg2(unpack(tbl3, 1, var2))
    end)
end

function module.prototype.finallyReturn(arg1, ...)
    local var2, tbl3 = pack(...)
    return arg1:_finally(debug.traceback(nil, 2), function()
        return unpack(tbl3, 1, var2)
    end)
end

function module.prototype.done(arg1, arg2)
    assert(arg2 == nil or isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:done"))

    return arg1:_finally(debug.traceback(nil, 2), arg2, true)
end

function module.prototype.doneCall(arg1, arg2, ...)
    assert(isCallable(arg2), string.format("Please pass a handler function to %s!", "Promise:doneCall"))
    local var2, tbl3 = pack(...)
    return arg1:_finally(debug.traceback(nil, 2), function()
        return arg2(unpack(tbl3, 1, var2))
    end, true)
end

function module.prototype.doneReturn(arg1, ...)
    local var2, tbl3 = pack(...)
    return arg1:_finally(debug.traceback(nil, 2), function()
        return unpack(tbl3, 1, var2)
    end, true)
end

function module.prototype:awaitStatus()
    self._unhandledRejection = false

    if self._status == module.Status.Started then
        local thread = coroutine.running()

        self:finally(function()
            task.spawn(thread)
        end)

        coroutine.yield()
    end

    if self._status == module.Status.Resolved then
        return self._status, unpack(self._values, 1, self._valuesLength)
    end

    if self._status ~= module.Status.Rejected then
        return self._status
    end

    return self._status, unpack(self._values, 1, self._valuesLength)
end

local function awaitHelper(resolved, ...)
    return resolved == module.Status.Resolved, ...
end

function module.prototype.await(arg1)
    return awaitHelper(arg1:awaitStatus())
end

local function expectHelper(resolved, ...)
    if resolved ~= module.Status.Resolved then
        error(if ... == nil then "Expected Promise rejected with no value." else ..., 3)
    end

    return ...
end

function module.prototype.expect(arg1)
    return expectHelper(arg1:awaitStatus())
end

module.prototype.awaitValue = module.prototype.expect

function module.prototype:_unwrap()
    if self._status == module.Status.Started then
        error("Promise has not resolved or rejected.", 2)
    end

    return self._status == module.Status.Resolved, unpack(self._values, 1, self._valuesLength)
end

function module.prototype:_resolve(...)
    if self._status ~= module.Status.Started then
        if module.is((...)) then
            (...):_consumerCancelled(self)
        end

        return
    end

    if not module.is((...)) then
        self._status = module.Status.Resolved
        local _valuesLength, _values = pack(...)
        self._valuesLength = _valuesLength
        self._values = _values

        for _, value in ipairs(self._queuedResolve) do
            coroutine.wrap(value)(...)
        end

        self:_finalize()
        return
    end

    local select = select

    if select("#", ...) > 1 then
        local str1 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", self._source)

        warn(str1)
    end

    local var2 = ...

    local _parent = var2:andThen(function(...)
        self:_resolve(...)
    end, function(...)
        local var3 = var2._values[1]

        if var2._error then
            var3 = Error.new({
                error = var2._error,
                kind = Error.Kind.ExecutionError,
                context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]"
            })
        end

        if not Error.isKind(var3, Error.Kind.ExecutionError) then
            self:_reject(...)
            return
        end

        return self:_reject(
            var3:extend({
                error = "This Promise was chained to a Promise that errored.",
                trace = "",
                context = string.format(
                    "The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n",
                    self._source
                )
            })
        )
    end)

    if _parent._status == module.Status.Cancelled then
        self:cancel()
    elseif _parent._status == module.Status.Started then
        self._parent = _parent
        _parent._consumers[self] = true
    end
end

function module.prototype:_reject(...)
    if self._status ~= module.Status.Started then
        return
    end

    self._status = module.Status.Rejected
    local _valuesLength, _values = pack(...)
    self._valuesLength = _valuesLength
    self._values = _values

    if not isEmpty(self._queuedReject) then
        for _, value in ipairs(self._queuedReject) do
            coroutine.wrap(value)(...)
        end
    else
        local str1 = tostring((...))

        coroutine.wrap(function()
            module._timeEvent:Wait()

            if not self._unhandledRejection then
                return
            end

            local str2 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", str1, self._source)

            for _, _unhandledRejectionCallback in ipairs(module._unhandledRejectionCallbacks) do
                local spawn = task.spawn
                local var3 = self
                local _values = self._values
                local _valuesLength = self._valuesLength
                spawn(_unhandledRejectionCallback, var3, unpack(_values, 1, _valuesLength))
            end

            if module.TEST then
                return
            end

            warn(str2)
        end)()
    end

    self:_finalize()
end

function module.prototype:_finalize()
    for _, value in ipairs(self._queuedFinally) do
        coroutine.wrap(value)(self._status)
    end

    self._queuedFinally = nil
    self._queuedReject = nil
    self._queuedResolve = nil

    if not module.TEST then
        self._parent = nil
        self._consumers = nil
    end

    task.defer(coroutine.close, self._thread)
end

function module.prototype:now(arg1)
    local var2 = debug.traceback(nil, 2)
    if self._status == module.Status.Resolved then
        return self:_andThen(var2, function(...)
            return ...
        end)
    end
    local reject = module.reject

    if arg1 == nil then
        arg1 = Error.new({
            kind = Error.Kind.NotResolvedInTime,
            error = "This Promise was not resolved in time for :now()",
            context = ":now() was called at:\n\n" .. var2
        })
            or arg1
    end

    return reject(arg1)
end

function module.retry(arg1, num1: number, ...)
    assert(isCallable(arg1), "Parameter #1 to Promise.retry must be a function")
    assert(type(num1) == "number", "Parameter #2 to Promise.retry must be a number")

    local tbl3 = { ... }
    local select = select
    local var2 = select("#", ...)

    return module.resolve(arg1(...)):catch(function(...)
        if num1 > 0 then
            return module.retry(arg1, num1 - 1, unpack(tbl3, 1, var2))
        end
        return module.reject(...)
    end)
end

function module.retryWithDelay(arg1, num1: number, num2: number, ...)
    assert(isCallable(arg1), "Parameter #1 to Promise.retry must be a function")
    assert(type(num1) == "number", "Parameter #2 (times) to Promise.retry must be a number")
    assert(type(num2) == "number", "Parameter #3 (seconds) to Promise.retry must be a number")

    local tbl3 = { ... }
    local select = select
    local var2 = select("#", ...)

    return module.resolve(arg1(...)):catch(function(...)
        if not (num1 > 0) then
            return module.reject(...)
        end

        module.delay(num2):await()

        return module.retryWithDelay(arg1, num1 - 1, num2, unpack(tbl3, 1, var2))
    end)
end

function module.fromEvent(rbxScriptSignal, arg1)
    local var2 = arg1 or function(): boolean
        return true
    end

    return module._new(debug.traceback(nil, 2), function(callback, _, callback2)
        local connection2 = nil
        local bool1 = false

        local function disconnect() -- Luacid: Inlined by compiler; 1 call site recovered
            connection2:Disconnect()
            connection2 = nil
        end

        connection2 = rbxScriptSignal:Connect(function(...)
            local var3 = var2(...)

            if var3 ~= true then
                if type(var3) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean")
                end
                return
            end

            callback(...)

            if connection2 then
                disconnect()
                return
            end

            bool1 = true
        end)
        if bool1 and connection2 then
            return disconnect()
        end

        callback2(disconnect)
    end)
end

function module.onUnhandledRejection(arg1)
    table.insert(module._unhandledRejectionCallbacks, arg1)

    return function()
        local var2 = table.find(module._unhandledRejectionCallbacks, arg1)

        if var2 then
            table.remove(module._unhandledRejectionCallbacks, var2)
        end
    end
end

return module
