-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local _types = require(TimeToInteractiveTracker.Stores.types)

local mergeTTIEventMetadata = require(TimeToInteractiveTracker.Utils.mergeTTIEventMetadata)
local getMemoryMb = require(TimeToInteractiveTracker.Utils.getMemoryMb)
local FFlagTTITrackerMemoryTracking = require(TimeToInteractiveTracker.Utils.FFlagTTITrackerMemoryTracking)

local function buildTTIStatArgs(arg1, endTime: number)
    local deltaMs = (endTime - arg1.startTime) * 1000
    local memoryMb = if FFlagTTITrackerMemoryTracking then getMemoryMb() else nil
    return {
        statName = arg1.statName,
        deltaMs = deltaMs,
        metaData = mergeTTIEventMetadata(arg1.metaData, { startTime = arg1.startTime, endTime = endTime, deltaMs = deltaMs }),
        samplingRateOverride = arg1.samplingRateOverride,
        milestones = arg1.milestones,
        totalMemoryMB = if memoryMb then memoryMb.totalMemoryMB else nil,
        luaHeapMB = if memoryMb then memoryMb.luaHeapMB else nil
    }
end

return buildTTIStatArgs
