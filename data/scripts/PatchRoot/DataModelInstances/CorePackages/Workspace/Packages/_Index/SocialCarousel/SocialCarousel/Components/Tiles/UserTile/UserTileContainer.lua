-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local Cryo = require(SocialCarouselParent.Cryo)
local Foundation = require(SocialCarouselParent.Foundation)
local GameJoinCard = require(SocialCarouselParent.GameJoinCard)
local PlayerContextualMenu = require(SocialCarouselParent.PlayerContextualMenu)
local React = require(SocialCarouselParent.React)
local Responsive = require(SocialCarouselParent.Responsive)
local RobloxAppEnums = require(SocialCarouselParent.RobloxAppEnums)
local DataStatus = require(SocialCarouselParent.DataHydration).DataStatus
local UserProfiles = require(SocialCarouselParent.UserProfiles)
local SocialCommon = require(SocialCarouselParent.SocialCommon)
local useJoinUserInExperience = require(SocialCarouselParent.SocialExperienceJoin).useJoinUserInExperience
local Enums = require(SocialCarouselParent.FriendsNetworking).Enums
local useGetPresenceByUserId = require(SocialCarouselParent.FriendsCommon).Hooks.useGetPresenceByUserId

local FFlagSocialCarouselUseProfileStore = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselUseProfileStore
local FFlagSocialCarouselInGameTitleMarquee = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTitleMarquee
local FFlagUserProfilePlatformProfile = require(SocialCarouselParent.SharedFlags).FFlagUserProfilePlatformProfile
local FFlagMobileGameJoinCardVideo = require(SocialCarouselParent.SharedFlags).FFlagMobileGameJoinCardVideo
local FFlagSocialCarouselBuildPresence = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselBuildPresence
local Signals = require(SocialCarouselParent.Signals)
local SignalsReact = require(SocialCarouselParent.SignalsReact)
local var1 = UserProfiles.Stores.UserProfileStore.get()
local PresenceTypes = SocialCommon.Enums.PresenceTypes
local Enums2 = require(SocialCarouselParent.SocialLuaAnalytics).Analytics.Enums
local Enums3 = require(SocialCarousel.Common.Enums)
local Localization = require(SocialCarouselParent.Localization)
local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local usePreferredInput = Responsive.usePreferredInput
local useAppPolicy = require(SocialCarouselParent.UniversalAppPolicy).useAppPolicy
local useDeviceType = require(SocialCarouselParent.RobloxAppHooks).useDeviceType

local useNavigation = require(SocialCarouselParent.Navigation).useNavigation
local useDispatch = require(SocialCarouselParent.RoactUtils).Hooks.RoactRodux.useDispatch

local View = Foundation.View
local AppPage = RobloxAppEnums.AppPage
local useLocalization = Localization.Hooks.useLocalization
local Tile = Enums3.Tile

