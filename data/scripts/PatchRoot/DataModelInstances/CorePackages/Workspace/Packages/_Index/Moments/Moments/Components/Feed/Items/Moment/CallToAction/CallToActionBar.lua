-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local Button = Foundation.Button
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local IconSize = Foundation.Enums.IconSize
local Radius = Foundation.Enums.Radius
local getRbxThumb = Foundation.Utility.getRbxThumb
local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue
local useLocalization = Localization.Hooks.useLocalization
local useSignalState = SignalsReact.useSignalState

local useExperienceDetails = require(Moments.Hooks.useExperienceDetails)
local useIsTvRemoteDevice = require(MomentsParent.RoactUtils).Hooks.useIsTvRemoteDevice

local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local GetFFlagMomentsAndroidTvEnabled = require(Moments.Flags.GetFFlagMomentsAndroidTvEnabled)

local ImageWithSkeleton = require(Moments.Components.ImageWithSkeleton)
local FeedContext = require(Moments.Components.Feed.FeedContext)
local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local MomentContext = require(script.Parent.Parent.MomentContext)

local getExperienceDetailsSheetStore = require(Moments.ExperienceDetailsSheet.Sheet.getExperienceDetailsSheetStore)
local JoinButton = require(Moments.ExperienceDetailsSheet.Join.JoinButton)
local PostStatusRowContainer = require(Moments.Components.PostFeedback.PostStatusRow.PostStatusRowContainer)
local usePendingMomentRecord = require(Moments.Components.PostFeedback.usePendingMomentRecord)
local FFlagMomentsServeEDPVideos = require(MomentsParent.SharedFlags).FFlagMomentsServeEDPVideos
local FFlagMomentsPostFeedback = require(MomentsParent.SharedFlags).FFlagMomentsPostFeedback

local bool1 = game:DefineFastFlag("MomentsFixExperienceHandleVerifiedSpacing", false)

local FFlagMomentsFixRecommendationImpressionLifecycle = require(Moments.Flags.FFlagMomentsFixRecommendationImpressionLifecycle)
local FFlagMomentsUpdateExperienceActionLabelText = require(Moments.Flags.FFlagMomentsUpdateExperienceActionLabelText)
local FFlagMomentsJoinImpression = require(Moments.Flags.FFlagMomentsJoinImpression)
local FFlagMomentsFollowingFeed = require(Moments.Flags.FFlagMomentsFollowingFeed)
local FFlagMomentsRecommendationFeedType = require(Moments.Flags.FFlagMomentsRecommendationFeedType)
local VerifiedBadge = if bool1 then require(MomentsParent.VerifiedBadges.VerifiedBadge) else nil
local tbl1 = {
    join = if FFlagMomentsUpdateExperienceActionLabelText then "Feature.Moments.Action.Play" else "Feature.Moments.Action.Join"
}

local str1 = utf8.char(57344)

