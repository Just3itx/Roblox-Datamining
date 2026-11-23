-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:16Z
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
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffectOnMount = require(AppChatParent.RoactUtils).Hooks.useEffectOnMount
local useIsLocalPlayerPartyVoiceEligible = require(AppChatParent.SquadsCore.Hooks).useIsLocalPlayerPartyVoiceEligible
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useScreenSize = require(AppChatParent.RobloxAppHooks).useScreenSize
local useState = React.useState

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local EventNames = require(AppChat.Analytics.EventNames)

local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector

local PartialModal = require(script.Parent.PartialModal)

local tbl1 = {
    conversationId = "",
    onDismissed = function() end,
    navigateToConversation = function(_) end,
    navigateToToast = function(_) end,
    titleKey = "Feature.Chat.Heading.CreateUnfilteredChatDialog",
    bodyKey = "Feature.Chat.Description.CreateUnfilteredChatDialog",
    bodyKeyWithVoice = "Feature.Chat.Description.CreateUnfilteredChatWithVoice",
    networkErrorTextKey = "Feature.Toast.NetworkingError.SomethingIsWrong",
    actionKey = "Feature.Chat.Action.Create",
    cancelAlertKey = "Feature.Chat.Action.Cancel"
}

return memo(function(tbl2) -- name: CreateUnfilteredChatPartialModalContainer
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local style = useStyle()
    local var3 = useScreenSize()
    local var4 = useLayerCollector()
    if var4 and var4.absoluteSize then
        var3 = var4.absoluteSize
    end
    local isButtonDisabled, var6 = useState(false)
    local var7 = useDispatch()
    local var8 = useAnalytics()
    local var9 = useIsLocalPlayerPartyVoiceEligible()

    useEffectOnMount(function()
        if var8 then
            var8.fireAnalyticsEvent(EventNames.ConversationUpgradeDialogRendered, { conversationId = var1.conversationId })
        end
    end)

    local var10 = useLocalization({
        networkErrorText = var1.networkErrorTextKey,
        titleText = var1.titleKey,
        bodyText = var1.bodyKey,
        bodyTextWithVoice = var1.bodyKeyWithVoice,
        actionText = var1.actionKey,
        cancelAlertText = var1.cancelAlertKey
    })

    local var11 = useCallback(function()
        var1.navigateToToast(var10.networkErrorText)
    end, { var1.navigateToToast, var10.networkErrorText })

    local onActivated = useCallback(function()
        if var8 then
            var8.fireAnalyticsEvent(EventNames.ConversationUpgradeDialogActionClicked, { conversationId = var1.conversationId })
        end

        var6(true)
        var7(AppChatNetworking.rodux.DuplicateConversation.API(var1.conversationId, "trusted_comms")):andThen(function(arg1)
            local responseBody = arg1.responseBody
            local id = responseBody and responseBody.conversations and responseBody.conversations[1] and responseBody.conversations[1].id
            if id then
                var1.navigateToConversation(id)
                return
            end
            var11()
        end):catch(function()
            var11()
        end):finally(
            function()
                var6(false)
            end
        )
    end, {
        var7,
        var6,
        var11,
        var1.navigateToConversation,
        var1.conversationId,
        var8
    })
    local onDismissed = useCallback(function()
        if var8 then
            var8.fireAnalyticsEvent(EventNames.ConversationUpgradeDialogDismissed, { conversationId = var1.conversationId })
        end

        var1.onDismissed()
    end, { var1.onDismissed, var8, var1.conversationId })

    return React.createElement(PartialModal, {
        titleText = var10.titleText,
        bodyText = if var9 then var10.bodyTextWithVoice else var10.bodyText,
        actionText = var10.actionText,
        cancelAlertText = var10.cancelAlertText,
        isButtonDisabled = isButtonDisabled,
        screenSize = var3,
        onActivated = onActivated,
        onDismissed = onDismissed,
        style = style
    })
end)
