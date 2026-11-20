-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local console = require(scriptParentParentParentParent.Shared).console

local module = {}
module.__index = module

function module.new(_instance)
    return (setmetatable({
        _suspendedEventQueue = {},
        _connections = {},
        _listeners = {},
        _status = "Disabled",
        _isResuming = false,
        _instance = _instance
    }, module))
end

function module:connectEvent(arg1, arg2)
    self:_connect(arg1, self._instance[arg1], arg2)
end

function module:connectPropertyChange(arg1, arg2)
    local success, result = pcall(self._instance.GetPropertyChangedSignal, self._instance, arg1)

    if not success then
        error(string.format("Cannot get changed signal on property %q: %s", tostring(arg1), result), 0)
    end

    self:_connect("Change." .. arg1, result, arg2)
end

function module:_connect(arg1, rbxScriptSignal, arg2)
    if arg2 == nil then
        if self._connections[arg1] ~= nil then
            self._connections[arg1]:Disconnect()
            self._connections[arg1] = nil
        end

        self._listeners[arg1] = nil
        return
    end
    if self._connections[arg1] == nil then
        self._connections[arg1] = rbxScriptSignal:Connect(function(...)
            if self._status == "Enabled" then
                self._listeners[arg1](self._instance, ...)
                return
            end

            if self._status ~= "Suspended" then
                return
            end

            local select = select
            local var1 = select("#", ...)
            table.insert(self._suspendedEventQueue, { arg1, var1, ... })
        end)
    end

    self._listeners[arg1] = arg2
end

function module:suspend()
    self._status = "Suspended"
end

function module:resume()
    if self._isResuming then
        return
    end

    self._isResuming = true

    for _, value in self._suspendedEventQueue do
        local _listener = self._listeners[value[1]]
        local var1 = value[2]

        if _listener == nil then
            continue
        end

        local thread = coroutine.create(_listener)
        local resume2 = coroutine.resume

        local _instance = self._instance
        local var2 = 2 + var1
        local var3, var4 = resume2(thread, _instance, unpack(value, 3, var2))

        if not var3 then
            console.warn("%s", var4)
        end
    end

    self._isResuming = false
    self._status = "Enabled"
    table.clear(self._suspendedEventQueue)
end

return module
