-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:06:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Immutable)

local module = {}

module.__index = module

function module.new()
    local tbl1 = {
        _listeners = {}
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module:connect(callback)
    local tbl1 = { callback = callback, isConnected = true }

    self._listeners = Immutable.Append(self._listeners, tbl1)

    local function disconnect() -- Luacid: Inlined by compiler; 1 call site recovered
        tbl1.isConnected = false
        self._listeners = Immutable.RemoveValueFromList(self._listeners, tbl1)
    end

    return {
        Disconnect = function()
            warn(string.format("Connection:Disconnect() has been deprecated, use Connection:disconnect()\n%s]", debug.traceback()))
            disconnect()
        end,
        disconnect = disconnect
    }
end

function module:fire(...)
    for _, _listener in ipairs(self._listeners) do
        if _listener.isConnected then
            _listener.callback(...)
        end
    end
end

function module.Connect(arg1, ...)
    warn(string.format("Signal:Connect() has been deprecated, use Signal:connect()\n%s]", debug.traceback()))
    return arg1:connect(...)
end

function module.Fire(arg1, ...)
    warn(string.format("Signal:Fire() has been deprecated, use Signal:fire()\n%s]", debug.traceback()))
    arg1:fire(...)
end

return module
