-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local Signal = require(script.Parent.Signal)
local NoYield = require(script.Parent.NoYield)

local tbl1 = {
    reportReducerError = function(_, _, arg1)
        error(string.format("Received error: %s\n\n%s", arg1.message, arg1.thrownValue))
    end,
    reportUpdateError = function(_, _, _, arg1)
        error(string.format("Received error: %s\n\n%s", arg1.message, arg1.thrownValue))
    end
}

local function tracebackReporter(arg1)
    return debug.traceback(tostring(arg1))
end

local module = {
    _flushEvent = RunService.Heartbeat
}
module.__index = module

function module.new(_reducer, _state, arg1, _errorReporter, _devtools)
    assert(typeof(_reducer) == "function", "Bad argument #1 to Store.new, expected function.")
    assert(arg1 == nil or typeof(arg1) == "table", "Bad argument #3 to Store.new, expected nil or table.")
    assert(
        _devtools == nil or typeof(_devtools) == "table" and _devtools.__className == "Devtools",
        "Bad argument #5 to Store.new, expected nil or Devtools object."
    )

    if arg1 ~= nil then
        for i = 1, #arg1 do
            local bool1 = typeof(arg1[i]) == "function"
            local str1 = tostring(arg1[i])
            assert(bool1, ("Expected the middleware ('%s') at index %d to be a function."):format(str1, i))
        end
    end

    local module2 = {
        _source = string.match(debug.traceback(), "^.-\n(.-)\n"),
        _errorReporter = _errorReporter or tbl1,
        _isDispatching = false,
        _lastState = nil
    }
    module2.changed = Signal.new(module2)

    module2._reducer = _reducer
    function module2._flushHandler(arg2)
        module2.changed:fire(arg2, module2._lastState)
    end

    if _devtools then
        module2._devtools = _devtools

        _devtools:_hookIntoStore(module2)
    end

    local tbl2 = { type = "@@INIT" }

    module2._actionLog = { tbl2 }
    local success, result = xpcall(function()
        module2._state = module2._reducer(_state, tbl2)
    end, tracebackReporter)
    if not success then
        module2._errorReporter.reportReducerError(
            _state,
            tbl2,
            { message = "Caught error in reducer with init", thrownValue = result }
        )
        module2._state = _state
    end
    module2._lastState = module2._state

    module2._mutatedSinceFlush = false
    module2._connections = {}

    setmetatable(module2, module)

    local connection = module2._flushEvent:Connect(function()
        module2:flush()
    end)
    table.insert(module2._connections, connection)

    if arg1 then
        local dispatch = module2.dispatch
        local function func1(...)
            return dispatch(module2, ...)
        end

        for i = #arg1, 1, -1 do
            func1 = arg1[i](func1, module2)
        end

        function module2.dispatch(_, ...)
            return func1(...)
        end
    end

    return module2
end

function module:getState()
    if self._isDispatching then
        local error = error

        local _reducer = self._reducer
        error(
            ("You may not call store:getState() while the reducer is executing. The reducer (%s) has already received the state as an argument. Pass it down from the top reducer instead of reading it from the store."):format(
                tostring(_reducer)
            )
        )
    end

    return self._state
end

function module:dispatch(arg1)
    if typeof(arg1) ~= "table" then
        error(("Actions must be tables. Use custom middleware for %q actions."):format(typeof(arg1)), 2)
    end

    if arg1.type == nil then
        error(
            "Actions may not have an undefined 'type' property. " .. "Have you misspelled a constant? \n" .. tostring(arg1),
            2
        )
    end
    if self._isDispatching then
        error("Reducers may not dispatch actions.")
    end

    local success, result = pcall(function()
        self._isDispatching = true
        self._state = self._reducer(self._state, arg1)
        self._mutatedSinceFlush = true
    end)

    self._isDispatching = false

    if not success then
        self._errorReporter.reportReducerError(self._state, arg1, { message = "Caught error in reducer", thrownValue = result })
    end

    if #self._actionLog == 3 then
        table.remove(self._actionLog, 1)
    end
    table.insert(self._actionLog, arg1)
end

function module:destruct()
    for _, _connection in ipairs(self._connections) do
        _connection:Disconnect()
    end

    self._connections = nil
end

function module:flush()
    if not self._mutatedSinceFlush then
        return
    end

    self._mutatedSinceFlush = false

    local _state = self._state

    local success, result = xpcall(function()
        NoYield(self._flushHandler, _state)
    end, tracebackReporter)

    if not success then
        self._errorReporter.reportUpdateError(
            self._lastState,
            _state,
            self._actionLog,
            { message = "Caught error flushing store updates", thrownValue = result }
        )
    end

    self._lastState = _state
end

return module
