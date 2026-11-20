-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local VRService = game:GetService("VRService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Components = scriptParentParent.Components
local Presentation = Components.Presentation
local Chrome = scriptParentParent.Parent.Chrome

local Constants = require(scriptParentParent.Constants)
local ExperienceAgeRatingPolicy = require(scriptParentParent.ExperienceAgeRatingPolicy)
local ExperienceAgeRatingBadge = require(CorePackages.Workspace.Packages.InExperienceTopBar.ExperienceAgeRatingBadge)
local InExperienceCloudPlay = CorePackages.Workspace.Packages.InExperienceCloudPlay
local FFlagEnableRestyleTopBar = require(InExperienceCloudPlay.FFlagEnableRestyleTopBar)
local RestyleTimer = if FFlagEnableRestyleTopBar then require(Presentation.RestyleTimer) else nil
local FFlagExperienceAgeRatingBadge = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagExperienceAgeRatingBadge

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local CoreScriptsRoactCommon = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon)
local Foundation = require(CorePackages.Packages.Foundation)
local Display = require(CorePackages.Workspace.Packages.Display)
local React = require(CorePackages.Packages.React)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local _Songbird = require(CorePackages.Workspace.Packages.Songbird)
local SwitchServer = require(CorePackages.Workspace.Packages.SwitchServer)
local Traversal = CoreScriptsRoactCommon.Traversal
local UIBlox = require(CorePackages.Packages.UIBlox)
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)

local FFlagAddMenuNavigationToggleDialog = SharedFlags.FFlagAddMenuNavigationToggleDialog
local FFlagGamepadNavigationDialogABTest = require(scriptParentParent.Flags.FFlagGamepadNavigationDialogABTest)
local FFlagEnablePlaytestModeUnibar = SharedFlags.FFlagEnablePlaytestModeUnibar
local FFlagUseUIOverlayForCloudPlay = SharedFlags.FFlagUseUIOverlayForCloudPlay
local FFlagEnableTeamTestLua = SharedFlags.FFlagEnableTeamTestLua
local FFlagAddTraversalBackButton = Traversal.Flags.FFlagAddTraversalBackButton
local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice

local GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice = SharedFlags.GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagShowGameAgeRating = SharedFlags.FFlagShowGameAgeRating
local var1 = FFlagExperienceAgeRatingBadge and FFlagShowGameAgeRating
local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab
local InExperienceShop = require(CorePackages.Workspace.Packages.InExperienceShop)
local FFlagEnableInExperienceShop = SharedFlags.FFlagEnableInExperienceShop
local var2 = InExperienceShop.FFlagEnableExperienceShopGlobalIcon and FFlagEnableInExperienceShop
local FFlagCenterInExperienceShopWindow = InExperienceShop.FFlagCenterInExperienceShopWindow
local FFlagExperienceShopNewIconography = InExperienceShop.FFlagExperienceShopNewIconography
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local var3 = isSideSheetEnabled and (FFlagShowSwitchServerButton or isPioneerLaunch())
local ShopGlobalIcon = InExperienceShop.ShopGlobalIcon
local FFlagEnableFreeTrialTopBarChip = InExperienceShop.FFlagEnableFreeTrialTopBarChip
local FreeTrialChipHost = require(Presentation.FreeTrialChipHost)
local FFlagTopBarShopIconV2 = require(scriptParentParent.Flags.FFlagTopBarShopIconV2)
local ShopIcon = if FFlagTopBarShopIconV2 then require(Components.Presentation.ShopIcon) else nil

local View = Foundation.View
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider

