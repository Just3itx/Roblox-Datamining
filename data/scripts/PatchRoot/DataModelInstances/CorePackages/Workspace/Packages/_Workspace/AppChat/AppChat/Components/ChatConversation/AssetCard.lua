-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Roact = require(AppChatParent.Roact)
local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local ChatBubbleContainer = require(script.Parent.Bubble.ChatBubbleContainer)
local Constants = require(AppChat.Constants)
local Foundation = require(AppChatParent.Foundation)
local useScaledValue = Foundation.Hooks.useScaledValue
local GetTextSize = require(AppChatParent.Style).GetTextSize

local PlaceIdContainer = require(AppChat.Components.ChatConversation.ShareLinkComponents.GameCardComponents.PlaceIdContainer)

local GameCardContainer = require(AppChat.Components.ChatConversation.ShareLinkComponents.GameCardComponents.GameCardContainer)
local ShareLinkContainer = require(AppChat.Components.ChatConversation.ShareLinkComponents.ShareLinkContainer)
local ShareLinkV2Presentation = require(AppChat.Components.ChatConversation.ShareLinkComponents.ShareLinkV2Presentation)

local useShareLinkV2Presentation = require(AppChat.Components.ChatConversation.ShareLinkComponents.useShareLinkV2Presentation)
local PlainText = require(script.Parent.PlainText)
local ChatMessageContainerConstants = require(script.Parent.ChatMessageContainerConstants)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local ChatBubbleEnum = require(script.Parent.Bubble.ChatBubbleEnum)
local RepliedToMarker = require(script.Parent.Bubble.RepliedToMarker)
local toMessageGroupShape = require(script.Parent.Grouping.toMessageGroupShape)

local isAssetCardClassification = require(AppChat.Components.ChatConversation.ShareLinkComponents.isAssetCardClassification)
local GetShareLinkV2Store = require(AppChat.Stores.GetShareLinkV2Store)

local FFlagAppChatShareLinkV2Fallbacks = require(AppChat.Flags.FFlagAppChatShareLinkV2Fallbacks)
local FFlagAppChatFullPlaintextBeforeGameCards = require(AppChat.Flags.FFlagAppChatFullPlaintextBeforeGameCards)

local FFlagAppChatIntrinsicAssetCardHeight = require(AppChat.Flags.FFlagAppChatIntrinsicAssetCardHeight)
local FFlagAppChatResolveShareLinkV2 = require(AppChat.Flags.FFlagAppChatResolveShareLinkV2)
local FFlagAppChatPlusReferralAssetCard = require(AppChat.Flags.FFlagAppChatPlusReferralAssetCard)
local FFlagAppChatMomentAssetCard = require(AppChat.Flags.FFlagAppChatMomentAssetCard)
local FFlagAppChatGameAssetCard = require(AppChat.Flags.FFlagAppChatGameAssetCard)

local BUBBLE_PADDING = ChatMessageContainerConstants.BUBBLE_PADDING
local TEXT_BUBBLE_X_PADDING = ChatMessageContainerConstants.TEXT_BUBBLE_X_PADDING
local TEXT_BUBBLE_X_WIDE_ADDITIONAL_PADDING = ChatMessageContainerConstants.TEXT_BUBBLE_X_WIDE_ADDITIONAL_PADDING

local tbl1 = {
    additionalProps = {
        shareLink = nil,
        placeId = nil,
        universeId = nil,
        senderUserId = nil,
        onDetailsOpened = function() end,
        openGameDetailsPage = function() end
    },
    hasTail = false,
    innerPadding = 0,
    isIncoming = false,
    isPending = true,
    isUnfiltered = false,
    isLastMessageInMessageGroup = false,
    maxWidth = 0,
    parentWidth = 0,
    wideMode = false
}

local signal = Signals.createSignal(nil)

local function useRendersAssetCardView(shareLink)
    local linkId = if FFlagAppChatResolveShareLinkV2 and shareLink and shareLink.version == 2 then shareLink.linkId else nil
    local shareLinkV2Store = GetShareLinkV2Store(false)
    local var1 = React.useMemo(function()
        if linkId then
            return (shareLinkV2Store.getAndFetchClassification(linkId))
        end

        return nil
    end, { shareLinkV2Store, linkId or "" })
    local var2 = SignalsReact.useSignalState(if var1 then var1.data else signal)

    if linkId == nil then
        return FFlagAppChatGameAssetCard
    end
    return isAssetCardClassification(var2)
end

