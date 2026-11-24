-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local RoactUtils = require(ExpChatParent.RoactUtils)
local SignalsReact = require(ExpChatParent.SignalsReact)

local ExpChatPresetChatEmojiTabExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatEmojiTabExperimentation

local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local isUserChatEnabled = require(ExpChat.isUserChatEnabled)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local function selectIsChatWindowVisible(arg1)
    return arg1.ChatVisibility.isChatWindowEnabled.value
end

local function PresetChatEmojiTabExposureLogger()
    local var1 = useSelector(selectIsChatWindowVisible)
    local var2 = SignalsReact.useSignalState(GetChatStatusStore(false).getChatStatus)
    local var3 = isUserChatEnabled(var2)

    React.useEffect(function()
        if var1 and var3 then
            ExpChatPresetChatEmojiTabExperimentation.logExposure()
        end
    end, { var1, var3 })

    return nil
end

return PresetChatEmojiTabExposureLogger
