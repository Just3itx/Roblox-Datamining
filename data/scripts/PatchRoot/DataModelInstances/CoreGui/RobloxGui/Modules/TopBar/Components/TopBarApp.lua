-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local _Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local Foundation = require(CorePackages.Packages.Foundation)
local Image = Foundation.Image
local View = Foundation.View

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Interactable = UIBlox.Core.Control.Interactable
local ControlState = UIBlox.Core.Control.Enum.ControlState
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)

local FFlagCoreUiMigrateUIBloxToFoundation = SharedFlags.FFlagCoreUiMigrateUIBloxToFoundation
local FFlagEnableTeamTestLua = SharedFlags.FFlagEnableTeamTestLua

local Images = UIBlox.App.ImageSet.Images
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/controls/close-ingame" else Images["icons/controls/close-ingame"]
local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider
local BuildExperience = require(CorePackages.Workspace.Packages.BuildExperience)
local BuildModeLaunch = require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.BuildModeLaunch)
local Songbird = require(CorePackages.Workspace.Packages.Songbird)

local Traversal = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).Traversal

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local Stores = CoreGuiCommon.Stores
local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization

local Constants = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))
local SettingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal

local Presentation = script.Parent.Presentation
local BuildPillMenuPortalHost = BuildExperience.BuildPillMenuPortalHost
local MenuIcon = require(Presentation.MenuIcon)
local ChatIcon = require(Presentation.ChatIcon)
local MoreMenu = require(Presentation.MoreMenu)
local HealthBar = require(Presentation.HealthBar)
local HurtOverlay = require(Presentation.HurtOverlay)
local GamepadNavigationDialog = require(Presentation.GamepadNavigationDialog)
local HeadsetMenu = require(Presentation.HeadsetMenu)
local HeadsetDisconnectDialog = CoreGuiCommon.Components.HeadsetDisconnectDialog
local PlaytestModeTooltip = require(Presentation.PlaytestModeTooltip)
local UnpublishedPlaytestModeTooltip = BuildExperience.UnpublishedPlaytestModeTooltip

local TraversalBackButton = require(script.Parent.TraversalBackButton)

local Chrome = script.Parent.Parent.Parent.Chrome

local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
local PlaytestModeThemeProvider = require(Chrome.ChromeShared.Unibar.PlaytestModeThemeProvider)
local FFlagEnablePlaytestModeUnibar = SharedFlags.FFlagEnablePlaytestModeUnibar
local FFlagUseUIOverlayForCloudPlay = SharedFlags.FFlagUseUIOverlayForCloudPlay

local FFlagEnableUISelector = CoreGuiCommon.Flags.FFlagEnableUISelector

local FFlagAppNavMyStatsTab = SharedFlags.FFlagAppNavMyStatsTab
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas

local FFlagAddUILessMode = SharedFlags.FFlagAddUILessMode
local FIntAddUILessModeVariant = SharedFlags.FIntAddUILessModeVariant
local num1 = game:DefineFastInt("UILessTooltipDuration", 10)

local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen
local FFlagTopBarSignalizeScreenSize = CoreGuiCommon.Flags.FFlagTopBarSignalizeScreenSize

local FFlagAddTraversalBackButton = Traversal.Flags.FFlagAddTraversalBackButton
local bool1 = game:DefineFastFlag("UseNewHeadsetDisconnectDialog", false)
local InExperienceShop = require(CorePackages.Workspace.Packages.InExperienceShop)
local FFlagEnableInExperienceShop = SharedFlags.FFlagEnableInExperienceShop
local var2 = InExperienceShop.FFlagEnableExperienceShopGlobalIcon and FFlagEnableInExperienceShop

local FFlagCenterInExperienceShopWindow = InExperienceShop.FFlagCenterInExperienceShopWindow
local FFlagExperienceShopNewIconography = InExperienceShop.FFlagExperienceShopNewIconography
local FFlagEnableFreeTrialTopBarChip = InExperienceShop.FFlagEnableFreeTrialTopBarChip
local ShopGlobalIcon = InExperienceShop.ShopGlobalIcon
local FreeTrialChipHost = require(Presentation.FreeTrialChipHost)
local FFlagTopBarShopIconV2 = require(script.Parent.Parent.Flags.FFlagTopBarShopIconV2)
local ShopIcon = if FFlagTopBarShopIconV2 then require(Presentation.ShopIcon) else nil

local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagShowGameAgeRating = SharedFlags.FFlagShowGameAgeRating

local FFlagExperienceAgeRatingBadge = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagExperienceAgeRatingBadge
local var3 = FFlagExperienceAgeRatingBadge and FFlagShowGameAgeRating
local ExperienceAgeRatingBadge = require(CorePackages.Workspace.Packages.InExperienceTopBar.ExperienceAgeRatingBadge)
local InExperienceCloudPlay = CorePackages.Workspace.Packages.InExperienceCloudPlay
local FFlagEnableRestyleTopBar = require(InExperienceCloudPlay.FFlagEnableRestyleTopBar)
local RestyleTimer = if FFlagEnableRestyleTopBar then require(Presentation.RestyleTimer) else nil
local ExperienceAgeRatingPolicy = require(script.Parent.Parent.ExperienceAgeRatingPolicy)

local isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial

local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch
local var4 = isSideSheetEnabled and (FFlagShowSwitchServerButton or isPioneerLaunch())
local SwitchServer = require(CorePackages.Workspace.Packages.SwitchServer)
local SwitchServerConfirmation = SwitchServer.SwitchServerConfirmation
local GetSwitchServerStore = SwitchServer.GetSwitchServerStore

local Unibar = nil
local KeepOutAreasHandler = nil
local Analytics = nil
if ChromeEnabled() then
    Unibar = require(Chrome.ChromeShared.Unibar)
end
if game:GetEngineFeature("InGameChromeSignalAPI") then
    KeepOutAreasHandler = require(Chrome.ChromeShared.Service.KeepOutAreasHandler)
    if ChromeEnabled() then
        Analytics = require(Chrome.ChromeShared.Analytics)
    end
end

local LocalStore = nil
local Constants2 = nil
local CommonIcon = nil
if ChromeEnabled() then
    LocalStore = require(Chrome.ChromeShared.Service.LocalStore)
    Constants2 = require(Chrome.ChromeShared.Unibar.Constants)
    if var2 then
        CommonIcon = require(Chrome.Integrations.CommonIcon)
    end
end

local var5 = FFlagTopBarShopIconV2 and FFlagAddTraversalBackButton and ChromeEnabled()

local Connection = require(script.Parent.Connection)

