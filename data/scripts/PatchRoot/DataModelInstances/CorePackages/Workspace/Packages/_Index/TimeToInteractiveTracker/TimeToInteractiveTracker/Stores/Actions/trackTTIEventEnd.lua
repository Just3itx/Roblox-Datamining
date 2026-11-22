-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")
local TimeToInteractiveTrackerParent = TimeToInteractiveTracker.Parent
local var1 = require(TimeToInteractiveTracker.Logger):new(script.Name)

local _types = require(script.Parent.Parent.types)

local now = require(script.Parent.Parent.Parent.Utils.now)
local sendTTIStat = require(TimeToInteractiveTracker.Utils.sendTTIStat)
local sendTTIStatAtFirstFrame = require(TimeToInteractiveTracker.Utils.sendTTIStatAtFirstFrame)
local buildTTIStatArgs = require(TimeToInteractiveTracker.Utils.buildTTIStatArgs)
local Util = require(TimeToInteractiveTracker.Utils.Util)
local FFlagLuaAppNavTTIMeasurementV2 = require(TimeToInteractiveTrackerParent.SharedFlags).FFlagLuaAppNavTTIMeasurementV2

return function(callback, tbl1)
    local function endEvent(statName: string, arg1, bool1: boolean) -- Luacid: unused: defined but never referenced
        local var2 = nil
        local var3 = nil
        local bool2 = false
        local var4 = not arg1 or arg1.cleanupAfterSend == nil or arg1.cleanupAfterSend
        local samplingRateOverride = if arg1 then arg1.samplingRateOverride else nil

        callback(function(arg2)
            local var5 = arg2[statName]
            if var5 == nil then
                if FFlagLuaAppNavTTIMeasurementV2 and tbl1 and tbl1[statName] then
                    return arg2
                end
                var1:warning(`called before trackStart for eventName={statName}`)
                return arg2
            end

            if var5.startTime == nil then
                var1:warning(`called before trackStart for eventName={statName}`)
                return arg2
            end

            local endTime = now()

            local deltaMs = (endTime - var5.startTime) * 1000
            bool2 = var5.sent ~= true

            if bool2 then
                var2 = endTime
                var3 = {
                    statName = statName,
                    startTime = var5.startTime,
                    metaData = var5.metadata,
                    milestones = var5.milestones,
                    samplingRateOverride = samplingRateOverride
                }
            end

            local var8 = table.clone(arg2)
            if bool2 and var4 then
                var8[statName] = nil
                return var8
            end
            local str1 = statName
            var8[str1] = {
                startTime = var5.startTime,
                endTime = endTime,
                deltaMs = deltaMs,
                sent = true,
                metadata = table.clone(var5.metadata),
                milestones = if var5.milestones then Util.deepCloneMilestones(var5.milestones) else nil
            }

            return var8
        end)

        if var3 == nil or var2 == nil then
            return
        end

        if bool1 then
            sendTTIStatAtFirstFrame(var3, if var4 then nil else callback)
        else
            sendTTIStat(buildTTIStatArgs(var3, var2))
        end
    end
    local function trackEnd(statName: string, arg1)
        local var2 = nil
        local var3 = nil
        local bool1 = false
        local var4 = not arg1 or arg1.cleanupAfterSend == nil or arg1.cleanupAfterSend
        local samplingRateOverride = if arg1 then arg1.samplingRateOverride else nil

        callback(function(arg2)
            local var5 = arg2[statName]
            if var5 == nil then
                if FFlagLuaAppNavTTIMeasurementV2 and tbl1 and tbl1[statName] then
                    return arg2
                end
                var1:warning(`called before trackStart for eventName={statName}`)
                return arg2
            end

            if var5.startTime == nil then
                var1:warning(`called before trackStart for eventName={statName}`)
                return arg2
            end

            local endTime = now()

            local deltaMs = (endTime - var5.startTime) * 1000
            bool1 = var5.sent ~= true

            if bool1 then
                var2 = endTime
                var3 = {
                    statName = statName,
                    startTime = var5.startTime,
                    metaData = var5.metadata,
                    milestones = var5.milestones,
                    samplingRateOverride = samplingRateOverride
                }
            end

            local var8 = table.clone(arg2)
            if bool1 and var4 then
                var8[statName] = nil
                return var8
            end
            local str1 = statName
            var8[str1] = {
                startTime = var5.startTime,
                endTime = endTime,
                deltaMs = deltaMs,
                sent = true,
                metadata = table.clone(var5.metadata),
                milestones = if var5.milestones then Util.deepCloneMilestones(var5.milestones) else nil
            }

            return var8
        end)

        if var3 == nil or var2 == nil then
            return
        end

        sendTTIStat(buildTTIStatArgs(var3, var2))
    end

    local function trackEndAtNextFrame(statName: string, arg1)
        local var2 = nil
        local var3 = nil
        local bool1 = false
        local var4 = not arg1 or arg1.cleanupAfterSend == nil or arg1.cleanupAfterSend
        local samplingRateOverride = if arg1 then arg1.samplingRateOverride else nil

        callback(function(arg2)
            local var5 = arg2[statName]
            if var5 == nil then
                if FFlagLuaAppNavTTIMeasurementV2 and tbl1 and tbl1[statName] then
                    return arg2
                end
                var1:warning(`called before trackStart for eventName={statName}`)
                return arg2
            end

            if var5.startTime == nil then
                var1:warning(`called before trackStart for eventName={statName}`)
                return arg2
            end

            local endTime = now()

            local deltaMs = (endTime - var5.startTime) * 1000
            bool1 = var5.sent ~= true

            if bool1 then
                var2 = endTime
                var3 = {
                    statName = statName,
                    startTime = var5.startTime,
                    metaData = var5.metadata,
                    milestones = var5.milestones,
                    samplingRateOverride = samplingRateOverride
                }
            end

            local var8 = table.clone(arg2)
            if bool1 and var4 then
                var8[statName] = nil
                return var8
            end
            local str1 = statName
            var8[str1] = {
                startTime = var5.startTime,
                endTime = endTime,
                deltaMs = deltaMs,
                sent = true,
                metadata = table.clone(var5.metadata),
                milestones = if var5.milestones then Util.deepCloneMilestones(var5.milestones) else nil
            }

            return var8
        end)

        if var3 == nil or var2 == nil then
            return
        end

        sendTTIStatAtFirstFrame(var3, if var4 then nil else callback)
    end

    return trackEnd, trackEndAtNextFrame
end
