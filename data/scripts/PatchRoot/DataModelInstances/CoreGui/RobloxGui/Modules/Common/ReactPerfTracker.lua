-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local num1 = game:DefineFastInt("ReactPerfTrackerKibana", 0)

function applicationId()
    local AppStorageService = game:GetService("AppStorageService")
    if not AppStorageService then
        return nil
    end

    local item = AppStorageService:GetItem("AppInstallationId")
    local str1 = typeof(item)

    if str1 == "number" then
        return tonumber(item) or nil
    end

    if str1 ~= "string" then
        return nil
    end

    if string.len(item) <= 0 then
        return nil
    end

    return tonumber(string.sub(item, -string.len(tostring(1000))))
end

if not (num1 > 0) then
    return nil
end

local num2 = math.random(0, 1000)
local var1 = applicationId()
if var1 ~= nil then
    num2 = (var1 + 327) % 1000
end

if not ((if num2 < num1 then num1 else 0) > 0) then
    return nil
end

local CorePackages = game:GetService("CorePackages")
local LoggingProtocol = require(CorePackages.Workspace.Packages.LoggingProtocol)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local tbl1 = {
    eventName = "ReactCoreScriptPerformance",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = 10000,
    lastUpdated = { 24, 10, 4 },
    description = "Reporting the time utilization of React in CoreScripts",
    links = ""
}

local module = {}
module.__index = module

function module.new()
    return (setmetatable({
        totalTime = 0,
        componentTotalTime = {},
        componentMaxTime = {},
        componentCount = {},
        sampleCount = 0,
        loggingProtocol = LoggingProtocol.default,
        outgoingEvents = {},
        nextSendTime = 0,
        previousSendTime = 0
    }, module))
end

function module.start(arg1)
    arg1.eventSender = coroutine.create(function()
        while true do
            while true do
                local var2 = table.remove(arg1.outgoingEvents, 1)
                if not var2 then
                    break
                end

                wait()
                arg1.loggingProtocol:logRobloxTelemetryEvent(tbl1, {}, var2)
            end
            coroutine.yield()
        end
    end)

    ReactRoblox.robloxReactProfiling.startTimerSampling(function(tbl2)
        local id = tbl2.id
        local var2 = (tbl2.endTime - tbl2.startTime) * 1000

        if not arg1.componentTotalTime[id] then
            arg1.componentTotalTime[id] = 0
            arg1.componentMaxTime[id] = 0
            arg1.componentCount[id] = 0
        end

        local componentTotalTime = arg1.componentTotalTime
        componentTotalTime[id] += var2
        local componentCount = arg1.componentCount
        componentCount[id] += 1
        local var3 = arg1
        var3.sampleCount += 1
        local var4 = arg1
        var4.totalTime += var2
        local componentMaxTime = arg1.componentMaxTime
        componentMaxTime[id] = math.max(arg1.componentMaxTime[id], var2)

        if not (tbl2.startTime >= arg1.nextSendTime) then
            return
        end

        if arg1.nextSendTime > 0 then
            arg1:sendEvents()
        end
        arg1.previousSendTime = arg1.nextSendTime

        if arg1.previousSendTime == 0 then
            arg1.previousSendTime = tbl2.startTime
        end
        arg1.nextSendTime = tbl2.startTime + 30
    end)
end

function module:genEvents()
    local num3 = 0
    for component, _ in self.componentCount do
        num3 += 1
        table.insert(self.outgoingEvents, {
            sessionid = if RbxAnalyticsService then RbxAnalyticsService:GetSessionId() else "",
            component = component,
            time_ms_max = self.componentMaxTime[component],
            time_ms_avg = self.componentTotalTime[component] / self.componentCount[component],
            total_time_ms = self.componentTotalTime[component],
            total_time_pct = self.componentTotalTime[component] / self.totalTime,
            count = self.componentCount[component],
            count_pct = self.componentCount[component] / self.sampleCount
        })
    end
    table.insert(self.outgoingEvents, 1, {
        summary_sessionid = if RbxAnalyticsService then RbxAnalyticsService:GetSessionId() else "",
        summary_total_time_ms = self.totalTime,
        summary_sample_time_s = self.nextSendTime - self.previousSendTime,
        summary_num_components = num3,
        summary_sample_count = self.sampleCount
    })
end

function module:sendEvents()
    if self.sampleCount == 0 then
        return
    end

    self:genEvents()
    self:resetCounts()

    coroutine.resume(self.eventSender)
end

function module:resetCounts()
    self.componentTotalTime = {}
    self.componentMaxTime = {}
    self.componentCount = {}
    self.sampleCount = 0
    self.totalTime = 0
end

return module
