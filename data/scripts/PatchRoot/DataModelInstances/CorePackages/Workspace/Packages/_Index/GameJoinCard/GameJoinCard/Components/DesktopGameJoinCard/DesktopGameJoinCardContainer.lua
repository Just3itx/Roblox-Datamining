-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCard = script:FindFirstAncestor("GameJoinCard")
local GameJoinCardParent = GameJoinCard.Parent
local HttpService = game:GetService("HttpService")
local React = require(GameJoinCardParent.React)
local Foundation = require(GameJoinCardParent.Foundation)
local Responsive = require(GameJoinCardParent.Responsive)
local GameDetail = require(GameJoinCardParent.GameDetail)
local DataHydration = require(GameJoinCardParent.DataHydration)
local UserCtaAction = require(GameJoinCardParent.UserCtaCommon).Enums.UserCtaAction
local useLocalization = require(GameJoinCardParent.Localization).Hooks.useLocalization
local SocialCommon = require(GameJoinCardParent.SocialCommon)
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local EnteredChatFromEntryPoint = SocialCommon.Actions.EnteredChatFromEntryPoint
local DiscoveryAnalytics = require(GameJoinCardParent.DiscoveryAnalytics)
local SocialExperienceJoin = require(GameJoinCardParent.SocialExperienceJoin)
local gamePlayIntent = DiscoveryAnalytics.Events.gamePlayIntent
local gameDetailReferral = DiscoveryAnalytics.Events.gameDetailReferral
local PeopleListInHomePage = DiscoveryAnalytics.Constants.Context.PeopleListInHomePage
local RobloxAppEnums = require(GameJoinCardParent.RobloxAppEnums)
local AppPage = RobloxAppEnums.AppPage
local NotificationType = RobloxAppEnums.NotificationType

local RoactServiceTags = require(GameJoinCardParent.RoactServiceTags)
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local AppSessionService = RoactServiceTags.AppSessionService
local AppGuiService = RoactServiceTags.AppGuiService
local SetGamePlaySession = require(GameJoinCardParent.RobloxAppSessionization).SetGamePlaySession
local SessionType = require(GameJoinCardParent.RobloxAppSessionization).SessionType
local RobloxAppHooks = require(GameJoinCardParent.RobloxAppHooks)
local useRoactService = RobloxAppHooks.useRoactService
local useDeviceType = RobloxAppHooks.useDeviceType
local ContentProvider = game:GetService("ContentProvider")
local DesktopGameJoinCard = require(script.Parent.DesktopGameJoinCard)
local GamepadJoinFocusBehavior = require(script.Parent.GamepadJoinFocusBehavior)
local OpenGameDetails = GameDetail.OpenGameDetails

local useNavigation = require(GameJoinCardParent.Navigation).useNavigation
local useNavigationFocus = require(GameJoinCardParent.Navigation).useNavigationFocus
local Hooks = require(GameJoinCardParent.RoactUtils).Hooks
local dependencyArray = Hooks.dependencyArray
local useDispatch = Hooks.RoactRodux.useDispatch
local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize

local useJoinUserInExperience = SocialExperienceJoin.useJoinUserInExperience
local usePreferredInput = Responsive.usePreferredInput
local useAppPolicy = require(GameJoinCardParent.UniversalAppPolicy).useAppPolicy

local FocusNavigationUtils = require(GameJoinCardParent.FocusNavigationUtils)
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local SharedFlags = require(GameJoinCardParent.SharedFlags)
local FFlagDesktopGameJoinCardGamepadSupport = SharedFlags.FFlagDesktopGameJoinCardGamepadSupport
local FFlagConsoleOpenGameJoinCard = SharedFlags.FFlagConsoleOpenGameJoinCard
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane
local FFlagEnableOnScreenAPIIntegration = SharedFlags.FFlagEnableOnScreenAPIIntegration
local FFlagGameJoinCardAnalyticsCardId = SharedFlags.FFlagGameJoinCardAnalyticsCardId
local var1 = SharedFlags.FFlagSocialCarouselInGameTileInstantJoin or SharedFlags.FFlagSocialCarouselInGameTextInstantJoin
local FFlagJoinabilityCTARefactor = SharedFlags.FFlagJoinabilityCTARefactor
local FFlagJoinUserCTAsIxpEnabled = SharedFlags.FFlagJoinUserCTAsIxpEnabled
local FStringJoinUserCTAsIxpLayer = SharedFlags.FStringJoinUserCTAsIxpLayer
local IXPServiceWrapper = if FFlagJoinUserCTAsIxpEnabled then require(GameJoinCardParent.IXPServiceWrapper).IXPServiceWrapper else nil
local FFlagGameJoinCardChatEntryPoint = require(GameJoinCard.Flags.FFlagGameJoinCardChatEntryPoint)
local useIsRouteOnScreen = if FFlagEnableOnScreenAPIIntegration then require(GameJoinCardParent.RobloxAppNavigation).useIsRouteOnScreen else nil
local getPlatformFriendsService = require(GameJoinCard.Utils.getPlatformFriendsService)

