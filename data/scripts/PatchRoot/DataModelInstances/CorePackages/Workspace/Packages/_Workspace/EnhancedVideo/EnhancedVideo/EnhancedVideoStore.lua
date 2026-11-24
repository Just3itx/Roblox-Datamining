-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local Signals = require(scriptParentParent.Signals)
local t = require(scriptParentParent.t)
local Loggers = require(scriptParentParent.Loggers)

local EnhancedVideoTelemetry = require(scriptParent.EnhancedVideoTelemetry)

local flaggedMutedError = Loggers.flaggedMutedError
local createSignal = Signals.createSignal

local serveEnhancedVideo = require(scriptParent.serveEnhancedVideo)
local _Types = require(scriptParent.Types)

local var1 = t.interface({
    adDisclosureText = t.string,
    showAdPreferencesUrl = t.boolean,
    videoAssetId = t.string,
    timelineJson = t.optional(t.string)
})

function createEnhancedVideoStore()
    local getAdDisclosureText, var3 = createSignal("")
    local getShowAdPreferencesUrl, var5 = createSignal(false)
    local getVideoAssetId, var7 = createSignal("")
    local getTimelineJson, var9 = createSignal("")

    return {
        getAdDisclosureText = getAdDisclosureText,
        getShowAdPreferencesUrl = getShowAdPreferencesUrl,
        getVideoAssetId = getVideoAssetId,
        getTimelineJson = getTimelineJson,
        fetchInitialData = function(arg1, num1: number)
            return serveEnhancedVideo(arg1, num1):andThen(function(arg2)
                local responseBody = arg2.responseBody
                if not var1(responseBody) then
                    flaggedMutedError(
                        "EnhancedVideo_InvalidResponseSchema",
                        `Response does not match expected schema for universe {num1}`
                    )
                    return nil
                end
                var3(responseBody.adDisclosureText)
                var5(responseBody.showAdPreferencesUrl)
                var7(responseBody.videoAssetId)
                local timelineJson = responseBody.timelineJson or ""
                var9(timelineJson)
                return {
                    videoAssetId = responseBody.videoAssetId,
                    timelineJson = timelineJson
                }
            end):catch(function(arg2)
                EnhancedVideoTelemetry.logServeEnhancedVideoError(tostring(arg2))
                return nil
            end)
        end
    }
end

return Signals.createComputed(createEnhancedVideoStore)
