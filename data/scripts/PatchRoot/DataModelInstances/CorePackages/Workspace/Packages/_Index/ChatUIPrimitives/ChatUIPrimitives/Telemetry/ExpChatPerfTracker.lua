-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local IntervalPerformanceTracker = require(ChatUIPrimitivesParent.IntervalPerformanceTracker).IntervalPerformanceTracker
local TimeToInteractiveTracker = require(ChatUIPrimitivesParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local var1 = require(ChatUIPrimitivesParent.Lumberyak).Logger.new(nil, "ExpChatPerfTracker")

local ExpChatPerfEventConfig = require(script.Parent.ExpChatPerfEventConfig)
local EventTypes = ExpChatPerfEventConfig.EventTypes
local Events = ExpChatPerfEventConfig.Events
local EventConfig = ExpChatPerfEventConfig.EventConfig

local SocialLuaAnalytics = require(ChatUIPrimitivesParent.SocialLuaAnalytics)
local ScrollIntervalTracker = require(ChatUIPrimitivesParent.ScrollIntervalTracker)
local FFlagExpChatMigrateScrollIntervalTracker = require(ChatUIPrimitives.Flags.FFlagExpChatMigrateScrollIntervalTracker)
local FFlagExpChatPerfTrackerTabName = require(ChatUIPrimitives.Flags.FFlagExpChatPerfTrackerTabName)

local module = {}

function module.start(debugName, arg1, tbl1): boolean
    local var2 = EventConfig[debugName] or {}
    if var2.type == EventTypes.TTI then
        var2.onStart(arg1)
        TimeToInteractiveTracker.trackStart(var2.baseName)
        if FFlagExpChatPerfTrackerTabName and tbl1 and tbl1.tabName then
            TimeToInteractiveTracker.updateMetadata(var2.baseName, { page = tbl1.tabName })
        end
        return true
    end

    if var2.type ~= EventTypes.Interval then
        var1:warning(`ExpChatPerfTracker.start: unknown event type for event: {debugName}`)
        return false
    end

    if not var2.canStart(arg1) then
        return false
    end

    IntervalPerformanceTracker:cancelTracking(var2.name)
    var2.onStart(arg1)
    if FFlagExpChatPerfTrackerTabName and tbl1 then
        IntervalPerformanceTracker:startTracking(var2.name, nil, var2.intervalMetrics, true, true, tbl1)
    else
        IntervalPerformanceTracker:startTracking(var2.name, nil, var2.intervalMetrics, true, true)
    end
    return true
end

function module.finish(debugName, arg1, tbl1)
    local var2 = EventConfig[debugName] or {}
    if var2.type == EventTypes.TTI then
        if not var2.canFinish(arg1) then
            return
        end
        if FFlagExpChatPerfTrackerTabName and tbl1 and tbl1.tabName then
            TimeToInteractiveTracker.updateMetadata(var2.baseName, { page = tbl1.tabName })
        end
        TimeToInteractiveTracker.trackEnd(var2.baseName)
        return
    end

    if var2.type ~= EventTypes.Interval then
        var1:warning(`ExpChatPerfTracker.finish: unknown event type for event: {debugName}`)
        return
    end

    if not var2.canFinish(arg1) then
        return
    end
    if FFlagExpChatPerfTrackerTabName and tbl1 then
        var1:warning("Unable to update finished interval extra fields")
    end
    var2.onFinish(arg1)
    IntervalPerformanceTracker:stopAndLogTracking(var2.name)
end

function module.cancel(arg1, arg2)
    local var2 = EventConfig[arg1] or {}
    if var2.type == EventTypes.TTI then
        TimeToInteractiveTracker.resetEvent(var2.baseName)
    elseif var2.type == EventTypes.Interval then
        var2.onFinish(arg2)
        IntervalPerformanceTracker:cancelTracking(var2.name)
    else
        var1:warning(`ExpChatPerfTracker.cancel: unknown event type for event: {arg1}`)
    end
end

function module.cancelAll()
    for value, _ in EventConfig do
        module.cancel(value)
    end
end

module.Events = Events
function module.startChatWindowScrollInterval(debugName, arg1, arg2, tbl1)
    local tbl2 = { debugName = debugName }

    local function func1(arg3)
        return module.start(debugName, arg3, tbl1)
    end
    local function func2(arg3)
        module.finish(debugName, arg3)
    end
    if FFlagExpChatMigrateScrollIntervalTracker then
        return ScrollIntervalTracker.createScrollIntervalTracker(func1, func2, arg1, arg2, tbl2)
    end
    return SocialLuaAnalytics.Performance.createScrollIntervalTracker(func1, func2, arg1, arg2, tbl2)
end

return module
