-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local __DEV__ = _G.__DEV__

local _success, result = xpcall(function(): boolean
    return game:DefineFastFlag("RoduxRemoveConnectTraceback", false)
end, function(): boolean
    return true
end)

local function immutableAppend<T>(_listeners: {T}, ...): {T}
    local result2 = ({})
    local _listenersLen = #_listeners

    for i = 1, _listenersLen do
        result2[i] = _listeners[i]
    end

    local select2 = select

    for i = 1, select2("#", ...) do
        local num1 = _listenersLen + i
        local select = select
        result2[num1] = select(i, ...)
    end

    return result2
end

local function immutableRemoveValue(_listeners, tbl1: {callback: (...any) -> (...any), connectTraceback: nil, disconnectTraceback: nil, disconnected: boolean})
    local result2 = {}

    for i = 1, #_listeners do
        if _listeners[i] ~= tbl1 then
            table.insert(result2, _listeners[i])
        end
    end

    return result2
end

local module = {}

module.__index = module

function module.new(_store)
    local tbl1 = {
        _listeners = {},
        _store = _store
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module:connect(callback)
    if typeof(callback) ~= "function" then
        error("Expected the listener to be a function.")
    end

    if self._store and self._store._isDispatching then
        error(
            "You may not call store.changed:connect() while the reducer is executing. If you would like to be notified after the store has been updated, subscribe from a component and invoke store:getState() in the callback to access the latest state. "
        )
    end

    local tbl1 = {
        callback = callback,
        disconnected = false,
        connectTraceback = nil,
        disconnectTraceback = nil
    }

    if not result or __DEV__ then
        tbl1.connectTraceback = debug.traceback()
    end

    self._listeners = immutableAppend(self._listeners, tbl1)

    return {
        disconnect = function()
            if tbl1.disconnected then
                local error = error

                local str1 = tostring(tbl1.connectTraceback)
                local disconnectTraceback = tbl1.disconnectTraceback
                error(("Listener connected at: \n%s\nwas already disconnected at: \n%s\n"):format(str1, tostring(disconnectTraceback)))
            end

            if self._store and self._store._isDispatching then
                error("You may not unsubscribe from a store listener while the reducer is executing.")
            end

            if not result or __DEV__ then
                tbl1.disconnectTraceback = debug.traceback()
            end
            tbl1.disconnected = true
            self._listeners = immutableRemoveValue(self._listeners, tbl1)
        end
    }
end

function module:fire(...)
    for _, _listener in ipairs(self._listeners) do
        if not _listener.disconnected then
            _listener.callback(...)
        end
    end
end

return module
