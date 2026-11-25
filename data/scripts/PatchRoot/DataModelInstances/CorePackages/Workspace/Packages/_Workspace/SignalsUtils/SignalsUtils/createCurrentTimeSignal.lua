-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RunService = game:GetService("RunService")

local SignalsUtilsParent = script:FindFirstAncestor("SignalsUtils").Parent
local Signals = require(SignalsUtilsParent.Signals)

local var1 = (setmetatable({}, { __mode = "v" }))
local var2 = nil

local function maybeDisconnect() -- Luacid: Inlined by compiler; 1 call site recovered
    if next(var1) == nil and var2 then
        var2:Disconnect()
        var2 = nil
    end
end

local function onHeartbeat()
    maybeDisconnect()

    if not var2 then
        return
    end

    local lastTick = os.clock()
    for value, value2 in var1 do
        if value <= lastTick - value2.lastTick then
            value2.lastTick = lastTick
            value2.setter(DateTime.now().UnixTimestamp)
        end
    end
end

local function ensureConnection() -- Luacid: Inlined by compiler; 1 call site recovered
    var2 = var2 or RunService.Heartbeat:Connect(onHeartbeat)
end

local function createCurrentTimeSignal(num1: number?)
    local num2 = num1 or 30

    if not var1[num2] then
        local getter, setter = Signals.createSignal(DateTime.now().UnixTimestamp)
        var1[num2] = {
            getter = getter,
            setter = setter,
            lastTick = os.clock()
        }
        ensureConnection()
    end

    local var3 = var1[num2]

    return function(arg1)
        return var3.getter(arg1)
    end
end

return createCurrentTimeSignal
