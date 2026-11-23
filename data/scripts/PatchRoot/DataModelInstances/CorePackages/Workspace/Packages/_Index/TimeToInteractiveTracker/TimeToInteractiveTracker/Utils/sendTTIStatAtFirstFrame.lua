-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local _types = require(TimeToInteractiveTracker.Stores.types)

local now = require(TimeToInteractiveTracker.Utils.now)
local sendTTIStat = require(TimeToInteractiveTracker.Utils.sendTTIStat)
local buildTTIStatArgs = require(TimeToInteractiveTracker.Utils.buildTTIStatArgs)
local frameSignal = require(TimeToInteractiveTracker.Utils.frameSignal)
local getAppLifecycleObserverService = require(TimeToInteractiveTracker.Utils.getAppLifecycleObserverService)
local logTTIDiscard = require(TimeToInteractiveTracker.Utils.logTTIDiscard)
local FFlagTTITrackerDropEventsOnAppHide = require(TimeToInteractiveTracker.Utils.FFlagTTITrackerDropEventsOnAppHide)

local var1 = require(TimeToInteractiveTracker.Utils.FIntTTIFirstFrameMaxWaitMs) / 1000

local function sendTTIStatAtFirstFrame(arg1, callback)
    local var2 = now()
    local connection = nil
    local var3 = frameSignal.once(function()
        local endTime = now()
        if connection then
            connection:Disconnect()
        end
        if endTime - var2 > var1 then
            logTTIDiscard(arg1.statName, "lateFrame")
            return
        end

        local tTiStatArgs = buildTTIStatArgs(arg1, endTime)
        if callback then
            callback(function(arg2)
                local var4 = arg2[arg1.statName]
                if var4 == nil or var4.startTime ~= arg1.startTime or not var4.sent then
                    return arg2
                end
                local var5 = table.clone(var4)
                var5.endTime = endTime
                var5.deltaMs = tTiStatArgs.deltaMs
                local var6 = table.clone(arg2)
                var6[arg1.statName] = var5
                return var6
            end)
        end
        sendTTIStat(tTiStatArgs)
    end)

    if not FFlagTTITrackerDropEventsOnAppHide then
        return
    end

    local appLifecycleObserverService = getAppLifecycleObserverService()
    if appLifecycleObserverService then
        connection = appLifecycleObserverService.OnHide:Once(function()
            var3:Disconnect()
            logTTIDiscard(arg1.statName, "backgrounded")
        end)
    end
end

return sendTTIStatAtFirstFrame
