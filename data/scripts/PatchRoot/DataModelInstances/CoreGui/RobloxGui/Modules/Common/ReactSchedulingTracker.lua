-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RunService = game:GetService("RunService")

local num1 = game:DefineFastInt("ReactSchedulingTracker", 0)
local num2 = game:DefineFastInt("ReactSchedulingTrackerPeriodMs", 30000)
local engineFeature = game:GetEngineFeature("TelemetryServiceMemoryCPUInfoEnabled")
local bool1 = game:DefineFastFlag("DisableReactSchedulingTimePctStats", false)
local bool2 = game:DefineFastFlag("DisableReactSchedulingAvgMaxMsStats", false)
local FStringReactSchedulingContext = require(CorePackages.Workspace.Packages.SharedFlags).FStringReactSchedulingContext
local str1 = game:DefineFastString("ReactSchedulingPercentiles", "10,50,95,99")
local num3 = game:DefineFastInt("ReactSchedulingKllSketchMaxSize", 200)
local bool3 = game:DefineFastFlag("DebugReactSchedulingEnableErrorEvents", false)
local bool4 = game:DefineFastFlag("ReactSchedulingTrackerLayoutEffects", false)
local bool5 = game:DefineFastFlag("ReactSchedulingTrackerDataModelUpdate", false)
local engineFeature2 = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")
local bool6 = game:DefineFastFlag("EnableCorescriptExecutionTime", false)
local engineFeature3 = game:GetEngineFeature("ScriptPlusExecutionTimeEnabled")

function applicationId()
    local AppStorageService = game:GetService("AppStorageService")
    if not AppStorageService then
        return nil
    end

    local item = AppStorageService:GetItem("AppInstallationId")
    local str2 = typeof(item)

    if str2 == "number" then
        return tonumber(item) or nil
    end

    if str2 ~= "string" then
        return nil
    end

    if string.len(item) <= 0 then
        return nil
    end

    return tonumber(string.sub(item, -string.len(tostring(10000))))
end

local bool7 = num1 > 0
local bool8 = true
local bool9 = true

if not bool7 then
    bool9 = false
    bool8 = false
end

local num4 = math.random(0, 10000)
local var1 = applicationId()
if var1 ~= nil then
    num4 = (var1 + 1409) % 10000
end

if not (num4 < num1) then
    bool9 = false
    bool8 = false
end

local TelemetryService = game:GetService("TelemetryService")
local mutedError = require(CorePackages.Workspace.Packages.Loggers).mutedError
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)
local _ReactReconciler = require(CorePackages.Packages.ReactReconciler)
local KllSketch = require(CorePackages.Workspace.Packages.InExperiencePerformance).KllSketch

local tbl1 = string.split(str1)
local CorePackages2 = game:GetService("CorePackages")
local DeviceTier = require(CorePackages2.Workspace.Packages.Devices).DeviceTier

local schedulingProfiler = ReactRoblox.schedulingProfiler
local profilerEventTypes = schedulingProfiler.profilerEventTypes

local function getCurrentTimeMs(): number -- Luacid: Inlined by compiler; 16 call sites recovered
    return os.clock() * 1000
end

local deviceTier = DeviceTier.GetDeviceMemoryTier()

local tbl2 = {}
tbl2.__index = tbl2

