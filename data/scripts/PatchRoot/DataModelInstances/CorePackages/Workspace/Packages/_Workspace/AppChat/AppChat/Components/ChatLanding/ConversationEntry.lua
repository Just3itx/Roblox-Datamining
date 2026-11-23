-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local HttpService = game:GetService("HttpService")

local React = require(AppChatParent.React)
local memo = React.memo
local useMemo = React.useMemo
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local useRelativeTimestampBinding = require(AppChat.Hooks.useRelativeTimestampBinding)
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)

local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset
local Cryo = require(AppChatParent.Cryo)

local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local GetTextSize = require(AppChatParent.Style).GetTextSize

local getBoldTextTheme = require(script.Parent.Utils.getBoldTextTheme)

local ConversationCell = require(AppChat.Components.Cells).ConversationCell
local ConversationRelativeTimestamp = require(script.Parent.ConversationRelativeTimestamp)
local DomLocators = require(AppChat.Utils.DomLocators)
local SquadJoinButton = require(AppChatParent.Squads.SquadJoinButton)
local SquadButtonSourceEnum = require(AppChatParent.Squads.Enums).SquadButtonSourceEnum
local SquadComponentAccessWrapper = require(AppChatParent.Squads.SquadComponentAccessWrapper)

local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useNavigation = require(AppChatParent.Navigation).useNavigation
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local useActivationOnFocus = require(AppChatParent.FocusNavigationUtils).useActivationOnFocus

local getFFlagDebugAppChat = require(AppChat.Flags.getFFlagDebugAppChat)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagAppChatTimestampInSubtitle = require(AppChat.Flags.FFlagAppChatTimestampInSubtitle)
local FFlagAppChatUseActivationOnFocus = require(AppChatParent.SharedFlags).FFlagAppChatUseActivationOnFocus
local conversationFocusActivationDelaySeconds = require(AppChat.Flags.conversationFocusActivationDelaySeconds)
local FFlagAppChatEnableU13ChatOptIn = require(AppChatParent.SharedFlags).FFlagAppChatEnableU13ChatOptIn

local useTelemetry = require(AppChat.Telemetry.useTelemetry)
local ChatLandingTelemetryLayer = require(AppChat.Telemetry.Layers.ChatLandingTelemetryLayer)

local Constants = require(AppChat.Constants)

local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)

local EnumScreens = require(AppChat.EnumScreens)
local Conversation = require(AppChat.Models.Conversation)
local shouldShowOSAForConversation = require(AppChat.Utils.shouldShowOSAForConversation)
local shouldShowU13ChatOptInForConversation = require(AppChat.Utils.shouldShowU13ChatOptInForConversation)

local GetOverlayStore = require(AppChat.Stores.GetOverlayStore)
local OverlayTypes = require(AppChat.Stores.GetOverlayStore.OverlayTypes)
local useChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext).useChatPlacementContext

local useCanAccessParty = require(AppChatParent.Squads.useCanAccessParty)

local _types = require(AppChat.types)

local tbl1 = {
    entryHeight = 64,
    boldTitle = true,
    onSquadJoinButtonActivated = function() end
}

