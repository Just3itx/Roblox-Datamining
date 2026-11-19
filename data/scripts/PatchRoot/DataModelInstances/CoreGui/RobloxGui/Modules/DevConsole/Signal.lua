-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
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

function module:Connect(callback)
    local tbl1 = { callback = callback, isConnected = true }

    self._listeners = Immutable.Append(self._listeners, tbl1)

    return {
        Disconnect = function() -- name: disconnect
            tbl1.isConnected = false
            self._listeners = Immutable.RemoveValueFromList(self._listeners, tbl1)
        end
    }
end

function module:Fire(...)
    for _, _listener in ipairs(self._listeners) do
        if _listener.isConnected then
            _listener.callback(...)
        end
    end
end

return module