local PresentationParentParent = Presentation.Parent.Parent
local Constants3 = require(PresentationParentParent.Constants)
local SetScreenSize = require(PresentationParentParent.Actions.SetScreenSize)
local SetKeepOutArea = require(PresentationParentParent.Actions.SetKeepOutArea)
local RemoveKeepOutArea = require(PresentationParentParent.Actions.RemoveKeepOutArea)
local MenuIconContext = if ChromeEnabled() and (FFlagEnableConsoleExpControls or FFlagExperienceAgeRatingBadge) then require(script.Parent.MenuIconContext) else nil
local GamepadMenu = nil
local GamepadConnector = nil
local FFlagAddMenuNavigationToggleDialog = nil
local MenuNavigationToggleDialog = nil
if ChromeEnabled() and FFlagEnableConsoleExpControls then
    GamepadConnector = require(script.Parent.GamepadConnector)
    FFlagAddMenuNavigationToggleDialog = SharedFlags.FFlagAddMenuNavigationToggleDialog
    MenuNavigationToggleDialog = require(Presentation.GamepadMenu.MenuNavigationToggleDialog)
else
    GamepadMenu = require(Presentation.GamepadMenu)
end

local FFlagResponsiveUnitsDeprecateTenFoot = SharedFlags.FFlagResponsiveUnitsDeprecateTenFoot
local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)
local isNewInGameMenuEnabled = require(RobloxGui.Modules.isNewInGameMenuEnabled)
local isNewTiltIconEnabled = require(RobloxGui.Modules.isNewTiltIconEnabled)
local FFlagGamepadNavigationDialogABTest = require(PresentationParentParent.Flags.FFlagGamepadNavigationDialogABTest)
local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice

local PartyMicBinder = require(script.Parent.Parent.Parent.Chrome.Integrations.Party.PartyMicBinder)

local GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice = SharedFlags.GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice

local JoinVoiceBinder = if game:GetEngineFeature("VoiceChatSupported")
    and GetFFlagFixSeamlessVoiceIntegrationWithPrivateVoice()
    and ChromeEnabled() then require(script.Parent.Parent.Parent.Chrome.Integrations.JoinVoiceBinder) else nil

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local VoiceStateContext = require(RobloxGui.Modules.VoiceChat.VoiceStateContext)
local TopBarAppPolicy = require(script.Parent.Parent.TopBarAppPolicy)

local var6 = ChromeEnabled()
local var7 = if isInExperienceUIVREnabled and ChromeEnabled() then require(script.Parent.VRBottomUnibar) else require(RobloxGui.Modules.VR.VRBottomBar.VRBottomBar)

local function selectMenuOpen(arg1) -- Luacid: unused: defined but never referenced
    return arg1.displayOptions.menuOpen or arg1.displayOptions.inspectMenuOpen
end

local function canShowAssistantBuild() -- Luacid: Inlined by compiler; 2 call sites recovered
    return BuildModeLaunch:hasBuildMode() and not VRService.VREnabled
end

local var8 = Roact.PureComponent:extend("TopBarApp")

var8.validateProps = t.strictInterface({
    menuOpen = if FFlagTopBarSignalizeMenuOpen then nil else t.optional(t.boolean),
    inspectMenuOpen = if FFlagTopBarSignalizeMenuOpen then nil else t.optional(t.boolean),
    setScreenSize = if FFlagTopBarSignalizeScreenSize then nil else t.callback,
    setKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback,
    removeKeepOutArea = if FFlagTopBarSignalizeKeepOutAreas then nil else t.callback,
    showGameAgeRating = t.optional(t.boolean)
})

