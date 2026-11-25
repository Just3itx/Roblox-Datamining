-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local InputUi = require(ProfilePlatformParent.InputUi)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)

local useScreenSize = RobloxAppHooks.useScreenSize
local useTopBarHeight = RobloxAppHooks.useTopBarHeight
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local ProfileTopBar = require(ProfilePlatform.Components.ProfileTopBar)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileScrollContext = require(ProfilePlatform.Contexts.ProfileScrollContext.useProfileScrollContext)
local useProfileCardWidth = require(ProfilePlatform.Hooks.useProfileCardWidth)
local useProfileCardWidth2 = require(ProfilePlatformParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local getPeekViewOpenHeightByProfileType = require(ProfilePlatform.Utils.getPeekViewOpenHeightByProfileType)
local getSafeAreaSize = InputUi.getSafeAreaSize
local useProfilePeekViewHeight = require(ProfilePlatform.Hooks.useProfilePeekViewHeight)
local useShouldShowContextualInformation = require(ProfilePlatform.Hooks.useShouldShowContextualInformation)
local Constants = require(ProfilePlatform.Common.Constants)
local Presence = require(ProfilePlatform.Rodux.Presence)
local NetworkingPresence = require(ProfilePlatform.Networking.NetworkingPresence)
local convertPresenceEnum = require(ProfilePlatform.Utils.convertPresenceEnum)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffectOnMount = RoactUtils.Hooks.useEffectOnMount
local Enums = require(ProfilePlatform.Common.Enums)

local ProfileModalView = require(script.Parent.ProfileModalView)
local ProfileFullView = require(script.Parent.ProfileFullView)
local ProfilePlatformPage = require(ProfilePlatform.Components.ProfilePlatformPage)
local ProfilePeekView = require(script.Parent.ProfilePeekView)
local isPeekViewStateFullyOpen = require(ProfilePlatform.Utils.isPeekViewStateFullyOpen)
local FFlagProfileInspectAvatarSlideIn = require(ProfilePlatformParent.SharedFlags).FFlagProfileInspectAvatarSlideIn
local FFlagProfileInspectAvatarShopChip = require(ProfilePlatformParent.SharedFlags).FFlagProfileInspectAvatarShopChip
local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformNewProfileHeader

local FFlagSwitchProfileWidthHookToSocialCommon = require(ProfilePlatformParent.SharedFlags).FFlagSwitchProfileWidthHookToSocialCommon
local FFlagEnableMobileGameJoinCard = require(ProfilePlatformParent.SharedFlags).FFlagEnableMobileGameJoinCard

local FFlagProfilePlatformPresenceStoreMigration = require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration)
local useGetPresenceByUserId = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local var1 = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.DataHydration).Presence.PresenceStore.get() else nil
local FFlagEnableSplitPane = require(ProfilePlatformParent.SharedFlags).FFlagEnableSplitPane
local SplitPane = if FFlagEnableSplitPane then require(ProfilePlatformParent.SplitPane) else nil
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState

local tbl1 = { skipFetch = true }