local GamepadConnector = require(Components.GamepadConnector)
local GamepadNavigationDialog = require(Presentation.GamepadNavigationDialog)
local HealthBar = CoreGuiCommon.Components.HealthBar
local MenuIcon = require(scriptParentParent.ComponentsV2.MenuIcon)
local MenuIconContext = require(Components.MenuIconContext)
local MenuNavigationToggleDialog = require(Presentation.GamepadMenu.MenuNavigationToggleDialog)
local TraversalBackButton = require(Components.TraversalBackButton)
local PlaytestModeTooltip = require(Presentation.PlaytestModeTooltip)
local var4 = if isInExperienceUIVREnabled then require(Components.VRBottomUnibar) else require(scriptParentParentParent.VR.VRBottomBar.VRBottomBar)
local BuildExperience = require(CorePackages.Workspace.Packages.BuildExperience)
local BuildModeLaunch = require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.BuildModeLaunch)
local BuildPillMenuPortalHost = BuildExperience.BuildPillMenuPortalHost
local UnpublishedPlaytestModeTooltip = BuildExperience.UnpublishedPlaytestModeTooltip
local Analytics = if game:GetEngineFeature("InGameChromeSignalAPI") then require(Chrome.ChromeShared.Analytics) else nil
local JoinVoiceBinder = if game:GetEngineFeature("VoiceChatSupported") and GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice() then require(Chrome.Integrations.JoinVoiceBinder) else nil
local PartyMicBinder = require(Chrome.Integrations.Party.PartyMicBinder)
local Unibar = require(Chrome.ChromeShared.Unibar)
local default = require(scriptParentParentParent.VoiceChat.VoiceChatServiceManager).default
local VoiceStateContext = require(scriptParentParentParent.VoiceChat.VoiceStateContext)
local Service = if var2 then require(Chrome.Service) else nil
local Constants2 = if var2 then require(Chrome.ChromeShared.Unibar.Constants) else nil
local CommonIcon = if var2 then require(Chrome.Integrations.CommonIcon) else nil
local useMappedSignal = if var2 then require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal else nil

local var5 = if var2 and Service and Constants2 then require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal.new(Service:onIntegrationStatusChanged(), function()
    return Service:isWindowOpen(Constants2.IN_EXPERIENCE_SHOP_ID)
end) else nil

local toggleInExperienceShopWindow = if var2 then require(Chrome.Integrations.InExperienceShop.ShopWindowLayout).toggleInExperienceShopWindow else nil
local SwitchServerConfirmation = SwitchServer.SwitchServerConfirmation
local GetSwitchServerStore = SwitchServer.GetSwitchServerStore

local function getShopGlobalIconEnabled(arg1)
    if not var2 then
        return false
    end
    local getShopGlobalIconStore = InExperienceShop.GetShopGlobalIconStore
    if getShopGlobalIconStore then
        return (getShopGlobalIconStore(arg1).getEnabled(arg1))
    end

    return false
end

local function getShopGlobalStatusIndicatorEnabled(arg1)
    if not var2 then
        return false
    end
    local getShopGlobalIconStore = InExperienceShop.GetShopGlobalIconStore
    if getShopGlobalIconStore then
        return (getShopGlobalIconStore(arg1).getStatusIndicatorEnabled(arg1))
    end

    return false
end

local function handleShopGlobalIconActivated()
    if not var2 then
        return
    end
    if FFlagCenterInExperienceShopWindow then
        if toggleInExperienceShopWindow then
            toggleInExperienceShopWindow()
        end
    elseif Service and Constants2 then
        Service:toggleWindow(Constants2.IN_EXPERIENCE_SHOP_ID)
    end
end

local function canShowAssistantBuild() -- Luacid: Inlined by compiler; 1 call site recovered
    return BuildModeLaunch:hasBuildMode() and not VRService.VREnabled
end

local function getShouldEnableSwitchServer(arg1)
    if not var3 then
        return false
    end
    local var6 = GetSwitchServerStore
    if var6 then
        return (var6(arg1).shouldEnableSwitchServer(arg1))
    end

    return false
end

local function getIsConfirmationOpen(arg1)
    if not var3 then
        return false
    end
    local var6 = GetSwitchServerStore
    if var6 then
        return (var6(arg1).isConfirmationOpen(arg1))
    end

    return false
end