function var8.init(arg1)
    local unibarRightSidePosition, setUnibarRightSidePosition = Roact.createBinding(UDim2.new())
    arg1.unibarRightSidePosition = unibarRightSidePosition
    arg1.setUnibarRightSidePosition = setUnibarRightSidePosition
    local closeButtonState, setCloseButtonState = Roact.createBinding(false)
    arg1.closeButtonState = closeButtonState
    arg1.setCloseButtonState = setCloseButtonState
    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)

    if FFlagAddUILessMode then
        arg1.uiLessStore = Stores.GetUILessStore(false)

        if FIntAddUILessModeVariant ~= 0 then
            local uiLessTooltipVisible, setUiLessTooltipVisible = Roact.createBinding(false)
            arg1.uiLessTooltipVisible = uiLessTooltipVisible
            arg1.setUILessTooltipVisible = setUiLessTooltipVisible
            local uiLessTooltipTransparency, setUiLessTooltipTransparency = Roact.createBinding(0)
            arg1.uiLessTooltipTransparency = uiLessTooltipTransparency
            arg1.setUILessTooltipTransparency = setUiLessTooltipTransparency

            function arg1.fadeOutUILessTooltip()
                local numberValue = Instance.new("NumberValue")
                numberValue.Value = 0
                numberValue:GetPropertyChangedSignal("Value"):Connect(function()
                    arg1.setUILessTooltipTransparency(numberValue.Value)
                end)

                local tweenInfo = TweenInfo.new(0.5)
                arg1.uiLessTooltipTween = TweenService:Create(numberValue, tweenInfo, { Value = 1 })

                arg1.uiLessTooltipTween.Completed:Connect(function()
                    arg1.setUILessTooltipVisible(false)
                    arg1.uiLessTooltipTween = nil
                end)

                arg1.uiLessTooltipTween:Play()
            end

            function arg1.cleanupUILessTooltip()
                if arg1.uiLessTooltipTween then
                    arg1.uiLessTooltipTween:Cancel()
                    arg1.uiLessTooltipTween = nil
                end
                if arg1.uiLessTooltipTimer then
                    task.cancel(arg1.uiLessTooltipTimer)
                    arg1.uiLessTooltipTimer = nil
                end
            end

            if arg1.uiLessStore.getUILessModeEnabled(false) then
                local bool2

                if LocalStore then
                    local var17 = LocalStore.loadForLocalPlayer("NumExperiencesUserSeenUILessTooltipKey2") or 0

                    bool2 = var17 < Constants2.MAX_NUM_UNIVERSES_SHOWN
                    if bool2 then
                        LocalStore.storeForLocalPlayer("NumExperiencesUserSeenUILessTooltipKey2", var17 + 1)
                    end
                else
                    bool2 = true
                end

                if bool2 then
                    arg1.setUILessTooltipVisible(true)
                    arg1.uiLessTooltipTimer = task.delay(num1, function()
                        arg1.fadeOutUILessTooltip()
                        arg1.uiLessTooltipTimer = nil
                    end)
                end
            end

            ContextActionService:BindCoreAction("ToggleUILess", function(_, userInputState)
                if userInputState ~= Enum.UserInputState.Begin then
                    return
                end

                if not arg1.uiLessStore.getUILessModeEnabled(false) then
                    SettingsHub:PopMenu(false, true, Constants.AnalyticsMenuOpenTypes.Keyboard)
                    return
                end

                if FIntAddUILessModeVariant == 1 then
                    arg1.uiLessStore.setUIVisible(function(arg2): boolean
                        if arg2 == SettingsHub:GetVisibility() then
                            SettingsHub:PopMenu(false, true, Constants.AnalyticsMenuOpenTypes.Keyboard)
                        end
                        return not arg2
                    end)
                    arg1.cleanupUILessTooltip()
                    arg1.setUILessTooltipVisible(false)
                    return
                end

                if FIntAddUILessModeVariant ~= 2 then
                    return
                end

                arg1.uiLessStore.setUIVisible(function(arg2): boolean
                    return not arg2
                end)
                if SettingsHub:GetVisibility() then
                    SettingsHub:PopMenu(false, true, Constants.AnalyticsMenuOpenTypes.Keyboard)
                end
                arg1.cleanupUILessTooltip()
                arg1.setUILessTooltipVisible(false)
            end, false, Enum.KeyCode.Escape)
        end
    end

    if FFlagTopBarSignalizeMenuOpen then
        local tiltMenuOpen, setTiltMenuOpen = Roact.createBinding(false)
        arg1.tiltMenuOpen = tiltMenuOpen
        arg1.setTiltMenuOpen = setTiltMenuOpen
        local inspectMenuOpen, setInspectMenuOpen = Roact.createBinding(false)
        arg1.inspectMenuOpen = inspectMenuOpen
        arg1.setInspectMenuOpen = setInspectMenuOpen

        arg1.inspectMenuDisposeEffect = Signals.createEffect(function(arg2)
            local var17 = Stores.GetInspectAndBuyStore(arg2).getInspectAndBuyOpen(arg2)
            arg1.setInspectMenuOpen(var17)
        end)

        SettingsShowSignal:connect(function(arg2)
            arg1.setTiltMenuOpen(arg2)
        end)
    end

    if FFlagTopBarSignalizeKeepOutAreas then
        arg1.keepOutAreasStore = CoreGuiCommon.Stores.GetKeepOutAreasStore(false)
    end
    if FFlagExperienceAgeRatingBadge then
        arg1:setState({ ageRatingSpatial = isSpatial() })
        local ageRatingControlsVisible, setAgeRatingControlsVisible = React.createBinding(true)
        arg1.ageRatingControlsVisible = ageRatingControlsVisible
        arg1.setAgeRatingControlsVisible = setAgeRatingControlsVisible
        local ageRatingControlsWidth, setAgeRatingControlsWidth = React.createBinding(0)
        arg1.ageRatingControlsWidth = ageRatingControlsWidth
        arg1.setAgeRatingControlsWidth = setAgeRatingControlsWidth
        function arg1.onAgeRatingControlsSizeChanged(arg2)
            arg1.setAgeRatingControlsWidth(arg2.AbsoluteSize.X)
        end
        function arg1.onAgeRatingUnibarAreaChanged(str1: string, vector2: Vector2, vector2_2: Vector2)
            arg1.setAgeRatingControlsWidth(vector2_2.X);

            (if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else arg1.props.setKeepOutArea)(
                str1,
                vector2,
                vector2_2
            )
        end

        function arg1.onAgeRatingAreaChanged(arg2)
            (if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else arg1.props.setKeepOutArea)(
                ExperienceAgeRatingPolicy.keepOutAreaId,
                if arg2 then arg2.AbsolutePosition else Vector2.zero,
                if arg2 then arg2.AbsoluteSize else Vector2.zero
            )
        end
    end

    if FFlagEnableFreeTrialTopBarChip then
        local var13 = not GamepadConnector or GamepadConnector:getShowTopBar():get()
        local freeTrialShowTopBar, setFreeTrialShowTopBar = React.createBinding(var13)
        arg1.freeTrialShowTopBar = freeTrialShowTopBar
        arg1.setFreeTrialShowTopBar = setFreeTrialShowTopBar

        local var16 = not FFlagAddUILessMode
            or FIntAddUILessModeVariant == 0
            or not (arg1.uiLessStore and arg1.uiLessStore.getUILessModeEnabled(false))
            or arg1.uiLessStore.getUIVisible(false)

        local freeTrialUiVisible, setFreeTrialUiVisible = React.createBinding(var16)
        arg1.freeTrialUiVisible = freeTrialUiVisible
        arg1.setFreeTrialUiVisible = setFreeTrialUiVisible
    end

    function arg1.onCloseBtnStateChange(_, arg2)
        arg1.setCloseButtonState(arg2)
    end
    if ChromeEnabled() then
        local service = require(Chrome.Service)
        arg1:setState({ unibarAlignment = service:orderAlignment():get() })

        if FFlagEnableConsoleExpControls then
            arg1.GamepadConnector = GamepadConnector
        end

        if FFlagEnableConsoleExpControls then
            arg1.unibarMenuRef = React.createRef()
            arg1.menuIconRef = Roact.createRef()
        end

        if var2 and not var5 then
            arg1.shopGlobalIconDisposeEffect = Signals.createEffect(function(arg2)
                local getShopGlobalIconStore = InExperienceShop.GetShopGlobalIconStore
                if not getShopGlobalIconStore then
                    return
                end
                local shopGlobalIconStore = getShopGlobalIconStore(arg2)
                arg1:setState({
                    shopGlobalIconEnabled = shopGlobalIconStore.getEnabled(arg2),
                    shopGlobalStatusIndicatorEnabled = shopGlobalIconStore.getStatusIndicatorEnabled(arg2)
                })
            end)
            function arg1.onShopGlobalIconActivated()
                if FFlagCenterInExperienceShopWindow then
                    require(Chrome.Integrations.InExperienceShop.ShopWindowLayout).toggleInExperienceShopWindow()
                    return
                end
                service:toggleWindow(Constants2.IN_EXPERIENCE_SHOP_ID)
            end

            arg1.shopGlobalIconCleanup = InExperienceShop.initShopGlobalIcon and InExperienceShop.initShopGlobalIcon()
            arg1.shopIsActiveMappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal.new(service:onIntegrationStatusChanged(), function()
                return service:isWindowOpen(Constants2.IN_EXPERIENCE_SHOP_ID)
            end)
        end
    end

    arg1:setState({ chatVersion = TextChatService.ChatVersion })

    if not game:IsLoaded() then
        game.Loaded:Connect(function()
            arg1:setState({ chatVersion = TextChatService.ChatVersion })
        end)
    end

    if not var4 then
        return
    end

    arg1.disposeSwitchServerEffect = Signals.createEffect(function(arg2)
        local switchServerStore = GetSwitchServerStore(false)
        arg1:setState({
            shouldEnableSwitchServer = switchServerStore.shouldEnableSwitchServer(arg2),
            isConfirmationOpen = switchServerStore.isConfirmationOpen(arg2)
        })
    end)
    arg1.setConfirmationOpen = GetSwitchServerStore(false).setConfirmationOpen
end

