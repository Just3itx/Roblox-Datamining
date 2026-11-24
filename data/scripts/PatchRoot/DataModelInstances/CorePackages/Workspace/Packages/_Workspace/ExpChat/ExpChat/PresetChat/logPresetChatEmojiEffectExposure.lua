-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local ExpChatShared = require(ExpChatParent.ExpChatShared)
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)

local ExpChatPresetChatEmojiEffectExperimentation = require(ExpChatParent.SocialExperiments).ExpChatPresetChatEmojiEffectExperimentation

local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local isUserChatEnabled = require(ExpChat.isUserChatEnabled)
local isMessageForOpenChannel = require(ExpChat.isMessageForOpenChannel)
local selectSelectedTabName = require(ExpChat.selectSelectedTabName)
local getMessageSettings = require(ExpChat.ChatWindow.Helpers.getMessageSettings)
local getMessageText = require(ExpChat.ChatWindow.Helpers.getMessageText)
local _getBubbleChatDisplayText = require(ExpChat.BubbleChat.Helpers.getBubbleChatDisplayText)
local isBorderlessBubbleChatMessage = require(ExpChat.BubbleChat.Helpers.isBorderlessBubbleChatMessage)

local MessageEffect = require(ExpChat.MessageEffects.MessageEffect)
local getMessageEffects = require(ExpChat.MessageEffects.getMessageEffects)

local function isShownInChatWindow(arg1)
    local store = ExpChatShared.context.store
    if store == nil then
        return false
    end
    local state = store:getState()
    if not state.ChatVisibility.isChatWindowEnabled.value or selectSelectedTabName(state) == FriendsChatTabName then
        return false
    end

    return isMessageForOpenChannel(state, { TextChannel = arg1.textChannel }, arg1.channelNameOverride)
end

local function isChatWindowEnlargeMessage(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local messageSettings = getMessageSettings(arg1)
    local messageText = getMessageText(messageSettings.useTranslation, messageSettings.translation, messageSettings.text)
    return table.find(getMessageEffects(messageText), MessageEffect.ChatWindowEnlarge) ~= nil
end

local function logPresetChatEmojiEffectExposure(arg1)
    if not isUserChatEnabled(GetChatStatusStore(false).getChatStatus(false)) then
        return
    end

    if arg1.isVisibleInChatWindow and isShownInChatWindow(arg1) and isChatWindowEnlargeMessage(arg1)
        or arg1.isVisibleInBubbleChat and isBorderlessBubbleChatMessage(arg1)
    then
        ExpChatPresetChatEmojiEffectExperimentation.logExposure()
    end
end

return logPresetChatEmojiEffectExposure
