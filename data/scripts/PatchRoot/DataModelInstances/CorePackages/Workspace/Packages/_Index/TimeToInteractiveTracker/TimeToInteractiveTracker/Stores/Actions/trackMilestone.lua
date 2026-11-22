-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local var1 = require(TimeToInteractiveTracker.Logger):new(script.Name)
local FFlagDebugTimeToInteractiveTracker = require(TimeToInteractiveTracker.Utils.FFlagDebugTimeToInteractiveTracker)

local FFlagTimeToInteractiveTrackerWarningsRequireDebug = require(TimeToInteractiveTracker.Utils.FFlagTimeToInteractiveTrackerWarningsRequireDebug)

local _types = require(script.Parent.Parent.types)

local now = require(TimeToInteractiveTracker.Utils.now)
local getMemoryMb = require(TimeToInteractiveTracker.Utils.getMemoryMb)
local FFlagTTITrackerMemoryTracking = require(TimeToInteractiveTracker.Utils.FFlagTTITrackerMemoryTracking)

return function(arg1, callback)
    return function(str1: string, name, arg3)
        local timestamp = now()
        local var3 = arg1(false)[str1]

        if not (var3 and var3.startTime) then
            if FFlagTimeToInteractiveTrackerWarningsRequireDebug then
                if FFlagDebugTimeToInteractiveTracker then
                    var1:warning(`called before trackStart for eventName={str1}`)
                    return
                end
            else
                var1:warning(`called before trackStart for eventName={str1}`)
            end
            return
        end

        local deltaMs = (timestamp - var3.startTime) * 1000
        local memoryMb = if FFlagTTITrackerMemoryTracking then getMemoryMb() else nil
        local tbl1 = {
            name = name,
            id = if arg3 then arg3.id else nil,
            timestamp = timestamp,
            deltaMs = deltaMs,
            totalMemoryMB = if memoryMb then memoryMb.totalMemoryMB else nil,
            luaHeapMB = if memoryMb then memoryMb.luaHeapMB else nil
        }

        callback(function(arg4)
            local var5 = arg4[str1]
            if not var5 then
                return arg4
            end

            local var6 = table.clone(arg4)
            local var7 = table.clone(var5)
            local milestones = not var7.milestones and {} or table.clone(var7.milestones)
            table.insert(milestones, tbl1)
            var7.milestones = milestones

            var6[str1] = var7
            return var6
        end)
    end
end