local AnalyticsConstants = require(script.Parent.Parent.Parent.Analytics.AnalyticsConstants)
local GameJoinCardButtonAction = AnalyticsConstants.GameJoinCardButtonAction
local GameJoinCardSurface = AnalyticsConstants.GameJoinCardSurface
local viewEDPsourceValues = AnalyticsConstants.viewEDPsourceValues
local viewProfileSourceValues = AnalyticsConstants.viewProfileSourceValues
local useGameJoinCardAnalytics = require(script.Parent.Parent.Parent.Analytics.useGameJoinCardAnalytics)
local useAgeCheckUpsellAnalytics = require(script.Parent.Parent.Parent.Analytics.useAgeCheckUpsellAnalytics)
local useAgeCheckCompletionLogger = useAgeCheckUpsellAnalytics.useAgeCheckCompletionLogger
local useAgeCheckPressLogger = useAgeCheckUpsellAnalytics.useAgeCheckPressLogger
local Actions = require(GameJoinCard.Components.Actions)
local containsAction = require(GameJoinCard.Components.Actions.containsAction)
local useJoinUserActions = require(GameJoinCard.Hooks.useJoinUserActions)
local useLogActionsResolveTime = require(GameJoinCard.Telemetry.useLogActionsResolveTime)

local DataStatus = DataHydration.DataStatus