function var8.didMount(arg1)
    if FFlagExperienceAgeRatingBadge then
        if GamepadConnector then
            local showTopBar = GamepadConnector:getShowTopBar()
            arg1.ageRatingVisibilityConnection = showTopBar:connect(function()
                arg1.setAgeRatingControlsVisible(showTopBar:get())
            end, true)
        end
        if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and arg1.uiLessStore then
            arg1.ageRatingVisibilityEffect = Signals.createEffect(function(arg2)
                if arg1.uiLessStore.getUILessModeEnabled(arg2) then
                    arg1.setAgeRatingControlsVisible(arg1.uiLessStore.getUIVisible(arg2))
                end
            end)
        end
        arg1.ageRatingSpatialConnection = VRService:GetPropertyChangedSignal("VREnabled"):Connect(function()
            arg1:setState({ ageRatingSpatial = isSpatial() })
        end)
    end
    if FFlagEnableFreeTrialTopBarChip then
        if GamepadConnector then
            local showTopBar = GamepadConnector:getShowTopBar()
            arg1.freeTrialShowTopBarConnection = showTopBar:connect(function()
                arg1.setFreeTrialShowTopBar(showTopBar:get())
            end, true)
        end
        if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 and arg1.uiLessStore then
            arg1.freeTrialUiVisibleEffect = Signals.createEffect(function(arg2)
                if arg1.uiLessStore.getUILessModeEnabled(arg2) then
                    arg1.setFreeTrialUiVisible(arg1.uiLessStore.getUIVisible(arg2))
                    return
                end
                arg1.setFreeTrialUiVisible(true)
            end)
        end
    end

    if not ChromeEnabled() then
        return
    end

    local service = require(Chrome.Service)
    arg1.orderAlignmentConnection = service:orderAlignment():connect(function()
        arg1:setState({ unibarAlignment = service:orderAlignment():get() })
    end)

    if var2 and not var5 then
        arg1.shopIsActiveConnection = service:onIntegrationStatusChanged():connect(function()
            arg1:setState({ shopGlobalIconIsActive = service:isWindowOpen(Constants2.IN_EXPERIENCE_SHOP_ID) })
        end)
    end

    if not FFlagEnableConsoleExpControls then
        return
    end

    if not isSpatial() then
        arg1.GamepadConnector:connectToTopbar()
    end
    arg1.vrEnabledConnection = VRService:GetPropertyChangedSignal("VREnabled"):Connect(function()
        if isSpatial() then
            arg1.GamepadConnector:disconnectFromTopbar()
            return
        end
        arg1.GamepadConnector:connectToTopbar()
    end)
end

function var8.willUnmount(arg1)
    if arg1.ageRatingVisibilityConnection then
        arg1.ageRatingVisibilityConnection:disconnect()
    end
    if arg1.ageRatingVisibilityEffect then
        arg1.ageRatingVisibilityEffect()
    end
    if arg1.ageRatingSpatialConnection then
        arg1.ageRatingSpatialConnection:Disconnect()
    end
    if FFlagEnableFreeTrialTopBarChip then
        if arg1.freeTrialShowTopBarConnection then
            arg1.freeTrialShowTopBarConnection:disconnect()
        end
        if arg1.freeTrialUiVisibleEffect then
            arg1.freeTrialUiVisibleEffect()
        end
    end
    if ChromeEnabled() then
        if arg1.orderAlignmentConnection then
            arg1.orderAlignmentConnection:disconnect()
            arg1.orderAlignmentConnection = nil
        end

        if FFlagEnableConsoleExpControls then
            if arg1.vrEnabledConnection then
                arg1.vrEnabledConnection:Disconnect()
                arg1.vrEnabledConnection = nil
            end
            arg1.GamepadConnector:disconnectFromTopbar()
        end
    end

    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end

    if var2 and not var5 then
        if ChromeEnabled() and arg1.shopGlobalIconDisposeEffect then
            arg1.shopGlobalIconDisposeEffect()
        end

        if arg1.shopIsActiveConnection then
            arg1.shopIsActiveConnection:disconnect()
            arg1.shopIsActiveConnection = nil
        end

        if arg1.shopGlobalIconCleanup then
            arg1.shopGlobalIconCleanup()
            arg1.shopGlobalIconCleanup = nil
        end
    end

    if FFlagAddUILessMode then
        if arg1.uiLessStore then
            arg1.uiLessStore.cleanup()
        end
        if FIntAddUILessModeVariant ~= 0 then
            arg1.cleanupUILessTooltip()
            ContextActionService:UnbindCoreAction("ToggleUILess")
        end
    end

    if FFlagTopBarSignalizeMenuOpen then
        if arg1.tiltMenuDisposeEffect then
            arg1.tiltMenuDisposeEffect()
        end
        if arg1.inspectMenuDisposeEffect then
            arg1.inspectMenuDisposeEffect()
        end
    end

    if FFlagTopBarSignalizeKeepOutAreas and arg1.keepOutAreasStore then
        arg1.keepOutAreasStore.cleanup()
    end

    if var4 and arg1.disposeSwitchServerEffect then
        arg1.disposeSwitchServerEffect()
    end
end

function var8.render(arg1)
    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                Overlay = {
                    Color = arg2.Color.Common.Scrim.Color3,
                    Transparency = arg2.Color.Common.Scrim.Transparency
                },
                BackgroundOnHover = {
                    Color = arg2.Color.State.Hover.Color3,
                    Transparency = arg2.Color.State.Hover.Transparency
                },
                BackgroundOnPress = {
                    Color = arg2.Color.State.Press.Color3,
                    Transparency = arg2.Color.State.Press.Transparency
                }
            },
            Tokens = {
                Color = {
                    Extended = {
                        White = {
                            White_100 = arg2.Color.Extended.White.White_100
                        }
                    }
                },
                Size = {
                    Size_100 = arg2.Size.Size_100,
                    Size_200 = arg2.Size.Size_200,
                    Size_300 = arg2.Size.Size_300
                },
                Radius = {
                    Small = arg2.Radius.Small
                },
                FontSize = {
                    FontSize_300 = arg2.FontSize.FontSize_300
                },
                Global = {
                    Color = {
                        White = arg2.Color.Extended.White.White_100
                    },
                    Space_50 = arg2.Size.Size_100,
                    Space_100 = arg2.Size.Size_200,
                    Space_150 = arg2.Size.Size_300,
                    FontSize_50 = arg2.FontSize.FontSize_300
                },
                Semantic = {
                    Radius = {
                        Small = arg2.Radius.Small
                    }
                }
            }
        }
    end, function(arg2)
        return arg1:renderWithStyle(arg2)
    end)
end