function tbl2.new(frameReporter: (...any) -> (...any), rootReporter: (...any) -> (...any))
    return (setmetatable({
        frameReporter = frameReporter,
        rootReporter = rootReporter,
        currentState = "Idle",
        timerStartMs = 0,
        layoutTimerStartMs = if bool4 then 0 else nil,
        rootUpdateInProgress = false,
        rootUpdateTime = {
            tag = "RootUpdateTime",
            RenderMs = 0,
            CommitMs = 0,
            LayoutEffectsMs = if bool4 then 0 else nil,
            StartTimeMs = 0
        },
        rootPassiveEffectsTime = { tag = "RootPassiveEffectsTime", PassiveEffectsMs = 0 },
        renderLevel = 0,
        states = {
            Idle = function(arg1, num5: number)
                if num5 == profilerEventTypes.RenderStart then
                    arg1.timerStartMs = getCurrentTimeMs()
                    if not arg1.rootUpdateInProgress then
                        arg1.rootUpdateInProgress = true
                        arg1.rootUpdateTime = {
                            tag = "RootUpdateTime",
                            RenderMs = 0,
                            CommitMs = 0,
                            LayoutEffectsMs = if bool4 then 0 else nil,
                            StartTimeMs = getCurrentTimeMs()
                        }
                    end
                    return "Render"
                elseif num5 == profilerEventTypes.PassiveEffectsStart then
                    arg1.timerStartMs = getCurrentTimeMs()
                    arg1.rootPassiveEffectsTime = {
                        tag = "RootPassiveEffectsTime",
                        PassiveEffectsMs = 0
                    }

                    return "PassiveEffects"
                else
                    if num5 ~= profilerEventTypes.CommitStart then
                        return nil
                    end

                    arg1.timerStartMs = getCurrentTimeMs()
                    return "Commit"
                end
            end,
            Render = function(arg1, num5: number): string
                if num5 ~= profilerEventTypes.RenderYield and num5 ~= profilerEventTypes.RenderStop then
                    mutedError("Invalid event in Render: " .. num5)
                    return "Idle"
                end

                local var2 = getCurrentTimeMs() - arg1.timerStartMs
                local rootUpdateTime = arg1.rootUpdateTime
                rootUpdateTime.RenderMs += var2
                arg1.frameReporter(var2)
                return "Idle"
            end,
            Commit = function(arg1, num5: number, arg2)
                if num5 == profilerEventTypes.CommitStop then
                    if arg1.renderLevel > 0 then
                        if bool4 and arg1.renderLevel == 1 then
                            local rootUpdateTime = arg1.rootUpdateTime
                            rootUpdateTime.LayoutEffectsMs += getCurrentTimeMs() - arg1.layoutTimerStartMs
                        end

                        arg1.renderLevel -= 1
                        return nil
                    end

                    local var2 = getCurrentTimeMs() - arg1.timerStartMs
                    local rootUpdateTime = arg1.rootUpdateTime
                    rootUpdateTime.CommitMs += var2
                    arg1.frameReporter(var2)
                    arg1.rootReporter(arg1.rootUpdateTime, arg2)
                    arg1.rootUpdateInProgress = false
                    return "Idle"
                end

                if num5 == profilerEventTypes.RenderStart then
                    arg1.renderLevel += 1
                    if bool4 and arg1.renderLevel == 1 then
                        arg1.layoutTimerStartMs = getCurrentTimeMs()
                    end
                    return nil
                end

                if bool4 and (num5 == profilerEventTypes.LayoutEffectsStart or num5 == profilerEventTypes.PassiveEffectsStart) then
                    if arg1.renderLevel == 0 then
                        arg1.layoutTimerStartMs = getCurrentTimeMs()
                    end
                    return nil
                end

                if bool4 and (num5 == profilerEventTypes.LayoutEffectsStop or num5 == profilerEventTypes.PassiveEffectsStop) then
                    if arg1.renderLevel == 0 then
                        local rootUpdateTime = arg1.rootUpdateTime
                        rootUpdateTime.LayoutEffectsMs += getCurrentTimeMs() - arg1.layoutTimerStartMs
                    end
                    return nil
                end

                if num5 ~= profilerEventTypes.RenderYield then
                    return nil
                end

                mutedError("Invalid event in Commit: " .. num5)
                return "Idle"
            end,
            PassiveEffects = function(arg1, passiveEffectsStop: number, arg2): string
                if passiveEffectsStop ~= profilerEventTypes.PassiveEffectsStop then
                    mutedError("Invalid event in PassiveEffects: " .. passiveEffectsStop)
                    return "Idle"
                end

                local var2 = getCurrentTimeMs() - arg1.timerStartMs
                local rootPassiveEffectsTime = arg1.rootPassiveEffectsTime
                rootPassiveEffectsTime.PassiveEffectsMs += var2
                arg1.frameReporter(var2)
                arg1.rootReporter(arg1.rootPassiveEffectsTime, arg2)
                return "Idle"
            end
        }
    }, tbl2))
end

function tbl2:transition(num5: number, arg1)
    local currentState = self.currentState
    local var2 = self.states[currentState](self, num5, arg1)
    if var2 then
        self.currentState = var2
    end
end

local tbl3 = {
    "addPlaceId",
    "addUniverseId",
    "addSessionId",
    "addOSInfo",
    "addSessionInfo"
}
tbl3 = engineFeature
    and {
        "addPlaceId",
        "addUniverseId",
        "addSessionId",
        "addOSInfo",
        "addSessionInfo",
        "addMemoryInfo",
        "addCPUInfo"
    }
    or tbl3

if engineFeature2 then
    table.insert(tbl3, "addPlaySessionId")
end

local config = {
    eventName = "ReactSessionSummary",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("ReactSessionSummaryEventThrottleHunderedthsPercent", 0),
    lastUpdated = { 2025, 7, 10 },
    description = "Summary of React performance over a game session",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
}

local config2 = nil
config2 = bool3
    and {
        eventName = "ReactSessionErrorEvent",
        backends = { "EventIngest" },
        throttlingPercentage = game:DefineFastInt("DebugReactSessionErrorEventThrottleHunderedthsPercent", 0),
        lastUpdated = { 2025, 8, 7 },
        description = "Summary of React performance over a game session",
        links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
    }
    or config2

