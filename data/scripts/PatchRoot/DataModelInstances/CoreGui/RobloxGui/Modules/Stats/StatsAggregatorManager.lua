-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local StatsAggregator = require(CoreGui.RobloxGui.Modules.Stats.StatsAggregator)

local GetFFlagLazyPerfStatsInit = require(CoreGui.RobloxGui.Modules.Flags.GetFFlagLazyPerfStatsInit)

local module = {}
module.__index = module

module.SecondsBetweenUpdate = 1
module.NumSamplesToKeep = 20

local var1 = nil

function module.getSingleton()
    if var1 == nil then
        var1 = module.__new()
        if not GetFFlagLazyPerfStatsInit() then
            var1:StartListening()
        end
    end
    return var1
end

function module.__new()
    local result = {}
    setmetatable(result, module)

    result._statsAggregators = {}

    for _, value in ipairs(StatsUtils.AllStatTypes) do
        local statsAggregator = StatsAggregator.new(value, module.NumSamplesToKeep, module.SecondsBetweenUpdate)
        result._statsAggregators[value] = statsAggregator
    end

    return result
end

function module:StartListening()
    for _, _statsAggregator in pairs(self._statsAggregators) do
        _statsAggregator:StartListening()
    end
end

function module:StopListening()
    for _, _statsAggregator in pairs(self._statsAggregators) do
        _statsAggregator:StopListening()
    end
end

function module:GetAggregator(arg1)
    return self._statsAggregators[arg1]
end

return module