return React.memo(function(tbl2) -- name: CallToActionBar
    local var1 = useLocalization(tbl1)
    local var2 = useTokens()
    local store = MomentContext.useMoment().store
    local data = store.getData(false)
    local bool2 = data.kind == "ad"
    local advertiser = if data.kind == "ad" then data.advertiser else nil
    local var3 = if data.kind ~= "experience" then 0 else data.placeId
    local universeId = if data.kind ~= "experience" then 0 else data.universeId

    local isDisabled = useSignalState(GetMomentsPreferencesStore(false).getIsTeleporting)
    local var4 = useSignalState(store.getIsModerated)
    local fFlagMomentsAndroidTvEnabled = GetFFlagMomentsAndroidTvEnabled()
    local var7 = useIsTvRemoteDevice()

    local var8 = useExperienceDetails(if bool2 then nil else universeId)
    if FFlagMomentsServeEDPVideos and var3 == 0 and var8.rootPlaceId ~= nil then
        var3 = var8.rootPlaceId
    end
    local var9 = FFlagMomentsServeEDPVideos and not bool2

    if var9 then
        if universeId == 0 then
            var9 = false
        else
            var9 = var3 == 0
        end
    end

    local xOffset = useScaledValue(160)
    local var10 = if FFlagMomentsFixRecommendationImpressionLifecycle or FFlagMomentsFollowingFeed or FFlagMomentsRecommendationFeedType then FeedContext.useFeedOptional() else nil
    local recommendationSource = if (FFlagMomentsFollowingFeed or FFlagMomentsRecommendationFeedType) and var10 ~= nil then var10.recommendationSource else nil
    local var11 = if FFlagMomentsPostFeedback then usePendingMomentRecord(data.momentId) else nil
    local image = if bool2 then if advertiser then advertiser.iconImage else nil elseif universeId ~= 0 then getRbxThumb(Foundation.Enums.ThumbnailType.GameIcon, universeId) else getRbxThumb(Foundation.Enums.ThumbnailType.Asset, var3)

    if var11 ~= nil and data.kind == "experience" and data.isPending then
        return React.createElement(PostStatusRowContainer, { momentId = data.momentId, LayoutOrder = tbl2.LayoutOrder })
    end

    if not bool2 and var3 == 0 and not var9 then
        return nil
    end

    local var13 = if FFlagMomentsServeEDPVideos and var9 then nil elseif bool2 then if advertiser then advertiser.title else nil else var8.name
    local var14 = if FFlagMomentsServeEDPVideos and var9 then nil elseif bool2 then if advertiser then advertiser.subtitle else nil else var8.creatorName
    local bool3 = if bool2 then not (advertiser == nil) and advertiser.isVerified else var8.isCreatorVerified == true
    local text = if bool2 and advertiser then advertiser.ctaText else var1.join

    if not bool1 and var14 and bool3 then
        var14 = `{var14} {str1}`
    end

    local size1000 = var2.Size.Size_1000

    local thumbnail = React.createElement(ImageWithSkeleton, {
        LayoutOrder = 1,
        Image = image,
        Size = UDim2.fromOffset(size1000, size1000),
        radius = Radius.Medium,
        backgroundStyle = var2.Color.Shift.Shift_300
    })

    local createElement = React.createElement
    local var16 = View
    local tbl3 = { LayoutOrder = 2, tag = "col align-x-left align-y-center grow gap-xsmall auto-y" }

    local tbl4 = {
        Title = if var13 then React.createElement(FoundationText, {
            LayoutOrder = 1,
            tag = "size-full-0 auto-y text-title-medium text-align-x-left text-align-y-top text-truncate-end content-emphasis",
            Text = var13
        }) else React.createElement(Skeleton, {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(xOffset, var2.Size.Size_400),
            testId = if FFlagMomentsServeEDPVideos then "moments-experience-title-skeleton" else nil
        }),
        Subtitle = 0
    }
    local element2

    if bool1 and var14 then
        element2 = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-x-left align-y-center gap-xsmall size-full-0 auto-y",
            testId = "moments-experience-handle"
        }, {
            Handle = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "shrink auto-xy text-body-medium text-align-x-left text-align-y-center text-truncate-end content-default",
                Text = var14
            }),
            VerifiedBadge = if bool3 then React.createElement(
                VerifiedBadge,
                {
                    LayoutOrder = 2,
                    size = IconSize.XSmall,
                    testId = "moments-experience-verified-badge"
                }
            ) else nil
        })
    elseif var14 then
        element2 = React.createElement(FoundationText, {
            LayoutOrder = 2,
            tag = "auto-xy text-body-medium text-align-x-left text-align-y-center text-truncate-end content-default",
            Text = var14
        })
    else
        element2 = nil
    end

    tbl4.Subtitle = element2
    local metadata = createElement(var16, tbl3, tbl4)

    local createElement2 = React.createElement
    local var17 = View

    local tbl5 = {
        LayoutOrder = 1,
        tag = "row align-x-left align-y-center grow gap-medium auto-y",
        testId = "moments-experience-row",
        onActivated = not bool2 and not var4 and (not FFlagMomentsServeEDPVideos or var3 ~= 0) and function()
            getExperienceDetailsSheetStore(false).open({
                placeId = var3,
                universeId = universeId,
                feedItemId = data.feedItemId,
                tracingId = data.feedSessionId,
                contentType = data.contentType,
                recommendationSource = recommendationSource,
                onBeforeJoin = if FFlagMomentsFixRecommendationImpressionLifecycle and var10 ~= nil then var10.flushView else nil
            })
        end or nil,
        stateLayer = not bool2
            and not var4
            and (not FFlagMomentsServeEDPVideos or var3 ~= 0)
            and {
                affordance = Foundation.Enums.StateLayerAffordance.None
            }
            or nil,
        selection = if fFlagMomentsAndroidTvEnabled then var7 and { Selectable = false } or nil else nil
    }

    local mediaAndMetadata = createElement2(var17, tbl5, { Thumbnail = thumbnail, Metadata = metadata })

    local createElement3 = React.createElement
    local var18 = View
    local tbl6 = {
        LayoutOrder = tbl2.LayoutOrder,
        tag = "row align-x-left align-y-center gap-medium size-full-0 auto-y"
    }
    local tbl7 = { MediaAndMetadata = mediaAndMetadata, CtaButton = 0 }
    local element4

    if fFlagMomentsAndroidTvEnabled and var7 then
        element4 = nil
    elseif bool2 then
        element4 = React.createElement(Button, {
            LayoutOrder = 2,
            isDisabled = isDisabled or var4,
            onActivated = function() end,
            size = Foundation.Enums.InputSize.Medium,
            text = text,
            variant = Foundation.Enums.ButtonVariant.Emphasis
        })
    elseif FFlagMomentsServeEDPVideos and var3 == 0 then
        element4 = nil
    else
        element4 = React.createElement(JoinButton, {
            LayoutOrder = 2,
            context = {
                placeId = var3,
                universeId = universeId,
                feedItemId = data.feedItemId,
                tracingId = data.feedSessionId,
                contentType = data.contentType,
                recommendationSource = recommendationSource
            },
            text = text,
            isDisabled = var4 or not FFlagMomentsServeEDPVideos and var3 == 0,
            reportsImpression = FFlagMomentsJoinImpression
        })
    end

    tbl7.CtaButton = element4
    return createElement3(var18, tbl6, tbl7)
end)
