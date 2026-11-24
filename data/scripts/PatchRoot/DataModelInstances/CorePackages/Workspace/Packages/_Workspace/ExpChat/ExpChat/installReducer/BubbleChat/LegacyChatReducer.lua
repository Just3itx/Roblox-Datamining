-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local LegacyBubbleChatEnabledChanged = require(Actions.LegacyBubbleChatEnabledChanged)
local LegacyBubbleChatSettingsChanged = require(Actions.LegacyBubbleChatSettingsChanged)

local LegacyDefaultSettings = require(script.Parent.LegacyDefaultSettings)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[LegacyBubbleChatEnabledChanged.name] = function(arg1, arg2)
    return Dictionary.join(arg1, { Enabled = arg2.value })
end

tbl1[LegacyBubbleChatSettingsChanged.name] = function(_, arg1)
    local chatSettings = arg1.chatSettings
    if chatSettings.Transparency then
        chatSettings.BackgroundTransparency = chatSettings.Transparency
    end

    local var1 = Dictionary.join(LegacyDefaultSettings, chatSettings)

    if chatSettings and chatSettings.UserSpecificSettings then
        for k, userSpecificSetting in pairs(chatSettings.UserSpecificSettings) do
            local var2 = Dictionary.copyDeep(LegacyDefaultSettings)
            if userSpecificSetting.Transparency then
                userSpecificSetting.BackgroundTransparency = userSpecificSetting.Transparency
            end
            var2.UserSpecificSettings = nil
            var1.UserSpecificSettings[k] = Dictionary.join(var2, userSpecificSetting)
        end
    end

    return var1
end

return createReducer(LegacyDefaultSettings, tbl1)