local config3 = {
    eventName = "ReactPeriodSummary",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("ReactPeriodSummaryEventThrottleHunderedthsPercent", 0),
    lastUpdated = { 2025, 2, 18 },
    description = "Summary of React performance over a period",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
}

local config4 = {
    eventName = "ReactPeriod",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 2, 18 },
    description = "Stats for React performance over a period",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
}

local tbl4 = {
    eventName = "ReactFrameCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2025, 2, 18 },
    description = "Frame counts for React performance over a period",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
}

local config5 = {
    eventName = "ReactRootSummary",
    backends = { "EventIngest" },
    lastUpdated = { 2025, 2, 18 },
    throttlingPercentage = game:DefineFastInt("ReactRootSummaryEventThrottleHunderedthsPercent2", 0),
    description = "Summary of React performance for a root",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
}

local var2 = nil
var2 = not bool1
    and {
        eventName = "ReactRootPeriod",
        backends = { "RobloxTelemetryStat" },
        lastUpdated = { 2025, 2, 18 },
        description = "Stats for React performance for a root over a period",
        links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
    }
    or var2

local tbl5 = {
    eventName = "ReactRootTaskCount",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2025, 2, 18 },
    description = "Task counts for React performance for a root over a period",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
}

local var3 = nil
var3 = not bool2
    and {
        eventName = "ReactRootPeriodTask",
        backends = { "RobloxTelemetryStat" },
        lastUpdated = { 2025, 2, 18 },
        description = "Task stats for React performance for a root over a period",
        links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
    }
    or var3

local config6 = {
    eventName = "ReactRootUpdate",
    backends = { "RobloxTelemetryStat" },
    lastUpdated = { 2025, 2, 18 },
    description = "Task stats for individual React root updates, all in milliseconds",
    links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/3321660204/React+Profiler+Metric+Issues+and+Path+Forward#New-Metrics-%E2%9C%A8"
}

local tbl6 = {}
tbl6.__index = tbl6

function tbl6.new(context: string?)
    local sketches = ({})
    local tbl7 = ({})
    local tbl8 = ({})
    local tbl10 = ({})
    local tbl11 = ({})
    local tbl12 = ({})
    sketches.all = KllSketch.new(num3)
    tbl7.all = KllSketch.new(num3)
    tbl8.all = KllSketch.new(num3)
    if bool3 then
        tbl10.all = {}
        tbl11.all = {}
        tbl12.all = {}
    end

    local self = setmetatable({
        started = false,
        periodStartMs = 0,
        reactFrameTimeMs = 0,
        frameMetrics = {
            totalFrameCount = 0,
            reactFrameCount = 0,
            totalReactTimeMs = 0,
            totalCorescriptTimeMs = 0,
            maxReactFrameTimeMs = 0,
            allFrameHistogram = {
                0,
                0,
                0,
                0
            },
            reactFrameHistogram = {
                0,
                0,
                0,
                0
            },
            reactDropChangeHistogram = {
                0,
                0,
                0,
                0
            }
        },
        rootsMetrics = {},
        sessionMetrics = {
            updateTime = {
                sketches = sketches,
                allData = not bool3 and {} or tbl10,
                numRoots = 1
            },
            commitTime = {
                sketches = tbl7,
                allData = not bool3 and {} or tbl11,
                numRoots = 1
            },
            timeToUpdate = {
                sketches = tbl8,
                allData = not bool3 and {} or tbl12,
                numRoots = 1
            },
            timePerFrame = {
                sketch = KllSketch.new(num3),
                allData = {}
            },
            timePerReactFrame = {
                sketch = KllSketch.new(num3),
                allData = {}
            }
        },
        context = context
    }, tbl6)

    self.schedulerStateMachine = tbl2.new(function(arg1)
        self:addToFrame(arg1)
    end, function(arg1, arg2)
        self:trackSessionSketches(arg1, arg2)
        if bool9 then
            self:reportRoot(arg1, arg2)
        end
    end)

    return self
end

function tbl6:start()
    self.started = true
    self:resetState()

    schedulingProfiler.registerProfilerEventCallback(function(num5: number, arg1)
        self.schedulerStateMachine:transition(num5, arg1)
    end)

    RunService.Heartbeat:Connect(function(deltaTime: number)
        self:processFrame(deltaTime * 1000)
        self.reactFrameTimeMs = 0

        if not (getCurrentTimeMs() - self.periodStartMs > num2) then
            return
        end

        if bool8 then
            self:reportPeriod()
        end
        self:resetState()
    end)
end

