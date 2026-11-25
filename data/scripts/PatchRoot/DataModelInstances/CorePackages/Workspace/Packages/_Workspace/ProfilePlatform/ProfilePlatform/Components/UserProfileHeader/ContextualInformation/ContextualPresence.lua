-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local RoactAnalyticsCommonGameEvents = require(ProfilePlatformParent.RoactServiceTags).RoactAnalyticsCommonGameEvents
local useRoactService = require(ProfilePlatformParent.RobloxAppHooks).useRoactService

local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useEffectOnMount = RoactUtils.Hooks.useEffectOnMount
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation

local OpenGameDetails = require(ProfilePlatformParent.GameDetail).OpenGameDetails
local UIBlox = require(ProfilePlatformParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local getIconSize = UIBlox.App.ImageSet.getIconSize
local PlayerContext = UIBlox.App.Indicator.PlayerContext

local Presence = require(ProfilePlatform.Rodux.Presence)
local PresenceType = Presence.Enums.PresenceType
local NetworkingPresence = require(ProfilePlatform.Networking.NetworkingPresence)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local Enums = require(ProfilePlatform.Common.Enums)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local convertPresenceEnum = require(ProfilePlatform.Utils.convertPresenceEnum)

local FFlagProfilePlatformImproveGameDetailsAnalytics = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformImproveGameDetailsAnalytics

local FFlagProfilePlatformPresenceStoreMigration = require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration)
local useGetPresenceByUserId = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local var1 = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.DataHydration).Presence.PresenceStore.get() else nil
local tbl1 = {
    userPresenceType = PresenceType.Offline,
    lastLocation = "",
    universeId = "",
    placeId = ""
}

local tbl2 = { skipFetch = true }

local tbl3 = {
    [Enums.PresenceTypes.Offline] = Images["component_assets/circle_26_stroke_3"],
    [Enums.PresenceTypes.Online] = Images["component_assets/circle_16"],
    [Enums.PresenceTypes.InGame] = Images["icons/menu/games_small"],
    [Enums.PresenceTypes.InStudio] = Images["icons/logo/studiologo_small"]
}

local function contextualPresence(tbl4)
    local var2 = useDispatch()
    local var3 = useNavigation()
    local var4 = useStyle()
    local var5 = useProfileAnalyticsContext()
    local var6 = if FFlagProfilePlatformImproveGameDetailsAnalytics then useRoactService(RoactAnalyticsCommonGameEvents) else nil
    local var7 = React.useRef(false)
    local var8 = React.useRef(false)

    local profileId = useProfileWrapperContext().profileId
    local var9

    if FFlagProfilePlatformPresenceStoreMigration then
        useEffectOnMount(function()
            var1.RefreshPresenceByUserId(tostring(profileId))
        end)
        local var10, var11 = useGetPresenceByUserId(profileId, tbl2)

        var9 = var10 or tbl4.presenceInfoOverride or tbl1

        React.useEffect(function()
            if var8.current or var11 ~= "Ready" and var11 ~= "Failed" then
                return
            end

            var8.current = true

            local var12 = convertPresenceEnum
            local userPresenceType = var9.userPresenceType
            local var13 = if var9.universeId then tonumber(var9.universeId) else nil
            local presenceType = var12(userPresenceType, var13)

            var5.fireAnalyticsEvent(EventNames.ProfilePresenceLoaded, { presenceType = presenceType, universeId = var9.universeId })
        end, { var9, var11, var5 })
    else
        useEffectOnMount(function()
            var2(NetworkingPresence.GetPresencesFromUserIds.API({ profileId })):andThen(function()
                var7.current = true
            end):catch(function(_) end)
        end)

        local var10 = useSelector(function(arg1)
            return Presence.Selectors.getUserPresenceByUserId(arg1, profileId)
                or {
                    userPresenceType = PresenceType.Offline,
                    lastLocation = ""
                }
        end)

        if not var7.current then
            var9 = tbl4.presenceInfoOverride or var10
        else
            var9 = var10
        end
        React.useEffect(function()
            if not var7.current or var8.current then
                return
            end
            var8.current = true

            local presenceType = convertPresenceEnum(var9.userPresenceType, var9.universeId)
            var5.fireAnalyticsEvent(EventNames.ProfilePresenceLoaded, { presenceType = presenceType, universeId = var9.universeId })
        end, { var9 })
    end

    local var10 = convertPresenceEnum
    local userPresenceType = var9.userPresenceType
    local universeId = if FFlagProfilePlatformPresenceStoreMigration then if var9.universeId then tonumber(var9.universeId) else nil else var9.universeId
    local var11 = var10(userPresenceType, universeId)

    local lastLocation = var9.lastLocation
    local universeId2 = var9.universeId

    local var12 = React.useCallback(function()
        var5.fireAnalyticsEvent(EventNames.GameDetailsButton)
        if FFlagProfilePlatformImproveGameDetailsAnalytics then
            var6.reportOpenGameDetailFromProfileContext(
                var9.placeId,
                var9.universeId,
                AppPage.ProfilePlatform,
                profileId,
                "ProfilePlatformContextualPresence"
            )
        end
        var2(OpenGameDetails(universeId2, var3, { mountAsFullView = true, showBackButton = true }))
    end, { universeId2, var3, var5 })

    local var13 = useLocalization({
        [Enums.PresenceTypes.Online] = TextKeys.Online,
        [Enums.PresenceTypes.Offline] = TextKeys.Offline,
        [Enums.PresenceTypes.InStudio] = TextKeys.InStudio
    })
    local var14 = nil
    local var15, var16, var17, var18, iconSize

    if var9 then
        if var11 == Enums.PresenceTypes.Online then
            var15 = tbl3[Enums.PresenceTypes.Online]
            var16 = var4.Theme.OnlineStatus.Color
            var17 = var4.Theme.OnlineStatus.Transparency
            lastLocation = var13.Online
            var18 = var4.Theme.TextMuted
            iconSize = 12
        elseif var11 == Enums.PresenceTypes.InGame then
            var15 = tbl3[Enums.PresenceTypes.InGame]
            var16 = var4.Theme.IconEmphasis.Color
            var17 = var4.Theme.IconEmphasis.Transparency

            var18 = var4.Theme.TextEmphasis
            iconSize = getIconSize(IconSize.Small)
            var14 = var12
        elseif var11 == Enums.PresenceTypes.InStudio then
            var15 = tbl3[Enums.PresenceTypes.InStudio]
            var16 = var4.Theme.TextDefault.Color
            var17 = var4.Theme.TextDefault.Transparency
            lastLocation = var13.InStudio
            var18 = var4.Theme.TextMuted
            iconSize = getIconSize(IconSize.Small)
        else
            var15 = tbl3[Enums.PresenceTypes.Offline]
            var16 = var4.Theme.OfflineStatus.Color
            var17 = var4.Theme.OfflineStatus.Transparency

            lastLocation = var13.Offline
            var18 = var4.Theme.TextMuted
            iconSize = 12
        end
    else
        var15 = nil
        var16 = nil
        iconSize = nil
        var17 = nil
        lastLocation = nil
        var18 = nil
    end

    return React.createElement(PlayerContext, {
        fontStyle = var4.Font.CaptionBody,
        icon = var15,
        iconColor = var16,
        iconSize = UDim2.fromOffset(iconSize, iconSize),
        iconTransparency = var17,
        layoutOrder = 2,
        text = lastLocation,
        textColorStyle = var18,
        onActivated = var14
    })
end

return contextualPresence
