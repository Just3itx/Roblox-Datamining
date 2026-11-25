-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin
local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local getRbxThumb = Foundation.Utility.getRbxThumb
local useTokens = Foundation.Hooks.useTokens
local Radius = Foundation.Enums.Radius
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local ThumbnailType = Foundation.Enums.ThumbnailType
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local Enums = require(ProfilePlatform.Common.Enums)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local NetworkingGames = require(ProfilePlatform.Networking.NetworkingGames)

local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation
local OpenGameDetails = require(ProfilePlatformParent.GameDetail).OpenGameDetails
local RoactAnalyticsCommonGameEvents = require(ProfilePlatformParent.RoactServiceTags).RoactAnalyticsCommonGameEvents
local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local ContentProvider = game:GetService("ContentProvider")

local FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail = require(ProfilePlatform.Flags.FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail)
local FFlagProfileCurrentlyPlayingEDPFromCard = require(ProfilePlatform.Flags.FFlagProfileCurrentlyPlayingEDPFromCard)

local FFlagProfilePlatformImproveGameDetailsAnalytics = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformImproveGameDetailsAnalytics
local FFlagJoinabilityCTAContextCopy = require(ProfilePlatformParent.SharedFlags).FFlagJoinabilityCTAContextCopy

local function CurrentlyPlaying(tbl1)
    local var1 = useTokens()
    local var2 = useProfileJsonComponent(Enums.Components.CurrentlyPlaying)
    local var3 = useDispatch()
    local var4 = if FFlagProfileCurrentlyPlayingEDPFromCard or FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail then useNavigation() else nil
    local var5 = if FFlagProfileCurrentlyPlayingEDPFromCard or FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail then useProfileWrapperContext() else nil
    local profileId = var5 and var5.profileId
    local var6 = if FFlagProfilePlatformImproveGameDetailsAnalytics then useRoactService(RoactAnalyticsCommonGameEvents) else nil
    local var7 = if FFlagJoinabilityCTAContextCopy then useLocalization({ playTogether = TextKeys.PlayTogether, playTogetherSoon = TextKeys.PlayTogetherSoon }) else nil
    local universeId = var2.universeId

    React.useEffect(function()
        if not universeId then
            return
        end
        var3(NetworkingGames.GetExperiencesDetails.API({ tostring(universeId) })):catch(function(arg1)
            warn("CurrentlyPlaying: failed to fetch experience details for universeId", universeId, arg1)
        end)
    end, { universeId, var3 })

    local var8 = useSelector(function(arg1)
        return getDeepValue(arg1, `ProfilePlatform.Games.byGameId.{tostring(universeId)}`)
    end)
    local rootPlaceId = var8 and var8.rootPlaceId
    local name = var8 and var8.name or ""

    local var9 = if FFlagProfileCurrentlyPlayingEDPFromCard or FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail then React.useCallback(function(str1: string)
        if rootPlaceId == nil then
            return
        end
        if FFlagProfilePlatformImproveGameDetailsAnalytics then
            var6.reportOpenGameDetailFromProfileContext(rootPlaceId, tostring(universeId), AppPage.ProfilePlatform, profileId, str1)
        end

        var3(OpenGameDetails(tostring(universeId), var4, { mountAsFullView = true, showBackButton = true }))
    end, {
        universeId,
        rootPlaceId,
        profileId,
        var6,
        var3,
        var4
    }) else nil

    local var10 = if FFlagProfileCurrentlyPlayingEDPFromCard then React.useCallback(function()
        var9("ProfilePlatformCurrentlyPlayingCard")
    end, { var9 }) else nil

    local var11 = if FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail then React.useCallback(function()
        var9("ProfilePlatformCurrentlyPlayingThumbnail")
    end, { var9 }) else nil

    local onActivated = if FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail then React.useCallback(function()
        var9("ProfilePlatformCurrentlyPlayingGameName")
    end, { var9 }) else nil

    local image = if universeId then getRbxThumb(ThumbnailType.GameIcon, universeId, ThumbnailSize.Small) else nil
    local var13, var14 = React.useState(if image then ContentProvider:GetAssetFetchStatus(image) else Enum.AssetFetchStatus.None)

    React.useEffect(function()
        if image then
            local connection = ContentProvider:GetAssetFetchStatusChangedSignal(image):Connect(var14)
            return function()
                connection:Disconnect()
            end
        end
    end, { image })

    local deepValue = getDeepValue(var2, "ageRecommendation.ageRecommendationSummary.ageRecommendation.displayNameWithHeaderShort")

    local bool1 = name == "" or var13 == Enum.AssetFetchStatus.Loading
    local var15 = if not FFlagJoinabilityCTAContextCopy or bool1 then nil elseif var2.joinability == "Joinable" then var7.playTogether elseif var2.joinability == "NotJoinable" then var7.playTogetherSoon else nil

    if not universeId then
        return nil
    end
    local createElement = React.createElement
    local var16 = HorizontalPageMargin
    local tbl2 = {
        size = UDim2.new(1, 0, 0, 0),
        backgroundTransparency = 1,
        layoutOrder = tbl1.layoutOrder,
        useAutomaticSizing = true
    }
    local tbl3 = { Content = 0 }
    local createElement2 = React.createElement
    local var17 = View
    local tbl4 = {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-large stroke-standard stroke-default radius-medium bg-shift-100",
        onActivated = 0,
        stateLayer = 0
    }
    if not FFlagProfileCurrentlyPlayingEDPFromCard or bool1 then
        var10 = nil
    end

    tbl4.onActivated = var10

    tbl4.stateLayer = FFlagProfileCurrentlyPlayingEDPFromCard and not bool1 and {
        affordance = StateLayerAffordance.None
    } or nil

    local tbl5 = { GameThumbnail = 0, TextStack = 0 }
    local element

    if not bool1 then
        local createElement3 = React.createElement
        local var18 = Image
        local tbl6 = {
            tag = "radius-small aspect-1-1 size-1000-1000 auto-xy align-y-center",
            LayoutOrder = 1,
            Image = image,
            onActivated = 0,
            stateLayer = 0
        }

        if not FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail then
            var11 = nil
        end

        tbl6.onActivated = var11

        tbl6.stateLayer = FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail and {
            affordance = StateLayerAffordance.None
        } or nil
        element = createElement3(var18, tbl6)
    else
        element = React.createElement(
            Skeleton,
            {
                LayoutOrder = 1,
                Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_1000),
                Radius = Radius.Small
            }
        )
    end

    tbl5.GameThumbnail = element

    local createElement3 = React.createElement
    local var18 = View
    local tbl6 = {
        tag = "col align-y-center fill gap-xsmall auto-y content-default",
        LayoutOrder = 2
    }

    local tbl7 = { GameTitle = 0, AgeRecommendationText = 0, JoinabilityStatusText = 0 }
    local element2

    if bool1 then
        element2 = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(0.7, 0, 0, var1.Typography.TitleMedium.FontSize),
                Radius = Radius.Small,
                LayoutOrder = 1
            }
        )
    elseif FFlagProfileCurrentlyPlayingEDPFromNameAndThumbnail then
        element2 = React.createElement(View, {
            tag = "size-full-0 auto-y",
            LayoutOrder = 1,
            onActivated = onActivated,
            stateLayer = {
                affordance = StateLayerAffordance.None
            }
        }, {
            Label = React.createElement(
                FoundationText,
                {
                    tag = "emphasis size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end",
                    Text = name
                }
            )
        })
    else
        element2 = React.createElement(FoundationText, {
            tag = "emphasis size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end",
            Text = name,
            LayoutOrder = 1
        })
    end

    tbl7.GameTitle = element2

    tbl7.AgeRecommendationText = if bool1 then React.createElement(
        Skeleton,
        {
            Size = UDim2.new(0.5, 0, 0, var1.Typography.BodyMedium.FontSize),
            Radius = Radius.Small,
            LayoutOrder = 2
        }
    ) else React.createElement(
        FoundationText,
        {
            tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end",
            Text = deepValue,
            LayoutOrder = 2
        }
    )

    tbl7.JoinabilityStatusText = if var15 == nil then nil else React.createElement(
        FoundationText,
        {
            tag = "size-full-0 auto-y text-body-medium text-align-x-left text-truncate-end",
            Text = var15,
            LayoutOrder = 3
        }
    )
    tbl5.TextStack = createElement3(var18, tbl6, tbl7)
    tbl3.Content = createElement2(var17, tbl4, tbl5)
    return createElement(var16, tbl2, tbl3)
end

return CurrentlyPlaying
