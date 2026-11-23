-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local DataHydration = require(AppChatParent.DataHydration)
local Foundation = require(AppChatParent.Foundation)
local _MomentsTypes = require(AppChatParent.MomentsTypes)
local RoactUtils = require(AppChatParent.RoactUtils)
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local GameCardContainer = require(script.Parent.GameCardComponents.GameCardContainer)
local GameCardGroupable = require(script.Parent.GameCardComponents.GameCardGroupable)
local MomentShareCardContainer = require(script.Parent.MomentShareCard.MomentShareCardContainer)
local MomentAssetCard = require(script.Parent.MomentShareCard.MomentAssetCard)
local PlusReferralAssetCard = require(script.Parent.PlusReferralAssetCard.PlusReferralAssetCard)
local isAssetCardClassification = require(script.Parent.isAssetCardClassification)
local MessageGroupShape = require(AppChat.Components.ChatConversation.Grouping.MessageGroupShape)
local ShareLinkClassification = require(AppChat.Components.ChatConversation.Utils.RobloxUrlUtils.ShareLinkClassification)
local Constants = require(AppChat.Constants)
local ShareLinkV2Presentation = require(script.Parent.ShareLinkV2Presentation)
local getShareLinkV2Presentation = require(script.Parent.getShareLinkV2Presentation)
local var1 = require(AppChat.Logger):new(script.Name)

local useEffect = React.useEffect
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useScaledValue = Foundation.Hooks.useScaledValue

local GetShareLinkStore = require(AppChat.Stores.GetShareLinkStore)

local GetShareLinkV2Store = require(AppChat.Stores.GetShareLinkV2Store)

local FFlagAppChatResolveShareLinkV2 = require(AppChat.Flags.FFlagAppChatResolveShareLinkV2)
local FFlagAppChatMomentShareCard = require(AppChat.Flags.FFlagAppChatMomentShareCard)
local FFlagAppChatIntrinsicAssetCardHeight = require(AppChat.Flags.FFlagAppChatIntrinsicAssetCardHeight)
local FFlagAppChatShareLinkV2Fallbacks = require(AppChat.Flags.FFlagAppChatShareLinkV2Fallbacks)

local var2 = table.freeze({ direction = MessageGroupShape.Direction.Incoming, position = MessageGroupShape.Position.Only })

local function ShareLinkV1Container(tbl1)
    local linkId = tbl1.shareLink.linkId

    local linkType = tbl1.shareLink.linkType
    local shareLinkStore = GetShareLinkStore(false)
    local var3 = useSignalState(shareLinkStore.getShareLinkMetadataComputed(linkId))

    local var4 = useDispatch()
    useEffect(function()
        if not var3 then
            shareLinkStore.fetchShareLinkMetadata(var4, linkId, linkType)
            return
        end
        var1:warning("ShareLinkContainer: Missing linkId or linkType in props.")
    end, { linkId, linkType, var3 })

    return React.createElement(GameCardContainer, {
        universeId = if var3 then var3.universeId else nil,
        placeId = if var3 then var3.placeId else nil,
        conversationId = tbl1.conversationId,
        senderUserId = tbl1.senderUserId,
        onDetailsOpened = tbl1.onDetailsOpened,
        openGameDetailsPage = tbl1.openGameDetailsPage,
        networkImpl = tbl1.networkImpl,
        eventStream = tbl1.eventStream,
        eventIngest = tbl1.eventIngest,
        luaChatPlayTogetherEnabled = tbl1.luaChatPlayTogetherEnabled,
        isStartOfGroup = tbl1.isStartOfGroup,
        isIncoming = tbl1.isIncoming,
        isUnfiltered = tbl1.isUnfiltered,
        isPending = tbl1.isPending,
        isRepliedTo = tbl1.isRepliedTo,
        groupShape = tbl1.groupShape,
        mediaRef = tbl1.mediaRef
    })
end

local function ShareLinkV2Container(tbl1)
    local linkId = tbl1.shareLink.linkId
    local shareLinkV2Store = GetShareLinkV2Store(false)
    local var3 = React.useMemo(function()
        return shareLinkV2Store.getAndFetchClassification(linkId)
    end, { shareLinkV2Store, linkId })
    local var4 = useSignalState(var3.data)
    local var5 = if FFlagAppChatIntrinsicAssetCardHeight and FFlagAppChatMomentShareCard then useSignalState(var3.status) else nil
    local yOffset = if FFlagAppChatIntrinsicAssetCardHeight and FFlagAppChatMomentShareCard then useScaledValue(Constants.GameCard.THUMBNAIL_HEIGHT + Constants.GameCard.FOOTER_HEIGHT) else nil
    local var6 = if FFlagAppChatShareLinkV2Fallbacks then useSignalState(var3.status) else nil

    if isAssetCardClassification(var4) then
        local groupShape = tbl1.groupShape or var2
        if var4 and var4.type == ShareLinkClassification.PlusReferral then
            return React.createElement(
                PlusReferralAssetCard,
                {
                    referrerId = var4.referrerId,
                    groupShape = groupShape,
                    mediaRef = tbl1.mediaRef
                }
            )
        end

        if var4 and var4.type == ShareLinkClassification.Moment then
            return React.createElement(MomentAssetCard, {
                momentId = var4.momentId,
                targetIdType = var4.targetIdType,
                openMomentsDeepLink = tbl1.openMomentsDeepLink,
                groupShape = groupShape,
                mediaRef = tbl1.mediaRef
            })
        end
    end

    if FFlagAppChatMomentShareCard and var4 and var4.type == ShareLinkClassification.Moment then
        return React.createElement(MomentShareCardContainer, {
            momentId = var4.momentId,
            targetIdType = var4.targetIdType,
            openMomentsDeepLink = tbl1.openMomentsDeepLink,
            isStartOfGroup = tbl1.isStartOfGroup,
            isIncoming = tbl1.isIncoming,
            LayoutOrder = tbl1.LayoutOrder
        })
    elseif FFlagAppChatShareLinkV2Fallbacks and getShareLinkV2Presentation(var4, var6) == ShareLinkV2Presentation.Loading then
        return React.createElement(GameCardGroupable, { isLoading = true, gameName = "", gameThumbnail = "" })
    elseif FFlagAppChatIntrinsicAssetCardHeight and FFlagAppChatMomentShareCard and var5 == DataHydration.DataStatus.NotReady then
        return React.createElement(
            Foundation.View,
            {
                Size = UDim2.fromOffset(0, yOffset),
                testId = "ShareLinkPendingCard",
                LayoutOrder = tbl1.LayoutOrder
            }
        )
    end
    return nil
end

local function ShareLinkContainer(tbl1)
    if FFlagAppChatResolveShareLinkV2 and tbl1.shareLink.version == 2 then
        return React.createElement(ShareLinkV2Container, tbl1)
    end
    return React.createElement(ShareLinkV1Container, tbl1)
end

return ShareLinkContainer