return memo(function(tbl2) -- name: ConversationEntry
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = useTokens()
    local var4 = useTextSizeOffset()
    local var5 = useTelemetry(ChatLandingTelemetryLayer.Context)
    local conversation = var1.conversation
    local hasGroupUp = conversation.hasGroupUp

    local var6 = useIsUserPending(conversation)
    local hasUnreadMessages = conversation.hasUnreadMessages and not var6

    local boldTitle = hasUnreadMessages and not hasUnreadMessages
    if boldTitle then
        var2 = getBoldTextTheme(var2)
    end
    local var9 = useDispatch()
    local var10 = useChatPlacementContext()
    local var11 = useChatPagePadding()

    local captionSubHeader = var2.Font.CaptionSubHeader
    local var12 = var2.Font.BaseSize * captionSubHeader.RelativeSize
    local shortRelativeTime = var1.conversation.shortRelativeTime or ""
    local timestampText = useRelativeTimestampBinding(var1.conversation.unixTime)

    local var14 = useMemo(function()
        return GetTextSize(shortRelativeTime, var12, var3.Typography.CaptionLarge.Font, Vector2.new(10000, 10000)).X
    end, {
        shortRelativeTime,
        captionSubHeader.Font,
        var12,
        var4,
        var3.Typography.CaptionLarge.Font
    })

    local subTitleTimestamp = if FFlagAppChatTimestampInSubtitle then timestampText else nil
    local ref = React.useRef(nil)
    local var17 = useNavigation()
    local screenProps = false
    if var17.getScreenProps then
        screenProps = var17.getScreenProps("wideMode", screenProps)
    end
    React.useEffect(function()
        var1.fireImpressionEvent(var1.conversation)
    end, {})

    local overlayStore = GetOverlayStore(false)

    local var18 = React.useCallback(function(conversationId: string)
        var17.navigate(EnumScreens.ChatConversation, { conversationId = conversationId, isNavigatedFromGroupOSAJoin = true })
    end, { var17 })

    local var19 = React.useCallback(function(conversationId: string, impressionId: string?, modalVariant: string?, multiUserConversation: string?, callback: ((...any) -> (...any))?)
        overlayStore.showOverlay(OverlayTypes.GroupOSADialog, {
            conversationId = conversationId,
            impressionId = impressionId,
            modalVariant = modalVariant,
            onJoin = function()
                overlayStore.dismissOverlay()
                if callback then
                    callback(conversationId)
                    return
                end
                var18(conversationId)
            end,
            onDecline = function()
                if conversationId and multiUserConversation == Conversation.Type.MULTI_USER_CONVERSATION then
                    var9(RemovedConversation(conversationId))
                end
                overlayStore.dismissOverlay()
            end
        })
    end, { var18, var9 })

    local onActivated = React.useCallback(function(arg1)
        local var20 = nil
        local var21 = nil
        if shouldShowU13ChatOptInForConversation(arg1) then
            var21 = Constants.OptInVariant.ChatOptInInfoCard
        elseif shouldShowOSAForConversation(arg1) then
            var21 = Constants.OptInVariant.OsaContextCard
        end

        if var21 then
            var20 = HttpService:GenerateGUID(false)
            var19(arg1.id, var20, var21, arg1.conversationType)
        elseif var1.onActivated then
            var1.onActivated(arg1)
        end

        var1.fireClickEvent(arg1, var5, var20)
    end, {
        var19,
        var1.onActivated,
        var1.fireClickEvent,
        var5
    })

    local onSquadJoinButtonActivated = var1.onSquadJoinButtonActivated
    local var7 = React.useCallback(function(str1: string)
        local var21 = nil
        if shouldShowOSAForConversation(conversation) then
            var21 = Constants.OptInVariant.OsaContextCard
        elseif FFlagAppChatEnableU13ChatOptIn
            and shouldShowU13ChatOptInForConversation(conversation)
            and conversation.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
        then
            var21 = Constants.OptInVariant.ChatOptInInfoCard
        end

        if var21 and var19 then
            local str2 = HttpService:GenerateGUID(false)
            var19(str1, str2, var21, conversation.conversationType, onSquadJoinButtonActivated)
        elseif onSquadJoinButtonActivated then
            onSquadJoinButtonActivated(str1)
        end
    end, { var19, conversation, onSquadJoinButtonActivated })

    if FFlagAppChatUseActivationOnFocus then
        useActivationOnFocus(screenProps, ref, function()
            onActivated(conversation)
        end, function(arg1)
            return if arg1 then arg1.cell else nil
        end, function()
            return conversation and conversation.id
        end, nil, conversationFocusActivationDelaySeconds)
    else
        local var22 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
        React.useEffect(function()
            if not (screenProps and onActivated and var22) then
                return function() end
            end

            local var23 = var22.focusedGuiObject:subscribe(function(cell)
                if ref.current and cell == ref.current.cell then
                    onActivated(conversation)
                end
            end)
            return function()
                var23:unsubscribe()
            end
        end, { onActivated, screenProps, var22 })
    end

    local var22 = var1.children or {}

    local size1900 = var3.Size.Size_1900

    local var23 = useCanAccessParty()

    local var24 = if hasUnreadMessages then var3.Size.Size_200 + var3.Gap.XSmall else 0

    local right = var11.right
    local childWidth = if var23 and hasGroupUp then right + size1900 elseif FFlagAppChatTimestampInSubtitle then if hasUnreadMessages then var3.Gap.Medium + var3.Size.Size_200 else 0 else var14 + var24 + right
    local var26

    if var23 and hasGroupUp and conversation.id then
        local createElement = React.createElement
        local var27 = SquadComponentAccessWrapper
        local tbl3 = {
            parentChannelId = conversation.id
        }
        local createElement2 = React.createElement
        local str1 = "Frame"
        local tbl4 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, size1900, 1, 0),
            LayoutOrder = 2
        }
        local tbl5 = {}
        local tbl6 = {
            layout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            padding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 0) }),
            button = React.createElement(SquadJoinButton, {
                conversationId = conversation.id,
                isFullWidth = false,
                isInCard = false,
                layoutOrder = 0,
                onActivated = var7,
                Selectable = false,
                shouldAnimate = false,
                squadLocation = var10.chatPlacement,
                squadButtonSource = SquadButtonSourceEnum.ConversationEntry,
                testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingConversationEntrySquadButton(conversation.title) else nil
            })
        }
        var26 = createElement(var27, tbl3, { createElement2(str1, tbl4, tbl5, tbl6) })
    else
        var26 = nil
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = UDim2.new(1, 0, 0, var1.entryHeight),
        BackgroundTransparency = 1,
        ref = ref
    }
    local tbl4 = {
        cell = React.createElement(
            ConversationCell,
            {
                Size = UDim2.new(1, 0, 0, var1.entryHeight),
                conversation = var1.conversation,
                childWidth = childWidth,
                subTitleText = if getFFlagDebugAppChat() then var1.conversation.id else var1.conversation.lastMessageContent,
                subTitleTimestamp = subTitleTimestamp,
                onActivated = onActivated,
                style = var2,
                boldTitle = boldTitle,
                hideLeftAvatarPadding = true,
                onSquadJoinButtonActivated = var1.onSquadJoinButtonActivated,
                paddingLeft = var11.left,
                paddingRight = var11.right,
                testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatLandingConversationEntry(conversation.title) else nil
            },
            Cryo.Dictionary.join(var22, {
                timeStamp = if var26 or FFlagAppChatTimestampInSubtitle then nil else React.createElement(
                    ConversationRelativeTimestamp,
                    { timestampText = timestampText, hasUnreadMessages = hasUnreadMessages }
                ),
                unreadDot = if FFlagAppChatTimestampInSubtitle and not var26 and hasUnreadMessages then React.createElement(Foundation.View, { tag = "size-200-200 radius-circle bg-action-emphasis" }) else nil,
                squadButton = var26
            })
        )
    }
    return createElement(str1, tbl3, tbl4)
end)
