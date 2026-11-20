-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)

local module = {}
module.__index = module

function module.new(_statType, _numSamples, _pauseBetweenSamples)
    local result = {}
    setmetatable(result, module)

    result._statType = _statType
    result._numSamples = _numSamples
    result._pauseBetweenSamples = _pauseBetweenSamples

    result._statName = StatsUtils.StatNames[result._statType]
    result._statMaxName = StatsUtils.StatMaxNames[result._statType]

    result._samples = {}
    for i = 0, _numSamples - 1 do
        result._samples[i] = 0
    end
    result._oldestIndex = 0

    result._listeners = {}

    result._nextListenerId = 1001

    return result
end

function module:AddListener(arg1)
    local _nextListenerId = self._nextListenerId
    self._nextListenerId += 1
    self._listeners[_nextListenerId] = arg1
    return _nextListenerId
end

function module:RemoveListener(arg1)
    self._listeners[arg1] = nil
end

function module:_notifyAllListeners()
    for _, _listener in pairs(self._listeners) do
        _listener()
    end
end

function module.StartListening(arg1)
    if arg1._listening == true then
        return
    end

    spawn(function()
        arg1._listening = true
        while arg1._listening do
            local var1 = arg1:_getStatValue()
            arg1:_storeStatValue(var1)
            arg1:_notifyAllListeners()
            wait(arg1._pauseBetweenSamples)
        end
    end)
end

function module.StopListening(arg1)
    arg1._listening = false
end

function module:GetValues()
    local values = {}

    for i = 0, self._numSamples - 1 do
        local var1 = (self._oldestIndex + i) % self._numSamples
        values[i + 1] = self._samples[var1]
    end
    return values
end

function module:GetAverage()
    local num1 = 0
    for i = 0, self._numSamples - 1 do
        num1 += self._samples[i]
    end
    return num1 / self._numSamples
end

function module:GetLatestValue()
    local var1 = (self._oldestIndex + self._numSamples - 1) % self._numSamples
    return self._samples[var1]
end

function module:_storeStatValue(arg1)
    self._samples[self._oldestIndex] = arg1
    self._oldestIndex = (self._oldestIndex + 1) % self._numSamples
end

function module:_getStatValue()
    local Stats = game:GetService("Stats")
    if Stats == nil then
        return 0
    end

    local performanceStats = Stats:FindFirstChild("PerformanceStats")
    if performanceStats == nil then
        return 0
    end

    local var1 = performanceStats:FindFirstChild(self._statName)
    if var1 == nil then
        return 0
    end

    return var1:GetValue()
end

function module:GetTarget()
    local Stats = game:GetService("Stats")
    if Stats == nil then
        return 0
    end

    local performanceStats = Stats:FindFirstChild("PerformanceStats")
    if performanceStats == nil then
        return 0
    end

    local var1 = performanceStats:FindFirstChild(self._statMaxName)
    if var1 == nil then
        return 0
    end

    return var1:GetValue()
end

return module
