-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local IXPService = game:GetService("IXPService")
local EditProfileParent = EditProfile.Parent
local EditProfileLanding = require(EditProfile.Components.EditProfileLanding.EditProfileLanding)
local EditProfileLandingV2 = require(EditProfile.Components.EditProfileLanding.EditProfileLandingV2)
local FFlagEditProfileLandingV2Enabled = require(EditProfile.Flags.FFlagEditProfileLandingV2Enabled)
local React = require(EditProfileParent.React)
local Cryo = require(EditProfileParent.Cryo)
local useEffect = React.useEffect
local useLocalUserId = require(EditProfileParent.RobloxAppHooks).useLocalUserId
local var1 = require(EditProfileParent.UserProfiles).Stores.UserProfileStore.get()
local EditProfileStore = require(EditProfile.Stores.EditProfileStore)
local ProfileRefreshSignal = require(EditProfileParent.ProfilePlatformCommon).Signals.ProfileRefreshSignal
local Enums = require(EditProfile.Common.Enums)
local Constants = require(EditProfile.Common.Constants)
local useLocalRobuxBalance = require(EditProfileParent.RobloxAppHooks).useLocalRobuxBalance
local useRealNamesInDisplayNamesEnabled = require(EditProfile.Hooks.useRealNamesInDisplayNamesEnabled)
local FocusNavigatorWrapper = require(EditProfile.Utils.FocusNavigatorWrapper)
local FFlagEditProfilePPEStartOnEmotesPage = require(EditProfile.Flags.FFlagEditProfilePPEStartOnEmotesPage)
local FFlagEditProfileUsernameServerPrice = require(EditProfile.Flags.FFlagEditProfileUsernameServerPrice)

local useSignalState = require(EditProfileParent.SignalsReact).useSignalState

local Signals = require(EditProfileParent.Signals)

local DataHydrationTypes = require(EditProfileParent.DataHydration).DataHydrationTypes

