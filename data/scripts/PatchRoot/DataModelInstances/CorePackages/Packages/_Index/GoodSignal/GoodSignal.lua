-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = nil

local function acquireRunnerThreadAndCallEventHandler(callback, ...)
    local var2 = var1
    var1 = nil
    callback(...)

    var1 = var2
end

local function runEventHandlerInFreeThread()
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local Connection = {}
Connection.__index = Connection

function Connection.new(_signal, _fn)
    return (setmetatable({ _connected = true, _signal = _signal, _fn = _fn, _next = false }, Connection))
end

function Connection:Disconnect()
    self._connected = false

    if self._signal._handlerListHead == self then
        self._signal._handlerListHead = self._next
        return
    end
    local _handlerListHead = self._signal._handlerListHead
    while _handlerListHead and _handlerListHead._next ~= self do
        _handlerListHead = _handlerListHead._next
    end
    if _handlerListHead then
        _handlerListHead._next = self._next
    end
end

setmetatable(Connection, {
    __index = function(_, arg1)
        error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(arg1)), 2)
    end,
    __newindex = function(_, arg1)
        error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(arg1)), 2)
    end
})

local Signal = {}
Signal.__index = Signal

function Signal.new()
    return (setmetatable({ _handlerListHead = false }, Signal))
end

function Signal:Connect(arg1)
    local connection = Connection.new(self, arg1)
    if self._handlerListHead then
        connection._next = self._handlerListHead
    end

    self._handlerListHead = connection
    return connection
end

function Signal:DisconnectAll()
    self._handlerListHead = false
end

function Signal:Fire(...)
    local _handlerListHead = self._handlerListHead
    while _handlerListHead do
        if _handlerListHead._connected then
            if not var1 then
                var1 = coroutine.create(runEventHandlerInFreeThread)

                coroutine.resume(var1)
            end
            task.spawn(var1, _handlerListHead._fn, ...)
        end
        _handlerListHead = _handlerListHead._next
    end
end

function Signal.Wait(rbxScriptSignal)
    local thread = coroutine.running()
    local connection = nil
    connection = rbxScriptSignal:Connect(function(...)
        connection:Disconnect()
        task.spawn(thread, ...)
    end)
    return coroutine.yield()
end

function Signal.Once(rbxScriptSignal, callback)
    local connection = nil
    connection = rbxScriptSignal:Connect(function(...)
        if connection._connected then
            connection:Disconnect()
        end
        callback(...)
    end)
    return connection
end

setmetatable(Signal, {
    __index = function(_, arg1)
        error(("Attempt to get Signal::%s (not a valid member)"):format(tostring(arg1)), 2)
    end,
    __newindex = function(_, arg1)
        error(("Attempt to set Signal::%s (not a valid member)"):format(tostring(arg1)), 2)
    end
})

return Signal
