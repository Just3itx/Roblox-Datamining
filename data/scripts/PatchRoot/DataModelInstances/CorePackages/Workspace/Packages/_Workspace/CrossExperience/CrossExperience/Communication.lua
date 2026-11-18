-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:20:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")
local ExperienceService = game:GetService("ExperienceService")
local HttpService = game:GetService("HttpService")

local logEvent = require(CrossExperience.Analytics.CrossExperienceAnalytics).logEvent
local Constants = require(CrossExperience.Constants)
local getMemStorageKey = require(CrossExperience.Utils.getMemStorageKey)
local EventNames = require(CrossExperience.Analytics.EventNames)
local Logger = require(CrossExperience.Logger)
local _Types = require(CrossExperience.Types)

local FFlagFixCrossExperienceVoiceExecutePrint = require(CrossExperience.dependencies).SharedFlags.FFlagFixCrossExperienceVoiceExecutePrint

local function func1() end

local function execute(callId: string, arg1, callback: (...any) -> (...any), callback2: (...any) -> (...any))
    local success, result = pcall(function()
        ExperienceService:ExecuteCrossExperienceCall(callId, arg1, function(arg2)
            if callback then
                callback(arg2)
            end
        end, function(str1: string)
            if FFlagFixCrossExperienceVoiceExecutePrint then
                Logger:warning("Error executing call: {}", str1)
            else
                print("[CrossExperience] Error executing call", str1)
            end
            if callback2 then
                callback2(str1)
            end
        end)
    end)

    if success then
        return
    end
    if FFlagFixCrossExperienceVoiceExecutePrint then
        Logger:warning("Error executing call pcall: {} {}", callId, result)
    else
        print("[CrossExperience] Error executing call pcall", callId, result)
    end
    if callback2 then
        callback2("[CrossExperience] Error executing call pcall")
    end
end

local function func3(arg1, arg2, callback: (...any) -> (...any), func4: (...any) -> (...any))
    local tbl1 = {
        eventName = arg1.NOTIFY,
        clientTimeStamp = os.time(),
        cevJoinAttemptId = getMemStorageKey(Constants.CEV_JOIN_ATTEMPT_ID_KEY)
    }

    logEvent(EventNames.NotifyObserver, tbl1)
    execute(arg1.NOTIFY, arg2, callback, func4)
end

local function func4(experienceType, arg1, callback: (...any) -> (...any), _: (...any) -> (...any), func5: (...any) -> (...any))
    local observerId = HttpService:GenerateGUID(false)
    logEvent(EventNames.AddObserver, {
        eventName = arg1.ADD_OBSERVER,
        clientTimeStamp = os.time(),
        cevJoinAttemptId = getMemStorageKey(Constants.CEV_JOIN_ATTEMPT_ID_KEY)
    })
    execute(arg1.ADD_OBSERVER, { observerId = observerId, experienceType = experienceType }, callback, func5)

    return observerId
end

local function func5(experienceType, arg1, observerId: string, callback: (...any) -> (...any), func6: (...any) -> (...any))
    logEvent(EventNames.RemoveObserver, {
        eventName = arg1.REMOVE_OBSERVER,
        clientTimeStamp = os.time(),
        cevJoinAttemptId = getMemStorageKey(Constants.CEV_JOIN_ATTEMPT_ID_KEY)
    })
    execute(arg1.REMOVE_OBSERVER, { observerId = observerId, experienceType = experienceType }, callback, func6)
end

return {
    execute = execute,
    notify = function(arg1, arg2)
        func3(arg1, arg2, func1, func1)
    end,
    notifyWithCallbacks = func3,
    addObserver = function(experienceType, arg1, callback: (...any) -> (...any)): string
        return (func4(experienceType, arg1, callback, func1, func1))
    end,
    addObserverWithCallbacks = func4,
    removeObserver = function(experienceType, arg1, observerId: string)
        return func5(experienceType, arg1, observerId, func1, func1)
    end,
    removeObserverWithCallbacks = func5
}