local function renderAssetCardViewRow(arg1, card)
    return React.createElement(Foundation.View, {
        tag = "auto-xy",
        testId = "AssetCardRow",
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = if arg1.isIncoming then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, ChatBubbleEnum.REPLIED_TO_MARKER_GAP)
        },
        LayoutOrder = arg1.LayoutOrder
    }, {
        Card = React.createElement(Foundation.View, { tag = "auto-xy", LayoutOrder = 1 }, { Card = card }),
        RepliedToMarker = if arg1.isRepliedTo then React.createElement(RepliedToMarker, { isIncoming = arg1.isIncoming, layoutOrder = if arg1.isIncoming then 0 else 2 }) else nil
    })
end

local function AssetCardTemp(arg1)
    local var1 = Cryo.Dictionary.union(tbl1, arg1)

    local var2 = Cryo.Dictionary.union(tbl1.additionalProps, var1.additionalProps)
    local var3 = if var2.shareLink then ShareLinkContainer else var2.placeId and PlaceIdContainer or GameCardContainer
    local isPending = var1.isPending

    local var4 = useScaledValue(Constants.GameCard.THUMBNAIL_WIDTH)
    local var5 = useScaledValue(Constants.GameCard.THUMBNAIL_HEIGHT + Constants.GameCard.FOOTER_HEIGHT)
    local var6

    if FFlagAppChatShareLinkV2Fallbacks then
        local shareLink = var2.shareLink

        var6 = useShareLinkV2Presentation(if shareLink and shareLink.version == 2 then shareLink.linkId else nil)
    else
        var6 = nil
    end

    local var7, var8

    if FFlagAppChatPlusReferralAssetCard or FFlagAppChatMomentAssetCard or FFlagAppChatGameAssetCard then
        var7 = useRendersAssetCardView(var2.shareLink)
        var8 = React.useMemo(function()
            return toMessageGroupShape(var1.hasTail, var1.isLastMessageInMessageGroup, var1.isRepliedTo, var1.isIncoming)
        end, {
            var1.hasTail,
            var1.isLastMessageInMessageGroup,
            var1.isRepliedTo,
            var1.isIncoming
        })
    else
        var7 = false
        var8 = nil
    end

    if var6 == ShareLinkV2Presentation.Fallback then
        local url = var2.shareLink.url

        if FFlagAppChatFullPlaintextBeforeGameCards or url == nil then
            return nil
        end

        local x = var1.parentWidth - (TEXT_BUBBLE_X_PADDING + BUBBLE_PADDING) * 2 - (if var1.wideMode then TEXT_BUBBLE_X_WIDE_ADDITIONAL_PADDING else 0)
        local textSize = GetTextSize(url, var1.textSize, var1.font, Vector2.new(x, 10000))
        return Roact.createElement(PlainText, {
            text = url,
            font = var1.font,
            textSize = var1.textSize,
            innerPadding = var1.innerPadding,
            maxWidth = textSize.X + BUBBLE_PADDING * 2,
            hasTail = var1.hasTail,
            isIncoming = var1.isIncoming,
            isPending = var1.isPending,
            isUnfiltered = var1.isUnfiltered,
            isRepliedTo = var1.isRepliedTo,
            isPressed = var1.isPressed,
            isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup,
            bubbleRef = var1.bubbleRef,
            LayoutOrder = var1.LayoutOrder,
            [Roact.Change.AbsoluteSize] = var1[Roact.Change.AbsoluteSize]
        })
    end

    var2.isStartOfGroup = var1.hasTail
    var2.isIncoming = var1.isIncoming
    var2.isUnfiltered = var1.isUnfiltered
    var2.isPending = var1.isPending
    var2.isRepliedTo = var1.isRepliedTo

    if var7 then
        return renderAssetCardViewRow(
            var1,
            Roact.createElement(var3, Cryo.Dictionary.join(var2, { groupShape = var8, mediaRef = var1.bubbleRef }))
        )
    end

    local createElement = Roact.createElement
    local var9 = ChatBubbleContainer
    local tbl2 = {
        hasTail = var1.hasTail,
        isIncoming = var1.isIncoming,
        isPending = isPending,
        isUnfiltered = nil,
        isAssetCard = true,
        LayoutOrder = var1.LayoutOrder,
        padding = 0,
        isLastMessageInMessageGroup = var1.isLastMessageInMessageGroup or tbl1.isLastMessageInMessageGroup,
        bubbleRef = var1.bubbleRef,
        [Roact.Change.AbsoluteSize] = var1[Roact.Change.AbsoluteSize]
    }
    local tbl3 = {
        AssetCard = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = if FFlagAppChatIntrinsicAssetCardHeight then UDim2.fromOffset(var4 or 256, 0) else UDim2.fromOffset(var4 or 256, var5 or 208),
            AutomaticSize = Enum.AutomaticSize.XY
        }, {
            Card = Roact.createElement(var3, var2)
        })
    }
    return createElement(var9, tbl2, tbl3)
end

return AssetCardTemp
