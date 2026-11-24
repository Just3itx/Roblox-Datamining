-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local Dictionary = require(ExpChatParent.llama).Dictionary

local UI = script:FindFirstAncestor("UI")
local TranslatedTextMessage = require(UI.TranslatedTextMessage)

local var1 = require(ExpChatParent.UserProfiles).Stores.VerifiedBadgeDisplayStore.get()

local FFlagEnableVerifiedBadgeStore = require(ExpChatParent.SharedFlags).FFlagEnableVerifiedBadgeStore
local engineFeature = game:GetEngineFeature("EnableInExpChatRewrite")
local FFlagExpChatRewriteInline = require(ExpChat.Flags.FFlagExpChatRewriteInline)

local function createMessageChildren(tbl1)
    local messages = tbl1.messages
    local verifiedUserIds = tbl1.verifiedUserIds
    local textTransparency = tbl1.textTransparency
    local transparencyValue = tbl1.transparencyValue
    local chatWindowSettings = tbl1.chatWindowSettings
    local showTranslationButton = tbl1.showTranslationButton
    local isSpatialUiEnabled = tbl1.isSpatialUIEnabled
    local onTextMessageLabelButtonActivated = tbl1.onTextMessageLabelButtonActivated

    local var2 = Dictionary.map(messages, function(message, layoutOrder)
        if not message.isVisibleInChatWindow then
            return nil, nil
        end

        local isUserVerified = if FFlagEnableVerifiedBadgeStore then if message.userId then var1.isBadgeVisible(tonumber(message.userId)) else false elseif message.userId then Dictionary.has(verifiedUserIds, message.userId) else false
        local createElement = React.createElement
        local var3 = TranslatedTextMessage
        local tbl2 = {
            message = message,
            LayoutOrder = layoutOrder,
            isUserVerified = isUserVerified,
            textTransparency = textTransparency,
            transparencyValue = if engineFeature then transparencyValue else nil,
            onTextMessageLabelButtonActivated = onTextMessageLabelButtonActivated,
            chatWindowSettings = chatWindowSettings,
            showTranslationButton = showTranslationButton,
            isSpatialUIEnabled = isSpatialUiEnabled,
            onToggle = 0,
            chatWindowTransparencyBindable = 0
        }

        function tbl2.onToggle() end
        tbl2.chatWindowTransparencyBindable = if FFlagExpChatRewriteInline then transparencyValue else nil
        return createElement(var3, tbl2), message.messageId
    end)

    var2["$layout"] = React.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })

    return var2
end

return createMessageChildren
