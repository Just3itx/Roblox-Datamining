-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local useAnalytics = require(AppChat.Analytics.useAnalytics)
local useCallback = React.useCallback
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useScreenSize = require(AppChatParent.RobloxAppHooks).useScreenSize

local EventNames = require(AppChat.Analytics.EventNames)

local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector

local PartialModal = require(script.Parent.PartialModal)

local tbl1 = {
    conversationId = "",
    onDismissed = function() end,
    titleKey = "Feature.Chat.Heading.ExpressiveChat",
    bodyKey = "Feature.Chat.Description.ExpressiveChatLearnMore",
    cancelAlertKey = "CommonUI.Features.Action.Close"
}

return memo(function(tbl2) -- name: LearnMorePartialModalContainer
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local style = useStyle()
    local var3 = useScreenSize()
    local var4 = useLayerCollector()
    if var4 and var4.absoluteSize then
        var3 = var4.absoluteSize
    end
    local var5 = useAnalytics()

    useEffectOnMount(function()
        if var5 then
            var5.fireAnalyticsEvent(EventNames.ConversationLearnMoreDialogRendered, { conversationId = var1.conversationId })
        end
    end)

    local onDismissed = useCallback(function()
        if var5 then
            var5.fireAnalyticsEvent(EventNames.ConversationLearnMoreDialogDismissed, { conversationId = var1.conversationId })
        end

        var1.onDismissed()
    end, { var5, var1.conversationId, var1.onDismissed })

    local var7 = useLocalization({ titleText = var1.titleKey, bodyText = var1.bodyKey, cancelAlertText = var1.cancelAlertKey })

    return React.createElement(PartialModal, {
        titleText = var7.titleText,
        bodyText = var7.bodyText,
        cancelAlertText = var7.cancelAlertText,
        screenSize = var3,
        onDismissed = onDismissed,
        style = style
    })
end)
