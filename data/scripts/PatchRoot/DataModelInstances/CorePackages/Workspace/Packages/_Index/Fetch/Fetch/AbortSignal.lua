-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Error = require(scriptParentParent.LuauPolyfill).Error

local AbortSignal = {}
AbortSignal.__index = AbortSignal

function AbortSignal.new()
    local result = {}
    setmetatable(result, AbortSignal)

    result.aborted = false
    result.reason = Error.new("Undefined Error")

    result._signal = Instance.new("BindableEvent")

    return result
end

function AbortSignal.abort(reason)
    local var1 = AbortSignal.new()
    var1.reason = reason or Error.new("Signal Aborted")
    return var1
end

function AbortSignal.timeout(num1: number)
    local var1 = AbortSignal.new()
    var1.reason = Error.new("TimeoutError")
    task.delay(num1 / 1000, function()
        var1:fire()
    end)
    return var1
end

function AbortSignal:throwIfAborted()
    if self.aborted then
        error(self.reason)
    end
end

function AbortSignal:connect(arg1)
    return self._signal.Event:Connect(arg1)
end

function AbortSignal:fire()
    self.aborted = true
    self._signal:Fire()
end

return { AbortSignal = AbortSignal }