local UserTile = require(script.Parent.UserTile)
local UserTileEventHandlers = require(SocialCarouselParent.UserTile).UserTileEventHandlers
local FocusNavigationEventNameEnum = require(SocialCarouselParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local Constants = require(SocialCarousel.Common.Constants)
local TILE_CLICK_TARGETS = Constants.ANALYTICS.TILE_CLICK_TARGETS
local useSocialCarouselContext = require(SocialCarousel.Contexts.useSocialCarouselContext)
local useBuildCard = require(script.Parent.useBuildCard)

local DesktopGameJoinCardContainer = GameJoinCard.DesktopGameJoinCardContainer
local useAgeCheckCompletionLogger = GameJoinCard.Analytics.useAgeCheckUpsellAnalytics.useAgeCheckCompletionLogger
local useGameJoinCardNavigation = GameJoinCard.useGameJoinCardNavigation
local GameJoinCardTTI = GameJoinCard.Telemetry.GameJoinCardTTI

local str1 = game:DefineFastString("SocialCarouselVendorImagePath", "rbxasset://textures/ui/Shell/Icons/PlatformLogo.png")
local FFlagEnableSplitPane = require(SocialCarouselParent.SharedFlags).FFlagEnableSplitPane
local FFlagSocialCarouselEnableUserSeenEvents = require(SocialCarousel.Flags.FFlagSocialCarouselEnableUserSeenEvents)

local FFlagSocialCarouselUseConsolePolicyForCta = require(SocialCarousel.Flags.FFlagSocialCarouselUseConsolePolicyForCta)

local FFlagSocialCarouselFixGameJoinCardDismiss = require(SocialCarousel.Flags.FFlagSocialCarouselFixGameJoinCardDismiss)
local FFlagSocialCarouselShowPlusBadge = require(SocialCarousel.Flags.FFlagSocialCarouselShowPlusBadge)
local FFlagSocialCarouselInGamePlayIcon = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGamePlayIcon
local FFlagSocialCarouselInGameTileInstantJoin = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTileInstantJoin
local FFlagSocialCarouselInGameTextInstantJoin = require(SocialCarouselParent.SharedFlags).FFlagSocialCarouselInGameTextInstantJoin
local DiscoveryAnalytics = if FFlagSocialCarouselInGameTileInstantJoin or FFlagSocialCarouselInGameTextInstantJoin then require(SocialCarouselParent.DiscoveryAnalytics) else nil
local HttpService = if FFlagSocialCarouselInGameTileInstantJoin or FFlagSocialCarouselInGameTextInstantJoin then game:GetService("HttpService") else nil
local FFlagEnableMobileGameJoinCard = require(SocialCarouselParent.SharedFlags).FFlagEnableMobileGameJoinCard
local FFlagConsoleOpenMobileGameJoinCard = require(SocialCarouselParent.SharedFlags).FFlagConsoleOpenMobileGameJoinCard
local FFlagConsoleOpenGameJoinCard = require(SocialCarouselParent.SharedFlags).FFlagConsoleOpenGameJoinCard
local FFlagShowRequestsInCarouselForAllUsers = require(SocialCarouselParent.SharedFlags).FFlagShowRequestsInCarouselForAllUsers
local FFlagMobileGameJoinCardTTITracking = require(SocialCarouselParent.SharedFlags).FFlagMobileGameJoinCardTTITracking
local FFlagMobileGameJoinCardGamepadSupport = require(SocialCarouselParent.SharedFlags).FFlagMobileGameJoinCardGamepadSupport
local FFlagDesktopGameJoinCardGamepadSupport = require(SocialCarouselParent.SharedFlags).FFlagDesktopGameJoinCardGamepadSupport

local bool1 = game:DefineFastFlag("EnableFriendCarouselInGameFriendExposureLogging_v2", false)

local layerName = game:DefineFastString("SocialViewFriendSortInGameFriendsLayer", "Social.ViewFriendSortInGameFriends")

local function func1(item)
    if FFlagShowRequestsInCarouselForAllUsers and item.tileType == Tile.FriendRequest then
        return Enum.FriendStatus.FriendRequestReceived
    end

    if item.tileType ~= Tile.Recommendation then
        return Enum.FriendStatus.Friend
    end

    if item.isFriendWithUser then
        return Enum.FriendStatus.Friend
    end

    if item.hasIncomingFriendRequest then
        return Enum.FriendStatus.FriendRequestReceived
    end

    if item.hasPendingFriendRequest then
        return Enum.FriendStatus.FriendRequestSent
    end

    return Enum.FriendStatus.NotFriend
end

local function func2(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1 ~= nil or arg2 == DataStatus.Ready or arg2 == DataStatus.Failed
end

local function func3(item, bool2: boolean?, presence) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (bool2 and presence) then
        return item
    end

    local var2 = table.clone(item)
    var2.presence = presence
    return var2
end

return function(tbl1)
    local var2 = React.useRef(nil)
    local var3 = useDispatch()
    local var4 = useNavigation()
    local var5 = if FFlagMobileGameJoinCardGamepadSupport or FFlagDesktopGameJoinCardGamepadSupport then useDeviceType() else nil
    local preferredInput = usePreferredInput()
    local bool2 = preferredInput == Responsive.Input.Directional

    local bool3 = bool2
    if FFlagSocialCarouselUseConsolePolicyForCta or FFlagMobileGameJoinCardGamepadSupport then
        bool3 = useAppPolicy(function(arg1)
            return arg1.getUseConsoleGameJoinCard()
        end)
    end

    if FFlagDesktopGameJoinCardGamepadSupport and var5 == RobloxAppEnums.DeviceType.Desktop then
        bool3 = false
    end

    local bool4 = preferredInput == Responsive.Input.Directional

    local isPhoneOrTablet = var5 == RobloxAppEnums.DeviceType.Phone or var5 == RobloxAppEnums.DeviceType.Tablet
    local bool6 = false
    local bool7

    if FFlagEnableMobileGameJoinCard then
        if FFlagMobileGameJoinCardGamepadSupport then
            bool7 = isPhoneOrTablet or preferredInput == Responsive.Input.Touch
        else
            bool7 = preferredInput == Responsive.Input.Touch
        end

        bool6 = bool7
    end

    if not bool6 then
        bool7 = FFlagConsoleOpenMobileGameJoinCard and bool3
    end
    local var7 = useSocialCarouselContext()
    local var8 = useSocialCarouselAnalytics()
    local userPressed = var8.userPressed
    local userSeen = var8.userSeen
    local var9 = useLocalization({
        suggestedLabel = "Feature.Friends.Label.Suggested",
        friendRequestLabel = if FFlagShowRequestsInCarouselForAllUsers then "Feature.Friends.Label.FriendRequest" else nil
    })

    local var10 = nil
    local var11 = nil
    local var12

    if FFlagShowRequestsInCarouselForAllUsers then
        var10 = tbl1.item.tileType == Tile.FriendRequest

        local var13 = useGetPresenceByUserId
        local id = if var10 then tbl1.item.id else nil
        local var14
        var14, var12 = var13(id)
        var11 = var14
    else
        var12 = nil
    end
    local var13 = React.useMemo(function()
        if FFlagShowRequestsInCarouselForAllUsers then
            return func3(tbl1.item, var10, var11)
        end

        return tbl1.item
    end, { tbl1.item, var10, var11 })
    local bool8 = func2(var11, var12)
    local var14 = React.useMemo(function()
        if not (FFlagShowRequestsInCarouselForAllUsers and var10 and bool8) then
            return tbl1.item
        end

        local var14 = table.clone(tbl1.item)
        var14.presence = var11 or {
            userPresenceType = PresenceTypes.Offline
        }
        return var14
    end, {
        tbl1.item,
        var10,
        var11,
        bool8
    })

    local var15

    if FFlagShowRequestsInCarouselForAllUsers and var10 then
        var15 = nil
    else
        var15 = tbl1.item.presence
            and {
                locationString = tbl1.item.presence.lastLocation,
                locationPlaceId = tbl1.item.presence.placeId,
                locationRootPlaceId = tbl1.item.presence.rootPlaceId,
                locationUniverseId = tbl1.item.presence.universeId,
                status = tbl1.item.presence.userPresenceType
            }
            or nil
    end

    local var16, var17, var18

    if FFlagSocialCarouselUseProfileStore then
        local var19 = React.useMemo(function()
            return var1.fetchNamesByUserIds({ tbl1.item.id }, nil, FFlagUserProfilePlatformProfile)
        end, { tbl1.item.id })

        local var20 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                local var20 = var19(arg1)
                local var21 = var20 and var20.data and var20.data[1]
                if var21 and var21.names then
                    return (var21.names.getCombinedName(arg1))
                end

                return nil
            end)
        end, { var19 })

        local var21 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                local var21 = var19(arg1)
                local var22 = var21 and var21.data and var21.data[1]
                if var22 and var22.names then
                    return (var22.names.getPlatformName(arg1))
                end

                return nil
            end)
        end, { var19 })

        var16 = SignalsReact.useSignalState(var20)
        var17 = SignalsReact.useSignalState(var21)

        local var22 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                local var22 = var19(arg1)
                local var23 = var22 and var22.data and var22.data[1]
                if var23 then
                    return (var23.getPlatformProfileId(arg1))
                end

                return nil
            end)
        end, { var19 })

        var18 = SignalsReact.useSignalState(var22)
    else
        local var19 = UserProfiles.Hooks.useUserProfilesFetch(
            {
                userIds = { tbl1.item.id },
                query = UserProfiles.Queries.userProfilesDisplayUserPlatformNamesByUserIds
            }
        )
        var16 = React.useMemo(function()
            if not var19.data then
                return nil
            end

            return UserProfiles.Selectors.getCombinedNameFromId(var19.data, tbl1.item.id)
        end, { var19.data })

        var17 = React.useMemo(function()
            if not var19.data then
                return nil
            end

            return UserProfiles.Selectors.getPlatformNameFromId(var19.data, tbl1.item.id)
        end, { var19.data })

        var18 = React.useMemo(function()
            if not var19.data then
                return nil
            end

            return UserProfiles.Selectors.getPlatformProfileIdFromId(var19.data, tbl1.item.id)
        end, { var19.data, tbl1.item.id })
    end

    local var19 = if FFlagSocialCarouselShowPlusBadge then UserProfiles.Hooks.useIsRobloxSubscriber(tbl1.item.id) else nil
    local var20, var21 = React.useState(false)
    local bool9 = var20
    local func4 = var21
    local setOpenGameJoinCardUserId = var7.setOpenGameJoinCardUserId
    if setOpenGameJoinCardUserId then
        bool9 = var7.openGameJoinCardUserId == tbl1.item.id

        func4 = function(arg1)
            if arg1 then
                setOpenGameJoinCardUserId(tbl1.item.id)
                return
            end
            setOpenGameJoinCardUserId(function(id: string?): string?
                return if id == tbl1.item.id then nil else id
            end)
        end
    end

    local var22 = if FFlagSocialCarouselBuildPresence then useBuildCard({
        userId = tbl1.item.id,
        playerName = var16 or "",
        presence = tbl1.item.presence,
        preferredInput = preferredInput,
        isPhoneOrTablet = isPhoneOrTablet,
        anchorRef = var2
    }) else nil
    local var23 = if FFlagMobileGameJoinCardGamepadSupport then bool7 else nil
    local var24 = if FFlagMobileGameJoinCardGamepadSupport or FFlagDesktopGameJoinCardGamepadSupport then bool3 else nil
    local joinSheetUserIdRef = if FFlagSocialCarouselInGameTitleMarquee then var7.joinSheetUserIdRef else nil

    local var25 = if FFlagShowRequestsInCarouselForAllUsers then React.useCallback(function()
        (if FFlagEnableSplitPane then var4.push else var4.navigate)(
            AppPage.ProfilePlatform,
            {
                detail = tbl1.item.id,
                extraProps = {
                    source = Enums2.Sources.HomePageFriendsCarousel
                }
            }
        )
    end, { var4, tbl1.item.id }) else nil

    local bool10 = FFlagSocialCarouselInGamePlayIcon

    if bool10 then
        if tbl1.item.onActivated == nil and tbl1.item.tileType == Tile.Friend and tbl1.item.presence ~= nil then
            bool10 = tbl1.item.presence.userPresenceType == PresenceTypes.InGame
        else
            bool10 = false
        end
    end

    local var26

    if FFlagSocialCarouselInGameTileInstantJoin or FFlagSocialCarouselInGameTextInstantJoin then
        local var27 = useJoinUserInExperience
        local id = tbl1.item.id
        local tbl2 = {
            isHomePageCarousel = true,
            homepageCarouselAbsolutePosition = tbl1.index,
            presence = tbl1.item.presence,
            onAgeCheckCompletion = 0
        }
        local var28 = useAgeCheckCompletionLogger
        local var29 = if tbl1.item.presence then tostring(tbl1.item.presence.universeId) else ""
        tbl2.onAgeCheckCompletion = var28(var29)
        var26 = var27(id, tbl2)
    else
        var26 = nil
    end

    local useCallback = React.useCallback
    local function func5(_, tileClickTarget: string?)
        if (FFlagSocialCarouselInGameTileInstantJoin or FFlagSocialCarouselInGameTextInstantJoin)
            and bool10
            and not var26.isLoading
            and (FFlagSocialCarouselInGameTileInstantJoin or tileClickTarget ~= TILE_CLICK_TARGETS.AVATAR)
        then
            local presence = tbl1.item.presence
            local var27 = if presence and presence.placeId ~= nil then tostring(presence.placeId) else ""
            local var28 = if presence then tonumber(presence.rootPlaceId) else nil

            if var27 ~= "" and var28 ~= nil then
                DiscoveryAnalytics.Events.gamePlayIntent(
                    var7.eventIngest,
                    DiscoveryAnalytics.Constants.Context.PeopleListInHomePage,
                    {
                        placeId = var27,
                        rootPlaceId = var28,
                        friendId = tbl1.item.id,
                        joinAttemptId = HttpService:GenerateGUID(false)
                    }
                )
            end
            userPressed(var14, { absolutePosition = tbl1.index, tileClickTarget = tileClickTarget })

            var26.joinExperience()
            return
        end
        if tbl1.item.onActivated then
            tbl1.item.onActivated(tbl1.item)
        else
            local bool11 = not (tbl1.item.presence == nil) and tbl1.item.presence.userPresenceType == PresenceTypes.InGame
            local var27 = bool3 and bool11
            if FFlagShowRequestsInCarouselForAllUsers and var10 and var25 then
                var25()
            elseif var27 and not (FFlagConsoleOpenMobileGameJoinCard and bool7 and bool11) and not FFlagConsoleOpenGameJoinCard then
                var3(
                    PlayerContextualMenu.openPlayerContextualMenu({
                        subjectUserId = tbl1.item.id,
                        subjectPresence = var15,
                        robloxFriendshipStatus = func1(tbl1.item),
                        friendshipOriginSourceType = Enums.FriendshipOriginSourceType.FriendRecommendations.rawValue()
                    })
                )
            elseif tbl1.item.presence and tbl1.item.presence.userPresenceType == PresenceTypes.InGame then
                if bool1 then
                    IXPService:LogFlagLinkedUserLayerExposure(layerName)
                end
                if bool7 then
                    if FFlagMobileGameJoinCardTTITracking then
                        GameJoinCardTTI.trackMobileCardClickStart()
                    end

                    if joinSheetUserIdRef ~= nil then
                        joinSheetUserIdRef.current = tbl1.item.id
                    end
                    var4.navigate(AppPage.GameJoinCard, {
                        userId = tbl1.item.id,
                        homepageCarouselAbsolutePosition = tbl1.index,
                        isBannerVideoEnabled = if FFlagMobileGameJoinCardVideo then var7.isJoinCardVideoEnabled else nil,
                        videoPlaybackContext = if FFlagMobileGameJoinCardVideo then var7.videoPlaybackContext else nil
                    })
                else
                    func4(not bool9)
                end
            elseif FFlagSocialCarouselBuildPresence and var22.isInBuild and var22.canOpen then
                var22.onActivated()
            elseif FFlagShowRequestsInCarouselForAllUsers and var25 then
                var25()
            else
                (if FFlagEnableSplitPane then var4.push else var4.navigate)(
                    AppPage.ProfilePlatform,
                    {
                        detail = tbl1.item.id,
                        extraProps = {
                            source = Enums2.Sources.HomePageFriendsCarousel
                        }
                    }
                )
            end
        end

        local var27 = userPressed
        local var28 = var14
        local tbl2 = {
            absolutePosition = tbl1.index,
            tileClickTarget = 0
        }

        if not (FFlagSocialCarouselInGamePlayIcon and bool10) then
            tileClickTarget = nil
        end

        tbl2.tileClickTarget = tileClickTarget
        var27(var28, tbl2)
    end

    local item = tbl1.item
    local var27 = bool9
    local var28 = if FFlagSocialCarouselInGamePlayIcon then bool10 else nil
    local joinExperience = if FFlagSocialCarouselInGameTileInstantJoin or FFlagSocialCarouselInGameTextInstantJoin then var26.joinExperience else nil
    local isLoading = if FFlagSocialCarouselInGameTileInstantJoin or FFlagSocialCarouselInGameTextInstantJoin then var26.isLoading else nil
    local eventIngest = if FFlagSocialCarouselInGameTileInstantJoin or FFlagSocialCarouselInGameTextInstantJoin then var7.eventIngest else nil
    local var29 = if FFlagSocialCarouselInGameTitleMarquee then joinSheetUserIdRef else nil
    local var30 = FFlagSocialCarouselBuildPresence and var22
    local var31 = if FFlagShowRequestsInCarouselForAllUsers then var10 else nil
    local var32 = if FFlagShowRequestsInCarouselForAllUsers then var25 else nil
    local var33 = if FFlagShowRequestsInCarouselForAllUsers then var4 else nil
    local tableValue1 = item
    local tableValue2 = var27
    local tableValue3 = var28
    local tableValue4 = joinExperience
    local tableValue5 = isLoading
    local tableValue6 = eventIngest
    local tableValue7 = var23
    local tableValue8 = var24
    local tableValue9 = var29
    local tableValue10 = var30
    local tableValue11 = var31
    local tableValue12 = var32
    local tableValue13 = var33
    local tableValue14 = var14
    local tableValue15 = var3
    local tableValue16 = userPressed
    local var34 = bool3
    local index = tbl1.index
    local isJoinCardVideoEnabled = if FFlagMobileGameJoinCardVideo then var7.isJoinCardVideoEnabled else nil
    local videoPlaybackContext = if FFlagMobileGameJoinCardVideo then var7.videoPlaybackContext else nil
    local var35 = useCallback(func5, {
        tableValue1,
        tableValue2,
        tableValue3,
        tableValue4,
        tableValue5,
        tableValue6,
        tableValue7,
        tableValue8,
        tableValue9,
        tableValue10,
        tableValue11,
        tableValue12,
        tableValue13,
        tableValue14,
        tableValue15,
        tableValue16,
        var34,
        index,
        bool7,
        var15,
        isJoinCardVideoEnabled,
        videoPlaybackContext
    })

    local onActivated = if FFlagSocialCarouselInGamePlayIcon then React.useCallback(function()
        var35(nil, TILE_CLICK_TARGETS.AVATAR)
    end, { var35 }) else var35

    local var37 = if FFlagSocialCarouselInGamePlayIcon then React.useCallback(function()
        var35(nil, TILE_CLICK_TARGETS.TILE_TEXT)
    end, { var35 }) else nil

    local var38 = if FFlagSocialCarouselInGamePlayIcon then React.useCallback(function()
        var35(nil, TILE_CLICK_TARGETS.PLAY_ICON)
    end, { var35 }) else nil

    local contextualText = React.useMemo(function()
        if FFlagShowRequestsInCarouselForAllUsers and var10 then
            return var9.friendRequestLabel
        end

        if tbl1.item.tileType == Tile.Recommendation then
            return var9.suggestedLabel
        end

        if tbl1.item.presence and tbl1.item.presence.userPresenceType == PresenceTypes.InGame then
            return tbl1.item.presence.lastLocation
        end

        return nil
    end, {
        tbl1.item,
        var10,
        var9.friendRequestLabel,
        var9.suggestedLabel
    })

    local contextualInfo = if FFlagSocialCarouselBuildPresence and var22.isInBuild then var22.contextualInfo else nil
    local var40, var41 = React.useState(nil)
    local var42 = var41

    local tileRef = React.useRef(nil)

    local var6 = React.useCallback(function()
        if FFlagShowRequestsInCarouselForAllUsers and var25 then
            var25()
        else
            (if FFlagEnableSplitPane then var4.push else var4.navigate)(
                AppPage.ProfilePlatform,
                {
                    detail = tbl1.item.id,
                    extraProps = {
                        source = Enums2.Sources.HomePageFriendsCarousel
                    }
                }
            )
        end

        userPressed(var14, { absolutePosition = tbl1.index })
    end, {
        tbl1.item,
        tbl1.index,
        if FFlagShowRequestsInCarouselForAllUsers then var25 else nil,
        if FFlagShowRequestsInCarouselForAllUsers then nil else var4.navigate,
        if FFlagShowRequestsInCarouselForAllUsers then nil else var4.push,
        userPressed,
        var14
    })

    local buttons = React.useMemo(function()
        return {
            {
                onActivated = var6,
                focusEventName = FocusNavigationEventNameEnum.ViewProfile
            },
            {
                onActivated = function() end
            }
        }
    end, { var6 })

    local onCardGuiObjectChanged = React.useCallback(function(current)
        tileRef.current = current
        if var42 then
            var42(current)
        end
    end, { var42 })

    React.useEffect(function()
        if var7.unifiedLogging then
            var7.unifiedLogging.tagTileForImpressions(var2, tbl1.index)
        end
    end, { tbl1.index })

    React.useEffect(function()
        var7.onSuccessfulRender(Constants.ANALYTICS.UI_LOADING_EVENTS.CAROUSEL_FRIEND)
        if FFlagSocialCarouselEnableUserSeenEvents and not FFlagShowRequestsInCarouselForAllUsers then
            userSeen(tbl1.item, { absolutePosition = tbl1.index })
        end
    end, {})

    local var47 = React.useRef(nil)
    React.useEffect(function()
        if FFlagShowRequestsInCarouselForAllUsers
            and FFlagSocialCarouselEnableUserSeenEvents
            and (not var10 or bool8)
            and var47.current ~= tbl1.item.id
        then
            var47.current = tbl1.item.id
            userSeen(var14, { absolutePosition = tbl1.index })
        end
    end, {
        var14,
        var10,
        bool8,
        userSeen,
        tbl1.item.id,
        tbl1.index
    })

    if FFlagShowRequestsInCarouselForAllUsers then
        React.useEffect(function()
            if tbl1.onTileContentChanged then
                tbl1.onTileContentChanged(tbl1.item.id, tbl1.index, var14)
            end
        end, {
            tbl1.item.id,
            tbl1.index,
            var14,
            tbl1.onTileContentChanged
        })
    else
        React.useEffect(function()
            if tbl1.onTileContentChanged then
                tbl1.onTileContentChanged(tbl1.item.id, tbl1.index)
            end
        end, { tbl1.item.id, tbl1.index })
    end

    local var48

    if FFlagSocialCarouselFixGameJoinCardDismiss then
        local id = tbl1.item.id
        var48 = React.useCallback(function()
            if setOpenGameJoinCardUserId then
                setOpenGameJoinCardUserId(function(str2: string?): string?
                    return if str2 == id then nil else str2
                end)
            elseif func4 then
                func4(false)
            end
        end, { id, setOpenGameJoinCardUserId })
    else
        var48 = React.useCallback(function()
            if func4 then
                func4(false)
            end
        end, {})
    end

    if FFlagDesktopGameJoinCardGamepadSupport and bool2 then
        bool2 = var5 ~= RobloxAppEnums.DeviceType.Desktop
    end
    if FFlagConsoleOpenGameJoinCard then
        bool2 = bool3
    end

    local isFocused = useGameJoinCardNavigation(
        if FFlagConsoleOpenGameJoinCard and bool2 then nil elseif FFlagDesktopGameJoinCardGamepadSupport then if bool2 then var40 else nil else var40,
        bool2 and not FFlagConsoleOpenGameJoinCard,
        var2
    )
    local presence = tbl1.item.presence
    local var50 = presence and presence.userPresenceType == PresenceTypes.InGame
    local var51 = (bool9 or isFocused) and var50 and var15 ~= nil
    local var52 = var50 and bool2 and var51

    React.useEffect(function()
        if bool1 and var51 then
            IXPService:LogFlagLinkedUserLayerExposure(layerName)
        end
    end, { var51 })

    local createElement = React.createElement
    local var53 = UserTile
    local join = Cryo.Dictionary.join
    local tbl2 = {
        item = 0,
        itemSize = 0,
        onActivated = 0,
        name = 0,
        contextualText = 0,
        overlayIcon = 0,
        contextualInfo = 0,
        contextualInfoIcon = 0,
        tileRef = 0,
        titleIcon = 0,
        isRobloxSubscriber = 0,
        showPlayIcon = 0,
        onPlayIconActivated = 0,
        onTextActivated = 0
    }

    if not FFlagShowRequestsInCarouselForAllUsers then
        var13 = nil
    end

    tbl2.item = var13
    tbl2.itemSize = UDim2.fromScale(1, 1)
    tbl2.onActivated = onActivated
    tbl2.name = if tbl1.item.tileType == Tile.Recommendation then var17 else var16
    tbl2.contextualText = contextualText
    tbl2.overlayIcon = if FFlagShowRequestsInCarouselForAllUsers and var10 then Foundation.Enums.IconName.PersonPlus else nil

    tbl2.contextualInfo = if FFlagSocialCarouselBuildPresence and contextualInfo then contextualInfo.text else nil
    tbl2.contextualInfoIcon = if FFlagSocialCarouselBuildPresence and contextualInfo then contextualInfo.icon else nil

    tbl2.tileRef = var2
    tbl2.titleIcon = if tbl1.item.tileType == Tile.Recommendation then str1 else nil

    if not FFlagSocialCarouselShowPlusBadge then
        var19 = nil
    end

    tbl2.isRobloxSubscriber = var19
    tbl2.showPlayIcon = if FFlagSocialCarouselInGamePlayIcon then bool10 else nil
    if not (FFlagSocialCarouselInGamePlayIcon and bool10) then
        var38 = nil
    end

    tbl2.onPlayIconActivated = var38

    if not (FFlagSocialCarouselInGamePlayIcon and bool10) then
        var37 = nil
    end

    tbl2.onTextActivated = var37
    local userTile = createElement(var53, join(tbl1, tbl2))

    local createElement2 = React.createElement
    local var54 = View
    local tbl3 = {
        Size = tbl1.itemSize,
        LayoutOrder = tbl1.index,
        BackgroundTransparency = 1,
        ref = var2,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        }
    }
    local tbl4 = {
        UserTile = userTile,
        GameJoinCardPopover = 0,
        BuildJoinCardPopover = 0,
        TileEventHandlers = 0,
        CardEventHandlers = 0
    }
    local element2

    if FFlagSocialCarouselBuildPresence and var22.isInBuild or not (var15 and presence) then
        element2 = nil
    else
        element2 = React.createElement(DesktopGameJoinCardContainer, {
            layoutOrder = 1,
            playerName = var16 or "",
            platformName = var17 or "",
            platformProfileId = var18,
            universeId = tostring(presence.universeId),
            experienceName = presence.lastLocation,
            userId = tbl1.item.id,
            presence = presence,
            anchorRef = var2,
            isOpen = var51 == true,
            onClose = var48,
            homepageCarouselAbsolutePosition = tbl1.index,
            showGamepadJoinFocus = var52 == true,
            onCardGuiObjectChanged = onCardGuiObjectChanged,
            isFocused = isFocused,
            isConsole = bool2,
            experienceUtilities = if FFlagSocialCarouselInGameTileInstantJoin then var26 elseif FFlagSocialCarouselInGameTextInstantJoin then var26 else nil
        })
    end

    tbl4.GameJoinCardPopover = element2

    tbl4.BuildJoinCardPopover = if FFlagSocialCarouselBuildPresence then var22.popover else nil
    local createElement3 = React.createElement
    local var55 = UserTileEventHandlers
    local tbl5 = {
        tileRef = var2,
        buttons = if bool4 then buttons else nil,
        onTileActivated = 0
    }

    function tbl5.onTileActivated() end

    tbl4.TileEventHandlers = createElement3(var55, tbl5)

    tbl4.CardEventHandlers = if bool4 and var40 then React.createElement(UserTileEventHandlers, {
        tileRef = tileRef,
        buttons = buttons,
        onTileActivated = function() end
    }) else nil
    return createElement2(var54, tbl3, tbl4)
end