local function DesktopGameJoinCardContainer(tbl1)
    local dispatch = useDispatch()
    local navigation = useNavigation()
    local bool1 = if FFlagEnableOnScreenAPIIntegration then useIsRouteOnScreen() else useNavigationFocus() ~= false
    local var4 = nil
    local var5 = nil
    if FFlagGameJoinCardAnalyticsCardId then
        var4, var5 = React.useState(nil)
    end
    local layoutOrder = tbl1.layoutOrder
    local playerName = tbl1.playerName
    local platformName = tbl1.platformName
    local presence = tbl1.presence
    local universeId = tostring(presence.universeId)
    local lastLocation = presence.lastLocation
    local gameIconUrl = React.useMemo(function()
        return getRbxThumb(ThumbnailType.GameIcon, universeId, ThumbnailSize.Small)
    end, { universeId })
    local var6, var7 = React.useState(Enum.AssetFetchStatus.None)
    React.useEffect(function()
        var7(ContentProvider:GetAssetFetchStatus(gameIconUrl))
    end, { gameIconUrl })
    React.useEffect(function()
        local connection = ContentProvider:GetAssetFetchStatusChangedSignal(gameIconUrl):Connect(var7)
        return function()
            connection:Disconnect()
        end
    end, { gameIconUrl })

    local var8 = if var1 and tbl1.experienceUtilities then tbl1.experienceUtilities else useJoinUserInExperience(
        tbl1.userId,
        {
            isHomePageCarousel = true,
            homepageCarouselAbsolutePosition = tbl1.homepageCarouselAbsolutePosition,
            presence = tbl1.presence,
            onAgeCheckCompletion = useAgeCheckCompletionLogger(universeId)
        }
    )
    local onAgeCheckPressed = useAgeCheckPressLogger({
        userId = tbl1.userId,
        universeId = universeId,
        absolutePosition = tbl1.homepageCarouselAbsolutePosition,
        joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var4 else nil,
        joinAgeCheckUpsellFlow = var8.joinAgeCheckUpsellFlow
    })
    local var10, var11, var12

    if FFlagJoinabilityCTARefactor then
        local str2 = tostring(presence.userPresenceType)
        local str3 = tostring(presence.universeId)
        local str4 = tostring(presence.placeId)
        local str5 = tostring(presence.rootPlaceId)
        local ageCheckRequired = var8.ageCheckRequired
        local str6 = `{str2}:{str3}:{str4}:{str5}:{tostring(ageCheckRequired)}`

        local var13 = useJoinUserActions
        local userId = tbl1.userId
        local var14 = tbl1.isOpen == true and bool1
        var10, var11 = var13(userId, var14, str6)
        var12 = useLocalization(Actions.TextKeys)
    else
        var11 = nil
        var10 = nil
        var12 = nil
    end

    useLogActionsResolveTime(
        if FFlagJoinabilityCTARefactor then var11 else nil,
        tbl1.isOpen == true and bool1,
        GameJoinCardSurface.Desktop
    )
    local bool2 = if FFlagJoinabilityCTARefactor then var11 == DataStatus.Ready and containsAction(var10, UserCtaAction.UnlockExperience) else var8.ageCheckRequired == true
    local var13 = React.useRef(false)
    React.useEffect(function()
        local current = tbl1.isOpen == true and bool1

        if current and not var13.current then
            local var15 = if FFlagGameJoinCardAnalyticsCardId then HttpService:GenerateGUID(false) else nil

            if FFlagGameJoinCardAnalyticsCardId then
                var5(var15)
            end
            if FFlagJoinUserCTAsIxpEnabled then
                IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringJoinUserCTAsIxpLayer)
            end
            local universeId = tbl1.presence.universeId
            local logGameJoinCardPageLoaded = useGameJoinCardAnalytics.logGameJoinCardPageLoaded
            local tbl2 = {
                friendId = tbl1.userId,
                universeId = if universeId == nil or tostring(universeId) == "" then nil else tostring(universeId),
                absolutePosition = tbl1.homepageCarouselAbsolutePosition,
                joinGameCardId = 0
            }

            if not FFlagGameJoinCardAnalyticsCardId then
                var15 = nil
            end

            tbl2.joinGameCardId = var15
            logGameJoinCardPageLoaded(tbl2)
        end

        var13.current = current
    end, dependencyArray(tbl1.isOpen, bool1, tbl1.userId, tbl1.presence, tbl1.homepageCarouselAbsolutePosition))

    React.useEffect(function()
        if tbl1.isOpen and not bool1 then
            tbl1.onClose()
        end
    end, dependencyArray(bool1, tbl1))

    React.useEffect(function()
        if not (tbl1.isOpen and bool1 and bool2) then
            return
        end
        useGameJoinCardAnalytics.logJoinCardAgeCheckUpsellImpression(
            {
                universeId = if universeId == "" then nil else universeId
            }
        )
    end, dependencyArray(tbl1.isOpen, bool1, bool2, universeId))

    local isLoading = universeId == "" or lastLocation == nil or lastLocation == "" or var6 == Enum.AssetFetchStatus.Loading

    local var14 = usePreferredInput()
    local var15 = if FFlagDesktopGameJoinCardGamepadSupport then useDeviceType() else nil
    local isConsole = var14 == Responsive.Input.Directional
        and not (FFlagDesktopGameJoinCardGamepadSupport and var15 == RobloxAppEnums.DeviceType.Desktop)

    if tbl1.isConsole ~= nil then
        isConsole = tbl1.isConsole
    end
    local platformProfileId = tbl1.platformProfileId
    local var16 = React.useCallback(function()
        if getPlatformFriendsService == nil or platformProfileId == nil or platformProfileId == "" then
            return
        end
        getPlatformFriendsService:ShowProfile(platformProfileId)
    end, { platformProfileId })

    local var17 = useAppFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = false,
        isFocusable = tbl1.isFocused == true and bool1
    })

    local cardRef = React.useRef(nil)
    local bool4 = not (not (not FFlagDesktopGameJoinCardGamepadSupport or isConsole) or FFlagConsoleOpenGameJoinCard and isConsole)

    local focusRootRef = React.useCallback(function(current)
        cardRef.current = current
        if var17 and bool4 then
            var17(current)
        end
        if tbl1.onCardGuiObjectChanged then
            tbl1.onCardGuiObjectChanged(current)
        end
    end, { var17, tbl1.onCardGuiObjectChanged, bool4 })

    local eventIngest = useRoactService(AppEventIngestService)
    local var21 = useRoactService(AppSessionService)
    local guiService = useRoactService(AppGuiService)

    local var23 = useAppPolicy(function(arg1)
        return arg1.getCanUsePlatformChat()
    end)

    local bool5, tbl2

    if FFlagJoinabilityCTARefactor then
        bool5 = var11 == DataStatus.NotReady
        tbl2 = {}
        if var11 == DataStatus.Ready and var12 ~= nil then
            local resolveJoinCardActions = Actions.resolveJoinCardActions
            local tbl3 = {
                localized = var12,
                userId = tbl1.userId,
                telemetry = {
                    universeId = if universeId == "" then nil else universeId,
                    absolutePosition = tbl1.homepageCarouselAbsolutePosition,
                    joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var4 else nil
                },
                presence = 0,
                experience = 0,
                eventIngest = 0,
                dispatch = 0,
                guiService = 0,
                navigation = 0,
                joinAgeCheckUpsellFlow = 0
            }
            local tbl4 = {
                placeId = if presence.placeId == nil then nil else tostring(presence.placeId),
                rootPlaceId = if presence.rootPlaceId == nil then nil else tostring(presence.rootPlaceId)
            }
            tbl3.presence = tbl4

            tbl3.experience = {
                isLoading = isLoading,
                isInExperience = var8.isInExperience,
                joinExperience = var8.joinExperience,
                playExperience = var8.playExperience
            }
            tbl3.eventIngest = eventIngest
            tbl3.dispatch = dispatch
            tbl3.guiService = guiService
            tbl3.navigation = navigation
            tbl3.joinAgeCheckUpsellFlow = var8.joinAgeCheckUpsellFlow

            for _, value in (resolveJoinCardActions(var10, tbl3)) do
                if value.id ~= UserCtaAction.Chat or var23 then
                    table.insert(tbl2, value)
                end
            end
        end
    else
        tbl2 = nil
        bool5 = false
    end

    local var24 = React.useCallback(function()
        local userId = tbl1.userId
        if userId == "" then
            return
        end

        local var24 = if presence.placeId == nil or tostring(presence.placeId) == "" then "" else tostring(presence.placeId)
        local rootPlaceId = tonumber(presence.rootPlaceId)
        if var24 == "" or rootPlaceId == nil then
            return
        end
        gamePlayIntent(
            eventIngest,
            PeopleListInHomePage,
            {
                placeId = var24,
                rootPlaceId = rootPlaceId,
                friendId = userId,
                joinAttemptId = HttpService:GenerateGUID(false)
            }
        )
    end, dependencyArray(tbl1.userId, presence))

    local var25 = React.useCallback(function()
        if universeId == "" then
            return
        end
        local rootPlaceId = presence.rootPlaceId
        local pid = if rootPlaceId ~= nil and tostring(rootPlaceId) ~= "" then tostring(rootPlaceId) else universeId
        local homepageCarouselAbsolutePosition = tbl1.homepageCarouselAbsolutePosition or 0
        if var21 then
            SetGamePlaySession(var21, SessionType.StructuralIdentifier.GameDetailSource, false)
        end
        gameDetailReferral(eventIngest, "home", {
            ad = "no",
            friendId = tbl1.userId,
            pg = "home",
            pid = pid,
            pos = homepageCarouselAbsolutePosition,
            rowOnPage = 1,
            sortPos = tbl1.layoutOrder,
            tis = 1,
            universeId = universeId
        })
        dispatch(OpenGameDetails(universeId, navigation))
    end, dependencyArray(
        dispatch,
        navigation,
        universeId,
        presence,
        tbl1.homepageCarouselAbsolutePosition,
        tbl1.layoutOrder,
        tbl1.userId
    ))

    local onViewExperienceDetails = React.useCallback(function(arg1)
        if universeId == "" then
            return
        end
        if tbl1.userId ~= "" then
            local tbl3 = {
                friendId = tbl1.userId,
                universeId = if universeId == "" then nil else universeId,
                absolutePosition = tbl1.homepageCarouselAbsolutePosition,
                joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var4 else nil
            }
            if arg1 == viewEDPsourceValues.Thumbnail then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.ViewExperienceDetailsFromThumbnail, tbl3)
            elseif arg1 == viewEDPsourceValues.Title then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.ViewExperienceDetailsFromTitle, tbl3)
            end
        end

        var25()
    end, dependencyArray(var25, universeId, tbl1.userId, tbl1.homepageCarouselAbsolutePosition, var4))

    local var27 = React.useCallback(function()
        if tbl1.userId ~= "" then
            useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.JoinGame, {
                friendId = tbl1.userId,
                universeId = if universeId == "" then nil else universeId,
                absolutePosition = tbl1.homepageCarouselAbsolutePosition,
                joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var4 else nil
            })
        end
        var24()
        var8.joinExperience()
        tbl1.onClose()
    end, dependencyArray(
        var24,
        var8.joinExperience,
        tbl1.userId,
        universeId,
        tbl1.homepageCarouselAbsolutePosition,
        tbl1.onClose,
        var4
    ))

    local var28 = React.useCallback(function(arg1)
        if tbl1.userId ~= "" then
            local tbl3 = {
                friendId = tbl1.userId,
                universeId = if universeId == "" then nil else universeId,
                absolutePosition = tbl1.homepageCarouselAbsolutePosition,
                joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var4 else nil
            }
            if arg1 == viewProfileSourceValues.UserTile then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.OpenProfileFromUserTile, tbl3)
            elseif arg1 == viewProfileSourceValues.ViewProfileButton then
                useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.OpenProfileFromViewProfile, tbl3)
            end
        end

        (if FFlagEnableSplitPane then navigation.push else navigation.navigate)(
            AppPage.ProfilePlatform,
            {
                detail = tbl1.userId
            }
        )
        tbl1.onClose()
    end, dependencyArray(navigation, tbl1.userId, universeId, tbl1.homepageCarouselAbsolutePosition, tbl1.onClose, var4))

    local var29 = React.useCallback(function()
        if tbl1.userId == "" then
            return
        end
        useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.Chat, {
            friendId = tbl1.userId,
            universeId = if universeId == "" then nil else universeId,
            absolutePosition = tbl1.homepageCarouselAbsolutePosition,
            joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then var4 else nil
        })
        if FFlagGameJoinCardChatEntryPoint then
            dispatch(EnteredChatFromEntryPoint(ChatEntryPointNames.GameJoinCard))
        end
        guiService:BroadcastNotification(tbl1.userId, NotificationType.LAUNCH_CONVERSATION)
        tbl1.onClose()
    end, dependencyArray(
        tbl1.userId,
        universeId,
        tbl1.homepageCarouselAbsolutePosition,
        guiService,
        tbl1.onClose,
        var4,
        dispatch
    ))

    local createElement = React.createElement
    local var30 = DesktopGameJoinCard
    local tbl3 = {
        layoutOrder = layoutOrder,
        playerName = playerName,
        experienceName = lastLocation,
        gameIconUrl = gameIconUrl,
        isLoading = isLoading,
        onJoin = var27,
        onViewExperienceDetails = onViewExperienceDetails,
        anchorRef = tbl1.anchorRef,
        isOpen = tbl1.isOpen and bool1,
        onClose = tbl1.onClose,
        isConsole = isConsole,
        consolePlatformLabel = platformName,
        focusRootRef = focusRootRef,
        ageCheckRequired = var8.ageCheckRequired,
        onAgeCheckPressed = onAgeCheckPressed,
        onPlatformProfilePressed = 0,
        onChat = 0,
        onViewProfile = 0,
        actions = 0,
        areActionsLoading = 0
    }

    if not isConsole then
        var16 = nil
    end

    tbl3.onPlatformProfilePressed = var16
    if isConsole or not var23 then
        var29 = nil
    end

    tbl3.onChat = var29
    if isConsole then
        var28 = nil
    end

    tbl3.onViewProfile = var28
    tbl3.actions = not FFlagJoinabilityCTARefactor and {} or tbl2
    if not FFlagJoinabilityCTARefactor then
        bool5 = nil
    end

    tbl3.areActionsLoading = bool5
    local card = createElement(var30, tbl3)

    if not tbl1.showGamepadJoinFocus then
        return card
    end

    return React.createElement(React.Fragment, nil, {
        GamepadJoinFocus = React.createElement(GamepadJoinFocusBehavior, { tileRef = tbl1.anchorRef, cardRef = cardRef, joinExperience = var27 }),
        Card = card
    })
end
return DesktopGameJoinCardContainer
