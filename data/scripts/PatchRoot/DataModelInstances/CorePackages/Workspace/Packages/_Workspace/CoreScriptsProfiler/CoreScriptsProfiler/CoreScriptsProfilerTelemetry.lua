-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsProfiler = require(script.Parent.CoreScriptsProfiler)
local ProfilerDataParser = require(script.Parent.ProfilerDataParser)
local TelemetryService = game:GetService("TelemetryService")

local CoreScriptsProfilerParent = script:FindFirstAncestor("CoreScriptsProfiler").Parent
local DeviceTier = require(CoreScriptsProfilerParent.Devices).DeviceTier

game:DefineFastInt("CoreScriptsProfilerSamplingHundredthsPercentv1", 0)

local num1 = game:DefineFastInt("CoreScriptsProfilerDelaySeconds", 5)
local num2 = game:DefineFastInt("CoreScriptsProfilerDurationSeconds", 10)
local num3 = game:DefineFastInt("CoreScriptsProfilerTelemetryLimit", 20)

if not (math.random(0, 10000) <= game:GetFastInt("CoreScriptsProfilerSamplingHundredthsPercentv1")) then
    return nil
end

local config = {
    eventName = "CorescriptPackageStats",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 11, 25 },
    description = "Task stats for each corescript package, all in milliseconds",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/4084400405/Lua+time+break-down+CoreScriptsProfiler"
}

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(context: string?)
    return (setmetatable({ profiler = nil, profilingActive = false, context = context }, tbl1))
end

function tbl1:start()
    self.profiler = CoreScriptsProfiler.new(function(_: boolean, str1: string)
        self:reportResults(str1)

        self:cleanup()
    end)

    task.delay(num1, function()
        self:startProfilingSession()
    end)
end

function tbl1:startProfilingSession()
    if self.profilingActive or not self.profiler then
        return
    end

    self.profilingActive = true
    self.profiler:ClientStart()

    task.delay(num2, function()
        self:stopProfilingSession()
    end)
end

function tbl1:stopProfilingSession()
    if self.profilingActive and self.profiler then
        self.profiler:ClientStop()
        self.profilingActive = false
    end
end

local function sortPackageStatsByDuration(packageStatistics)
    local result = {}

    for packageName, packageStatistic in packageStatistics do
        table.insert(
            result,
            {
                packageName = packageName,
                count = packageStatistic.count,
                totalDuration = packageStatistic.totalDuration
            }
        )
    end

    table.sort(result, function(arg1, arg2): boolean
        return arg1.totalDuration > arg2.totalDuration
    end)

    return result
end

function tbl1:reportResults(str1: string)
    local packageStatistics = ProfilerDataParser.new(str1):getPackageStatistics()

    local tbl2 = sortPackageStatsByDuration(packageStatistics)

    local num4 = math.min(#tbl2, num3)

    local deviceTier = DeviceTier.GetDeviceMemoryTier()

    for i = 1, num4 do
        local var1 = tbl2[i]

        local customFields = {
            packageName = var1.packageName,
            context = self.context
        }
        customFields.deviceTier = deviceTier

        TelemetryService:LogStat(config, { customFields = customFields }, var1.totalDuration * 1000)
    end
end

function tbl1:cleanup()
    if self.profiler then
        self.profiler:Disconnect()
        self.profiler = nil
        self.profilingActive = false
    end
end

local var1 = nil

return function(str1: string?)
    var1 = var1 or tbl1.new(str1)

    return var1
end
