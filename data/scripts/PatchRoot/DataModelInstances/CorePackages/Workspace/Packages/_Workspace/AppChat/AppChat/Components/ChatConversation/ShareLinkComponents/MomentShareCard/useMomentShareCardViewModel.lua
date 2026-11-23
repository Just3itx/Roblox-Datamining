-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local _MomentsTypes = require(AppChatParent.MomentsTypes)
local RoactUtils = require(AppChatParent.RoactUtils)
local UserProfiles = require(AppChatParent.UserProfiles)

local _MomentShareCardView = require(script.Parent.MomentShareCardView)

local MomentDetailsStatus = require(script.Parent.MomentDetailsStatus)
local buildMomentShareCardMedia = require(script.Parent.buildMomentShareCardMedia)

local getMomentShareCardCornerRadii = require(script.Parent.getMomentShareCardCornerRadii)
local resolveMomentShareCardMetadataText = require(script.Parent.resolveMomentShareCardMetadataText)
local useExperienceName = require(script.Parent.useExperienceName)
local useIsMomentsViewingEligible = require(script.Parent.useIsMomentsViewingEligible)
local useMomentDetails = require(script.Parent.useMomentDetails)
local useMomentShareCardVideoFrame = require(script.Parent.useMomentShareCardVideoFrame)

local Constants = require(AppChat.Constants)
local FFlagAppChatMomentShareCardLoadingSkeletons = require(AppChat.Flags.FFlagAppChatMomentShareCardLoadingSkeletons)
local FFlagAppChatMomentShareCardEdgeCases = require(AppChat.Flags.FFlagAppChatMomentShareCardEdgeCases)
local FFlagAppChatUseUserProfileHydration = require(AppChat.Flags.FFlagAppChatUseUserProfileHydration)
local useProfileName = require(AppChat.Hooks.useProfileName)
local DataStatus = require(AppChatParent.DataHydration).DataStatus

local useScaledValue = Foundation.Hooks.useScaledValue
local useAssetFetchStatus = RoactUtils.Hooks.useAssetFetchStatus
local useTokens = Foundation.Hooks.useTokens

local function useMomentShareCardViewModel(tbl1)
    local var1 = useMomentDetails(tbl1.momentId, tbl1.targetIdType)
    local status = var1.status
    local mediaSize = useScaledValue(Constants.GameCard.THUMBNAIL_WIDTH)
    local var3 = useTokens()
    local var4 = not FFlagAppChatMomentShareCardEdgeCases or useIsMomentsViewingEligible()

    local var5 = FFlagAppChatMomentShareCardEdgeCases and not var4

    local creatorId = var1.creatorId
    local var6 = nil
    local var7 = nil
    if FFlagAppChatUseUserProfileHydration then
        var7 = useProfileName(if creatorId then tostring(creatorId) else nil)
    else
        var6 = UserProfiles.Hooks.useUserProfilesFetch({
            userIds = creatorId and { tostring(creatorId) } or {},
            query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
        })
    end

    local username = if FFlagAppChatUseUserProfileHydration then var7.username elseif creatorId and var6.data then UserProfiles.Selectors.getUsernameFromId(var6.data, creatorId) else nil
    local var9 = resolveMomentShareCardMetadataText(var1.description, nil, nil)
    local var10 = resolveMomentShareCardMetadataText(nil, var1.experienceName, nil)
    local bool1 = var9 == nil and var10 == nil
    local var11 = useExperienceName(var1.universeId, bool1)

    local metadataText = resolveMomentShareCardMetadataText(var9, var10, var11.name)
    local bool2 = status == MomentDetailsStatus.Loading
    local bool3 = if FFlagAppChatUseUserProfileHydration then not (creatorId == nil) and var7.status == DataStatus.NotReady else not (creatorId == nil) and (var6.loading == true or var6.isRetrying == true)
    local var13 = FFlagAppChatMomentShareCardLoadingSkeletons

    if var13 then
        if username == nil then
            var13 = bool2 or bool3
        else
            var13 = false
        end
    end
    local var14 = FFlagAppChatMomentShareCardLoadingSkeletons

    if var14 then
        if metadataText == nil then
            var14 = bool2 or var11.isLoading
        else
            var14 = false
        end
    end

    local assetId = var1.assetId
    local captureType = var1.captureType
    local assetAccessContext = var1.assetAccessContext
    local var15 = React.useMemo(function()
        if var5 or status ~= MomentDetailsStatus.Ready then
            return nil
        end
        return buildMomentShareCardMedia({ assetId = assetId, captureType = captureType, assetAccessContext = assetAccessContext })
    end, {
        var5,
        status,
        assetId,
        captureType,
        assetAccessContext
    })

    local isVideo = not (var15 == nil) and var15.captureType == Enum.CaptureType.Video
    local content = if var15 == nil or var15.captureType ~= Enum.CaptureType.Video then nil else var15.content
    local var16 = useMomentShareCardVideoFrame(content)
    local posterContent = if var15 == nil then nil elseif isVideo then var16 else var15.posterContent
    local uri = if isVideo or posterContent == nil then nil else posterContent.Uri
    local bool5 = useAssetFetchStatus(uri) == Enum.AssetFetchStatus.Success
    if isVideo then
        bool5 = var16 ~= nil
    end

    local size500 = var3.Size.Size_500

    local cornerRadii = React.useMemo(function()
        return getMomentShareCardCornerRadii(tbl1.isStartOfGroup, tbl1.isIncoming, size500)
    end, { tbl1.isStartOfGroup, tbl1.isIncoming, size500 })

    local openMomentsDeepLink = tbl1.openMomentsDeepLink
    local onActivated = React.useCallback(function()
        if var5 then
            return
        end
        if openMomentsDeepLink and var1.status == MomentDetailsStatus.Ready then
            openMomentsDeepLink(tbl1.momentId, tbl1.targetIdType)
        end
    end, {
        var5,
        openMomentsDeepLink,
        var1.status,
        tbl1.momentId,
        tbl1.targetIdType
    })

    local tbl2 = {
        status = if var5 then MomentDetailsStatus.Locked else var1.status,
        mediaSize = mediaSize,
        hasMedia = not var5 and (status == MomentDetailsStatus.Loading or var15 ~= nil),
        isVideo = isVideo,
        playIconStyle = var3.Color.Content.Emphasis,
        posterContent = posterContent,
        isPosterLoaded = bool5,
        cornerRadii = cornerRadii,
        username = username,
        metadataText = metadataText,
        isUsernameLoading = var13,
        isMetadataLoading = var14,
        onActivated = onActivated,
        selectable = 0,
        LayoutOrder = 0
    }
    local bool6 = not var5

    if bool6 then
        if status == MomentDetailsStatus.Ready then
            bool6 = openMomentsDeepLink ~= nil
        else
            bool6 = false
        end
    end

    tbl2.selectable = bool6
    tbl2.LayoutOrder = tbl1.LayoutOrder
    return tbl2
end

return useMomentShareCardViewModel
