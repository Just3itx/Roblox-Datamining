-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local getDeepValue = require(AppChat.Utils.getDeepValue)
local SharedFlags = require(AppChatParent.SharedFlags)
local Url = require(AppChatParent.Http).Url
local Localization = require(AppChatParent.RobloxAppLocales).Localization

local EnumMessageTypes = require(AppChat.Components.ChatConversation.EnumMessageTypes)
local MessageModel = require(AppChat.Models.MessageModel)

local GetFFlagEnableSocialCards = SharedFlags.GetFFlagEnableSocialCards

local function getMessageContent(arg1)
    if arg1.previewContent then
        return arg1.previewContent
    end

    if arg1.visibility == MessageModel.VisibilityTypes.Hidden then
        return Localization.new(LocalizationService.RobloxLocaleId):Format("Feature.Chat.Label.MessageNotAvailable")
    end

    if arg1.messageType == EnumMessageTypes.Link then
        return Url.WWW_URL .. "games/" .. arg1.gameLink.universeId
    end
    if GetFFlagEnableSocialCards() and arg1.messageType == EnumMessageTypes.System and arg1.cards then
        return arg1.cards[1] and arg1.cards[1].alt_text
    end
    return tostring(arg1.content)
end

return function(arg1)
    local deepValue = getDeepValue(arg1, "messages.values")
    local previewMessageId = arg1.previewMessageId

    if previewMessageId and deepValue and deepValue[previewMessageId] then
        return getMessageContent(deepValue[previewMessageId])
    end

    return if arg1.previewContent then arg1.previewContent else nil
end
