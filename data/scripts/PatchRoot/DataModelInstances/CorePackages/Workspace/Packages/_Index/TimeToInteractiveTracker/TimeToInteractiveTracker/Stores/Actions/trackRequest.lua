-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local var1 = require(TimeToInteractiveTracker.Logger):new(script.Name)
local FFlagDebugTimeToInteractiveTracker = require(TimeToInteractiveTracker.Utils.FFlagDebugTimeToInteractiveTracker)

local FFlagTimeToInteractiveTrackerWarningsRequireDebug = require(TimeToInteractiveTracker.Utils.FFlagTimeToInteractiveTrackerWarningsRequireDebug)

local _types = require(script.Parent.Parent.types)

local now = require(TimeToInteractiveTracker.Utils.now)
local Util = require(TimeToInteractiveTracker.Utils.Util)

return function(arg1, callback)
    return function(str1: string, arg2, name: string)
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

        local tbl1 = {
            name = name,
            timestamp = timestamp,
            deltaMs = (timestamp - var3.startTime) * 1000
        }

        callback(function(arg3)
            local var4 = arg3[str1]
            if not (var4 and var4.milestones) then
                return arg3
            end

            local lastMilestoneIndex = Util.findLastMilestoneIndex(var4.milestones, arg2)
            if not lastMilestoneIndex then
                if FFlagTimeToInteractiveTrackerWarningsRequireDebug then
                    if FFlagDebugTimeToInteractiveTracker then
                        var1:warning(`no milestone "{arg2}" found for eventName={str1}`)
                        return arg3
                    end
                else
                    var1:warning(`no milestone "{arg2}" found for eventName={str1}`)
                end
                return arg3
            end

            local var5 = table.clone(arg3)
            local var6 = table.clone(var4)
            local milestones = table.clone(var4.milestones)
            local var8 = table.clone(milestones[lastMilestoneIndex])

            local requests = not var8.requests and {} or table.clone(var8.requests)
            table.insert(requests, tbl1)
            var8.requests = requests

            milestones[lastMilestoneIndex] = var8
            var6.milestones = milestones
            var5[str1] = var6
            return var5
        end)
    end
end
