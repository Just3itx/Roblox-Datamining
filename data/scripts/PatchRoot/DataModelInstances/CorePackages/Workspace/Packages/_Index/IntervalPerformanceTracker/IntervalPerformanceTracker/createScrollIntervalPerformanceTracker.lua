-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IntervalPerformanceTrackerParent = script:FindFirstAncestor("IntervalPerformanceTracker").Parent

local ScrollIntervalTracker = require(IntervalPerformanceTrackerParent.ScrollIntervalTracker)
local IntervalPerformanceTracker = require(script.Parent.IntervalPerformanceTracker)

local bool1 = game:DefineFastFlag("IntervalPerformanceTrackerPerIntervalSampleRate", false)
game:DefineFastInt("ScrollIntervalPerformanceTrackerSampleRate", 1000)

local tbl1 = {
    "duration",
    "averageFPS",
    "framesCount",
    "longestFrameTime",
    "frameTimeAvgMs",
    "frameTimeStdDevMs",
    "frameTimeDistributionMs",
    "frameBuckets",
    "rawFrameTimesMs",
    "rawScrollPositionSamplesCsv"
}

local function createScrollIntervalPerformanceTracker(str1: string, arg1, arg2, tbl2)
    local var1 = if tbl2 and tbl2.metricsToTrack then tbl2.metricsToTrack else tbl1
    local var2 = not tbl2 or tbl2.countersEnabled == nil or tbl2.countersEnabled
    local var3 = not tbl2 or tbl2.eventStreamEnabled == nil or tbl2.eventStreamEnabled
    local scrollOptions = if tbl2 then tbl2.scrollOptions else nil
    local var4 = not tbl2 or tbl2.trackScrollType == nil or tbl2.trackScrollType
    local extraFields = if tbl2 then tbl2.extraFields else nil
    local bool2 = false

    local function buildExtraFields() -- Luacid: Inlined by compiler; 1 call site recovered
        local scrollType = if bool2 then "warm" else "cold"

        if not var4 then
            return extraFields
        end

        local extraFields2 = ({})
        if extraFields then
            for k, extraField in extraFields do
                extraFields2[k] = extraField
            end
        end
        extraFields2.scroll_type = scrollType
        return extraFields2
    end

    return ScrollIntervalTracker.createScrollIntervalTracker(function(_): boolean -- name: tryStart
        local var5 = IntervalPerformanceTracker
        local str2 = str1

        local var6 = var1
        local var7 = var2
        local var8 = var3
        local extraFields2 = buildExtraFields()
        local var9 = nil
        local var10 = arg1
        local fastInt = if bool1 then game:GetFastInt("ScrollIntervalPerformanceTrackerSampleRate") else nil
        var5:startTracking(str2, var9, var6, var7, var8, extraFields2, var10, fastInt)

        bool2 = true
        return true
    end, function(_) -- name: finish
        IntervalPerformanceTracker:stopAndLogTracking(str1)
    end, arg1, arg2, scrollOptions)
end

return createScrollIntervalPerformanceTracker