function tbl6:resetState()
    self.periodStartMs = getCurrentTimeMs()
    self.frameMetrics = {
        totalFrameCount = 0,
        reactFrameCount = 0,
        totalReactTimeMs = 0,
        totalCorescriptTimeMs = 0,
        maxReactFrameTimeMs = 0,
        allFrameHistogram = {
            0,
            0,
            0,
            0
        },
        reactFrameHistogram = {
            0,
            0,
            0,
            0
        },
        reactDropChangeHistogram = {
            0,
            0,
            0,
            0
        }
    }
    self.rootsMetrics = {}
end

function tbl6:getRootName(arg1)
    local str2 = "Unknown"
    if arg1 then
        if arg1.containerInfo.Name ~= "Folder" then
            return arg1.containerInfo.Name
        end

        if arg1.current and arg1.current.child and arg1.current.child.memoizedProps then
            for k, _ in arg1.current.child.memoizedProps do
                if typeof(k) == "string" then
                    return k
                end
            end
        end
    end
    return str2
end

function tbl6:addToFrame(arg1)
    self.reactFrameTimeMs += arg1
end

function tbl6:trackSessionSketches(tbl7, arg1)
    if not self.sessionMetrics then
        return
    end

    local rootName = self:getRootName(arg1)

    if tbl7.tag ~= "RootUpdateTime" then
        return
    end

    local var4 = getCurrentTimeMs() - tbl7.StartTimeMs

    if bool3 then
        table.insert(self.sessionMetrics.updateTime.allData.all, tbl7.RenderMs + tbl7.CommitMs)
        table.insert(self.sessionMetrics.commitTime.allData.all, tbl7.CommitMs)
        table.insert(self.sessionMetrics.timeToUpdate.allData.all, var4)
    end

    self.sessionMetrics.updateTime.sketches.all:insert(tbl7.RenderMs + tbl7.CommitMs)
    self.sessionMetrics.commitTime.sketches.all:insert(tbl7.CommitMs)
    self.sessionMetrics.timeToUpdate.sketches.all:insert(var4)

    if not self.sessionMetrics.updateTime.sketches[rootName] then
        self.sessionMetrics.updateTime.sketches[rootName] = KllSketch.new(num3)
        if bool3 then
            self.sessionMetrics.updateTime.allData[rootName] = {}
        end
        local updateTime = self.sessionMetrics.updateTime
        updateTime.numRoots += 1
    end
    self.sessionMetrics.updateTime.sketches[rootName]:insert(tbl7.RenderMs + tbl7.CommitMs)
    if bool3 then
        table.insert(self.sessionMetrics.updateTime.allData[rootName], tbl7.RenderMs + tbl7.CommitMs)
    end

    if not self.sessionMetrics.commitTime.sketches[rootName] then
        self.sessionMetrics.commitTime.sketches[rootName] = KllSketch.new(num3)
        if bool3 then
            self.sessionMetrics.commitTime.allData[rootName] = {}
        end
        local commitTime = self.sessionMetrics.commitTime
        commitTime.numRoots += 1
    end
    self.sessionMetrics.commitTime.sketches[rootName]:insert(tbl7.CommitMs)
    if bool3 then
        table.insert(self.sessionMetrics.commitTime.allData[rootName], tbl7.CommitMs)
    end

    if not self.sessionMetrics.timeToUpdate.sketches[rootName] then
        self.sessionMetrics.timeToUpdate.sketches[rootName] = KllSketch.new(num3)
        if bool3 then
            self.sessionMetrics.timeToUpdate.allData[rootName] = {}
        end
        local timeToUpdate = self.sessionMetrics.timeToUpdate
        timeToUpdate.numRoots += 1
    end
    self.sessionMetrics.timeToUpdate.sketches[rootName]:insert(var4)
    if bool3 then
        table.insert(self.sessionMetrics.timeToUpdate.allData[rootName], var4)
    end
end