local signal = Signals.createSignal("")
local AnalyticsServiceV2 = require(EditProfile.Analytics.AnalyticsServiceV2)
local FFlagAXEnableProfileTab = require(EditProfileParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagSplitPaneFullBleedEditProfile = require(EditProfileParent.SharedFlags).FFlagSplitPaneFullBleedEditProfile
local FFlagAXPPEReturnToEntrySurface = require(EditProfileParent.SharedFlags).FFlagAXPPEReturnToEntrySurface
local FFlagEditProfileImageV2Enabled = require(EditProfileParent.SharedFlags).FFlagEditProfileImageV2Enabled
local FocusNavigationUtils = require(EditProfileParent.FocusNavigationUtils)
local ReactFocusNavigation = require(EditProfileParent.ReactFocusNavigation)

local RoactNavigation = require(EditProfileParent.RoactNavigation)
local NavigationEvents = RoactNavigation.NavigationEvents
local layerName = game:DefineFastString("EditProfileIXPLayer", "Social.EditProfilePage")

local function getHostRoute(navigation) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = navigation._dangerouslyGetParent()
    local state = var2 and var2.state
    return if state and state.routeName then state else nil
end

local function getCoveredPage(arg1, hostRoute)
    local var2 = arg1._dangerouslyGetParent()

    while var2 do
        local var3 = if var2._dangerouslyGetParent then var2._dangerouslyGetParent() else nil
        arg1 = var2
        var2 = var3
    end

    local routes = arg1.state.routes
    if not routes then
        return nil, nil
    end

    for value, value2 in routes do
        if value2.routeName ~= hostRoute.routeName or not (value > 1) then
            continue
        end

        local var3 = routes[value - 1]
        if var3.routes and var3.index then
            var3 = var3.routes[var3.index]
        end

        return var3.routeName, var3.params
    end

    return nil, nil
end

local function openEditProfileImageFromProfilePlatform(navigation, tbl1)
    local tbl2 = {}
    if tbl1 and tbl1.mode then
        tbl2.mode = tbl1.mode
    end

    if FFlagAXEnableProfileTab and navigation.getParam and navigation.getParam("fullBleed") == true then
        tbl2.fullBleed = true
    end

    if next(tbl2) == nil then
        navigation.navigate(Enums.Screens.EditProfileImageProfilePlatform)
        return
    end
    navigation.navigate(Enums.Screens.EditProfileImageProfilePlatform, tbl2)
end

local function EditProfileLandingContainer(tbl1)
    local userId = useLocalUserId()
    local isPolicyEnabled = useRealNamesInDisplayNamesEnabled()
    local function onClose()
        ProfileRefreshSignal.notifyProfileRefresh()
        tbl1.navigation.pop()
    end

    local firstItemRef = React.useRef(nil)
    local tbl2 = { nil }
    local var5 = FocusNavigationUtils.useAutoFocus(tbl2, 0.1)
    local var6 = React.useContext(ReactFocusNavigation.FocusNavigationContext)

    useEffect(function()
        tbl2[1] = firstItemRef.current
        local var7 = if var6 and var6.focusedGuiObject:getValue() ~= nil and var5 then var5() else nil

        return function()
            if var7 then
                var7.cancel()
            end
        end
    end, { var5 })

    local fullBleed = FFlagAXEnableProfileTab and tbl1.navigation.getParam("fullBleed") == true
    local bool1

    if FFlagSplitPaneFullBleedEditProfile then
        local var8 = React.useContext(require(EditProfileParent.SplitPane).PaneHostContext)
        if var8 == nil then
            bool1 = fullBleed
        else
            bool1 = not var8.isFullScreen
        end
    else
        bool1 = fullBleed
    end

    local function displayName()
        AnalyticsServiceV2.sendDisplayNameModalOpened()
        tbl1.navigation.navigate(
            Enums.Screens.EditProfileSubScreen,
            {
                screen = Enums.Screens.EditDisplayName,
                fullBleed = fullBleed
            }
        )
    end
    local function showToast(text: string)
        tbl1.navigation.goBack()
        tbl1.navigation.navigate(Enums.Screens.EditProfileToast, { text = text })
    end

    local param = tbl1.navigation.getParam(Constants.EditUserNameWebView)
    local function navigateDownToPurchaseRobux()
        tbl1.navigation.navigate(Enums.Screens.UsernameInsufficientFundsModal)
    end
    local var8 = useLocalRobuxBalance()

    local var9 = nil
    if FFlagEditProfileUsernameServerPrice then
        local usernameChangePrice = EditProfileStore.getUsernameChangePrice(tostring(userId))
        var9 = useSignalState(usernameChangePrice.data)
    end

    local function username()
        local var10 = if FFlagEditProfileUsernameServerPrice then var9 and var9.priceInRobux else Constants.ChangeUsernamePrice
        local var11 = FFlagEditProfileUsernameServerPrice

        if var11 then
            if var9 == nil then
                var11 = false
            else
                var11 = var9.isFreeUsernameChange
            end
        end

        if var11 or var10 == nil or var10 <= var8 then
            param(showToast)
        else
            tbl1.navigation.navigate(
                Enums.Screens.UsernameInsufficientFundsModal,
                {
                    robux = var10 - var8,
                    navigateDownToPurchaseRobux = navigateDownToPurchaseRobux
                }
            )
        end

        AnalyticsServiceV2.sendEditUsernameOpened()
    end

    local function bio()
        tbl1.navigation.navigate(Enums.Screens.EditProfileSubScreen, { screen = Enums.Screens.EditBio, fullBleed = fullBleed })
    end

    local function avatar()
        AnalyticsServiceV2.sendOpenAvatarMarketplace()
        if FFlagEditProfileImageV2Enabled then
            openEditProfileImageFromProfilePlatform(tbl1.navigation)
            return
        end
        if FFlagAXPPEReturnToEntrySurface then
            local var10 = if FFlagEditProfilePPEStartOnEmotesPage then Enums.Screens.ProfilePictureEditorEmotes else Enums.Screens.ProfilePictureEditorCamera
            local hostRoute = getHostRoute(tbl1.navigation)
            if hostRoute then
                local coveredScreenName, coveredScreenParams = getCoveredPage(tbl1.navigation, hostRoute)
                local entryOrigin = {
                    screenName = hostRoute.routeName,
                    screenParams = hostRoute.params,
                    reopenAction = RoactNavigation.Actions.navigate({ routeName = tbl1.navigation.state.routeName, params = tbl1.navigation.state.params }),
                    coveredScreenName = coveredScreenName,
                    coveredScreenParams = coveredScreenParams
                }
                tbl1.navigation.navigate(var10, { entryOrigin = entryOrigin })

                return
            end
        end

        if FFlagEditProfilePPEStartOnEmotesPage then
            tbl1.navigation.navigate(Enums.Screens.ProfilePictureEditorEmotes)
            return
        end
        tbl1.navigation.navigate(Enums.Screens.ProfilePictureEditorCamera)
    end

    local var10 = React.useMemo(function()
        return var1.fetchNamesByUserIds({ tostring(userId) })
    end, { userId })
    useEffect(function()
        AnalyticsServiceV2.sendEditProfileOpened()
    end, {})

    local var11 = useSignalState(var10)
    local areNamesLoading = not var11 or var11.status ~= "success"
    local var12 = var11 and var11.data and var11.data[1]
    local var13 = if var12 then var12.names.getUsername else signal
    local var14 = if var12 then var12.names.getDisplayName else signal
    local var2 = useSignalState(var13) or ""
    local var3 = useSignalState(var14) or ""

    local description = EditProfileStore.getDescription(userId)
    local isBioLoading = useSignalState(description.status) == DataHydrationTypes.DataStatus.NotReady
    local bioText = useSignalState(description.data) or ""

    local function onProfileFramesActivated()
        openEditProfileImageFromProfilePlatform(tbl1.navigation, { mode = Enums.EditProfileImageMode.FramesOnly })
    end

    local tbl3 = {
        userId = userId,
        fullBleed = bool1,
        onClose = onClose,
        username = var2,
        displayName = var3,
        areNamesLoading = areNamesLoading,
        bioText = bioText,
        isBioLoading = isBioLoading,
        isPolicyEnabled = isPolicyEnabled,
        settingButtonOnActivated = {
            displayName = displayName,
            username = username,
            bio = bio,
            avatar = avatar
        },
        firstItemRef = firstItemRef
    }

    return FocusNavigatorWrapper({ onClose = onClose }, {
        EditProfileLandingExposureLogger = React.createElement(NavigationEvents, {
            onDidFocus = function()
                IXPService:LogUserLayerExposure(layerName)
            end
        }),
        EditProfileLanding = if FFlagEditProfileLandingV2Enabled then React.createElement(
            EditProfileLandingV2,
            Cryo.Dictionary.join(tbl3, { onProfileFramesActivated = onProfileFramesActivated })
        ) else React.createElement(EditProfileLanding, tbl3)
    })
end

return EditProfileLandingContainer