function var8.renderUnibarFrame(tbl1, bool2: boolean, replacesAgeRating: boolean)
    if isInExperienceUIVREnabled and isSpatial() then
        return nil
    end

    if not (FFlagEnableConsoleExpControls or var3) then
        return Roact.createElement(Unibar, {
            layoutOrder = 1,
            onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then tbl1.keepOutAreasStore.setKeepOutArea else tbl1.props.setKeepOutArea,
            onMinWidthChanged = not var5 and function(xOffset: number)
                tbl1.setUnibarRightSidePosition(UDim2.new(0, xOffset, 0, 0))
            end or nil
        })
    end

    local createElement = React.createElement
    local provider = MenuIconContext.Provider
    local tbl2 = {
        value = {
            menuIconRef = tbl1.menuIconRef,
            replacesAgeRating = replacesAgeRating
        }
    }
    local createElement2 = React.createElement
    local var9 = Unibar

    local tbl3 = {
        layoutOrder = 1,
        onAreaChanged = if var3 and not FFlagAddTraversalBackButton then tbl1.onAgeRatingUnibarAreaChanged elseif FFlagTopBarSignalizeKeepOutAreas then tbl1.keepOutAreasStore.setKeepOutArea else tbl1.props.setKeepOutArea,
        onMinWidthChanged = not var5 and function(xOffset: number)
            tbl1.setUnibarRightSidePosition(UDim2.new(0, xOffset, 0, 0))
        end or nil,
        menuRef = if bool2 then tbl1.unibarMenuRef else nil
    }

    return createElement(provider, tbl2, { createElement2(var9, tbl3) })
end