function tbl6:reportRoot(tbl7, arg1)
    local rootName = self:getRootName(arg1)
    if not self.rootsMetrics[rootName] then
        local rootsMetrics = self.rootsMetrics
        rootsMetrics[rootName] = {
            update_count = 0,
            layout_effects_count = if bool4 then 0 else nil,
            render_total_time_ms = 0,
            commit_total_time_ms = 0,
            layout_effects_total_time_ms = if bool4 then 0 else nil,
            data_model_update_total_time_ms = if bool4 then if bool5 then 0 else nil else nil,
            max_render_time_ms = 0,
            max_commit_time_ms = 0,
            max_update_time_ms = 0,
            max_layout_effects_time_ms = if bool4 then 0 else nil,
            max_data_model_update_time_ms = if bool4 then if bool5 then 0 else nil else nil,
            passive_effects_count = 0,
            passive_effects_total_time_ms = 0,
            max_passive_effects_time_ms = 0,
            total_time_to_update_ms = 0,
            max_time_to_update_ms = 0
        }
    end

    local rootsMetric = self.rootsMetrics[rootName]

    if tbl7.tag == "RootPassiveEffectsTime" then
        TelemetryService:LogStat(config6, {
            customFields = {
                rootName = rootName,
                deviceTier = deviceTier,
                updateType = "PassiveEffects",
                context = self.context
            }
        }, tbl7.PassiveEffectsMs)

        rootsMetric.passive_effects_count += 1
        rootsMetric.passive_effects_total_time_ms += tbl7.PassiveEffectsMs
        if tbl7.PassiveEffectsMs > rootsMetric.max_passive_effects_time_ms then
            rootsMetric.max_passive_effects_time_ms = tbl7.PassiveEffectsMs
        end

        return
    end
    if tbl7.tag ~= "RootUpdateTime" then
        return
    end

    local maxTimeToUpdateMs = getCurrentTimeMs() - tbl7.StartTimeMs
    TelemetryService:LogStat(config6, {
        customFields = {
            rootName = rootName,
            deviceTier = deviceTier,
            updateType = "TimeToComplete",
            context = self.context
        }
    }, maxTimeToUpdateMs)

    rootsMetric.total_time_to_update_ms += maxTimeToUpdateMs
    if rootsMetric.max_time_to_update_ms < maxTimeToUpdateMs then
        rootsMetric.max_time_to_update_ms = maxTimeToUpdateMs
    end

    TelemetryService:LogStat(config6, {
        customFields = {
            rootName = rootName,
            deviceTier = deviceTier,
            updateType = "RenderAndCommit",
            context = self.context
        }
    }, tbl7.RenderMs + tbl7.CommitMs)

    TelemetryService:LogStat(
        config6,
        {
            customFields = {
                rootName = rootName,
                deviceTier = deviceTier,
                updateType = "Commit",
                context = self.context
            }
        },
        tbl7.CommitMs
    )
    if bool4 then
        if tbl7.LayoutEffectsMs > 0 then
            TelemetryService:LogStat(config6, {
                customFields = {
                    rootName = rootName,
                    deviceTier = deviceTier,
                    updateType = "LayoutEffects",
                    context = self.context
                }
            }, tbl7.LayoutEffectsMs)
        end

        if bool5 then
            TelemetryService:LogStat(config6, {
                customFields = {
                    rootName = rootName,
                    deviceTier = deviceTier,
                    updateType = "DataModelUpdate",
                    context = self.context
                }
            }, tbl7.CommitMs - tbl7.LayoutEffectsMs)
        end
    end

    rootsMetric.update_count += 1
    if tbl7.RenderMs + tbl7.CommitMs > rootsMetric.max_update_time_ms then
        rootsMetric.max_update_time_ms = tbl7.RenderMs + tbl7.CommitMs
    end
    rootsMetric.render_total_time_ms += tbl7.RenderMs
    rootsMetric.commit_total_time_ms += tbl7.CommitMs
    if tbl7.RenderMs > rootsMetric.max_render_time_ms then
        rootsMetric.max_render_time_ms = tbl7.RenderMs
    end
    if tbl7.CommitMs > rootsMetric.max_commit_time_ms then
        rootsMetric.max_commit_time_ms = tbl7.CommitMs
    end
    if not bool4 then
        return
    end

    if tbl7.LayoutEffectsMs > 0 then
        rootsMetric.layout_effects_count += 1
        rootsMetric.layout_effects_total_time_ms += tbl7.LayoutEffectsMs
        if tbl7.LayoutEffectsMs > rootsMetric.max_layout_effects_time_ms then
            rootsMetric.max_layout_effects_time_ms = tbl7.LayoutEffectsMs
        end
    end
    if not bool5 then
        return
    end

    rootsMetric.data_model_update_total_time_ms += tbl7.CommitMs - tbl7.LayoutEffectsMs
    if tbl7.CommitMs - tbl7.LayoutEffectsMs > rootsMetric.max_data_model_update_time_ms then
        rootsMetric.max_data_model_update_time_ms = tbl7.CommitMs - tbl7.LayoutEffectsMs
    end
end

function tbl6:getFrameBucket(num5: number): number
    return math.min(4, math.floor(math.max(0, num5 - 2) / (50 / 3)) + 1)
end

