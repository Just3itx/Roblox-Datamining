-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local scriptParentParent = script.Parent.Parent
local _AppCommonLib = require(scriptParentParent.AppCommonLib)
local LoggingProtocol = require(scriptParentParent.LoggingProtocol)
local isReactProfilingEnabled = require(scriptParentParent.RoactUtils).Profiling.isReactProfilingEnabled

local bool1 = game:DefineFastFlag("SupportTerminalMilestoneInReactProfilerLogger", false)

local num1 = game:DefineFastInt("AppLaunchReactProfilerLoggerCollectionTimeoutSec", 30)
local str1 = game:DefineFastString(
    "SupportedAppLaunchMilestonesForReactProfilerLogger",
    "lua_app_starter_script_requires_end,fetch_homepage_data_begin,fetch_homepage_data_end,home_page_interactive"
)

local function getSupportedMilestones() -- Luacid: Inlined by compiler; 1 call site recovered
    local supportedMilestones = ({})
    for _, value in (str1:split(",")) do
        supportedMilestones[value] = true
    end
    return supportedMilestones
end

local tbl1 = {
    eventName = "AppLaunchReactProfilerUpdateCount",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 2, 25 },
    throttlingPercentage = 0
}

local tbl2 = {
    eventName = "AppLaunchReactProfilerRenderDuration",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 2, 25 },
    throttlingPercentage = 0
}

local tbl3 = {
    eventName = "AppLaunchReactProfilerCommitDuration",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 2, 25 },
    throttlingPercentage = 0
}

local tbl4 = {
    eventName = "AppLaunchReactProfilerExclusiveRenderDuration",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 2, 25 },
    throttlingPercentage = 0
}

local tbl5 = {
    eventName = "AppLaunchReactProfilerExclusiveCommitDuration",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 2, 25 },
    throttlingPercentage = 0
}

local function logProfilerData(tbl6)
    if next(tbl6) == nil then
        return
    end

    for _, value in tbl6 do
        TelemetryService:LogStat(
            tbl1,
            {
                customFields = {
                    profilerId = value.profilerId,
                    milestoneName = value.milestoneName
                }
            },
            value.updateCount
        )
        TelemetryService:LogStat(
            tbl2,
            {
                customFields = {
                    profilerId = value.profilerId,
                    milestoneName = value.milestoneName
                }
            },
            value.renderDuration
        )
        TelemetryService:LogStat(
            tbl3,
            {
                customFields = {
                    profilerId = value.profilerId,
                    milestoneName = value.milestoneName
                }
            },
            value.commitDuration
        )
        TelemetryService:LogStat(
            tbl4,
            {
                customFields = {
                    profilerId = value.profilerId,
                    milestoneName = value.milestoneName
                }
            },
            value.exclusiveRenderDuration
        )
        TelemetryService:LogStat(
            tbl5,
            {
                customFields = {
                    profilerId = value.profilerId,
                    milestoneName = value.milestoneName
                }
            },
            value.exclusiveCommitDuration
        )
    end
end

local function createProfilerData(profilerId: string, milestoneName: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        profilerId = profilerId,
        milestoneName = milestoneName,
        updateCount = 0,
        renderDuration = 0,
        commitDuration = 0,
        exclusiveRenderDuration = 0,
        exclusiveCommitDuration = 0
    }
end

local function updateProfilerData(tbl6, tbl7) -- Luacid: Inlined by compiler; 2 call sites recovered
    tbl6.updateCount += 1
    tbl6.renderDuration += tbl7.render.duration
    tbl6.commitDuration += tbl7.commit.duration
    tbl6.exclusiveRenderDuration += tbl7.render.exclusiveDuration
    tbl6.exclusiveCommitDuration += tbl7.commit.exclusiveDuration
end

local function createAppLaunchReactProfilerLogger(arg1, str2: string?)
    if not isReactProfilingEnabled then
        return
    end

    local tbl6 = ({})

    local tbl7 = {}

    local function correlateProfilerData()
        local result = {}

        for profilerId, value2 in tbl6 do
            local value2Len = #value2
            local num2 = #tbl7
            local num3 = 1
            local num4 = 1
            local var1 = nil
            local tbl8 = createProfilerData(profilerId, "aggregate")

            while num3 <= value2Len and num4 <= num2 do
                local var2 = value2[num3]
                local var3 = tbl7[num4]
                if var1 == nil then
                    var1 = createProfilerData(profilerId, var3.eventName)
                end

                if var2.render.startTime < var3.eventTime then
                    updateProfilerData(var1, var2)
                    updateProfilerData(tbl8, var2)
                    num3 += 1
                else
                    if var1.updateCount > 0 then
                        table.insert(result, var1)
                    end
                    num4 += 1
                    var1 = nil
                end
            end

            if var1 and var1.updateCount > 0 then
                table.insert(result, var1)
            end

            if tbl8.updateCount > 0 then
                table.insert(result, tbl8)
            end
        end

        tbl6 = {}
        tbl7 = {}

        return result
    end

    local function getOrCreateEventsForProfiler(profilerId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl8 = tbl6[profilerId]
        if tbl8 == nil then
            tbl8 = {}
            tbl6[profilerId] = tbl8
        end
        return tbl8
    end

    local connection = arg1.onRender:connect(function(render)
        table.insert(getOrCreateEventsForProfiler(render.profilerId), {
            render = render,
            commit = {
                profilerId = render.profilerId,
                commitTime = render.commitTime,
                duration = 0,
                exclusiveDuration = 0
            }
        })
    end)

    local connection2 = arg1.onCommit:connect(function(commit)
        local orCreateEventsForProfiler = getOrCreateEventsForProfiler(commit.profilerId)
        local var1 = orCreateEventsForProfiler[#orCreateEventsForProfiler]
        if var1 ~= nil and var1.render.commitTime == commit.commitTime then
            var1.commit = commit
            return
        end
        warn("Profiler invariants are broken")
    end)

    local var1 = nil

    if bool1 then
        local supportedMilestones = getSupportedMilestones()

        var1 = LoggingProtocol.default:setDurationLoggerListener(function(eventName: string)
            if supportedMilestones[eventName] then
                local eventTime = os.clock() * 1000
                table.insert(tbl7, { eventName = eventName, eventTime = eventTime })
            end

            if str2 ~= nil and eventName == str2 and var1 ~= nil then
                var1:disconnect()
                var1 = nil
            end
        end)
    else
        var1 = LoggingProtocol.default:setDurationLoggerListener(function(eventName: string)
            local eventTime = os.clock() * 1000
            table.insert(tbl7, { eventName = eventName, eventTime = eventTime })
        end)
    end

    local function disconnectListeners() -- Luacid: Inlined by compiler; 1 call site recovered
        if connection ~= nil then
            connection:disconnect()
            connection = nil
        end
        if connection2 ~= nil then
            connection2:disconnect()
            connection2 = nil
        end
        if var1 ~= nil then
            var1:disconnect()
            var1 = nil
        end
    end

    task.delay(num1, function()
        disconnectListeners()
        local tbl8 = correlateProfilerData()
        logProfilerData(tbl8)
    end)
end

return createAppLaunchReactProfilerLogger
