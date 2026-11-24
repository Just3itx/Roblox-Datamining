-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Signals = require(ExpChatParent.Signals)
local SharedFlags = require(ExpChatParent.SharedFlags)
local createUserChatSettingStore = require(script.createUserChatSettingStore)

local FFlagAIRephraseSettingEnabled = SharedFlags.FFlagAIRephraseSettingEnabled
local FFlagChatSummariesSettingEnabled = SharedFlags.FFlagChatSummariesSettingEnabled

local function applyAIRephraseFeatureValue(str1: string, str2: string, callback: (...any) -> (...any), callback2: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == "AIRephraseSettingStatus" then
        callback(str2 == "Enabled" or str2 == "Disabled")
        callback2(str2 == "Enabled")
    end
end

local function buildAIRephraseConfig()
    return {
        setupListener = function(_: (...any) -> (...any), _: (...any) -> (...any))
            return function() end
        end,
        buildFeatureValueHandler = function(callback, arg1): (string, string) -> ()
            return function(str1: string, str2: string)
                applyAIRephraseFeatureValue(str1, str2, callback, arg1)
            end
        end,
        onSetEnabled = function(bool1: boolean, callback: (...any) -> (...any))
            callback(bool1)
        end,
        requiresChatEnabled = true
    }
end

local function applyChatSummariesFeatureValue(str1: string, str2: string, callback: (...any) -> (...any), callback2: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == "AllowThirdPartySummary" then
        callback(str2 == "Enabled" or str2 == "Disabled")
        callback2(str2 == "Enabled")
    end
end

local function buildChatSummariesConfig()
    return {
        setupListener = function(_: (...any) -> (...any), _: (...any) -> (...any))
            return function() end
        end,
        buildFeatureValueHandler = function(callback, arg1): (string, string) -> ()
            return function(str1: string, str2: string)
                applyChatSummariesFeatureValue(str1, str2, callback, arg1)
            end
        end,
        onSetEnabled = function(bool1: boolean, callback: (...any) -> (...any))
            callback(bool1)
        end,
        requiresChatEnabled = false
    }
end

local getAIRephraseSettingStore = if FFlagAIRephraseSettingEnabled then Signals.createComputed(function()
    return createUserChatSettingStore((buildAIRephraseConfig()))
end) else nil

local getChatSummariesSettingStore = if FFlagChatSummariesSettingEnabled then Signals.createComputed(function()
    return createUserChatSettingStore((buildChatSummariesConfig()))
end) else nil

return {
    getAIRephraseSettingStore = getAIRephraseSettingStore,
    getChatSummariesSettingStore = getChatSummariesSettingStore,
    updateExpChatFeatureValue = function(str1: string, str2: string)
        if getAIRephraseSettingStore then
            getAIRephraseSettingStore(false).setIsSettingVisible(str1, str2)
        end
        if getChatSummariesSettingStore then
            getChatSummariesSettingStore(false).setIsSettingVisible(str1, str2)
        end
    end
}