function tbl6:processFrame(num5: number)
    local frameMetrics = self.frameMetrics
    local reactFrameTimeMs = self.reactFrameTimeMs
    if engineFeature3 and bool6 then
        local totalScriptPlusExecutionTime = RunService:GetTotalScriptPlusExecutionTime()
        if totalScriptPlusExecutionTime > 0 then
            frameMetrics.totalCorescriptTimeMs += totalScriptPlusExecutionTime
        end
    end

    frameMetrics.totalFrameCount += 1
    local frameBucket = self:getFrameBucket(num5)
    local allFrameHistogram = frameMetrics.allFrameHistogram
    allFrameHistogram[frameBucket] += 1
    self.sessionMetrics.timePerFrame.sketch:insert(reactFrameTimeMs)
    if bool3 then
        table.insert(self.sessionMetrics.timePerFrame.allData, reactFrameTimeMs)
    end

    if not (reactFrameTimeMs > 0) then
        return
    end
    frameMetrics.totalReactTimeMs += reactFrameTimeMs
    local reactFrameHistogram = frameMetrics.reactFrameHistogram
    reactFrameHistogram[frameBucket] += 1
    self.sessionMetrics.timePerReactFrame.sketch:insert(reactFrameTimeMs)
    if bool3 then
        table.insert(self.sessionMetrics.timePerReactFrame.allData, reactFrameTimeMs)
    end

    frameMetrics.reactFrameCount += 1
    if frameMetrics.maxReactFrameTimeMs < reactFrameTimeMs then
        frameMetrics.maxReactFrameTimeMs = reactFrameTimeMs
    end

    local var4 = frameBucket - self:getFrameBucket(num5 - reactFrameTimeMs)
    local reactDropChangeHistogram = frameMetrics.reactDropChangeHistogram
    local var5 = var4 + 1
    reactDropChangeHistogram[var5] += 1
end