local function TopBarApp(_)
    local var6 = if FFlagShowGameAgeRating then UniversalAppPolicy.useAppPolicy(function(arg1)
        return arg1.getShowGameAgeRating()
    end) else UniversalAppPolicy.useAppPolicy(function(arg1)
        return arg1.getShowBadgeOver12()
    end)

    local var7 = SignalsReact.useSignalState(function(arg1)
        return CoreGuiCommon.Stores.GetKeepOutAreasStore(arg1)
    end)
    local var8 = SignalsReact.useSignalState(function(arg1)
        return Display.GetDisplayStore(arg1).getUIScale(arg1)
    end)

    local var9, var10, var11, var12

    if var2 and not FFlagTopBarShopIconV2 then
        var9 = SignalsReact.useSignalState(getShopGlobalIconEnabled)
        var10 = SignalsReact.useSignalState(getShopGlobalStatusIndicatorEnabled)
        var11 = handleShopGlobalIconActivated
        React.useEffect(function()
            return InExperienceShop.initShopGlobalIcon and InExperienceShop.initShopGlobalIcon() or function() end
        end, {})
        var12 = (useMappedSignal or function() end)(var5)
    else
        var9 = nil
        var10 = nil
        var11 = nil
        var12 = nil
    end

    local var13 = React.useRef(nil)
    local var14 = isSpatial()
    local var15 = nil
    if FFlagExperienceAgeRatingBadge then
        local var16
        var14, var16 = React.useState(var14)
        var15 = var16
    end
    local replacesAgeRating = ExperienceAgeRatingPolicy.isEligible(var6, true, true, var14)
    local menuIconRef = React.useRef(nil)

    local showTopBar = GamepadConnector:getShowTopBar()
    local var18, var19 = React.useBinding(showTopBar:get())

    React.useEffect(function()
        if not isSpatial() then
            GamepadConnector:connectToTopbar()
        end
        local connection = VRService:GetPropertyChangedSignal("VREnabled"):Connect(function()
            if FFlagExperienceAgeRatingBadge then
                var15(isSpatial())
            end
            if isSpatial() then
                GamepadConnector:disconnectFromTopbar()
                return
            end
            GamepadConnector:connectToTopbar()
        end)

        local connection2 = showTopBar:connect(function()
            var19(showTopBar:get())
        end)
        return function()
            if connection then
                connection:Disconnect()
            end
            GamepadConnector:disconnectFromTopbar()
            if var7 then
                var7.cleanup()
            end
            connection2:disconnect()
        end
    end, {})

    local var20 = React.useCallback(function(arg1)
        var7.setKeepOutArea(Constants.TopBarKeepOutAreaId, arg1.AbsolutePosition, arg1.AbsoluteSize)
    end, { var7 })

    local xOffset = Constants.ScreenSideOffset * var8
    local yOffset = Constants.TopBarHeight * var8
    local yOffset2 = Constants.TopBarButtonHeight * var8
    local yOffset3 = Constants.TopBarTopMargin * var8
    local var21, var22, setConfirmationOpen

    if var3 then
        var21 = SignalsReact.useSignalState(getShouldEnableSwitchServer)
        var22 = SignalsReact.useSignalState(getIsConfirmationOpen)
        setConfirmationOpen = GetSwitchServerStore(false).setConfirmationOpen
    else
        var21 = nil
        var22 = nil
        setConfirmationOpen = nil
    end

    local createElement = React.createElement
    local var23 = View
    local tbl1 = {
        tag = "anchor-top-left auto-x row gap-small",
        Size = UDim2.fromOffset(0, yOffset2),
        onAbsoluteSizeChanged = if var1 then nil else var20,
        onAbsolutePositionChanged = if var1 then nil else var20,
        Position = if var1 then nil else UDim2.new(0, xOffset, 0, yOffset3),
        Visible = var18
    }
    local tbl2 = {
        MenuIcon = 0,
        TraversalBackButton = 0,
        UnibarFrame = 0,
        ShopIcon = 0,
        ShopGlobalIcon = 0,
        RestyleTimer = 0
    }
    local var24

    if isSideSheetEnabled then
        var24 = nil
    else
        local createElement2 = React.createElement
        local var25 = SelectionCursorProvider
        local tbl3 = {}
        local tbl4 = {
            Icon = React.createElement(MenuIcon, {
                buttonSize = if var1 then yOffset2 else nil,
                showBadgeOver12 = var6 and not replacesAgeRating,
                menuIconRef = menuIconRef,
                unibarMenuRef = var13
            })
        }
        var24 = createElement2(var25, tbl3, tbl4)
    end

    tbl2.MenuIcon = var24

    tbl2.TraversalBackButton = if FFlagAddTraversalBackButton then React.createElement(TraversalBackButton) else nil
    tbl2.UnibarFrame = React.createElement(
        MenuIconContext.Provider,
        {
            value = { menuIconRef = menuIconRef, replacesAgeRating = replacesAgeRating }
        },
        {
            React.createElement(Unibar, {
                layoutOrder = 2,
                onMinWidthChanged = function() end,
                onAreaChanged = function() end,
                menuRef = var13
            })
        }
    )

    tbl2.ShopIcon = if FFlagTopBarShopIconV2 and var2 then React.createElement(ShopIcon, { buttonSize = yOffset2, layoutOrder = 3 }) else nil
    local element = if FFlagTopBarShopIconV2 or not var2 or not var9 or ShopGlobalIcon == nil then nil else React.createElement(
        ShopGlobalIcon,
        {
            buttonSize = yOffset2,
            layoutOrder = 3,
            showStatusIndicator = var10,
            onActivated = var11,
            isActive = var12,
            icon = if FFlagExperienceShopNewIconography or not (CommonIcon and var5) then nil else CommonIcon("BuildingStore", nil, var5)
        }
    )
    tbl2.ShopGlobalIcon = element

    tbl2.RestyleTimer = if FFlagEnableRestyleTopBar and FFlagUseUIOverlayForCloudPlay then React.createElement(RestyleTimer, { buttonSize = yOffset2, layoutOrder = 4 }) else nil
    local element2 = createElement(var23, tbl1, tbl2)

    local createElement2 = React.createElement
    local str1 = "ScreenGui"
    local tbl3 = {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 6
    }
    local tbl4 = {
        Popups = React.createElement(View, { tag = "size-full" }, {
            MenuNavigationToggleDialog = if FFlagAddMenuNavigationToggleDialog then React.createElement(
                MenuNavigationToggleDialog,
                {
                    Position = UDim2.fromScale(0.5, 0.1),
                    GamepadConnector = GamepadConnector
                }
            ) else nil,
            GamepadNavigationDialog = if FFlagGamepadNavigationDialogABTest then React.createElement(GamepadNavigationDialog) else nil,
            SwitchServerConfirmation = if var21 and var22 then React.createElement(SwitchServerConfirmation, { setSwitchServerConfirmationOpen = setConfirmationOpen }) else nil
        }),
        Binders = React.createElement(React.Fragment, {}, {
            JoinVoiceBinder = if JoinVoiceBinder then React.createElement(JoinVoiceBinder) else nil,
            PartyMicBinder = if GetFFlagEnableCrossExpVoice() then React.createElement(PartyMicBinder) else nil,
            ChromeAnalytics = if Analytics then React.createElement(Analytics) else nil
        }),
        PlaytestTooltip = if FFlagEnablePlaytestModeUnibar then React.createElement(PlaytestModeTooltip, { anchorRef = var13 }) else nil,
        UnpublishedPlaytestTooltip = if FFlagEnableTeamTestLua then React.createElement(UnpublishedPlaytestModeTooltip, { anchorRef = var13, isVisible = var18 }) else nil,
        TopBarFrame = 0,
        VRBottomBar = 0
    }

    local createElement3 = React.createElement
    local var25 = View
    local tbl5 = {
        Size = UDim2.new(1, 0, 0, yOffset)
    }
    local tbl6 = { TopLeftFrame = 0, TopRightFrame = 0, FreeTrialChipHost = 0 }
    if var1 then
        local createElement4 = React.createElement
        local var26 = View
        local tbl7 = {
            tag = "row align-y-center gap-small auto-x",
            Size = UDim2.fromOffset(0, yOffset2),
            Position = UDim2.new(0, xOffset, 0, yOffset3),
            onAbsoluteSizeChanged = var20,
            onAbsolutePositionChanged = var20
        }
        local tbl8 = {
            Controls = element2,
            AgeRating = if replacesAgeRating then React.createElement(ExperienceAgeRatingBadge, { universeId = tostring(game.GameId), layoutOrder = 1 }) else nil
        }
        element2 = createElement4(var26, tbl7, tbl8)
    end

    tbl6.TopLeftFrame = element2

    tbl6.TopRightFrame = React.createElement(View, {
        tag = "anchor-top-right auto-x",
        Size = UDim2.fromOffset(0, yOffset2),
        Position = UDim2.new(1, -xOffset, 0, yOffset3)
    }, {
        BuildPillMenu = if FFlagAppNavMyStatsTab and canShowAssistantBuild() then React.createElement(BuildPillMenuPortalHost) else nil,
        HealthBar = React.createElement(HealthBar)
    })
    tbl6.FreeTrialChipHost = if FFlagEnableFreeTrialTopBarChip then React.createElement(
        FreeTrialChipHost,
        {
            position = UDim2.new(1, -xOffset, 0, yOffset3),
            size = UDim2.new(0.5, -xOffset, 0, yOffset2),
            visible = var18
        }
    ) else nil
    tbl4.TopBarFrame = createElement3(var25, tbl5, tbl6)

    tbl4.VRBottomBar = if VRService.VREnabled then React.createElement(VoiceStateContext.Provider, {}, {
        VRBottomBar = VoiceStateContext.withVoiceState(function(arg1)
            return React.createElement(var4, {
                voiceChatServiceManager = default,
                voiceEnabled = arg1.voiceEnabled,
                voiceState = arg1.voiceState,
                showBadgeOver12 = if isInExperienceUIVREnabled then var6 else nil
            })
        end)
    }) else nil

    return createElement2(str1, tbl3, tbl4)
end

return TopBarApp