function var8.renderWithStyle(arg1, arg2)
    local var9 = ChromeEnabled()

    local right = Enum.HorizontalAlignment.Right
    if arg1.state.unibarAlignment ~= nil then
        right = arg1.state.unibarAlignment
    end
    local var10 = ExperienceAgeRatingPolicy.isEligible(
        arg1.props.showGameAgeRating,
        var9,
        right == Enum.HorizontalAlignment.Left,
        if FFlagExperienceAgeRatingBadge then arg1.state.ageRatingSpatial else isSpatial()
    )

    local xOffset = Constants3.ScreenSideOffset * arg1.state.UiScale
    local yOffset = Constants3.TopBarHeight * arg1.state.UiScale
    local yOffset2 = Constants3.TopBarTopMargin * arg1.state.UiScale
    local leftGap = Constants3.TopBarPadding * arg1.state.UiScale
    local offset2 = if var10 and not var5 then if var2 and arg1.state.shopGlobalIconEnabled then 0 else leftGap elseif FFlagAppNavMyStatsTab and canShowAssistantBuild() then xOffset elseif var5 or not (var2 and arg1.state.shopGlobalIconEnabled) then leftGap else 2 * Constants2.UNIBAR_END_PADDING * arg1.state.UiScale
    local var11 = Constants3.LegacyCloseMenuIconSize * arg1.state.UiScale
    local offset3 = Constants3.UnibarFrame.PaddingTop * arg1.state.UiScale
    local offset4 = Constants3.UnibarFrame.PaddingBottom * arg1.state.UiScale
    local offset5 = Constants3.UnibarFrame.PaddingLeft * arg1.state.UiScale
    local xOffset2 = Constants3.UnibarFrame.ExtendedSize * arg1.state.UiScale
    local var12 = if FFlagTopBarSignalizeMenuOpen then arg1.tiltMenuOpen else arg1.props.menuOpen

    if TenFootInterface:IsEnabled() and not ChromeEnabled() then
        xOffset = Constants3.ScreenSideOffsetTenFoot
        yOffset = Constants3.TopBarHeightTenFoot
    end

    local var13 = if FFlagTopBarSignalizeMenuOpen then Roact.joinBindings({ arg1.tiltMenuOpen, arg1.inspectMenuOpen }):map(function(arg3): boolean
        return not (arg3[0] or arg3[1])
    end) else not (arg1.props.menuOpen or arg1.props.inspectMenuOpen)

    local var14

    if FFlagEnableFreeTrialTopBarChip then
        local controls = Roact.joinBindings({ showTopBar = arg1.freeTrialShowTopBar, uiVisible = arg1.freeTrialUiVisible }):map(function(arg3)
            return arg3.showTopBar and arg3.uiVisible
        end)
        if FFlagTopBarSignalizeMenuOpen then
            var14 = Roact.joinBindings({ menu = var13, controls = controls }):map(function(arg3)
                return arg3.menu and arg3.controls
            end)
        else
            var14 = controls:map(function(arg3)
                return var13 and arg3
            end)
        end
    else
        var14 = var13
    end

    local uDim2 = UDim2.new(0, 0, 0, yOffset2)
    local yOffset3 = yOffset - yOffset2
    local uDim2_2 = UDim2.new(0, xOffset, 0, 0)
    local uDim2_3 = UDim2.new(1, -xOffset, 0, 0)
    local uDim2_4 = UDim2.new(1, -xOffset, 0, yOffset2)
    local uDim2_5 = UDim2.new(0, 0, 0.5, 0)

    local element = Roact.createElement(VoiceStateContext.Provider, {}, {
        VRBottomBar = VoiceStateContext.withVoiceState(function(arg3)
            return Roact.createElement(var7, {
                voiceChatServiceManager = default,
                voiceEnabled = arg3.voiceEnabled,
                voiceState = arg3.voiceState,
                showBadgeOver12 = if isInExperienceUIVREnabled then arg1.props.showGameAgeRating else nil
            })
        end)
    })

    local icon = Roact.createElement(MenuIcon, {
        iconScale = if FFlagTopBarSignalizeMenuOpen then nil elseif arg1.props.menuOpen then Constants3.MenuIconOpenScale else 1,
        layoutOrder = 1,
        showBadgeOver12 = arg1.props.showGameAgeRating and not var10,
        menuIconRef = if var9 and FFlagEnableConsoleExpControls then arg1.menuIconRef else nil,
        unibarMenuRef = if var9 and FFlagEnableConsoleExpControls then arg1.unibarMenuRef else nil,
        onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else nil
    })
    local element3 = Roact.createElement(SelectionCursorProvider, {}, { Icon = icon })

    if FFlagEnablePlaytestModeUnibar then
        element3 = Roact.createElement(PlaytestModeThemeProvider, nil, { MenuIcon = element3 })
    end

    local bool2 = not (isInExperienceUIVREnabled and isSpatial())
    local var15

    if var10 then
        local createElement = React.createElement
        local var16 = View

        local tbl1 = {
            tag = "row align-y-center auto-x",
            Size = UDim2.fromOffset(0, Constants3.TopBarButtonHeight * arg1.state.UiScale),
            LayoutOrder = 3,
            padding = var5 and {
                left = arg1.ageRatingControlsVisible:map(function(arg3): UDim
                    return UDim.new(0, if arg3 then leftGap else 0)
                end)
            } or nil,
            ref = arg1.onAgeRatingAreaChanged,
            onAbsoluteSizeChanged = arg1.onAgeRatingAreaChanged,
            onAbsolutePositionChanged = arg1.onAgeRatingAreaChanged
        }

        local tbl2 = {
            Badge = React.createElement(ExperienceAgeRatingBadge, { universeId = tostring(game.GameId) })
        }
        var15 = createElement(var16, tbl1, tbl2)
    else
        var15 = nil
    end

    local createElement = Roact.createElement
    local str1 = "ScreenGui"

    local tbl1 = {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        AutoLocalize = false,
        DisplayOrder = 6,
        [Roact.Change.AbsoluteSize] = not FFlagTopBarSignalizeScreenSize and function(arg3)
            arg1.props.setScreenSize(arg3.AbsoluteSize)
        end or nil
    }
    local tbl2 = {
        Connection = Roact.createElement(Connection),
        PlaytestTooltip = if FFlagEnablePlaytestModeUnibar then Roact.createElement(PlaytestModeTooltip, { anchorRef = arg1.unibarMenuRef }) else nil,
        UnpublishedPlaytestTooltip = if FFlagEnableTeamTestLua then Roact.createElement(UnpublishedPlaytestModeTooltip, { anchorRef = arg1.unibarMenuRef, isVisible = var13 }) else nil,
        InExperienceUiSelector = if FFlagEnableUISelector then React.createElement(CoreGuiCommon.Components.InExperienceUiSelector) else nil,
        GamepadMenu = if FFlagEnableConsoleExpControls then nil else Roact.createElement(GamepadMenu, { chatVersion = arg1.state.chatVersion }),
        MenuNavigationToggleDialog = if var9 and FFlagAddMenuNavigationToggleDialog and FFlagEnableConsoleExpControls then Roact.createElement(
            MenuNavigationToggleDialog,
            {
                Position = UDim2.fromScale(0.5, 0.1),
                GamepadConnector = if FFlagEnableConsoleExpControls then arg1.GamepadConnector else nil
            }
        ) else nil,
        GamepadNavigationDialog = if FFlagGamepadNavigationDialogABTest then Roact.createElement(GamepadNavigationDialog) else nil,
        SwitchServerConfirmation = if var4 and arg1.state.shouldEnableSwitchServer and arg1.state.isConfirmationOpen then React.createElement(SwitchServerConfirmation, { setSwitchServerConfirmationOpen = arg1.setConfirmationOpen }) else nil,
        HeadsetMenu = if bool1 then Roact.createElement(HeadsetDisconnectDialog) else Roact.createElement(HeadsetMenu),
        VRBottomBar = if VRService.VREnabled then element or nil else nil,
        KeepOutAreasHandler = if FFlagTopBarSignalizeKeepOutAreas or not KeepOutAreasHandler then nil else Roact.createElement(KeepOutAreasHandler),
        FullScreenFrame = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = var13
            },
            {
                HurtOverlay = Roact.createElement(HurtOverlay)
            }
        ),
        MenuIconHolder = if isSideSheetEnabled or not (bool2 and isNewTiltIconEnabled()) then nil else Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, xOffset, 0, yOffset2),
                Size = UDim2.new(1, 0, 0, yOffset3)
            },
            { MenuIcon = element3 }
        ),
        UILessTooltip = if FFlagAddUILessMode and FIntAddUILessModeVariant ~= 0 then withLocalization({
            uiLessTooltipTitle = Constants3.LocalizedKeys.UILessTooltipTitle,
            uiLessTooltipDescription = Constants3.LocalizedKeys.UILessTooltipDescription
        })(
            function(arg3)
                return Roact.createElement("Frame", {
                    BackgroundColor3 = arg2.Tokens.Color.Extended.White.White_100.Color3,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, xOffset, 0, yOffset2),
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = arg1.uiLessTooltipTransparency,
                    Visible = arg1.uiLessTooltipVisible,
                    ZIndex = 10000,
                    [Roact.Ref] = arg1.uiLessTooltip
                }, {
                    Padding = Roact.createElement("UIPadding", {
                        PaddingTop = UDim.new(0, arg2.Tokens.Size.Size_200),
                        PaddingBottom = UDim.new(0, arg2.Tokens.Size.Size_200),
                        PaddingLeft = UDim.new(0, arg2.Tokens.Size.Size_300),
                        PaddingRight = UDim.new(0, arg2.Tokens.Size.Size_300)
                    }),
                    Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, arg2.Tokens.Radius.Small) }),
                    VerticalLayout = Roact.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical,
                        Padding = UDim.new(0, arg2.Tokens.Size.Size_100)
                    }),
                    Title = Roact.createElement("TextLabel", {
                        Text = arg3.uiLessTooltipTitle,
                        TextSize = arg2.Tokens.FontSize.FontSize_300,
                        TextTransparency = arg1.uiLessTooltipTransparency,
                        Font = Enum.Font.BuilderSansBold,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        LayoutOrder = 1
                    }),
                    Description = Roact.createElement("TextLabel", {
                        Text = arg3.uiLessTooltipDescription,
                        TextSize = arg2.Tokens.FontSize.FontSize_300,
                        TextTransparency = arg1.uiLessTooltipTransparency,
                        Font = Enum.Font.BuilderSans,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        LayoutOrder = 2
                    })
                })
            end
        ) else nil,
        LegacyCloseMenu = 0,
        SongbirdDebugAudio = 0,
        UnibarLeftFrame = 0,
        FreeTrialChipHost = 0,
        UnibarRightFrame = 0,
        TopBarFrame = 0
    }

    local bool3 = not (Unibar or isNewInGameMenuEnabled())

    if bool3 then
        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, xOffset, 0, 0),
            Size = UDim2.new(1, 0, 0, yOffset),
            Visible = var12
        }
        local tbl4 = { CloseMenuButtonRound = 0, CloseMenuButton = 0 }
        local var16

        if Unibar then
            local createElement3 = Roact.createElement
            local var17 = Interactable
            local tbl5 = {
                onStateChanged = arg1.onCloseBtnStateChange,
                Visible = not TenFootInterface:IsEnabled(),
                BackgroundTransparency = arg2.Theme.Overlay.Transparency,
                Position = uDim2_5,
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, var11, 0, var11),
                BackgroundColor3 = arg2.Theme.Overlay.Color
            }

            tbl5[Roact.Event.Activated] = function()
                require(RobloxGui.Modules.Settings.SettingsHub):ToggleVisibility()
            end
            local tbl6 = {
                UICorner = if var9 then Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }) or nil else nil,
                Line1 = Roact.createElement("Frame", {
                    Name = "TopLine",
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0),
                    Size = UDim2.new(0, 16, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    Rotation = 45
                }),
                Line2 = Roact.createElement("Frame", {
                    Name = "BottomLine",
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0),
                    Size = UDim2.new(0, 16, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    Rotation = -45
                }),
                StateOverlayRound = 0
            }
            local var18

            if var9 then
                var18 = nil
            else
                local createElement4 = Roact.createElement
                local str3 = "Frame"

                local tbl7 = {
                    BackgroundTransparency = arg1.closeButtonState:map(function(arg3)
                        if arg3 == ControlState.Pressed then
                            return arg2.Theme.BackgroundOnPress.Transparency
                        end

                        if arg3 == ControlState.Hover then
                            return arg2.Theme.BackgroundOnHover.Transparency
                        end

                        return 1
                    end),
                    BackgroundColor3 = arg1.closeButtonState:map(function(arg3)
                        if arg3 == ControlState.Pressed then
                            return arg2.Theme.BackgroundOnPress.Color
                        elseif arg3 == ControlState.Hover then
                            return arg2.Theme.BackgroundOnHover.Color
                        end

                        return Color3.new(1, 1, 1)
                    end),
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 2
                }

                var18 = createElement4(
                    str3,
                    tbl7,
                    {
                        UICorner = if var9 then Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }) or nil else nil
                    }
                )
                    or nil
            end

            tbl6.StateOverlayRound = var18
            var16 = createElement3(var17, tbl5, tbl6) or nil
        else
            var16 = nil
        end

        tbl4.CloseMenuButtonRound = var16
        local var17

        if Unibar then
            var17 = nil
        else
            local element5

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element5 = Roact.createElement(Image, {
                    Visible = not TenFootInterface:IsEnabled(),
                    Position = uDim2_5,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, var11, 0, var11),
                    Image = var1,
                    onActivated = function()
                        require(RobloxGui.Modules.Settings.SettingsHub):ToggleVisibility()
                    end
                })
            else
                local createElement3 = Roact.createElement
                local var18 = ImageSetButton
                local tbl5 = {
                    Visible = not TenFootInterface:IsEnabled(),
                    BackgroundTransparency = 1,
                    Position = uDim2_5,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, var11, 0, var11),
                    Image = var1
                }

                tbl5[Roact.Event.Activated] = function()
                    require(RobloxGui.Modules.Settings.SettingsHub):ToggleVisibility()
                end

                element5 = createElement3(var18, tbl5)
            end

            var17 = element5 or nil
        end

        tbl4.CloseMenuButton = var17
        bool3 = createElement2(str2, tbl3, tbl4)
    end

    tbl2.LegacyCloseMenu = bool3

    tbl2.SongbirdDebugAudio = Roact.createElement(Songbird.DebugAudioEmitters)
    local var16

    if Unibar and right == Enum.HorizontalAlignment.Left then
        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, yOffset3),
            Position = uDim2_4,
            AnchorPoint = Vector2.new(1, 0)
        }
        local tbl4 = {
            JoinVoiceBinder = if var9 and JoinVoiceBinder then Roact.createElement(JoinVoiceBinder) else nil,
            PartyMicBinder = if var9 and GetFFlagEnableCrossExpVoice() then Roact.createElement(PartyMicBinder) else nil,
            ChromeAnalytics = if Analytics then Roact.createElement(Analytics) else nil,
            Padding = Roact.createElement("UIPadding", {
                PaddingTop = UDim.new(0, offset3),
                PaddingBottom = UDim.new(0, offset4),
                PaddingLeft = if var10 then arg1.ageRatingControlsVisible:map(function(arg3)
                    return UDim.new(0, if arg3 then offset5 else 2 * xOffset)
                end) else UDim.new(0, offset5)
            }),
            TopBarLeftContainer = 0,
            Unibar = 0,
            HealthBar = 0,
            AssistantBuildPillMenu = 0,
            StackedElements = 0
        }

        local var17 = FFlagAddTraversalBackButton

        if var17 then
            if var5 then
                local createElement3 = React.createElement
                local var18 = View
                local tbl5 = { tag = "row auto-xy" }

                local tbl6 = {
                    PaddedControlRow = React.createElement(View, {
                        tag = "row gap-xsmall auto-xy",
                        LayoutOrder = 1
                    }, {
                        TraversalBackButton = if FFlagAddTraversalBackButton and not (isInExperienceUIVREnabled and isSpatial()) then React.createElement(TraversalBackButton) else nil,
                        UnibarFrame = arg1:renderUnibarFrame(var9, var10)
                    }),
                    ShopIcon = React.createElement(ShopIcon, {
                        layoutOrder = 2,
                        buttonSize = Constants3.TopBarButtonHeight * arg1.state.UiScale,
                        leftGap = leftGap,
                        onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else arg1.props.setKeepOutArea
                    }),
                    AgeRating = var15,
                    RestyleTimer = 0
                }
                local var19

                if FFlagEnableRestyleTopBar and FFlagUseUIOverlayForCloudPlay then
                    local createElement4 = React.createElement
                    local var20 = View
                    local tbl7 = {
                        tag = "auto-xy",
                        LayoutOrder = 4,
                        padding = {
                            left = UDim.new(0, leftGap)
                        }
                    }
                    local tbl8 = {
                        Timer = React.createElement(RestyleTimer, {
                            buttonSize = Constants3.TopBarButtonHeight * arg1.state.UiScale,
                            followsUILessMode = true,
                            onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else arg1.props.setKeepOutArea,
                            onAreaRemoved = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.removeKeepOutArea else arg1.props.removeKeepOutArea
                        })
                    }
                    var19 = createElement4(var20, tbl7, tbl8)
                else
                    var19 = nil
                end

                tbl6.RestyleTimer = var19
                var17 = createElement3(var18, tbl5, tbl6)
            else
                var17 = React.createElement(
                    View,
                    {
                        tag = "row gap-xsmall auto-xy",
                        onAbsoluteSizeChanged = if var3 then arg1.onAgeRatingControlsSizeChanged else nil
                    },
                    {
                        TraversalBackButton = if FFlagAddTraversalBackButton and not (isInExperienceUIVREnabled and isSpatial()) then React.createElement(TraversalBackButton) else nil,
                        UnibarFrame = arg1:renderUnibarFrame(var9, var10)
                    }
                )
            end
        end

        tbl4.TopBarLeftContainer = var17

        tbl4.Unibar = if FFlagAddTraversalBackButton then nil else arg1:renderUnibarFrame(var9, var10)

        tbl4.HealthBar = if var6 then Roact.createElement(HealthBar, {}) else nil

        tbl4.AssistantBuildPillMenu = if FFlagAppNavMyStatsTab and canShowAssistantBuild() then React.createElement(BuildPillMenuPortalHost, { position = UDim2.new(1, 0, 0, 0), anchorPoint = Vector2.new(1, 0) }) else nil

        local createElement3 = Roact.createElement
        local str3 = "Frame"

        local tbl5 = {
            BackgroundTransparency = 1,
            Position = if var10 and not var5 then Roact.joinBindings({ width = arg1.ageRatingControlsWidth, visible = arg1.ageRatingControlsVisible }):map(function(arg3): UDim2
                return UDim2.fromOffset(if FFlagAddTraversalBackButton or arg3.visible then arg3.width else 0, 0)
            end) else arg1.unibarRightSidePosition,
            Size = UDim2.new(1, 0, 1, 0)
        }

        local tbl6 = {
            Padding = Roact.createElement("UIPadding", {
                PaddingLeft = if var10 and not var5 then Roact.joinBindings({ visible = arg1.ageRatingControlsVisible, width = arg1.ageRatingControlsWidth }):map(function(arg3): UDim
                    local var18 = arg3.visible or FFlagAddTraversalBackButton and arg3.width > 0
                    return UDim.new(0, if var18 then offset2 else 0)
                end) else UDim.new(0, offset2)
            }),
            Layout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, leftGap),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            ShopGlobalIcon = 0,
            AgeRating = 0,
            RestyleTimer = 0,
            HealthBar = 0
        }

        local element5

        if var5 or not (var2 and arg1.state.shopGlobalIconEnabled) then
            element5 = nil
        else
            element5 = Roact.createElement(ShopGlobalIcon, {
                buttonSize = Constants3.TopBarButtonHeight * arg1.state.UiScale,
                layoutOrder = 1,
                leftGap = leftGap,
                showStatusIndicator = arg1.state.shopGlobalStatusIndicatorEnabled,
                onActivated = arg1.onShopGlobalIconActivated,
                onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else arg1.props.setKeepOutArea,
                isActive = arg1.state.shopGlobalIconIsActive,
                icon = if FFlagExperienceShopNewIconography or not (CommonIcon and arg1.shopIsActiveMappedSignal) then nil else CommonIcon("BuildingStore", nil, arg1.shopIsActiveMappedSignal)
            })
        end

        tbl6.ShopGlobalIcon = element5

        if var5 then
            var15 = nil
        end

        tbl6.AgeRating = var15
        local var18

        if FFlagEnableRestyleTopBar and FFlagUseUIOverlayForCloudPlay and not var5 then
            local createElement4 = React.createElement
            local var19 = View
            local tbl7 = {
                tag = "auto-xy",
                LayoutOrder = 4,
                padding = {
                    left = UDim.new(0, leftGap)
                }
            }
            local tbl8 = {
                Timer = React.createElement(RestyleTimer, {
                    buttonSize = Constants3.TopBarButtonHeight * arg1.state.UiScale,
                    followsUILessMode = true,
                    layoutOrder = 4,
                    onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else arg1.props.setKeepOutArea,
                    onAreaRemoved = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.removeKeepOutArea else arg1.props.removeKeepOutArea
                })
            }
            var18 = createElement4(var19, tbl7, tbl8)
        else
            var18 = nil
        end

        tbl6.RestyleTimer = var18

        tbl6.HealthBar = if var6 then nil else Roact.createElement(HealthBar, { layoutOrder = 10 })
        tbl4.StackedElements = createElement3(str3, tbl5, tbl6)
        var16 = createElement2(str2, tbl3, tbl4) or nil
    else
        var16 = nil
    end

    tbl2.UnibarLeftFrame = var16

    tbl2.FreeTrialChipHost = if FFlagEnableFreeTrialTopBarChip then React.createElement(FreeTrialChipHost, {
        position = UDim2.new(1, -xOffset, 0, yOffset2),
        size = UDim2.new(0.5, -xOffset, 0, Constants3.TopBarButtonHeight * arg1.state.UiScale),
        zIndex = 2,
        visible = var14
    }) else nil
    local var17

    if Unibar and right == Enum.HorizontalAlignment.Right then
        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, yOffset3),
            Position = uDim2_4,
            AnchorPoint = Vector2.new(1, 0)
        }
        local tbl4 = {
            ChromeAnalytics = if Analytics then Roact.createElement(Analytics) else nil,
            Padding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, offset3), PaddingBottom = UDim.new(0, offset4) }),
            Layout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, leftGap),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            HealthBar = Roact.createElement(HealthBar, { layoutOrder = 1 }),
            Unibar = Roact.createElement(Unibar, {
                onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else arg1.props.setKeepOutArea,
                layoutOrder = 2
            })
        }
        var17 = createElement2(str2, tbl3, tbl4) or nil
    else
        var17 = nil
    end

    tbl2.UnibarRightFrame = var17

    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, yOffset3),
        Visible = var13,
        Position = uDim2
    }
    local tbl4 = { LeftFrame = 0, RightFrame = 0 }
    local var18 = var9 or not TenFootInterface:IsEnabled() or FFlagResponsiveUnitsDeprecateTenFoot

    if var18 then
        local createElement3 = Roact.createElement
        local str3 = "Frame"
        local tbl5 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(0.5, -xOffset, 1, 0),
            Position = uDim2_2
        }
        local tbl6 = {
            Layout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, leftGap),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Blank = var9
                and Roact.createElement("Frame", { LayoutOrder = 1, Size = UDim2.new(0, xOffset2, 0, 1), BackgroundTransparency = 1 }),
            MenuIcon = not isNewTiltIconEnabled()
                and Roact.createElement(MenuIcon, {
                    layoutOrder = 1,
                    showBadgeOver12 = arg1.props.showGameAgeRating and not var10,
                    onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then arg1.keepOutAreasStore.setKeepOutArea else nil
                }),
            ChatIcon = if var9 then nil else Roact.createElement(ChatIcon, { layoutOrder = 3 }) or nil
        }
        var18 = createElement3(str3, tbl5, tbl6)
    end

    tbl4.LeftFrame = var18
    local element5

    if Unibar then
        element5 = nil
    else
        element5 = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0.5, -xOffset, 1, 0),
            Position = uDim2_3,
            AnchorPoint = Vector2.new(1, 0)
        }, {
            Layout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, leftGap),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            HealthBar = Roact.createElement(HealthBar, { layoutOrder = 1 }),
            MoreMenu = not TenFootInterface:IsEnabled() and Roact.createElement(MoreMenu, { layoutOrder = 2 })
        })
            or nil
    end

    tbl4.RightFrame = element5
    tbl2.TopBarFrame = createElement2(str2, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

local function mapStateToProps(arg1)
    if FFlagTopBarSignalizeMenuOpen then
        return nil
    end

    local inspectMenuOpen = arg1.displayOptions.inspectMenuOpen

    return {
        menuOpen = arg1.displayOptions.menuOpen,
        inspectMenuOpen = inspectMenuOpen
    }
end

local var9 = if FFlagShowGameAgeRating then UniversalAppPolicy.UniversalAppPolicy.connect(function(arg1, _)
    return {
        showGameAgeRating = arg1.getShowGameAgeRating()
    }
end)(var8) else TopBarAppPolicy.connect(function(arg1, _)
    return {
        showGameAgeRating = arg1.showBadgeOver12()
    }
end)(var8)

local function mapDispatchToProps(arg1)
    return {
        setScreenSize = not FFlagTopBarSignalizeScreenSize and function(arg2)
            return arg1(SetScreenSize(arg2))
        end or nil,
        setKeepOutArea = not FFlagTopBarSignalizeKeepOutAreas and function(arg2, arg3, arg4)
            return arg1(SetKeepOutArea(arg2, arg3, arg4))
        end or nil,
        removeKeepOutArea = not FFlagTopBarSignalizeKeepOutAreas and function(arg2)
            return arg1(RemoveKeepOutArea(arg2))
        end or nil
    }
end

local UNSTABLE_connect2 = RoactRodux.UNSTABLE_connect2

if FFlagTopBarSignalizeMenuOpen then
    mapStateToProps = nil
end

return UNSTABLE_connect2(mapStateToProps, mapDispatchToProps)(var9)