function tbl6:reportPeriod()
    local frameMetrics = self.frameMetrics
    local periodLengthMs = getCurrentTimeMs() - self.periodStartMs
    local customFields = {
        period_length_ms = periodLengthMs,
        react_total_time_ms = frameMetrics.totalReactTimeMs,
        react_total_time_pct = frameMetrics.totalReactTimeMs / periodLengthMs,
        react_frame_count = frameMetrics.reactFrameCount,
        total_frame_count = frameMetrics.totalFrameCount,
        corescript_total_time_ms = frameMetrics.totalCorescriptTimeMs,
        corescript_total_time_pct = frameMetrics.totalCorescriptTimeMs / periodLengthMs,
        average_react_all_frame_ms = frameMetrics.totalReactTimeMs / frameMetrics.totalFrameCount,
        average_react_only_frame_ms = if frameMetrics.reactFrameCount > 0 then frameMetrics.totalReactTimeMs / frameMetrics.reactFrameCount else 0,
        max_react_frame_ms = frameMetrics.maxReactFrameTimeMs,
        all_frame_drop0 = frameMetrics.allFrameHistogram[1],
        all_frame_drop1 = frameMetrics.allFrameHistogram[2],
        all_frame_drop2 = frameMetrics.allFrameHistogram[3],
        all_frame_drop3 = frameMetrics.allFrameHistogram[4],
        react_frame_drop0 = frameMetrics.reactFrameHistogram[1],
        react_frame_drop1 = frameMetrics.reactFrameHistogram[2],
        react_frame_drop2 = frameMetrics.reactFrameHistogram[3],
        react_frame_drop3 = frameMetrics.reactFrameHistogram[4],
        react_drop_change0 = frameMetrics.reactDropChangeHistogram[1],
        react_drop_change1 = frameMetrics.reactDropChangeHistogram[2],
        react_drop_change2 = frameMetrics.reactDropChangeHistogram[3],
        react_drop_change3 = frameMetrics.reactDropChangeHistogram[4]
    }

    TelemetryService:LogEvent(config3, { standardizedFields = tbl3, customFields = customFields })

    TelemetryService:LogStat(
        config4,
        {
            customFields = {
                stat = "ReactTotalTimePct",
                context = self.context,
                deviceTier = deviceTier
            }
        },
        customFields.react_total_time_pct
    )
    if engineFeature3 and bool6 then
        TelemetryService:LogStat(
            config4,
            {
                customFields = {
                    stat = "TotalCorescriptTimePct",
                    context = self.context,
                    deviceTier = deviceTier
                }
            },
            customFields.corescript_total_time_pct
        )
    end
    TelemetryService:LogStat(
        config4,
        {
            customFields = {
                stat = "AverageReactAllFrameMs",
                context = self.context,
                deviceTier = deviceTier
            }
        },
        customFields.average_react_all_frame_ms
    )
    TelemetryService:LogStat(
        config4,
        {
            customFields = {
                stat = "AverageReactOnlyFrameMs",
                context = self.context,
                deviceTier = deviceTier
            }
        },
        customFields.average_react_only_frame_ms
    )
    TelemetryService:LogStat(
        config4,
        {
            customFields = {
                stat = "MaxReactFrameMs",
                context = self.context,
                deviceTier = deviceTier
            }
        },
        customFields.max_react_frame_ms
    )
    for i = 1, 4 do
        local bucket = i - 1
        TelemetryService:LogCounter(
            tbl4,
            {
                customFields = {
                    category = "AllFrame",
                    bucket = bucket,
                    context = self.context,
                    deviceTier = deviceTier
                }
            },
            frameMetrics.allFrameHistogram[i]
        )
        TelemetryService:LogCounter(
            tbl4,
            {
                customFields = {
                    category = "ReactFrame",
                    bucket = bucket,
                    context = self.context,
                    deviceTier = deviceTier
                }
            },
            frameMetrics.reactFrameHistogram[i]
        )
        TelemetryService:LogCounter(
            tbl4,
            {
                customFields = {
                    category = "ReactDropChange",
                    bucket = bucket,
                    context = self.context,
                    deviceTier = deviceTier
                }
            },
            frameMetrics.reactDropChangeHistogram[i]
        )
    end

    for rootName, rootsMetric in self.rootsMetrics do
        rootsMetric.root_name = rootName
        rootsMetric.update_total_time_ms = rootsMetric.render_total_time_ms + rootsMetric.commit_total_time_ms
        rootsMetric.total_time_ms = rootsMetric.update_total_time_ms + rootsMetric.passive_effects_total_time_ms
        rootsMetric.avg_render_time_ms = rootsMetric.render_total_time_ms / rootsMetric.update_count
        rootsMetric.context = self.context
        rootsMetric.total_time_pct = (rootsMetric.update_total_time_ms + rootsMetric.passive_effects_total_time_ms) / customFields.react_total_time_ms
        rootsMetric.avg_update_time_ms = rootsMetric.update_total_time_ms / rootsMetric.update_count
        rootsMetric.avg_commit_time_ms = rootsMetric.commit_total_time_ms / rootsMetric.update_count
        if bool4 then
            rootsMetric.avg_layout_effects_time_ms = rootsMetric.layout_effects_total_time_ms / rootsMetric.layout_effects_count
            if bool5 then
                rootsMetric.avg_data_model_update_time_ms = rootsMetric.data_model_update_total_time_ms / rootsMetric.update_count
            end
        end
        rootsMetric.avg_passive_effects_time_ms = rootsMetric.passive_effects_total_time_ms / rootsMetric.passive_effects_count
        rootsMetric.avg_time_to_update_ms = rootsMetric.total_time_to_update_ms / rootsMetric.update_count

        TelemetryService:LogEvent(config5, { standardizedFields = tbl3, customFields = rootsMetric })

        if not bool1 then
            TelemetryService:LogStat(var2, {
                customFields = {
                    rootName = rootsMetric.root_name,
                    deviceTier = deviceTier,
                    stat = "TotalTimePct",
                    context = self.context
                }
            }, rootsMetric.total_time_pct)
        end

        TelemetryService:LogCounter(tbl5, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "RenderAndCommit",
                context = self.context
            }
        }, rootsMetric.update_count)

        if bool4 then
            TelemetryService:LogCounter(tbl5, {
                customFields = {
                    rootName = rootsMetric.root_name,
                    deviceTier = deviceTier,
                    task = "LayoutEffects",
                    context = self.context
                }
            }, rootsMetric.layout_effects_count)
        end

        TelemetryService:LogCounter(tbl5, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "PassiveEffects",
                context = self.context
            }
        }, rootsMetric.passive_effects_count)

        if bool2 then
            continue
        end

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "RenderAndCommit",
                stat = "AvgMs",
                context = self.context
            }
        }, rootsMetric.avg_update_time_ms)

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "Commit",
                stat = "AvgMs",
                context = self.context
            }
        }, rootsMetric.avg_commit_time_ms)

        if bool4 then
            TelemetryService:LogStat(var3, {
                customFields = {
                    rootName = rootsMetric.root_name,
                    deviceTier = deviceTier,
                    task = "LayoutEffects",
                    stat = "AvgMs",
                    context = self.context
                }
            }, rootsMetric.avg_layout_effects_time_ms)

            if bool5 then
                TelemetryService:LogStat(var3, {
                    customFields = {
                        rootName = rootsMetric.root_name,
                        deviceTier = deviceTier,
                        task = "DataModelUpdate",
                        stat = "AvgMs",
                        context = self.context
                    }
                }, rootsMetric.avg_data_model_update_time_ms)
            end
        end

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "TimeToUpdateMs",
                stat = "AvgMs",
                context = self.context
            }
        }, rootsMetric.avg_time_to_update_ms)

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "PassiveEffects",
                stat = "AvgMs",
                context = self.context
            }
        }, rootsMetric.avg_passive_effects_time_ms)

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "RenderAndCommit",
                stat = "MaxMs",
                context = self.context
            }
        }, rootsMetric.max_update_time_ms)

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "Commit",
                stat = "MaxMs",
                context = self.context
            }
        }, rootsMetric.max_commit_time_ms)

        if bool4 then
            TelemetryService:LogStat(var3, {
                customFields = {
                    rootName = rootsMetric.root_name,
                    deviceTier = deviceTier,
                    task = "LayoutEffects",
                    stat = "MaxMs",
                    context = self.context
                }
            }, rootsMetric.max_layout_effects_time_ms)

            if bool5 then
                TelemetryService:LogStat(var3, {
                    customFields = {
                        rootName = rootsMetric.root_name,
                        deviceTier = deviceTier,
                        task = "DataModelUpdate",
                        stat = "MaxMs",
                        context = self.context
                    }
                }, rootsMetric.max_data_model_update_time_ms)
            end
        end

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "TimeToUpdateMs",
                stat = "MaxMs",
                context = self.context
            }
        }, rootsMetric.max_time_to_update_ms)

        TelemetryService:LogStat(var3, {
            customFields = {
                rootName = rootsMetric.root_name,
                deviceTier = deviceTier,
                task = "PassiveEffects",
                stat = "MaxMs",
                context = self.context
            }
        }, rootsMetric.max_passive_effects_time_ms)
    end