return function(_)
    local var2 = useProfileWrapperContext()
    local var3 = useProfileScrollContext()
    local profileType = var2.profileType
    local previousView = var2.navigateTo.previousView
    local var4 = useScreenSize()
    local topBarHeight = useTopBarHeight()
    local mountAsFullView = if FFlagEnableMobileGameJoinCard then var2.mountAsFullView or false else false

    local navigateBack = React.useCallback(function()
        previousView(false)
    end, { previousView })

    local onClosed = React.useCallback(function()
        previousView(true)
    end, { previousView })

    local var8 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)

    local var9 = useProfileFormFactor()
    local bool1 = var9.formFactor == Enums.ProfileFormFactor.Wide
    local bool2

    if FFlagEnableSplitPane then
        local store = SplitPane.SplitPaneStore.getStore()
        local var10 = useSignalState(store.getSupportPaneModeIfActive)
        if var10 == nil then
            bool2 = false
        else
            bool2 = SplitPane.SplitPaneVariant.getProfileSplitPaneEligibility(var10) ~= nil
        end
    else
        bool2 = false
    end

    local renderContent = React.useCallback(function()
        return React.createElement(ProfilePlatformPage, {})
    end, {})

    local var11 = FFlagEnableSplitPane and bool2

    local renderTopBar = React.useCallback(function()
        return React.createElement(ProfileTopBar, {
            navigateBack = navigateBack,
            transparentBackground = true,
            backgroundTransparency = nil,
            hideNavigationButton = if FFlagEnableSplitPane then var11 else nil
        })
    end, FFlagEnableSplitPane and { navigateBack, var11 } or {})

    local safeAreaSize = getSafeAreaSize(var4, var8)
    local var13 = if FFlagProfilePlatformNewProfileHeader then if FFlagSwitchProfileWidthHookToSocialCommon then useProfileCardWidth2() else useProfileCardWidth(bool1) else math.min(safeAreaSize.X.Offset, Constants.MAXIMUM_CONTAINER_WIDTH)
    local offset

    if FFlagProfilePlatformNewProfileHeader then
        local profileId = var2.profileId
        local var14

        if FFlagProfilePlatformPresenceStoreMigration then
            useEffectOnMount(function()
                var1.RefreshPresenceByUserId(tostring(profileId))
            end)
            local var15 = useGetPresenceByUserId(profileId, tbl1)
            local var16 = convertPresenceEnum
            local var17 = var15 and var15.userPresenceType or Presence.Enums.PresenceType.Offline
            local var18 = if var15 and var15.universeId ~= "" then tonumber(var15.universeId) or nil else nil
            var14 = var16(var17, var18)
        else
            local var15 = useDispatch()

            useEffectOnMount(function()
                var15(NetworkingPresence.GetPresencesFromUserIds.API({ profileId })):catch(function(_) end)
            end)

            local var16 = useSelector(function(arg1)
                return Presence.Selectors.getUserPresenceByUserId(arg1, profileId)
                    or {
                        userPresenceType = Presence.Enums.PresenceType.Offline,
                        lastLocation = ""
                    }
            end)

            var14 = convertPresenceEnum(var16.userPresenceType, var16.universeId)
        end

        local var15 = useShouldShowContextualInformation(var14)
        offset = useProfilePeekViewHeight(var13, var15)
    else
        offset = nil
    end

    if not FFlagProfilePlatformNewProfileHeader or profileType ~= Enums.ProfileTypes.User then
        offset = getPeekViewOpenHeightByProfileType(profileType)
    end

    local uDim = if safeAreaSize.Y.Offset - topBarHeight < offset then UDim.new(1, 0) else UDim.new(0, offset)

    if var9.isFullView then
        return React.createElement(ProfileFullView, { renderContent = renderContent, navigateBack = navigateBack })
    end

    if bool1 then
        return React.createElement(ProfileModalView, {
            renderContent = renderContent,
            renderTopBar = renderTopBar,
            topBarHeight = topBarHeight,
            viewWidth = var13,
            fillPane = bool2,
            navigateBack = navigateBack
        })
    end

    local createElement = React.createElement
    local var14 = ProfilePeekView

    local tbl2 = {
        bottomDockedContainerHeight = 0,
        briefViewContentHeight = uDim,
        contentSlot = renderContent(),
        fullViewContentHeight = UDim.new(1, 0),
        mountAsFullView = mountAsFullView,
        onClosed = onClosed,
        onViewStateChanged = (FFlagProfileInspectAvatarSlideIn or FFlagProfileInspectAvatarShopChip) and function(arg1)
            var3.setIsPeekViewFullyOpen(isPeekViewStateFullyOpen(arg1))
        end or nil,
        topBarHeight = topBarHeight,
        topBarSlot = renderTopBar(),
        viewWidth = UDim.new(0, safeAreaSize.X.Offset),
        transitionPercentCallback = function(num1: number)
            var3.setPeekViewOpenPercent(num1)
        end,
        profileType = 0
    }
    if not FFlagProfilePlatformNewProfileHeader then
        profileType = nil
    end

    tbl2.profileType = profileType
    return createElement(var14, tbl2)
end
