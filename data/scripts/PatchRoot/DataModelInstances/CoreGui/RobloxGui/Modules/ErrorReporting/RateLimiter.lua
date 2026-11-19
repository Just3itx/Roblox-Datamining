-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")

local t = require(CorePackages.Packages.t)

local var1 = t.strictInterface({ period = t.number, threshold = t.number, processInterval = t.number })

local module = {}
module.__index = module

function module.new(arg1)
    assert(var1(arg1))

    return (setmetatable({
        _period = arg1.period,
        _threshold = arg1.threshold,
        _processInterval = arg1.processInterval,
        _lastProcessed = 0,
        _counts = {},
        _lastOccurrences = {}
    }, module))
end

function module:increment(arg1, arg2)
    arg2 = arg2 or os.clock()
    self._lastOccurrences[arg1] = arg2

    if self._counts[arg1] == nil then
        self._counts[arg1] = 1
        return
    end
    local _counts = self._counts
    _counts[arg1] += 1
end

function module:isRateLimited(arg1): boolean
    local _count = self._counts[arg1]
    return not (_count == nil) and self._threshold < _count
end

function module.startDecrementClock(arg1)
    arg1._decrementConnection = RunService.Heartbeat:Connect(function()
        arg1:stepDecrementClock(os.clock())
    end)
end

function module:stepDecrementClock(_lastProcessed)
    if not (_lastProcessed - self._lastProcessed > self._processInterval) then
        return
    end

    for k, value in pairs(self._lastOccurrences) do
        if not (_lastProcessed - value > self._period) then
            continue
        end

        local _counts = self._counts
        _counts[k] -= 1

        if self._counts[k] <= 0 then
            self._counts[k] = nil
            self._lastOccurrences[k] = nil
        end
    end

    self._lastProcessed = _lastProcessed
end

return module