end

function generatePercentilesFromSingleSketch(sketch)
    local str2 = "{"

    for value, value2 in tbl1 do
        str2 = (str2 .. "\"p" .. value2 .. "\":") .. sketch:getPercentile(tonumber(value2) or 0)
        if value < #tbl1 then
            str2 ..= ","
        end
    end

    return str2 .. "}"
end

function generatePercentilesFromSketches(sketches, numRoots: number)
    local str2 = "{"

    for value, value2 in tbl1 do
        local str3 = str2 .. "\"p" .. value2 .. "\":{"
        local num5 = tonumber(value2) or 0
        local num6 = 0
        for value3, value4 in sketches do
            num6 += 1
            str3 ..= "\"" .. value3 .. "\":" .. value4:getPercentile(num5)
            if num6 < numRoots then
                str3 ..= ","
            end
        end
        str2 = str3 .. (if value < #tbl1 then "}," else "}")
    end

    return str2 .. "}"
end

function tbl6:reportPercentError(tbl7: {any}, arg1, metric, rootName)
    table.sort(tbl7)
    local numDatapoints = #tbl7
    if numDatapoints < 1 then
        return
    end

    for _, value in tbl1 do
        local var4 = tbl7[math.ceil((tonumber(value) or 0) / 100 * numDatapoints)]
        local percentile = if arg1.sketches then arg1.sketches[rootName]:getPercentile(value) else arg1.sketch:getPercentile(value)
        local num6 = 0
        if var4 == 0 and percentile ~= 0 then
            continue
        end

        if var4 ~= 0 then
            num6 = (percentile - var4) * 100 / var4
        end

        local customFields = {
            rootName = rootName,
            percentile = value,
            metric = metric,
            numDatapoints = numDatapoints,
            context = self.context,
            approxError = num6
        }

        TelemetryService:LogEvent(config2, { standardizedFields = tbl3, customFields = customFields })
    end
end

function tbl6:reportSession()
    if not self.started then
        return
    end

    local customFields = {
        reactUpdateTime = generatePercentilesFromSketches(self.sessionMetrics.updateTime.sketches, self.sessionMetrics.updateTime.numRoots),
        reactCommitTime = generatePercentilesFromSketches(self.sessionMetrics.commitTime.sketches, self.sessionMetrics.commitTime.numRoots),
        reactTimeToUpdate = generatePercentilesFromSketches(self.sessionMetrics.timeToUpdate.sketches, self.sessionMetrics.timeToUpdate.numRoots),
        timePerFrame = generatePercentilesFromSingleSketch(self.sessionMetrics.timePerFrame.sketch),
        timePerReactFrame = generatePercentilesFromSingleSketch(self.sessionMetrics.timePerReactFrame.sketch)
    }
    if bool3 then
        for k, sessionMetric in self.sessionMetrics do
            if sessionMetric.sketches then
                for value, value2 in sessionMetric.allData do
                    self:reportPercentError(value2, sessionMetric, k, value)
                end
            else
                self:reportPercentError(sessionMetric.allData, sessionMetric, k, "all")
            end
        end
    end

    TelemetryService:LogEvent(config, { standardizedFields = tbl3, customFields = customFields })
end

return (tbl6.new(FStringReactSchedulingContext))
