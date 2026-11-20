-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local Features = if FFlagEnableNewBackpack then require(CorePackages.Workspace.Packages.System).Features else nil
local Symbol = require(CorePackages.Workspace.Packages.AppCommonLib).Symbol
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local IXPService = game:GetService("IXPService")
local LocalizationService = game:GetService("LocalizationService")
local TelemetryService = game:GetService("TelemetryService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot
local isEnabled = require(RobloxGui.Modules.TenFootInterface):IsEnabled()
local var1 = isEnabled and not FFlagResponsiveUnitsDeprecateTenFoot

local Roact = require(CorePackages.Packages.Roact)
local Cryo = require(CorePackages.Packages.Cryo)
local Otter = require(CorePackages.Packages.Otter)
local React = require(CorePackages.Packages.React)
local ReactRoblox = require(CorePackages.Packages.ReactRoblox)

local Foundation = require(CorePackages.Packages.Foundation)
local FoundationProvider = Foundation.FoundationProvider

local Traversal = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).Traversal

local PortalWithFoundationStylelink = require(script.Parent.Components.PortalWithFoundationStylelink)
local InExperienceMenuReact = require(script.Parent.InExperienceMenuReact)
local InExperienceMenuReactPage = require(script.Parent.Pages.InExperienceMenuReactPage)
local ReactPageSignal = require(script.Parent.ReactPageSignal)
local Utils = require(script.Parent.Integrations.Utils)
local Utility = require(RobloxGui.Modules.Settings.Utility)
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)
local PerfUtils = require(RobloxGui.Modules.Common.PerfUtils)
local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local isSubjectToDesktopPolicies = require(CorePackages.Workspace.Packages.SharedFlags).isSubjectToDesktopPolicies
local SwitchTabHint = require(RobloxGui.Modules.Settings.Components.TabHeader).SwitchTabHint
local TraversalHistoryMenu = require(RobloxGui.Modules.Settings.Components.Traversal).TraversalHistoryMenu
local MenuBackButton = require(RobloxGui.Modules.Settings.Components.MenuBackButton)
local MenuFrontButton = require(RobloxGui.Modules.Settings.Components.MenuFrontButton)
local MenuButtonsContainer = require(RobloxGui.Modules.Settings.Components.MenuButtons.MenuButtonsContainer)
local RoactAppExperiment = require(CorePackages.Packages.RoactAppExperiment)
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local CapturesPolicy = require(CorePackages.Workspace.Packages.CapturesInExperience).CapturesPolicy
local InExperienceCapabilities = require(CorePackages.Workspace.Packages.InExperienceCapabilities).InExperienceCapabilities
local getCamMicPermissions = require(CoreGui.RobloxGui.Modules.Settings.getCamMicPermissions)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local Stores = require(CorePackages.Workspace.Packages.CoreGuiCommon).Stores
local Signals = require(CorePackages.Packages.Signals)
local createSignal = Signals.createSignal
local AppStyleProvider = require(CorePackages.Packages.UIBlox).App.Style.AppStyleProvider
local Dark = require(CorePackages.Packages.Foundation).Enums.ColorMode.Dark
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local HelpPage = require(CorePackages.Workspace.Packages.HelpPage)
local leaveGame = require(RobloxGui.Modules.Settings.leaveGame)

local Theme = require(script.Parent.Theme)

local BackgroundColor3 = Theme.color("SETTINGS_SHIELD", Color3.new(41 / 255, 41 / 255, 41 / 255))
local BackgroundTransparency = Theme.transparency("SETTINGS_SHIELD_TRANSPARENCY", 0.2)

local SHIELD_INACTIVE_POSITION = Theme.SHIELD_INACTIVE_POSITION

local SettingsHubCursorOverride = Symbol.named("SettingsHubCursorOverride")

local yOffset = if var1 then 32 elseif Utility:IsSmallTouchScreen() then 24 else 26

local num1 = game:DefineFastInt("CheckLeaveGameUpsellCooldown", 300)
local num2 = game:DefineFastInt("GetServerChannelRetries", 10)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local Flags = require(script.Parent.Flags)

local tbl1 = {
    EngineFeatureRbxAnalyticsServiceExposePlaySessionId = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId"),
    EngineFeatureTeleportHistoryButtons = game:GetEngineFeature("TeleportHistoryButtons"),
    EngineFeaturePlayerScriptStatusProperty = game:GetEngineFeature("PlayerScriptStatusProperty"),
    FFlagPreventHiddenSwitchPage = game:DefineFastFlag("PreventHiddenSwitchPage", false),
    FFlagFixDisableTopPaddingError = game:DefineFastFlag("FixDisableTopPaddingError", false),
    FFlagWaitPlayerModuleStatus = game:DefineFastFlag("WaitPlayerModuleStatus", false),
    FFlagEnableInGameMenuDurationLogger = require(RobloxGui.Modules.Common.Flags.GetFFlagEnableInGameMenuDurationLogger)(),
    isNewInGameMenuEnabled = require(RobloxGui.Modules.isNewInGameMenuEnabled),
    GetFFlagRemoveAssetVersionEndpoint = require(RobloxGui.Modules.Flags.GetFFlagRemoveAssetVersionEndpoint),
    GetFFlagNewEventIngestPlayerScriptsDimensions = require(RobloxGui.Modules.Flags.GetFFlagNewEventIngestPlayerScriptsDimensions),
    GetFFlagReportAbuseMenuEntrypointAnalytics = require(RobloxGui.Modules.Settings.Flags.GetFFlagReportAbuseMenuEntrypointAnalytics),
    GetFFlagEnableLeaveGameUpsellEntrypoint = require(RobloxGui.Modules.Settings.Flags.GetFFlagEnableLeaveGameUpsellEntrypoint),
    GetFStringInExperienceMenuIXPLayer = require(RobloxGui.Modules.Settings.Flags.GetFStringInExperienceMenuIXPLayer),
    GetFStringExitModalIXPLayer = require(RobloxGui.Modules.Settings.Flags.GetFStringExitModalIXPLayer),
    GetFStringInExperienceMenuIXPVar = require(RobloxGui.Modules.Settings.Flags.GetFStringInExperienceMenuIXPVar),
    FFlagRelocateMobileMenuButtons = require(RobloxGui.Modules.Settings.Flags.FFlagRelocateMobileMenuButtons),
    FIntRelocateMobileMenuButtonsVariant = require(RobloxGui.Modules.Settings.Flags.FIntRelocateMobileMenuButtonsVariant),
    FFlagMenuButtonsMountWithIEM = require(RobloxGui.Modules.Settings.Flags.FFlagMenuButtonsMountWithIEM),
    FFlagSpatialUIFixMenuPanelChatExclusive = require(RobloxGui.Modules.Settings.Flags.FFlagSpatialUIFixMenuPanelChatExclusive),
    FFlagRemoveLoadingTimeout = require(RobloxGui.Modules.Flags.FFlagRemoveLoadingTimeout),
    FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav,
    ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled(),
    FFlagRespawnChromeShortcutTelemetry = require(RobloxGui.Modules.Chrome.Flags.FFlagRespawnChromeShortcutTelemetry),
    FFlagLocalizeVersionLabels = settings():GetFFlag("LocalizeVersionLabels"),
    isInExperienceUIVREnabled = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).isInExperienceUIVREnabled,
    InExperienceUIVRIXP = require(CorePackages.Workspace.Packages.SharedExperimentDefinition).InExperienceUIVRIXP,
    FFlagAddSwitchTabHintsToIEM = SharedFlags.FFlagAddSwitchTabHintsToIEM,
    GetFFlagEnableAppChatInExperience = SharedFlags.GetFFlagEnableAppChatInExperience,
    GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints = SharedFlags.GetFFlagEnableInExpPhoneVoiceUpsellEntrypoints,
    GetFFlagDisplayServerChannel = SharedFlags.GetFFlagDisplayServerChannel,
    FFlagSettingsHubIndependentBackgroundVisibility = SharedFlags.getFFlagSettingsHubIndependentBackgroundVisibility(),
    GetFFlagPackagifySettingsShowSignal = SharedFlags.GetFFlagPackagifySettingsShowSignal,
    FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls,
    FFlagIEMTabFocusNav = SharedFlags.FFlagIEMTabFocusNav,
    FFlagIEMFocusNavSupportNewButtons = Flags.FFlagIEMFocusNavSupportNewButtons,
    FFlagAddUILessMode = SharedFlags.FFlagAddUILessMode,
    FIntAddUILessModeVariant = SharedFlags.FIntAddUILessModeVariant,
    FFlagInExperienceReportClosingBugfix = SharedFlags.FFlagInExperienceReportClosingBugfix,
    FFlagEnableSettingsHubUIDelegateRollout = SharedFlags.FFlagEnableSettingsHubUIDelegateRollout,
    FFlagAddIEMProfilePage = SharedFlags.FFlagAddIEMProfilePage,
    FFlagFixSpatialUICaptures = SharedFlags.FFlagFixSpatialUICaptures,
    FFlagVoiceRewarmTelemetry = SharedFlags.FFlagVoiceRewarmTelemetry,
    FFlagAddTraversalBackButton = Traversal.Flags.FFlagAddTraversalBackButton,
    FFlagAddTraversalHistory = Traversal.Flags.FFlagAddTraversalHistory,
    FFlagEnableSystemScrimInSettingsHub = game:DefineFastFlag("EnableSystemScrimInSettingsHub", false),
    FFlagHelpPageIXPExposure = HelpPage.Flags.FFlagHelpPageIXPExposure,
    FStringHelpPageIXPLayer = HelpPage.Flags.FStringHelpPageIXPLayer,
    FFlagFixDisabledScrollOnIos = game:DefineFastFlag("FixDisabledScrollOnIos", false),
    FFlagSideSheetAndroidBack = game:DefineFastFlag("SideSheetAndroidBack", false),
    FFlagAddInviteFriendsIntegration = SharedFlags.FFlagAddInviteFriendsIntegration,
    FFlagIntegrateTraversalHistoryInSideSheet = SharedFlags.FFlagIntegrateTraversalHistoryInSideSheet,
    FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton,
    isExitModalRemoved = require(RobloxGui.Modules.Settings.Flags.isExitModalRemoved),
    FFlagEnableExitModalExposure = game:DefineFastFlag("EnableExitModalExposure", false)
}

local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local StarterGui = game:GetService("StarterGui")
local StarterPlayer = game:GetService("StarterPlayer")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local GameSettings = UserSettings().GameSettings
local ExperienceMenuSessionManagerInstance = require(CorePackages.Workspace.Packages.InExperienceSessionization).ExperienceMenuSessionManagerInstance

local PlatformService = nil
pcall(function()
    PlatformService = game:GetService("PlatformService")
end)
local PlatformFriendsService = nil
pcall(function()
    PlatformFriendsService = game:GetService("PlatformFriendsService")
end)

local GetServerVersion = nil
spawn(function()
    GetServerVersion = RobloxReplicatedStorage:WaitForChild("GetServerVersion", math.huge)
end)

local GetServerChannel = nil
if tbl1.GetFFlagDisplayServerChannel() then
    spawn(function()
        GetServerChannel = RobloxReplicatedStorage:WaitForChild("GetServerChannel", math.huge)
    end)
end

local bool1 = UserInputService.PreferredInput == Enum.PreferredInput.Touch
RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local platform = UserInputService:GetPlatform()

local BaseUrl = ContentProvider.BaseUrl
local bool2 = not string.find(BaseUrl, "www.roblox.com")
local DevConsoleMaster = require(RobloxGui.Modules.DevConsoleMaster)

local connection = nil
local bool3 = false

local serverResult = nil
local var4 = nil

local SettingsFullScreenTitleBar = require(RobloxGui.Modules.Settings.Components.SettingsFullScreenTitleBar)

local MenuLeaveGameTelemetryConfig = require(RobloxGui.Modules.Settings.Analytics.MenuLeaveGameTelemetryConfig)
local MenuResetCharacterTelemetryConfig = require(RobloxGui.Modules.Settings.Analytics.MenuResetCharacterTelemetryConfig)
local MenuResumeTelemetryConfig = require(RobloxGui.Modules.Settings.Analytics.MenuResumeTelemetryConfig)

local ReactPageAnalytics = require(RobloxGui.Modules.Settings.Analytics.ReactPageAnalytics)

local GameInvite = require(CorePackages.Workspace.Packages.GameInvite)
local GameInviteModalManager = GameInvite.GameInviteModalManager
local GameInviteConstants = GameInvite.GameInviteConstants

local CapturesApp = require(RobloxGui.Modules.Captures.CapturesApp)

local Constants = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))

local isSubjectToChinaPolicies = CachedPolicyService:IsSubjectToChinaPolicies()

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default
local Constants2 = require(RobloxGui.Modules.VoiceChat.Constants)
local bool4 = game:DefineFastFlag("SettingsHubRaceConditionFix", false)
local bool5 = game:DefineFastFlag("FixReportButtonCutOff", false)

local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)
local SettingsShowSignal = if tbl1.GetFFlagPackagifySettingsShowSignal() then require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal else nil
local SettingsUtility = if tbl1.GetFFlagPackagifySettingsShowSignal() then require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsUtility else nil
local tbl2 = { frequency = 4, dampingRatio = 1 }

local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)
local getDidSideSheetOpenWithPeoplePage = InExperienceSideSheet.getDidSideSheetOpenWithPeoplePage
local getHasRoomForPeoplePage = InExperienceSideSheet.getHasRoomForPeoplePage
local getIsPeoplePageOpen = InExperienceSideSheet.getIsPeoplePageOpen
local getSideSheetAnimationDuration = InExperienceSideSheet.getSideSheetAnimationDuration
local getSideSheetDrawerWidth = InExperienceSideSheet.getSideSheetDrawerWidth
local getSideSheetMenuPageHeight = InExperienceSideSheet.getSideSheetMenuPageHeight
local getSideSheetMenuPageWidth = InExperienceSideSheet.getSideSheetMenuPageWidth
local toggleSideSheet = InExperienceSideSheet.toggleSideSheet
local getSideSheetVisibility = InExperienceSideSheet.getSideSheetVisibility
local setupInGameMenuPeoplePageActions = InExperienceSideSheet.setupInGameMenuPeoplePageActions
local setupPeoplePageOpenTracking = InExperienceSideSheet.setupPeoplePageOpenTracking
local closePeoplePageWhenNoRoomBesideSideSheet = InExperienceSideSheet.closePeoplePageWhenNoRoomBesideSideSheet
local FFlagSideSheetOpenPeoplePage = InExperienceSideSheet.Flags.FFlagSideSheetOpenPeoplePage

local FFlagClosePeoplePageWhenNoRoomBesideSideSheet = InExperienceSideSheet.Flags.FFlagClosePeoplePageWhenNoRoomBesideSideSheet
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local GetSwitchServerStore = require(CorePackages.Workspace.Packages.SwitchServer).GetSwitchServerStore
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch

local _ReactPageFactory = require(RobloxGui.Modules.Settings.ReactPageFactory)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization

local var5 = tbl1.FFlagLocalizeVersionLabels or isSubjectToChinaPolicies
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local function tryTranslate(str1: string, str2: string) -- Luacid: Inlined by compiler; 12 call sites recovered
    if not RobloxTranslator then
        return str2
    end
    local success, result = pcall(RobloxTranslator.FormatByKey, RobloxTranslator, str1)
    return if success then result else str2
end

local ChatSelector = require(RobloxGui.Modules.ChatSelector)
local vector2, _vector2 = GuiService:GetGuiInset()
local uDim2 = UDim2.new(0, 0, 0, -vector2.Y)
local uDim2_2 = UDim2.new(1, 0, 1, vector2.Y)

local function GetServerVersionBlocking() -- Luacid: Inlined by compiler; 1 call site recovered
    if serverResult then
        return serverResult
    end
    if not GetServerVersion then
        repeat
            wait()
        until GetServerVersion
    end
    serverResult = GetServerVersion:InvokeServer()
    return serverResult
end

local function GetServerChannelBlocking()
    if var4 then
        return var4
    end

    local num3 = num2
    if not GetServerChannel then
        repeat
            task.wait()
            num3 -= 1
        until GetServerChannel or num3 == 0
    end
    if GetServerChannel then
        var4 = GetServerChannel:InvokeServer()
    else
        warn("GetServerChannelRemote not available")
        var4 = "Unknown"
    end
    return var4
end

local function GetPlaceVersionText(): number -- Luacid: unused: defined but never referenced
    if tbl1.GetFFlagRemoveAssetVersionEndpoint() then
        return game.PlaceVersion
    end

    local placeVersion = game.PlaceVersion

    pcall(function()
        local async = HttpRbxApiService:GetAsync(string.format("assets/%d/versions", game.PlaceId))
        local versionNumber = HttpService:JSONDecode(async)[1].VersionNumber
        placeVersion = string.format("%s (Latest: %d)", placeVersion, versionNumber)
    end)

    return placeVersion
end

local function createReactPage(arg1)
    return Create("Frame")({
        Name = "InExperienceMenuPage",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0, 0),
        Visible = false,
        Parent = arg1
    })
end

local function CreateSettingsHub()
    local module = {
        Visible = false,
        Active = true,
        Pages = {
            CurrentPage = nil,
            PageTable = {}
        },
        MenuStack = {},
        TabHeaders = {},
        BottomBarButtons = {},
        BottomBarButtonsComponents = {},
        ResizedConnection = nil,
        BackBarVisibleConnection = nil
    }

    if tbl1.EngineFeatureTeleportHistoryButtons then
        module.FrontBarVisibleConnection = nil
    end
    module.PreferredTransparencyChangedConnection = nil
    module.TabConnection = nil

    module.LeaveGamePage = require(RobloxGui.Modules.Settings.Pages.LeaveGame)
    module.LeaveGameUpsellPage = if tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() then require(RobloxGui.Modules.Settings.Pages.LeaveGameUpsell.LeaveGameUpsell) else nil
    module.ResetCharacterPage = require(RobloxGui.Modules.Settings.Pages.ResetCharacter)

    module.SettingsShowSignal = if tbl1.GetFFlagPackagifySettingsShowSignal() then SettingsShowSignal else Utility:CreateSignal()
    module.CurrentPageSignal = if tbl1.GetFFlagPackagifySettingsShowSignal() then SettingsUtility.CreateSignal() else Utility:CreateSignal()
    local showBottomBarSignal, setShowBottomBarSignal = createSignal(false)
    module.showBottomBarSignal = showBottomBarSignal
    module.setShowBottomBarSignal = setShowBottomBarSignal
    module.OpenStateChangedCount = 0
    module.BottomButtonFrame = nil
    if tbl1.FFlagRelocateMobileMenuButtons then
        module.addMenuKeyBindings = nil
        module.removeMenuKeyBindings = nil
    end
    if tbl1.FFlagIEMFocusNavSupportNewButtons then
        module.ResumeMenuButton = nil
    end
    module.hasMicPermissions = false
    if tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() then
        module.checkedUpsell = false
        module.leaveGameUpsellProp = Constants2.PHONE_UPSELL_VALUE_PROP.None
        module.sessionStartTime = os.time()
    end
    module.isFetchingMicPermissions = true
    if tbl1.FFlagAddUILessMode and tbl1.FIntAddUILessModeVariant ~= 0 then
        module.uiLessStore = Stores.GetUILessStore(false)
    end
    module.PageTitleLabel = nil
    module.PageTitleCloseButton = nil
    module.PageTitleHeader = nil

    module.isMuted = nil
    module.lastVoiceRecordingIndicatorTextUpdated = nil

    module.playSessionId = ""
    if tbl1.EngineFeatureRbxAnalyticsServiceExposePlaySessionId then
        module.playSessionId = RbxAnalyticsService:GetPlaySessionId()
    end

    module.reactPageAnalytics = ReactPageAnalytics.new()

    local connection2 = nil
    local connection3 = nil

    local poppedMenu = Instance.new("BindableEvent")
    poppedMenu.Name = "PoppedMenu"
    module.PoppedMenu = poppedMenu.Event

    module.ReactPage = nil
    module.ReactPage = createReactPage()

    local function shouldShowHubBar(arg1): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
        arg1 = arg1 or module.Pages.CurrentPage
        return if isSideSheetEnabled then arg1.ShouldShowHubBar == true else arg1.ShouldShowBottomBar == true
    end

    local function updatePageTitleHeader(currentPage) -- Luacid: Inlined by compiler; 2 call sites recovered
        if not (shouldShowHubBar(currentPage) and currentPage.TabHeader) then
            module.PageTitleLabel.Text = ""
            return
        end

        module.PageTitleLabel.Text = currentPage.TabHeader.TabLabel.Title.Text
    end

    local function setTabHeaderSelection(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        if not tbl1.FFlagIEMTabFocusNav then
            return
        end
        local nextSelectionUp = arg1:GetTabHeader()
        if not nextSelectionUp then
            return
        end
        for _, nextSelectionDown in arg1.FirstSelectableObjects do
            nextSelectionDown.NextSelectionUp = nextSelectionUp
            nextSelectionUp.NextSelectionDown = nextSelectionDown
        end
    end

    local function updateTabHeaderWrapping() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not tbl1.FFlagIEMTabFocusNav then
            return
        end

        for _, tabHeader in module.TabHeaders do
            tabHeader.NextSelectionLeft = nil
            tabHeader.NextSelectionRight = nil
        end
        local tabHeadersLen = #module.TabHeaders
        if tabHeadersLen < 2 then
            return
        end

        module.TabHeaders[1].NextSelectionLeft = module.TabHeaders[tabHeadersLen]
        module.TabHeaders[tabHeadersLen].NextSelectionRight = module.TabHeaders[1]
    end

    local function setBottomBarSelection(arg1)
        if not module.BottomButtonFrame
            and not arg1
            and (not tbl1.FFlagRelocateMobileMenuButtons
                or tbl1.FIntRelocateMobileMenuButtonsVariant == 0
                or tbl1.FIntRelocateMobileMenuButtonsVariant == 2)
        then
            return
        end

        if module.ResumeButton then
            arg1.PageNextSelectionDown = module.ResumeButton
        elseif tbl1.FFlagIEMFocusNavSupportNewButtons and tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and module.ResumeMenuButton then
            arg1.PageNextSelectionDown = module.ResumeMenuButton
        end

        if tbl1.FFlagIEMTabFocusNav and module.BottomButtonFrame then
            local nextSelectionDown = arg1:GetTabHeader()

            local nextSelectionUp = module.ResumeButton or module.ResumeMenuButton
            if nextSelectionUp then
                for k, _ in pairs(module.Pages.PageTable) do
                    local tabHeader2 = k:GetTabHeader()
                    if tabHeader2 then
                        tabHeader2.NextSelectionUp = nextSelectionUp
                    end
                end
            end
            for _, descendant in module.BottomButtonFrame:GetDescendants() do
                if descendant:IsA("GuiObject") and descendant.Selectable then
                    descendant.NextSelectionDown = nextSelectionDown
                end
            end
        end

        for _, nextSelectionUp in arg1.LastSelectableObjects do
            module.BottomButtonFrame.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
            module.BottomButtonFrame.NextSelectionUp = nextSelectionUp
            nextSelectionUp.NextSelectionDown = arg1.PageNextSelectionDown

            local leaveGameButton = module.LeaveGameButton
            if leaveGameButton then
                leaveGameButton.NextSelectionUp = nextSelectionUp
            end
            if not tbl1.FFlagIEMFocusNavSupportNewButtons or tbl1.FIntRelocateMobileMenuButtonsVariant ~= 2 then
                continue
            end

            for _, descendant in module.BottomButtonFrame:GetDescendants() do
                if descendant:IsA("GuiObject") and descendant.Selectable then
                    descendant.NextSelectionUp = nextSelectionUp
                end
            end
        end

        if not (#arg1.LastSelectableObjects < 1) then
            return
        end

        module.BottomButtonFrame.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        module.BottomButtonFrame.NextSelectionUp = nil
        local leaveGameButton = module.LeaveGameButton
        if leaveGameButton then
            leaveGameButton.NextSelectionUp = nil
        end
        if not tbl1.FFlagIEMFocusNavSupportNewButtons or tbl1.FIntRelocateMobileMenuButtonsVariant ~= 2 then
            return
        end

        for _, descendant in module.BottomButtonFrame:GetDescendants() do
            if descendant:IsA("GuiObject") and descendant.Selectable then
                local nextSelectionUp = if tbl1.FFlagIEMTabFocusNav then arg1:GetTabHeader() else nil
                descendant.NextSelectionUp = nextSelectionUp
            end
        end
    end

    local function shouldShowBottomBar(arg1): boolean
        arg1 = arg1 or module.Pages.CurrentPage

        if (not tbl1.FFlagRelocateMobileMenuButtons
            or tbl1.FIntRelocateMobileMenuButtonsVariant == 0
            or tbl1.FIntRelocateMobileMenuButtonsVariant == 2)
            and (Utility:IsPortrait() or Utility:IsSmallTouchScreen())
            and not Theme.AlwaysShowBottomBar()
        then
            return false
        end

        return not (arg1 == nil) and arg1.ShouldShowBottomBar == true
    end

    local function shouldDisableDefaultScroll(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        arg1 = arg1 or module.Pages.CurrentPage
        return not (arg1 == nil) and arg1.ShouldDisableDefaultScroll == true
    end

    local function setBottomBarBindings()
        if not module.Visible then
            return
        end

        if not tbl1.FFlagRelocateMobileMenuButtons or tbl1.FIntRelocateMobileMenuButtonsVariant == 0 then
            for i = 1, #module.BottomBarButtons do
                local bottomBarButton = module.BottomBarButtons[i]
                local actionName = bottomBarButton[1]
                local var8 = bottomBarButton[2]
                ContextActionService:BindCoreAction(actionName, var8[1], false, unpack(var8[2]))
            end
        elseif module.addMenuKeyBindings then
            module.addMenuKeyBindings()
        end

        if module.BottomButtonFrame then
            module.BottomButtonFrame.Visible = true
        end
    end

    local function removeBottomBarBindings(arg1)
        if not tbl1.FFlagRelocateMobileMenuButtons or tbl1.FIntRelocateMobileMenuButtonsVariant == 0 then
            for _, bottomBarButton in pairs(module.BottomBarButtons) do
                ContextActionService:UnbindCoreAction(bottomBarButton[1])
            end
        elseif module.removeMenuKeyBindings then
            module.removeMenuKeyBindings()
        end

        local openStateChangedCount = module.OpenStateChangedCount
        local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
            if module.OpenStateChangedCount == openStateChangedCount and module.BottomButtonFrame then
                module.BottomButtonFrame.Visible = false
            end
        end

        if arg1 then
            delay(arg1, func1)
            return
        end

        func1()
    end

    local function updateButtonPosition(arg1, position, size) -- Luacid: unused: defined but never referenced
        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
            return
        end

        local var8 = module.BottomButtonFrame:FindFirstChild(arg1 .. "ButtonButton", true)
        if not var8 then
            return
        end
        var8.Position = position
        var8.Size = size
    end

    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local localization = Localization.new(robloxLocaleId)

    local function hideVoiceUx()
        local muteButtonButton = module.MuteButtonButton
        if muteButtonButton then
            muteButtonButton.Visible = false
            muteButtonButton:Destroy()
        end

        local uDim2_3 = if var1 then UDim2.new(0, 320, 0, 72) else UDim2.new(0, 260, 0, Theme.LargeButtonHeight)

        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
            return
        end

        local uDim2_4 = UDim2.new(0.5, if var1 then -160 else -130, 0.5, -25)

        if not tbl1.FFlagRelocateMobileMenuButtons or tbl1.FIntRelocateMobileMenuButtonsVariant == 0 then
            local leaveGameButtonButton = module.BottomButtonFrame:FindFirstChild("LeaveGameButtonButton", true)
            if leaveGameButtonButton then
                leaveGameButtonButton.Position = uDim2_4
                leaveGameButtonButton.Size = uDim2_3
            end
        end

        local uDim2_5 = UDim2.new(0.5, if var1 then -550 else -400, 0.5, -25)

        if not tbl1.FFlagRelocateMobileMenuButtons or tbl1.FIntRelocateMobileMenuButtonsVariant == 0 then
            local resetCharacterButtonButton = module.BottomButtonFrame:FindFirstChild("ResetCharacterButtonButton", true)
            if resetCharacterButtonButton then
                resetCharacterButtonButton.Position = uDim2_5
                resetCharacterButtonButton.Size = uDim2_3
            end
        end

        local uDim2_6 = UDim2.new(0.5, if var1 then 200 else 140, 0.5, -25)

        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
            return
        end

        local resumeButtonButton = module.BottomButtonFrame:FindFirstChild("ResumeButtonButton", true)
        if not resumeButtonButton then
            return
        end
        resumeButtonButton.Position = uDim2_6
        resumeButtonButton.Size = uDim2_3
    end

    local function addBottomBarButtonOld(str1: string, arg1, image, image2: string, position, arg2, arg3, callback)
        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
            return
        end

        local var8 = str1 .. "Button"
        local var9 = str1 .. "Text"

        local uDim2_3 = UDim2.new(0, 260, 0, Theme.LargeButtonHeight)
        if var1 then
            uDim2_3 = UDim2.new(0, 320, 0, 72)
        end

        local tbl3 = module
        local tbl4 = module
        local var10, var11 = Utility:MakeStyledButton(str1 .. "Button", arg1, uDim2_3, arg2, nil, module)
        tbl3[var8] = var10
        tbl4[var9] = var11
        Create("UIListLayout")({
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Parent = module[var8]
        })
        Create("UIPadding")({ PaddingLeft = UDim.new(0.025, 0), Parent = module[var8] })

        module[var9].Size = UDim2.new(0, 0, 1, 0)

        Create("UIFlexItem")({ FlexMode = Enum.UIFlexMode.Grow, Parent = module[var9] })

        module[var8].Position = position
        module[var8].Parent = module.BottomButtonFrame
        if var1 then
            module[var8].ImageTransparency = 1
        end

        module[var9].FontSize = Enum.FontSize.Size24
        local var12 = nil

        if not bool1 then
            local var13 = str1 .. "Hint"
            local var2 = if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) or platform == Enum.Platform.XBoxOne then image else image2
            var12 = Create("ImageLabel")({
                Name = var13,
                ZIndex = module.Shield.ZIndex + 2,
                BackgroundTransparency = 1,
                Image = var2,
                LayoutOrder = -1,
                Parent = module[var8]
            })

            if var2 == image2 then
                local imageColor3 = Theme.color("WhiteButtonText", Color3.new(1, 1, 1))
                var12.ImageColor3 = imageColor3
                local imageTransparency = Theme.transparency("WhiteButtonText", 1)
                var12.ImageTransparency = imageTransparency
            end
            local uDim2_4 = UDim2.new(0, 9, 0.5, 0)
            var12.Position = uDim2_4
            local uDim2_5 = UDim2.new(0, 33, 0, 33)
            var12.Size = uDim2_5
            local vector2_2 = Vector2.new(0, 0.5)
            var12.AnchorPoint = vector2_2
        end

        if var1 then
            module[var9].FontSize = Enum.FontSize.Size36
        end

        UserInputService.InputBegan:connect(function(input: InputObject)
            if input.UserInputType == Enum.UserInputType.Gamepad1
                or input.UserInputType == Enum.UserInputType.Gamepad2
                or input.UserInputType == Enum.UserInputType.Gamepad3
                or input.UserInputType == Enum.UserInputType.Gamepad4
            then
                if var12 then
                    var12.Image = image
                end
            elseif input.UserInputType == Enum.UserInputType.Keyboard and var12 then
                var12.Image = image2
            end
        end)

        module.BottomBarButtons[#module.BottomBarButtons + 1] = {
            var8,
            {
                function(_, userInputState, _)
                    if userInputState == Enum.UserInputState.Begin then
                        callback()
                    end
                end,
                arg3
            }
        }
    end

    local str1 = if var1 then "@2x" else ""
    local var8, var9, var10

    if tbl1.FFlagEnableConsoleExpControls then
        var8 = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonB)
        var9 = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonX)
        var10 = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonY)
    else
        var8 = "rbxasset://textures/ui/Controls/DesignSystem/ButtonB" .. str1 .. ".png"
        var9 = "rbxasset://textures/ui/Controls/DesignSystem/ButtonX" .. str1 .. ".png"
        var10 = "rbxasset://textures/ui/Controls/DesignSystem/ButtonY" .. str1 .. ".png"
    end

    local contentId = UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonStart)

    local bool6 = false
    local connection4 = nil

    local function setupVoiceListeners()
        if not game:GetEngineFeature("VoiceChatSupported") or bool6 then
            return
        end
        bool6 = true
        local function showUI()
            module.VoiceRecordingText.Visible = true
            default:getService().StateChanged:Connect(function(_, voiceChatState)
                if voiceChatState == Enum.VoiceChatState.Joined then
                    module.VoiceRecordingText.Visible = true
                end
            end)
            default:SetupParticipantListeners()
            getCamMicPermissions(function(arg1)
                module.hasMicPermissions = arg1.hasMicPermissions
            end, nil, true, "PermissionsButtons.getPermissions")
            connection4 = default.muteChanged.Event:Connect(function(isMuted)
                module.isMuted = isMuted
                module.lastVoiceRecordingIndicatorTextUpdated = tick()
                module.voiceRecordingIndicatorTextMotor:setGoal(Otter.instant(0))
                if module.isMuted then
                    module.VoiceRecordingText.Text = tryTranslate("InGame.CommonUI.Label.MicOff", "Mic Off")
                    return
                end
                module.VoiceRecordingText.Text = tryTranslate("InGame.CommonUI.Label.MicOnRecording", "Mic On (recording audio)")
            end)
        end

        local function hideUI()
            module.VoiceRecordingText.Visible = false
            hideVoiceUx()
            if connection4 then
                connection4:Disconnect()
            end
        end

        if default.voiceUIVisible then
            showUI()
        end
        default.showVoiceUI.Event:Connect(showUI)
        default.hideVoiceUI.Event:Connect(hideUI)
    end

    if not bool4 then
        setupVoiceListeners()
    end

    local bool7 = true
    local function setResetEnabled(bool8: boolean)
        bool7 = bool8
        if not module.ResetCharacterButton then
            return
        end

        module.ResetCharacterButton.Selectable = bool8
        module.ResetCharacterButton.Active = bool8
        module.ResetCharacterButton.Enabled.Value = bool8
        local resetCharacterHint = module.ResetCharacterButton:FindFirstChild("ResetCharacterHint")
        if resetCharacterHint then
            resetCharacterHint.ImageColor3 = bool8 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 100, 100)
        end
        local resetCharacterButtonTextLabel = module.ResetCharacterButton:FindFirstChild("ResetCharacterButtonTextLabel")
        if resetCharacterButtonTextLabel then
            resetCharacterButtonTextLabel.TextColor3 = bool8 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 100, 100)
        end
    end

    local var11 = nil
    function module.GetRespawnBehaviour(_)
        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
            return module:GetExperienceControlStore().getCanRespawn(false), module:GetExperienceControlStore().getCustomRespawnCallback(false)
        end
        return bool7, var11
    end

    module.RespawnBehaviourChangedEvent = Instance.new("BindableEvent")

    StarterGui:RegisterSetCore("ResetButtonCallback", function(arg1)
        local isBindableEvent = typeof(arg1) == "Instance" and arg1:IsA("BindableEvent")

        if isBindableEvent or type(arg1) == "boolean" then
            module.ResetCharacterPage:SetResetCallback(arg1)
        else
            warn("ResetButtonCallback must be set to a BindableEvent or a boolean")
        end

        local var12 = if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then module:GetExperienceControlStore().getCanRespawn(false) else bool7

        if arg1 == false then
            if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                module:GetExperienceControlStore().setCanRespawn(false)
            else
                setResetEnabled(false)
            end
            if isSideSheetEnabled then
                InExperienceSideSheet.setIsRespawnEnabled(false)
            end
        elseif not var12 and (isBindableEvent or arg1 == true) then
            if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                module:GetExperienceControlStore().setCanRespawn(true)
            else
                setResetEnabled(true)
            end
            if isSideSheetEnabled then
                InExperienceSideSheet.setIsRespawnEnabled(true)
            end
        end
        if isBindableEvent then
            if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                module:GetExperienceControlStore().setCustomRespawnCallback(arg1)
            else
                var11 = arg1
            end
        end
        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
            module.RespawnBehaviourChangedEvent:Fire(
                module:GetExperienceControlStore().getCanRespawn(false),
                module:GetExperienceControlStore().getCustomRespawnCallback(false)
            )
            return
        end
        module.RespawnBehaviourChangedEvent:Fire(bool7, var11)
    end)

    StarterGui:RegisterGetCore("ResetButtonCallback", function()
        local var12, _ = module:GetRespawnBehaviour()
        return var12
    end)

    local setVisibilityInternal = nil

    local getCanRespawn, var13 = createSignal(true)
    local getCustomRespawnCallback, setCustomRespawnCallback = createSignal(nil)

    function module.GetExperienceControlStore(_)
        return {
            getCanRespawn = getCanRespawn,
            getCustomRespawnCallback = getCustomRespawnCallback,
            setCanRespawn = function(bool8: boolean)
                var13(bool8)
                if not module.ResetCharacterButton then
                    return
                end

                module.ResetCharacterButton.Selectable = bool8
                module.ResetCharacterButton.Active = bool8
                module.ResetCharacterButton.Enabled.Value = bool8
                local resetCharacterHint = module.ResetCharacterButton:FindFirstChild("ResetCharacterHint")
                if resetCharacterHint then
                    resetCharacterHint.ImageColor3 = bool8 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 100, 100)
                end
                local resetCharacterButtonTextLabel = module.ResetCharacterButton:FindFirstChild("ResetCharacterButtonTextLabel")
                if resetCharacterButtonTextLabel then
                    resetCharacterButtonTextLabel.TextColor3 = bool8 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 100, 100)
                end
            end,
            setCustomRespawnCallback = setCustomRespawnCallback,
            onLeaveGame = function(source: string)
                if not module:GetVisibility() then
                    return
                end

                module:AddToMenuStack(module.Pages.CurrentPage)
                module.HubBar.Visible = false
                if tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() and module.leaveGameUpsellProp ~= Constants2.PHONE_UPSELL_VALUE_PROP.None then
                    module:SwitchToPage(module.LeaveGameUpsellPage, false)
                else
                    module:SwitchToPage(module.LeaveGamePage, false, nil, true)
                end

                TelemetryService:LogCounter(MenuLeaveGameTelemetryConfig, { customFields = { source = source } })
            end,
            onRespawn = function(source: string)
                if not getCanRespawn(false) then
                    return
                end

                module:AddToMenuStack(module.Pages.CurrentPage)
                module.HubBar.Visible = false
                module:SwitchToPage(module.ResetCharacterPage, false, nil, true)

                TelemetryService:LogCounter(MenuResetCharacterTelemetryConfig, { customFields = { source = source } })
            end,
            onResume = function(source: string)
                if tbl1.FFlagAddUILessMode then
                    module:SetVisibility(false, nil, nil, nil, source)
                else
                    module:SetVisibility(false)
                end

                if tbl1.FFlagAddUILessMode and tbl1.FIntAddUILessModeVariant ~= 0 and module.uiLessStore.getUILessModeEnabled(false) then
                    module.uiLessStore.setUIVisible(false)
                end

                RbxAnalyticsService:SetRBXEventStream(
                    Constants.AnalyticsTargetName,
                    Constants.AnalyticsResumeGameName,
                    Constants.AnalyticsMenuActionName,
                    {
                        source = source,
                        playsessionid = module.playSessionId,
                        universeid = tostring(game.GameId)
                    }
                )

                TelemetryService:LogCounter(MenuResumeTelemetryConfig, { customFields = { source = source } })
            end
        }
    end

    local var16 = if tbl1.FFlagRelocateMobileMenuButtons then tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 and function()
        if module.BottomButtonFrameRoot then
            return
        end

        local experienceControlStore = module:GetExperienceControlStore()

        module.BottomButtonFrameRoot = ReactRoblox.createRoot(module.BottomButtonFrame)
        local bottomButtonFrameRoot = module.BottomButtonFrameRoot
        local createElement = React.createElement
        local var16 = MenuButtonsContainer

        local tbl3 = {
            onLeaveGame = experienceControlStore.onLeaveGame,
            onRespawn = experienceControlStore.onRespawn,
            onResume = experienceControlStore.onResume,
            setAddMenuKeyBindings = function(addMenuKeyBindings: (...any) -> (...any))
                module.addMenuKeyBindings = addMenuKeyBindings
            end,
            setRemoveMenuKeyBindings = function(removeMenuKeyBindings: (...any) -> (...any))
                module.removeMenuKeyBindings = removeMenuKeyBindings
            end,
            getVisibility = function()
                return module.GetVisibility()
            end,
            getCanRespawn = experienceControlStore.getCanRespawn,
            currentPageChangeSignal = if Flags.FFlagAddTraversalHistoryReactMenuButtons then module.CurrentPageSignal else nil,
            setResumeMenuButton = tbl1.FFlagIEMFocusNavSupportNewButtons and function(arg1)
                module.ResumeMenuButton = arg1
                if tbl1.FFlagIEMFocusNavSupportNewButtons
                    and not (GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(module.Shield))
                then
                    GuiService.SelectedCoreObject = arg1
                end
            end or nil
        }

        bottomButtonFrameRoot:render(createElement(var16, tbl3))
    end or nil else nil

    local var17 = if tbl1.FFlagRelocateMobileMenuButtons then tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 and function()
        if module.BottomButtonFrameRoot then
            module.BottomButtonFrameRoot:unmount()
            module.BottomButtonFrameRoot = nil
        end
    end or nil else nil

    local function createGui()
        local num3 = if Utility:IsSmallTouchScreen() then 5 else 0

        module.ClippingShield = Create("Frame")({
            Name = "SettingsClippingShield",
            Size = uDim2_2,
            Position = uDim2,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            BackgroundTransparency = 1,
            Visible = true,
            ZIndex = 2,
            Parent = RobloxGui
        })

        module.CanvasGroup = Create("CanvasGroup")({
            Name = "CanvasGroup",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            GroupTransparency = 0,
            Visible = false,
            Parent = module.ClippingShield
        })

        module.Shield = Create("ImageButton")({
            Name = "SettingsShield",
            Size = UDim2.new(1, 0, 1, 0),
            Position = SHIELD_INACTIVE_POSITION,
            BackgroundTransparency = BackgroundTransparency,
            BackgroundColor3 = BackgroundColor3,
            BorderSizePixel = 0,
            Visible = false,
            Active = true,
            ZIndex = 2,
            Parent = module.ClippingShield
        })
        module.VRShield = Create("Frame")({
            Name = "VRBackground",
            Parent = module.Shield,
            BackgroundColor3 = BackgroundColor3,
            BackgroundTransparency = BackgroundTransparency,
            Position = UDim2.new(0, -4, 0, 24),
            Size = UDim2.new(1, 8, 1, -40),
            BorderSizePixel = 0,
            Visible = false
        })

        local engineFeature = game:GetEngineFeature("CoreScriptVersionEnabled")

        if engineFeature then
            module.VersionContainer = Create("ScrollingFrame")({
                Name = "VersionContainer",
                Parent = module.Shield,
                CanvasSize = UDim2.new(0, 0, 0, yOffset),
                BackgroundColor3 = BackgroundColor3,
                BackgroundTransparency = BackgroundTransparency,
                Position = UDim2.new(0, 0, 1, 0),
                Size = UDim2.new(1, 0, 0, yOffset),
                AnchorPoint = Vector2.new(0, 1),
                BorderSizePixel = 0,
                AutoLocalize = false,
                ScrollingDirection = Enum.ScrollingDirection.X,
                ScrollBarThickness = 0,
                ZIndex = 5,
                Visible = false
            })
        else
            module.VersionContainer = Create("Frame")({
                Name = "VersionContainer",
                Parent = module.Shield,
                BackgroundColor3 = BackgroundColor3,
                BackgroundTransparency = BackgroundTransparency,
                Position = UDim2.new(0, 0, 1, 0),
                Size = UDim2.new(1, 0, 0, yOffset),
                AnchorPoint = Vector2.new(0, 1),
                BorderSizePixel = 0,
                AutoLocalize = false,
                ZIndex = 5,
                Visible = false
            })
        end

        local var18 = Create("UIListLayout")({
            Name = "VersionContainer",
            Parent = module.VersionContainer,
            Padding = UDim.new(0, 6),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        local function addSizeToLabel(arg1) -- Luacid: Inlined by compiler; 8 call sites recovered
            local uDim2_3 = UDim2.new(0.2, -6, 1, 0)
            if engineFeature then
                uDim2_3 = UDim2.new(0, arg1.TextBounds.X + 6, 0, yOffset) or uDim2_3
            end

            arg1.Size = uDim2_3
        end
        if tbl1.GetFFlagDisplayServerChannel() then
            module.ServerChannelLabel = Create("TextLabel")({
                Name = "ServerChannelLabel",
                Parent = module.VersionContainer,
                LayoutOrder = 3,
                BackgroundTransparency = 1,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
                Text = "Server Channel: ...",
                Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 5
            })

            spawn(function()
                local var19 = if var5 then tryTranslate("InGame.HelpMenu.Label.ServerChannel", "Server Channel: ") else "Server Channel: "

                module.ServerChannelLabel.Text = var19 .. GetServerChannelBlocking()
                addSizeToLabel(module.ServerChannelLabel)
                module.ServerChannelLabel.TextScaled = not (engineFeature or module.ServerChannelLabel.TextFits)
            end)
        end

        module.ServerVersionLabel = Create("TextLabel")({
            Name = "ServerVersionLabel",
            Parent = module.VersionContainer,
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
            Text = "Server Version: ...",
            Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 5
        })

        spawn(function()
            local var19 = if var5 then tryTranslate("InGame.HelpMenu.Label.ServerVersion", "Server Version: ") else "Server Version: "
            module.ServerVersionLabel.Text = var19 .. GetServerVersionBlocking()
            addSizeToLabel(module.ServerVersionLabel)
            module.ServerVersionLabel.TextScaled = not (engineFeature or module.ServerVersionLabel.TextFits)
        end)

        local var19 = if var5 then tryTranslate("InGame.HelpMenu.Label.ClientVersion", "Client Version: ") else "Client Version: "

        local robloxVersion = RunService:GetRobloxVersion()
        local success, result = pcall(function(): string
            return RunService.ClientGitHash
        end)

        if success then
            robloxVersion = string.format("%s (%.6s)", robloxVersion, result)
        end

        module.ClientVersionLabel = Create("TextLabel")({
            Name = "ClientVersionLabel",
            Parent = module.VersionContainer,
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
            Text = var19 .. robloxVersion,
            Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 5
        })

        addSizeToLabel(module.ClientVersionLabel)
        module.ClientVersionLabel.TextScaled = not (engineFeature or module.ClientVersionLabel.TextFits)

        module.PlaceVersionLabel = Create("TextLabel")({
            Name = "PlaceVersionLabel",
            Parent = module.VersionContainer,
            BackgroundTransparency = 1,
            LayoutOrder = 3,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
            Text = "Place Version: ...",
            Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 5
        })

        local function setPlaceVersionText()
            local var20 = if var5 then tryTranslate("InGame.HelpMenu.Label.PlaceVersion", "Place Version: ") else "Place Version: "

            local placeVersionLabel = module.PlaceVersionLabel
            local placeVersion

            if tbl1.GetFFlagRemoveAssetVersionEndpoint() then
                placeVersion = game.PlaceVersion
            else
                local placeVersion2 = game.PlaceVersion

                pcall(function()
                    local async = HttpRbxApiService:GetAsync(string.format("assets/%d/versions", game.PlaceId))
                    local versionNumber = HttpService:JSONDecode(async)[1].VersionNumber
                    placeVersion2 = string.format("%s (Latest: %d)", placeVersion2, versionNumber)
                end)

                placeVersion = placeVersion2
            end

            placeVersionLabel.Text = var20 .. placeVersion
            addSizeToLabel(module.PlaceVersionLabel)
            module.PlaceVersionLabel.TextScaled = not (engineFeature or module.PlaceVersionLabel.TextFits)
        end
        game:GetPropertyChangedSignal("PlaceVersion"):Connect(setPlaceVersionText)
        spawn(setPlaceVersionText)

        if not CachedPolicyService:IsSubjectToChinaPolicies() then
            module.EnvironmentLabel = Create("TextLabel")({
                Name = "EnvironmentLabel",
                Parent = module.VersionContainer,
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                TextColor3 = Color3.new(1, 1, 1),
                LayoutOrder = 4,
                TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
                Text = BaseUrl,
                Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 5,
                Visible = bool2
            })
            addSizeToLabel(module.EnvironmentLabel)
            module.EnvironmentLabel.TextScaled = not (engineFeature or module.EnvironmentLabel.TextFits)
        end

        if game:GetEngineFeature("GetPlaySessionIdEnabled") then
            local rbxStr = game:GetPlaySessionId()
            if rbxStr ~= "" then
                local str2 = "PlaySessionId: " .. rbxStr
                if RobloxTranslator then
                    str2 = RobloxTranslator:FormatByKey("InGame.HelpMenu.Label.PlaySessionId", { RBX_STR = rbxStr })
                end
                module.PlaySessionIdLabel = Create("TextLabel")({
                    Name = "PlaySessionIdLabel",
                    Parent = module.VersionContainer,
                    BackgroundTransparency = 1,
                    LayoutOrder = 5,
                    TextColor3 = Color3.new(1, 1, 1),
                    TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
                    Text = str2,
                    Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    ZIndex = 5
                })

                addSizeToLabel(module.PlaySessionIdLabel)
                module.PlaySessionIdLabel.TextScaled = not module.PlaySessionIdLabel.TextFits
            end
        end

        local function getOverridesPlayerScripts()
            if tbl1.EngineFeaturePlayerScriptStatusProperty then
                return ({
                    [0] = "Unknown",
                    [1] = "v3 Custom",
                    [2] = "v3 Default",
                    [3] = "v1 Custom",
                    [4] = "v2 Default",
                    [5] = "v2 Custom"
                })[StarterPlayer.PlayerModuleStatus]
            end

            local starterPlayerScripts = StarterPlayer:WaitForChild("StarterPlayerScripts", tbl1.FFlagRemoveLoadingTimeout and math.huge or nil)
            local playerScriptsLoader = starterPlayerScripts:FindFirstChild("PlayerScriptsLoader")
            local playerModule = starterPlayerScripts:FindFirstChild("PlayerModule")
            if playerModule and playerScriptsLoader and not playerModule.Archivable then
                if playerScriptsLoader.Archivable then
                    if var5 then
                        return tryTranslate("InGame.CommonUI.Label.PossiblyCustom", "Possibly Custom")
                    end

                    return "Possibly Custom"
                elseif var5 then
                    return tryTranslate("InGame.CommonUI.Label.Default", "Default")
                else
                    return "Default"
                end
            else
                local cameraScript = starterPlayerScripts:FindFirstChild("CameraScript")
                local controlScript = starterPlayerScripts:FindFirstChild("ControlScript")
                if cameraScript or controlScript then
                    if var5 then
                        return tryTranslate("InGame.CommonUI.Label.CustomOld", "Custom Old")
                    end

                    return "Custom Old"
                elseif var5 then
                    return tryTranslate("InGame.CommonUI.Label.Custom", "Custom")
                else
                    return "Custom"
                end
            end
        end

        module.OverridesPlayerScriptsLabel = Create("TextLabel")({
            Name = "OverridesPlayerScriptsLabel",
            Parent = module.VersionContainer,
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            TextColor3 = Color3.new(1, 1, 1),
            LayoutOrder = 5,
            TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
            Text = "PlayerScripts: ",
            Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 5,
            Visible = false
        })

        spawn(function()
            local playerPermissionsModule = require(RobloxGui.Modules.PlayerPermissionsModule)
            if not Players.LocalPlayer then
                Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            end
            if tbl1.FFlagWaitPlayerModuleStatus and StarterPlayer.PlayerModuleStatus == 0 then
                StarterPlayer:GetPropertyChangedSignal("PlayerModuleStatus"):Wait()
            end

            local var20 = if var5 then tryTranslate("InGame.HelpMenu.Label.PlayerScripts", "PlayerScripts: ") else "PlayerScripts: "

            local overridesPlayerScripts = getOverridesPlayerScripts()
            local defaultPlayerScripts = if tbl1.EngineFeaturePlayerScriptStatusProperty then overridesPlayerScripts == "v3 Default" else overridesPlayerScripts == "Default"
            RbxAnalyticsService:setRBXEventStream(
                Constants.AnalyticsTargetName,
                "player_scripts_status",
                "player_scripts_status_action",
                {
                    defaultPlayerScripts = defaultPlayerScripts,
                    placeID = tostring(game.PlaceId),
                    rawValue = if tbl1.GetFFlagNewEventIngestPlayerScriptsDimensions() then overridesPlayerScripts else nil,
                    context = if tbl1.GetFFlagNewEventIngestPlayerScriptsDimensions() then "IGMv1" else nil
                }
            )
            module.OverridesPlayerScriptsLabel.Text = var20 .. overridesPlayerScripts
            module.OverridesPlayerScriptsLabel.Visible = bool2 or playerPermissionsModule.IsPlayerAdminAsync(Players.LocalPlayer)
            addSizeToLabel(module.OverridesPlayerScriptsLabel)
            module.OverridesPlayerScriptsLabel.TextScaled = not (engineFeature or module.OverridesPlayerScriptsLabel.TextFits)
        end)

        if engineFeature then
            local var20 = if var5 then tryTranslate("InGame.HelpMenu.Label.ClientCoreScriptVersion", "Client CoreScript Version: ") else "Client CoreScript Version: "

            module.CoreScriptVersionLabel = Create("TextLabel")({
                Name = "CoreScriptVersionLabel",
                Parent = module.VersionContainer,
                LayoutOrder = 6,
                BackgroundTransparency = 1,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = Theme.textSize(if var1 then 28 elseif Utility:IsSmallTouchScreen() then 14 else 20),
                Text = var20 .. RunService:GetCoreScriptVersion(),
                Font = Theme.font(Enum.Font.SourceSans, "SettingsHub"),
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 5
            })

            addSizeToLabel(module.CoreScriptVersionLabel)

            local versionContainer = module.VersionContainer
            var18:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                versionContainer.CanvasSize = UDim2.new(0, var18.AbsoluteContentSize.X, 0, yOffset)
            end)
        end

        module.Modal = Create("TextButton")({
            Name = "Modal",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 1, -1),
            Size = UDim2.new(1, 0, 1, 0),
            Modal = true,
            Text = "",
            Parent = module.Shield,
            Selectable = false
        })

        if tbl1.FFlagSettingsHubIndependentBackgroundVisibility then
            local tbl3 = module
            tbl3.DarkenBackground = Create("ImageButton")({
                Name = "DarkenBackground",
                ZIndex = module.Shield.ZIndex - 1,
                BackgroundTransparency = 1,
                BackgroundColor3 = if tbl1.isInExperienceUIVREnabled then module.SettingsUIDelegate:getDarkBackgroundTheme().Color else Theme.color("DarkenBackground"),
                Size = UDim2.new(1, 0, 1, 0),
                Parent = module.ClippingShield,
                AutoButtonColor = false,
                Visible = false
            })
        else
            module.DarkenBackground = Create("Frame")({
                Name = "DarkenBackground",
                ZIndex = module.Shield.ZIndex - 1,
                BackgroundTransparency = 1,
                BackgroundColor3 = Theme.color("DarkenBackground"),
                Size = UDim2.new(1, 0, 1, 0),
                Parent = module.ClippingShield
            })
        end

        local var20 = Theme.MenuContainerPosition(module.SettingsUIDelegate)
        module.MenuContainer = Create("ImageButton")({
            Name = "MenuContainer",
            ZIndex = module.Shield.ZIndex,
            BackgroundTransparency = Theme.transparency("MenuContainer", 1),
            BackgroundColor3 = Theme.color("MenuContainer"),
            Position = var20.Position,
            Size = var20.Size,
            AnchorPoint = var20.AnchorPoint,
            AutomaticSize = var20.AutomaticSize,
            Parent = module.Shield
        })
        module.ReactPage.Parent = module.MenuContainer

        module.Page = Create("Frame")(
            {
                Name = "Page",
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                Parent = module.MenuContainer
            }
        )
        module.Page.SelectionGroup = true
        module.Page.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        module.Page.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        module.Page.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
        module.Page.SelectionBehaviorRight = Enum.SelectionBehavior.Stop

        local page = module.Page
        module.MenuContainerPadding = Create("UIPadding")({ Parent = page })

        if not var1 then
            local _guiInsetY = GuiService:GetGuiInset().Y

            module.MenuContainerPadding.PaddingTop = UDim.new(0, 0)
        end

        local var21 = Theme.HubPadding()
        module.MenuContainer.AutoButtonColor = false
        module.MenuContainerPadding.PaddingLeft = var21.PaddingLeft
        module.MenuContainerPadding.PaddingRight = var21.PaddingRight
        module.MenuContainerPadding.PaddingBottom = var21.PaddingBottom
        module.MenuContainerPadding.PaddingTop = var21.PaddingTop

        Create("UICorner")({ CornerRadius = Theme.MenuContainerCornerRadius, Parent = module.MenuContainer })

        getCamMicPermissions(function(arg1)
            module.hasMicPermissions = arg1.hasMicPermissions
            module.isFetchingMicPermissions = false
        end, nil, true)

        module.SettingsShowSignal:connect(function(arg1)
            if not arg1 then
                return
            end

            if default:IsSeamlessVoice() and not default.voiceUIVisible then
                if tbl1.FFlagVoiceRewarmTelemetry then
                    local var22, var23, var24, var25 = default:GetConnectDisconnectButtonAnalyticsData(true)
                    default.Analytics:reportJoinVoiceButtonEventWithVoiceSessionId(
                        "shown",
                        var22,
                        var23,
                        var24,
                        var25,
                        default.joinVoiceButtonContext
                    )
                else
                    default.Analytics:reportJoinVoiceButtonEventWithVoiceSessionId(
                        "shown",
                        default:GetConnectDisconnectButtonAnalyticsData(true)
                    )
                end
            elseif default:IsSeamlessVoice() and default.voiceUIVisible then
                default.Analytics:reportLeaveVoiceButtonEvent("shown", default:GetConnectDisconnectButtonAnalyticsData(true))
            end

            if default:UserVoiceEnabled() and module.isFetchingMicPermissions then
                return
            end

            if not default:UserOnlyEligibleForVoice() and (not default:UserVoiceEnabled() or module.hasMicPermissions) then
            end
        end)

        module.MenuListLayout = Create("UIListLayout")({
            Name = "MenuListLayout",
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = page
        })

        module.HubBar = Create("ImageLabel")({
            Name = "HubBar",
            BackgroundColor3 = Theme.color("HubBarContainer"),
            BackgroundTransparency = Theme.transparency("HubBarContainerTransparency"),
            ZIndex = module.Shield.ZIndex + 1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0),
            LayoutOrder = 0,
            Parent = page
        })

        if not isSideSheetEnabled then
            Create("Frame")({
                BackgroundColor3 = Theme.color("Divider"),
                BackgroundTransparency = Theme.transparency("Divider"),
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                Parent = module.HubBar
            })
        end

        if isSideSheetEnabled then
            module.PageTitleHeader = Create("Frame")({
                Name = "PageTitleHeader",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                LayoutOrder = 0,
                Parent = module.HubBar,
                ZIndex = module.Shield.ZIndex + 1
            })

            Create("UIPadding")({ PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = module.PageTitleHeader })

            module.PageTitleLabel = Create("TextLabel")({
                Name = "Title",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -36, 0, 0),
                Position = UDim2.new(0, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = Enum.AutomaticSize.Y,
                Text = "",
                TextXAlignment = Enum.TextXAlignment.Left,
                TextColor3 = Color3.new(1, 1, 1),
                Font = Theme.font(Enum.Font.SourceSansBold, "Confirmation"),
                FontSize = Theme.fontSize(Enum.FontSize.Size36, "Confirmation"),
                Parent = module.PageTitleHeader
            })
        end

        module.HubBarListLayout = Create("UIListLayout")({
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = module.HubBar
        })

        if not tbl1.FFlagAddTraversalBackButton then
            if tbl1.EngineFeatureTeleportHistoryButtons then
                module.BackBarRef = Roact.createRef()
                module.FrontBarRef = Roact.createRef()
                module.BackBar = Roact.createElement(RoactAppExperiment.Provider, {
                    value = IXPService
                }, {
                    AppStyleProvider = Roact.createElement(AppStyleProvider, {
                        style = { themeName = Dark }
                    }, {
                        ButtonsFrame = Roact.createElement(
                            "Frame",
                            {
                                BackgroundTransparency = 1,
                                LayoutOrder = -1,
                                AutomaticSize = Enum.AutomaticSize.Y,
                                Size = UDim2.new(1, 0, 0, 0)
                            },
                            {
                                BackButton = Roact.createElement(MenuBackButton, { BackBarRef = module.BackBarRef, HubBar = module.HubBar, LayoutOrder = 1 }),
                                FrontButton = Roact.createElement(MenuFrontButton, { FrontBarRef = module.FrontBarRef, HubBar = module.HubBar, LayoutOrder = 2 })
                            }
                        )
                    })
                })

                Roact.mount(module.BackBar, page, "BackBar")
            else
                module.BackBarRef = Roact.createRef()
                module.BackBar = Roact.createElement(RoactAppExperiment.Provider, {
                    value = IXPService
                }, {
                    AppStyleProvider = Roact.createElement(
                        AppStyleProvider,
                        {
                            style = { themeName = Dark }
                        },
                        {
                            BackButton = Roact.createElement(MenuBackButton, { BackBarRef = module.BackBarRef, HubBar = module.HubBar })
                        }
                    )
                })
                Roact.mount(module.BackBar, page, "BackBar")
            end
        end

        if Utility:IsSmallTouchScreen() then
            module.HubBar.Size = UDim2.new(0, RobloxGui.AbsoluteSize.X - 100, 0, 50)
            module.HubBar.Position = UDim2.new(0.5, 0, 0, 6)
        elseif var1 then
            module.HubBar.Size = UDim2.new(0, 1200, 0, 100)
            module.HubBar.Position = UDim2.new(0.5, 0, 0.1, 0)
        else
            module.HubBar.Size = UDim2.new(0, 800, 0, 60)
            module.HubBar.Position = UDim2.new(0.5, 0, 0.1, 0)
        end

        local tbl3 = module
        tbl3.VoiceRecordingIndicatorFrame = Create("Frame")({
            Size = if tbl1.ChromeEnabled then UDim2.new(1, 0, 0, 100) else UDim2.fromOffset(0, 100),
            Position = UDim2.new(0, 0, 0, 0),
            Parent = module.HubBar,
            BackgroundTransparency = 1
        })

        module.VoiceRecordingText = Create("TextLabel")({
            Parent = module.VoiceRecordingIndicatorFrame,
            Text = "",
            Visible = false,
            Position = UDim2.new(0, 60, 0, 0),
            TextSize = 12,
            Font = AppFonts.default:getMedium(),
            Size = UDim2.fromScale(1, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1
        })

        if Utility:IsSmallTouchScreen() then
            module.VoiceRecordingText.Size = UDim2.fromScale(1, 1)
            module.VoiceRecordingText.AnchorPoint = Vector2.new(0, 0)
            if tbl1.ChromeEnabled then
                module.VoiceRecordingText.TextXAlignment = Enum.TextXAlignment.Right
                module.VoiceRecordingText.Position = UDim2.new(0, 0, 0, -60)
            else
                module.VoiceRecordingText.Position = UDim2.new(0, 60, 0, -60)
            end
        elseif var1 then
            module.VoiceRecordingText.AnchorPoint = Vector2.new(0, 1)
            if tbl1.ChromeEnabled then
                module.VoiceRecordingText.TextXAlignment = Enum.TextXAlignment.Right
                module.VoiceRecordingText.Size = UDim2.new(1, 0, 0, 100)
                module.VoiceRecordingText.Position = UDim2.new(0, 0, 0.1, 0)
            else
                module.VoiceRecordingText.Size = UDim2.new(0, 1200, 0, 100)
                module.VoiceRecordingText.Position = UDim2.new(0.5, 0, 0.1, 0)
            end
        else
            module.VoiceRecordingText.AnchorPoint = Vector2.new(0, 1)
            if tbl1.ChromeEnabled then
                module.VoiceRecordingText.TextXAlignment = Enum.TextXAlignment.Right
                module.VoiceRecordingText.Size = UDim2.new(1, 0, 0, 60)
                module.VoiceRecordingText.Position = UDim2.new(0, 0, 0.1, 0)
            else
                module.VoiceRecordingText.Size = UDim2.new(0, 800, 0, 60)
                module.VoiceRecordingText.Position = UDim2.new(0.5, 0, 0.1, 0)
            end
        end

        module.voiceRecordingIndicatorTextMotor = Otter.createSingleMotor(0)
        module.voiceRecordingIndicatorTextMotor:onStep(function(textTransparency)
            module.VoiceRecordingText.TextTransparency = textTransparency
        end)

        spawn(function()
            RunService:BindToRenderStep("VoiceRecordingIndicator", 1, function()
                if module.isMuted ~= nil
                    and module.lastVoiceRecordingIndicatorTextUpdated ~= nil
                    and tick() - module.lastVoiceRecordingIndicatorTextUpdated >= 5
                    and module.isMuted
                then
                    module.voiceRecordingIndicatorTextMotor:setGoal(Otter.spring(1, tbl2))
                    module.voiceRecordingIndicatorTextMotor:start()
                end
            end)
        end)

        module.PageViewClipper = Create("Frame")({
            Name = "PageViewClipper",
            BackgroundTransparency = 1,
            Size = UDim2.new(
                module.HubBar.Size.X.Scale,
                module.HubBar.Size.X.Offset,
                1,
                -module.HubBar.Size.Y.Offset - module.HubBar.Position.Y.Offset - num3
            ),
            Position = UDim2.new(
                module.HubBar.Position.X.Scale,
                module.HubBar.Position.X.Offset,
                module.HubBar.Position.Y.Scale,
                module.HubBar.Position.Y.Offset + module.HubBar.Size.Y.Offset + 1
            ),
            AnchorPoint = Vector2.new(0.5, 0),
            ClipsDescendants = true,
            LayoutOrder = 1,
            Parent = page,
            SelectionGroup = true,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Escape,
            SelectionBehaviorUp = Enum.SelectionBehavior.Escape
        })

        if tbl1.FFlagEnableConsoleExpControls and tbl1.ChromeEnabled then
            module.PageViewPadding = Create("UIPadding")({ Parent = module.PageViewClipper })

            local service = require(RobloxGui.Modules.Chrome.Service)
            service:onShortcutBarChanged():connect(function()
                if Utility:IsSmallTouchScreen() and service:getCurrentShortcutBar():get() ~= nil then
                    module.PageViewPadding.PaddingBottom = UDim.new(0, Theme.ExtraPageBottomPaddingMobile)
                    return
                end
                module.PageViewPadding.PaddingBottom = UDim.new(0, 0)
            end)
        end

        module.PageView = Create("ScrollingFrame")({
            Name = "PageView",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 2),
            Size = UDim2.new(1, 0, 1, -20),
            CanvasSize = UDim2.new(1, 0, 1, 0),
            ZIndex = module.Shield.ZIndex,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Selectable = false,
            ScrollBarThickness = Theme.DefaultScrollBarThickness,
            Parent = module.PageViewClipper
        })
        module.PageView.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

        module.PageViewInnerFrame = Create("Frame")({
            Name = "PageViewInnerFrame",
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = module.Shield.ZIndex,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Selectable = false,
            Parent = module.PageView,
            LayoutOrder = 1
        })

        Create("UIPadding")({ PaddingTop = UDim.new(0, 5), Parent = module.PageViewInnerFrame })

        module.InnerCanvasGroupShow = Create("CanvasGroup")({
            Name = "InnerCanvasGroupShow",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            GroupTransparency = 0,
            Visible = false,
            Parent = module.PageViewInnerFrame
        })

        module.InnerCanvasGroupHide = Create("CanvasGroup")({
            Name = "InnerCanvasGroupHide",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            GroupTransparency = 0,
            Visible = false,
            Parent = module.PageViewInnerFrame
        })

        if UserInputService.MouseEnabled then
            module.PageViewClipper.Size = UDim2.new(
                module.HubBar.Size.X.Scale,
                module.HubBar.Size.X.Offset,
                0.5,
                -(module.HubBar.Position.Y.Offset - module.HubBar.Size.Y.Offset)
            )
        end
        module.BottomButtonFrame = Create("Frame")({
            Name = "BottomButtonFrame",
            Size = module.HubBar.Size,
            Position = UDim2.new(
                0.5,
                -module.HubBar.Size.X.Offset / 2,
                1 - module.HubBar.Position.Y.Scale - module.HubBar.Size.Y.Scale,
                -module.HubBar.Position.Y.Offset - module.HubBar.Size.Y.Offset
            ),
            ZIndex = module.Shield.ZIndex + 1,
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Parent = page,
            Selectable = false,
            SelectionGroup = true,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        })
        module.BottomButtonFrame:GetPropertyChangedSignal("Visible"):Connect(function()
            module.setShowBottomBarSignal(module.BottomButtonFrame.Visible)
        end)

        local function func1(source)
            if tbl1.FFlagAddUILessMode then
                setVisibilityInternal(false, nil, nil, nil, source)
            else
                setVisibilityInternal(false)
            end

            if tbl1.FFlagAddUILessMode and tbl1.FIntAddUILessModeVariant ~= 0 and module.uiLessStore.getUILessModeEnabled(false) then
                module.uiLessStore.setUIVisible(false)
            end

            RbxAnalyticsService:SetRBXEventStream(
                Constants.AnalyticsTargetName,
                Constants.AnalyticsResumeGameName,
                Constants.AnalyticsMenuActionName,
                {
                    source = source,
                    playsessionid = module.playSessionId,
                    universeid = tostring(game.GameId)
                }
            )
            GuiService.SelectedCoreObject = nil
        end

        if isSideSheetEnabled then
            module.PageTitleCloseButton = Utility:MakeStyledImageButton(
                "PageTitleClose",
                "rbxasset://textures/ui/InspectMenu/x.png",
                UDim2.new(0, 40, 0, 40),
                UDim2.new(0, 16, 0, 16),
                function()
                    func1(Constants.AnalyticsResumeXButtonSource)
                end,
                nil,
                module,
                "DefaultButton"
            )
            module.PageTitleCloseButton.AnchorPoint = Vector2.new(1, 0.5)
            module.PageTitleCloseButton.Position = UDim2.new(1, 0, 0.5, 0)

            local border = module.PageTitleCloseButton:FindFirstChild("Border")
            if border then
                border.Parent = nil
            end

            module.PageTitleCloseButton.Parent = module.PageTitleHeader
        end

        if not tbl1.FFlagMenuButtonsMountWithIEM
            and tbl1.FFlagRelocateMobileMenuButtons
            and (tbl1.FIntRelocateMobileMenuButtonsVariant == 1
                or tbl1.FIntRelocateMobileMenuButtonsVariant == 3
                or tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and not Utility:IsSmallTouchScreen())
        then
            var16()
        end

        if not tbl1.FFlagRelocateMobileMenuButtons
            or tbl1.FIntRelocateMobileMenuButtonsVariant == 0
            or tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and Utility:IsSmallTouchScreen()
        then
            module.BottomButtonFrame.Size = UDim2.new(1, 0, 0, 80)
        end

        module.MenuListLayout = Create("UIListLayout")({
            Padding = UDim.new(0, 12),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = module.BottomButtonFrame
        })

        if tbl1.FFlagEnableSystemScrimInSettingsHub then
            local var22 = require(CorePackages.Workspace.Packages.SystemScrim).SystemScrimSignalStore(false)
            var22.backgroundScrimActivated.Event:Connect(function()
                if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                    module:GetExperienceControlStore().onResume(Constants.AnalyticsResumeShieldSource)
                    return
                end
                func1(Constants.AnalyticsResumeShieldSource)
            end)

            module.Shield:GetPropertyChangedSignal("Visible"):Connect(function()
                var22.setTransparency(1)
                var22.setAutoDismiss(true)
                var22.setVisibility(module.Shield.Visible)
            end)
        end

        module.Shield.Activated:Connect(function()
            if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                module:GetExperienceControlStore().onResume(Constants.AnalyticsResumeShieldSource)
                return
            end
            func1(Constants.AnalyticsResumeShieldSource)
        end)

        if tbl1.FFlagSettingsHubIndependentBackgroundVisibility then
            module.DarkenBackground.Activated:Connect(function()
                if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                    module:GetExperienceControlStore().onResume(Constants.AnalyticsResumeShieldSource)
                else
                    func1(Constants.AnalyticsResumeShieldSource)
                end
                InExperienceAppChatModal.default:setVisible(false)
            end)
        end

        if not tbl1.FFlagRelocateMobileMenuButtons or tbl1.FIntRelocateMobileMenuButtonsVariant == 0 then
            local function func2()
                if tbl1.FFlagPreventHiddenSwitchPage and module:GetVisibility() == false then
                    return
                end

                module:AddToMenuStack(module.Pages.CurrentPage)
                module.HubBar.Visible = false
                removeBottomBarBindings()
                if tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() and module.leaveGameUpsellProp ~= Constants2.PHONE_UPSELL_VALUE_PROP.None then
                    module:SwitchToPage(module.LeaveGameUpsellPage, nil, 1, true)
                    return
                end
                module:SwitchToPage(module.LeaveGamePage, nil, 1, true)
            end

            if InExperienceCapabilities.canNavigateHome then
                addBottomBarButtonOld(
                    "LeaveGame",
                    "Leave",
                    var9,
                    "rbxasset://textures/ui/Settings/Help/LeaveIcon.png",
                    UDim2.new(0.5, if var1 then -160 else -130, 0.5, -25),
                    func2,
                    { Enum.KeyCode.L, if tbl1.FFlagEnableConsoleExpControls and tbl1.ChromeEnabled then nil else Enum.KeyCode.ButtonX },
                    func2
                )
            end

            local function func3()
                if bool7 then
                    module:AddToMenuStack(module.Pages.CurrentPage)
                    module.HubBar.Visible = false
                    removeBottomBarBindings()
                    module:SwitchToPage(module.ResetCharacterPage, nil, 1, true)
                end
            end

            local var22 = localization:Format(Constants.RespawnLocalizedKey)
            addBottomBarButtonOld(
                "ResetCharacter",
                var22,
                var10,
                "rbxasset://textures/ui/Settings/Help/ResetIcon.png",
                UDim2.new(0.5, if var1 then -550 else -400, 0.5, -25),
                func3,
                { Enum.KeyCode.R, if tbl1.FFlagEnableConsoleExpControls and tbl1.ChromeEnabled then nil else Enum.KeyCode.ButtonY },
                func3
            )

            local function func4()
                func1(Constants.AnalyticsResumeButtonSource)
            end
            local function func5()
                func1(Constants.AnalyticsResumeGamepadSource)
            end
            addBottomBarButtonOld(
                "Resume",
                "Resume",
                if tbl1.FFlagEnableConsoleExpControls then contentId else var8,
                "rbxasset://textures/ui/Settings/Help/EscapeIcon.png",
                UDim2.new(0.5, if var1 then 200 else 140, 0.5, -25),
                func4,
                tbl1.FFlagEnableConsoleExpControls and tbl1.ChromeEnabled and {} or { Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart },
                func5
            )
        end

        if tbl1.FFlagAddSwitchTabHintsToIEM then
            local function MountSwitchTabHint(tbl4)
                local var22 = Create("Frame")({
                    Name = "SwitchTabHintContainer",
                    Size = UDim2.fromScale(0, 1),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.X,
                    LayoutOrder = tbl4.layoutOrder,
                    Parent = tbl4.parent
                })

                local root = ReactRoblox.createRoot(var22)
                local createElement = React.createElement
                local fragment = React.Fragment
                local element = React.createElement("UIListLayout", {
                    Name = "SwitchTabHintCenterAlign",
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                })
                local createElement2 = React.createElement
                local var23 = FoundationProvider
                local tbl5 = {
                    colorMode = Foundation.Enums.ColorMode.Dark,
                    device = Utils.getDeviceType()
                }
                local tbl6 = {
                    ["SwitchTabHint" .. tbl4.keycode.Name] = React.createElement(SwitchTabHint, { keycode = tbl4.keycode })
                }
                root:render(createElement(fragment, nil, element, createElement2(var23, tbl5, tbl6)))
            end

            module.TabHeaderContainer = Create("Frame")({
                Name = "TabHeaderContainer",
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Parent = module.HubBar,
                Visible = not isSideSheetEnabled
            })

            module.TabHeaderContainerListLayout = Create("UIListLayout")({
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = module.TabHeaderContainer
            })

            MountSwitchTabHint({ keycode = Enum.KeyCode.ButtonL1, parent = module.TabHeaderContainer, layoutOrder = -999 })

            MountSwitchTabHint({ keycode = Enum.KeyCode.ButtonR1, parent = module.TabHeaderContainer, layoutOrder = 999 })
        end

        local tbl4 = module
        tbl4.HubBarContainer = Create("ImageLabel")({
            Name = "HubBarContainer",
            ZIndex = module.Shield.ZIndex + 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Theme.color("HubBarContainer"),
            BackgroundTransparency = Theme.transparency("HubBarContainerTransparency"),
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Parent = if tbl1.FFlagAddSwitchTabHintsToIEM then module.TabHeaderContainer else module.HubBar,
            Selectable = not tbl1.FFlagIEMTabFocusNav and nil,
            SelectionGroup = if tbl1.FFlagIEMTabFocusNav then true else nil,
            SelectionBehaviorUp = if tbl1.FFlagIEMTabFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorLeft = if tbl1.FFlagIEMTabFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorRight = if tbl1.FFlagIEMTabFocusNav then Enum.SelectionBehavior.Stop else nil
        })

        module.HubBar.ImageTransparency = 1
        module.HubBarListLayout.Parent = module.HubBarContainer

        if isSubjectToDesktopPolicies() then
            module.FullScreenTitleBar = SettingsFullScreenTitleBar.mount({}, module.Shield, "FullScreenTitleBar")
        end

        local function cameraViewportChanged() -- Luacid: Inlined by compiler; 2 call sites recovered
            Theme.viewportResized()
            Utility:FireOnResized()
        end

        local connection5 = nil
        local function onWorkspaceChanged(property: string)
            if property ~= "CurrentCamera" then
                return
            end

            cameraViewportChanged()

            if connection5 then
                connection5:disconnect()
            end

            connection5 = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(cameraViewportChanged)
        end

        cameraViewportChanged()

        if connection5 then
            connection5:disconnect()
        end

        connection5 = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(cameraViewportChanged)

        workspace.Changed:Connect(onWorkspaceChanged)
    end

    local function resizeBottomBarButtons()
        local absoluteSizeX = module.BottomButtonFrame.AbsoluteSize.X

        local bottomBarButtonsLen = #module.BottomBarButtons
        if bottomBarButtonsLen == 4 then
            absoluteSizeX = absoluteSizeX - 48 - 12
            bottomBarButtonsLen -= 1
        end

        local xOffset = (absoluteSizeX - (bottomBarButtonsLen - 1) * 12 - 12) / bottomBarButtonsLen
        if tbl1.isInExperienceUIVREnabled then
            xOffset = module.SettingsUIDelegate:getBottomButtonSize(xOffset)
        end
        for i = 1, #module.BottomBarButtons do
            local bottomBarButton = module.BottomBarButtons[i]
            local var18 = bottomBarButton[1]

            if var18 ~= "MuteButtonButton" then
                module[var18].Size = UDim2.fromOffset(xOffset, module[bottomBarButton[1]].Size.Y.Offset)
            end
        end
    end

    local function isSideSheetPairedWithPeoplePage() -- Luacid: Inlined by compiler; 31 call sites recovered
        return FFlagSideSheetOpenPeoplePage and getDidSideSheetOpenWithPeoplePage()
    end

    local function shouldAndroidBackUseSideSheet() -- Luacid: Inlined by compiler; 1 call site recovered
        return FFlagSideSheetOpenPeoplePage and (getSideSheetVisibility() or getHasRoomForPeoplePage())
    end

    local function shouldUseSideSheetPeoplePageLayout() -- Luacid: Inlined by compiler; 20 call sites recovered
        return isSideSheetPairedWithPeoplePage() and getSideSheetVisibility() and getIsPeoplePageOpen()
    end

    local function shouldShowSettingsHubModal(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return module.Visible and not shouldUseSideSheetPeoplePageLayout()
    end

    local function getShieldOpenTweenTime(num3: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if not (isSideSheetPairedWithPeoplePage() and getSideSheetVisibility()) then
            return num3
        end

        return getSideSheetAnimationDuration()
    end

    local function shouldCloseShieldWithSideSheet(bool8: boolean?) -- Luacid: Inlined by compiler; 9 call sites recovered
        if bool8 ~= nil then
            return bool8
        end

        return (shouldUseSideSheetPeoplePageLayout())
    end

    local function getShieldCloseTweenTime(num3: number, bool8: boolean?) -- Luacid: Inlined by compiler; 2 call sites recovered
        if not shouldCloseShieldWithSideSheet(bool8) then
            return num3
        end

        return getSideSheetAnimationDuration()
    end

    local function getSideSheetMenuInset() -- Luacid: Inlined by compiler; 8 call sites recovered
        if not shouldCloseShieldWithSideSheet(nil) then
            return 0
        end

        return getSideSheetDrawerWidth()
    end

    local function constrainMenuWidthForSideSheet(num3: number): number -- Luacid: Inlined by compiler; 4 call sites recovered
        local sideSheetMenuInset = getSideSheetMenuInset()

        if sideSheetMenuInset <= 0 then
            return num3
        end

        local var18 = Theme.HubPadding()
        return math.max(
            150,
            math.min(
                num3,
                (getSideSheetMenuPageWidth(
                    RobloxGui.AbsoluteSize.X,
                    sideSheetMenuInset,
                    var18.PaddingLeft.Offset + var18.PaddingRight.Offset
                ))
            )
        )
    end
    local function getSideSheetMenuReservedHeight(num3: number, num4: number) -- Luacid: Inlined by compiler; 1 call site recovered
        local var18 = Theme.HubPadding()
        return num3 + var18.PaddingTop.Offset + var18.PaddingBottom.Offset + num4
    end

    local function applySideSheetLayoutToMenuContainer(uDim2_3: UDim2, vector2_2: Vector2): (UDim2 | UDim2, Vector2 | Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
        local sideSheetMenuInset = getSideSheetMenuInset()

        if sideSheetMenuInset <= 0 then
            return uDim2_3, vector2_2
        end

        local var18 = sideSheetMenuInset / 2

        return UDim2.new(uDim2_3.X.Scale, uDim2_3.X.Offset + var18, 0.5, 0), Vector2.new(vector2_2.X, 0.5)
    end

    local function onScreenSizeChanged()
        if FFlagClosePeoplePageWhenNoRoomBesideSideSheet
            and shouldCloseShieldWithSideSheet(nil)
            and closePeoplePageWhenNoRoomBesideSideSheet(RobloxGui.AbsoluteSize.X)
        then
            return
        end

        local function getBackBarVisible() -- Luacid: Inlined by compiler; 2 call sites recovered
            return if module.BackBarRef:getValue() then module.BackBarRef:getValue().Visible else false
        end

        local function getFrontBarVisible() -- Luacid: Inlined by compiler; 2 call sites recovered
            return if module.FrontBarRef:getValue() then module.FrontBarRef:getValue().Visible else false
        end

        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and module.Visible then
            if not (Utility:IsPortrait() or Utility:IsSmallTouchScreen()) or Theme.AlwaysShowBottomBar() then
                if not module.BottomButtonFrameRoot then
                    var16()
                end
                if module.PlayersPage then
                    module.PlayersPage:UnmountMenuButtonsContainer()
                end
            else
                if module.BottomButtonFrameRoot then
                    var17()
                end
                if module.PlayersPage then
                    module.PlayersPage:CreateMenuButtonsContainer()
                end
            end
        end

        local var18 = Theme.MenuContainerPosition(module.SettingsUIDelegate)
        local num3 = 600
        local var19 = if tbl1.isInExperienceUIVREnabled then module.SettingsUIDelegate:getFullScreenSize() else RobloxGui.AbsoluteSize.y
        local yOffset2 = 0.050000000000000044 * var19
        local isPortrait = Utility:IsPortrait()

        if var1 then
            yOffset2 = 0.07 * var19
            num3 = 800
        elseif Utility:IsSmallTouchScreen() then
            yOffset2 = math.min(10, 0.010000000000000009 * var19)
        elseif tbl1.isInExperienceUIVREnabled and VRService.VREnabled then
            yOffset2 = 0
        end

        local var20, anchorPoint = applySideSheetLayoutToMenuContainer(var18.Position, var18.AnchorPoint)
        module.MenuContainer.Size = var18.Size
        module.MenuContainer.Position = var20
        module.MenuContainer.AnchorPoint = anchorPoint

        local offset = module.HubBar.Size.Y.Offset
        local _ = yOffset2 * 2 + offset * 2

        local num4 = 0
        if not tbl1.FFlagAddTraversalBackButton then
            if getBackBarVisible() and module.BackBarRef:getValue() then
                num4 = module.BackBarRef:getValue().Size.Y.Offset
            end

            if tbl1.EngineFeatureTeleportHistoryButtons and getFrontBarVisible() and module.FrontBarRef:getValue() then
                num4 += module.FrontBarRef:getValue().Size.Y.Offset
            end
        end

        if isPortrait then
            module.HubBar.Position = UDim2.new(0.5, 0, 0, 10)
            module.HubBar.Size = UDim2.new(0, constrainMenuWidthForSideSheet(RobloxGui.AbsoluteSize.X - 40), 0, 54)
        elseif var1 then
            module.HubBar.Size = UDim2.new(0, 1200, 0, 100)
        elseif Utility:IsSmallTouchScreen() then
            module.HubBar.Size = UDim2.new(0, constrainMenuWidthForSideSheet(RobloxGui.AbsoluteSize.X - 60), 0, 52)
        elseif tbl1.isInExperienceUIVREnabled then
            module.HubBar.Size = UDim2.new(0, constrainMenuWidthForSideSheet((module.SettingsUIDelegate:getHubBarSize())), 0, 60)
        else
            module.HubBar.Size = UDim2.new(0, constrainMenuWidthForSideSheet(800), 0, 60)
        end

        local var22 = if isSideSheetEnabled or not Theme.AlwaysShowBottomBar() then module.HubBar.Size.Y.Offset else module.HubBar.Size.Y.Offset + module.BottomButtonFrame.Size.Y.Offset
        local var23 = yOffset2 * 2 + (if tbl1.FFlagFixDisableTopPaddingError and module.Pages.CurrentPage == nil then var22 elseif module.Pages.CurrentPage.DisableTopPadding then 0 else var22)
        if not tbl1.FFlagAddTraversalBackButton then
            num4 = if getBackBarVisible() then if module.BackBarRef:getValue() then module.BackBarRef:getValue().Size.Y.Offset else 0 else 0

            if tbl1.EngineFeatureTeleportHistoryButtons and getFrontBarVisible() and module.FrontBarRef:getValue() then
                num4 += module.FrontBarRef:getValue().Size.Y.Offset
            end
        end

        RunService.Heartbeat:wait()

        if shouldShowBottomBar() then
            setBottomBarBindings()
            setBottomBarSelection(module.Pages.CurrentPage)
        else
            removeBottomBarBindings()
        end

        if tbl1.isInExperienceUIVREnabled then
            var23 += module.SettingsUIDelegate:getMenuContainerExtraSpace()
        end

        local yOffset3 = var19 - var23 - num4

        if tbl1.FFlagRelocateMobileMenuButtons
            and (tbl1.FIntRelocateMobileMenuButtonsVariant == 1 or tbl1.FIntRelocateMobileMenuButtonsVariant == 3)
            and Utility:IsSmallTouchScreen()
        then
            yOffset3 -= Theme.ExtraHubBottomPaddingMobile
        end

        if shouldCloseShieldWithSideSheet(nil) then
            yOffset3 = getSideSheetMenuPageHeight(module.Shield.AbsoluteSize.Y, (getSideSheetMenuReservedHeight(var22, num4)))
        end

        if FFlagSideSheetOpenPeoplePage then
            local pageView = module.PageView
            pageView.VerticalScrollBarInset = if shouldCloseShieldWithSideSheet(nil) then Enum.ScrollBarInset.Always else Enum.ScrollBarInset.ScrollBar
        end

        if not isPortrait then
            if num3 < yOffset3 then
                module.HubBar.Position = UDim2.new(module.HubBar.Position.X.Scale, module.HubBar.Position.X.Offset, 0.5, -num3 / 2 - module.HubBar.Size.Y.Offset)

                if module.BottomButtonFrame then
                    module.BottomButtonFrame.Position = UDim2.new(module.BottomButtonFrame.Position.X.Scale, module.BottomButtonFrame.Position.X.Offset, 0.5, num3 / 2)
                    yOffset3 = num3
                else
                    yOffset3 = num3
                end
            elseif yOffset3 < 150 then
                yOffset3 = 150
                module.HubBar.Position = UDim2.new(module.HubBar.Position.X.Scale, module.HubBar.Position.X.Offset, 0.5, -75 - module.HubBar.Size.Y.Offset)

                if module.BottomButtonFrame then
                    module.BottomButtonFrame.Position = UDim2.new(module.BottomButtonFrame.Position.X.Scale, module.BottomButtonFrame.Position.X.Offset, 0.5, 75)
                end
            else
                module.HubBar.Position = UDim2.new(module.HubBar.Position.X.Scale, module.HubBar.Position.X.Offset, 0, yOffset2)

                if module.BottomButtonFrame then
                    module.BottomButtonFrame.Position = UDim2.new(module.BottomButtonFrame.Position.X.Scale, module.BottomButtonFrame.Position.X.Offset, 1, -(yOffset2 + var22))
                end
            end
        end

        local var24

        if var1 then
            var24 = UDim2.new(0, module.HubBar.AbsoluteSize.X, 0, yOffset3)
        elseif Utility:IsSmallTouchScreen() then
            if tbl1.FFlagRelocateMobileMenuButtons
                and (tbl1.FIntRelocateMobileMenuButtonsVariant == 1 or tbl1.FIntRelocateMobileMenuButtonsVariant == 3)
            then
                var24 = UDim2.new(0, module.HubBar.AbsoluteSize.X, 0, yOffset3 + 0 + 0 - module.BottomButtonFrame.Size.Y.Offset)
            else
                var24 = UDim2.new(0, module.HubBar.AbsoluteSize.X, 0, yOffset3 + 0 + 0)
            end
        else
            var24 = UDim2.new(0, module.HubBar.AbsoluteSize.X, 0, yOffset3)
        end

        if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 and module.BottomButtonFrame then
            module.BottomButtonFrame.Size = UDim2.new(0, module.HubBar.Size.X.Offset, 0, module.HubBar.Size.Y.Offset)
        end

        local var25 = Theme.HubPadding()
        local var26 = var25.PaddingLeft.Offset + var25.PaddingRight.Offset
        local var27 = var25.PaddingTop.Offset + var25.PaddingBottom.Offset
        module.ReactPage.Size = UDim2.new(0, module.HubBar.AbsoluteSize.X + var26, 0, yOffset3 + var22 + var27)

        module.PageViewClipper.Size = var24
        if not isPortrait then
            module.PageViewClipper.Position = UDim2.new(module.PageViewClipper.Position.X.Scale, module.PageViewClipper.Position.X.Offset, 0.5, -yOffset3 / 2)
            return
        end

        module.PageViewClipper.Position = UDim2.new(0.5, 0, 0, module.HubBar.Position.Y.Offset + module.HubBar.AbsoluteSize.Y)
    end

    if FFlagSideSheetOpenPeoplePage then
        local function scheduleSideSheetPeoplePageLayoutRefresh()
            if isSideSheetPairedWithPeoplePage() and not getSideSheetVisibility() and getIsPeoplePageOpen() then
                return
            end

            local selectionBehavior = if shouldCloseShieldWithSideSheet(nil) then Enum.SelectionBehavior.Escape else Enum.SelectionBehavior.Stop

            if module.Modal then
                module.Modal.Visible = shouldShowSettingsHubModal()
            end
            if module.Page then
                module.Page.SelectionBehaviorLeft = selectionBehavior
            end
            if module.PageViewClipper then
                module.PageViewClipper.SelectionBehaviorLeft = selectionBehavior
            end
            if module._sideSheetLayoutRefreshScheduled then
                return
            end

            module._sideSheetLayoutRefreshScheduled = true
            task.defer(function()
                module._sideSheetLayoutRefreshScheduled = false
                if module.Visible and module.MenuContainer then
                    onScreenSizeChanged()
                end
            end)
        end

        module._sideSheetLayoutEffectDispose = Signals.createEffect(function(arg1)
            getSideSheetVisibility(arg1)
            getSideSheetDrawerWidth(arg1)
            getIsPeoplePageOpen(arg1)
            getDidSideSheetOpenWithPeoplePage(arg1)
            scheduleSideSheetPeoplePageLayoutRefresh()
        end)
    end

    local function onPreferredTransparencyChanged() -- Luacid: Inlined by compiler; 5 call sites recovered
        module.MenuContainer.BackgroundTransparency = Theme.transparency("MenuContainer", 1) * GuiService.PreferredTransparency
    end

    local function toggleQuickProfilerFromHotkey(arg1, userInputState, _)
        if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
            return
        end

        if arg1 == "Show Quick Profiler" and userInputState and userInputState == Enum.UserInputState.Begin then
            GameSettings.PerformanceStatsVisible = not GameSettings.PerformanceStatsVisible
        end
    end

    local function toggleDevConsole(arg1, userInputState, _)
        if arg1 == "Open Dev Console" and userInputState and userInputState == Enum.UserInputState.Begin then
            DevConsoleMaster:ToggleVisibility()
        end
    end

    local bool8 = isEnabled

    local tbl3 = {
        [Enum.UserInputType.Gamepad1] = true,
        [Enum.UserInputType.Gamepad2] = true,
        [Enum.UserInputType.Gamepad3] = true,
        [Enum.UserInputType.Gamepad4] = true,
        [Enum.KeyCode.Left] = true,
        [Enum.KeyCode.Right] = true,
        [Enum.KeyCode.Up] = true,
        [Enum.KeyCode.Down] = true,
        [Enum.KeyCode.Tab] = true,
        [Enum.UserInputType.Touch] = false,
        [Enum.UserInputType.MouseButton1] = false,
        [Enum.UserInputType.MouseButton2] = false
    }

    UserInputService.InputBegan:connect(function(input: InputObject)
        if input.UserInputType and tbl3[input.UserInputType] ~= nil then
            bool8 = tbl3[input.UserInputType]
        elseif input.KeyCode and tbl3[input.KeyCode] then
            bool8 = tbl3[input.KeyCode]
        end
    end)
    UserInputService.InputChanged:connect(function(input: InputObject)
        if input.KeyCode == Enum.KeyCode.Thumbstick1 or input.KeyCode == Enum.KeyCode.Thumbstick2 then
            if input.Position.magnitude >= 0.25 then
                bool8 = true
            end
        elseif input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            bool8 = false
        end
    end)

    local GetHeaderPosition = nil

    local function func1(arg1, bool9: boolean)
        if tbl1.FFlagInExperienceReportClosingBugfix and not module.HubBar.Visible then
            return
        end
        local headerPosition = GetHeaderPosition(module.Pages.CurrentPage)
        if headerPosition < 0 then
            return
        end
        local var18 = headerPosition + arg1
        if bool9 then
            var18 = if #module.TabHeaders < var18 then 1 else var18 < 1 and #module.TabHeaders or var18
        end

        local tabHeader = module.TabHeaders[var18]

        if not tabHeader then
            return
        end

        for k, _ in pairs(module.Pages.PageTable) do
            if k:GetTabHeader() == tabHeader then
                module:SwitchToPage(k, true, arg1)
                return
            end
        end
    end

    local function func2(_, userInputState, arg1)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end
        local num3 = 0
        if arg1.KeyCode == Enum.KeyCode.ButtonR1 then
            num3 = 1
        elseif arg1.KeyCode == Enum.KeyCode.ButtonL1 then
            num3 = -1
        end

        func1(num3, true)
    end

    local function func3(input: InputObject)
        if input.KeyCode == Enum.KeyCode.Tab then
            local num3 = if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then -1 else 1

            func1(num3, true)
        end
    end

    local function func4(_, userInputState, arg1)
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end
        local num3 = 0
        if arg1.KeyCode == Enum.KeyCode.PageUp then
            num3 = -100
        elseif arg1.KeyCode == Enum.KeyCode.PageDown then
            num3 = 100
        end

        module:ScrollPixels(num3)
    end

    if tbl1.isInExperienceUIVREnabled or tbl1.FFlagEnableSettingsHubUIDelegateRollout then
        module.SettingsUIDelegate = require(RobloxGui.Modules.Settings.SettingsUIDelegate).new(module)
    end
    createGui()

    if bool4 then
        setupVoiceListeners()
    end

    GetHeaderPosition = function(arg1)
        local tabHeader = arg1:GetTabHeader()
        if not tabHeader then
            return -1
        end
        for k, tabHeader2 in pairs(module.TabHeaders) do
            if tabHeader2 == tabHeader then
                return k
            end
        end

        return -1
    end

    local function func5(zIndex, arg1)
        if not arg1:IsA("GuiObject") then
            return
        end

        arg1.ZIndex = zIndex
        local children = arg1:GetChildren()
        for i = 1, #children do
            func5(zIndex, children[i])
        end
    end

    local function AddHeader(tabHeader, arg1)
        if not tabHeader then
            return
        end
        table.insert(module.TabHeaders, tabHeader)
        arg1.TabPosition = #module.TabHeaders

        local xScale = 1 / #module.TabHeaders
        for i = 1, #module.TabHeaders do
            module.TabHeaders[i].Size = UDim2.new(xScale, 0, 1, 0)
        end

        func5(3, tabHeader)
        tabHeader.Parent = module.HubBarContainer
    end

    local function RemoveHeader(tabHeader)
        local var18 = nil

        for i = 1, #module.TabHeaders do
            if module.TabHeaders[i] == tabHeader then
                table.remove(module.TabHeaders, i)
                var18 = i
                break
            end
        end

        if var18 then
            for i = var18, #module.TabHeaders do
                local tabHeader2 = module.TabHeaders[i]
                tabHeader2.Position = UDim2.new(
                    tabHeader2.Position.X.Scale,
                    tabHeader2.Position.X.Offset - tabHeader.AbsoluteSize.X,
                    tabHeader2.Position.Y.Scale,
                    tabHeader2.Position.Y.Offset
                )
            end
        end
        tabHeader.Parent = nil
    end

    function module.AddPage(_, arg1)
        module.Pages.PageTable[arg1] = true
        AddHeader(arg1:GetTabHeader(), arg1)
        arg1.Page.Position = UDim2.new(arg1.TabPosition - 1, 0, 0, 0)
        arg1.LastSelectableObjectsUpdated:connect(function()
            setBottomBarSelection(arg1)
        end)
        if not tbl1.FFlagIEMTabFocusNav then
            return
        end

        setTabHeaderSelection(arg1)
        updateTabHeaderWrapping()

        arg1.FirstSelectableObjectsUpdated:connect(function()
            setTabHeaderSelection(arg1)
        end)
    end

    function module.RemovePage(_, arg1)
        module.Pages.PageTable[arg1] = nil
        RemoveHeader(arg1:GetTabHeader())
        arg1.LastSelectableObjectsUpdated:disconnect()
        if tbl1.FFlagIEMTabFocusNav then
            arg1.FirstSelectableObjectsUpdated:disconnect()
            updateTabHeaderWrapping()
        end
    end

    function module.HideBar(_)
        module.HubBar.Visible = false
        module.PageViewClipper.Visible = false
        if module.BottomButtonFrame then
            removeBottomBarBindings()
        end
    end

    function module.ShowBar(_)
        module.HubBar.Visible = true
        module.PageViewClipper.Visible = true
        if module.BottomButtonFrame and shouldShowBottomBar() then
            setBottomBarBindings()
            setBottomBarSelection(module.Pages.CurrentPage)
        end
    end

    function module.ScrollPixels(_, arg1)
        local canvasPositionY = module.PageView.CanvasPosition.Y
        local var18 = module.PageView.CanvasSize.Y.Offset - module.PageViewClipper.AbsoluteSize.y
        local y = math.max(0, math.min(canvasPositionY + arg1, var18))
        module.PageView.CanvasPosition = Vector2.new(0, y)
    end

    function module.ScrollToFrame(_, arg1, arg2)
        if not bool8 and not arg2 then
            return
        end

        local y = arg1.AbsolutePosition.y - module.Pages.CurrentPage.Page.AbsolutePosition.y
        local var18 = y + arg1.AbsoluteSize.y

        if y < module.PageView.CanvasPosition.y then
            module.PageView.CanvasPosition = Vector2.new(0, y)
        elseif module.Pages.CurrentPage.Page.Name == Constants.PeoplePageKey
            and var18 - module.PageView.CanvasPosition.y > module.PageView.AbsoluteSize.Y - Constants.PeoplePageScrollBuffer
        then
            module.PageView.CanvasPosition = Vector2.new(0, var18 - module.PageView.AbsoluteSize.Y + Constants.PeoplePageScrollBuffer)
        elseif var18 - module.PageView.CanvasPosition.y > module.PageViewClipper.Size.Y.Offset then
            module.PageView.CanvasPosition = Vector2.new(0, var18 - module.PageViewClipper.Size.Y.Offset)
        end
    end

    function module.GetFirstPageWithTabHeader(_)
        local var18 = nil
        for k, _ in pairs(module.Pages.PageTable) do
            if k:GetTabHeader() ~= nil and k.TabPosition == 1 then
                var18 = k
                break
            end
        end

        if var18 ~= nil then
            return var18
        end

        error("No page with tab header found")
        return nil
    end

    function module.InitInPage(_, currentPage)
        local tabPosition = currentPage.TabPosition
        for k, _ in pairs(module.Pages.PageTable) do
            if k ~= currentPage then
                k:Hide(-1, tabPosition, true, nil, module.PageViewInnerFrame)
            end
        end

        if (not tbl1.FFlagRelocateMobileMenuButtons
            or tbl1.FIntRelocateMobileMenuButtonsVariant == 0
            or tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and Utility:IsSmallTouchScreen())
            and module.BottomButtonFrame
        then
            if shouldShowBottomBar(currentPage) then
                setBottomBarBindings()
                setBottomBarSelection(currentPage)
            else
                module.BottomButtonFrame.Visible = false
            end

            module.HubBar.Visible = shouldShowHubBar(currentPage)
        end

        local clipsDescendants = currentPage.IsPageClipped == true
        module.PageViewClipper.ClipsDescendants = clipsDescendants
        module.PageView.ClipsDescendants = clipsDescendants

        module.PageViewInnerFrame.ClipsDescendants = clipsDescendants

        module.Pages.CurrentPage = currentPage
        module.Pages.CurrentPage.Active = true
        module.CurrentPageSignal:fire(if module.Pages.CurrentPage then module.Pages.CurrentPage.Page.Name or nil else nil)

        if isSideSheetEnabled then
            updatePageTitleHeader(module.Pages.CurrentPage)
        end

        local size = module.Pages.CurrentPage:GetSize()
        module.PageView.CanvasSize = UDim2.new(0, 0, 0, size.Y)

        connection2 = module.Pages.CurrentPage.Page.Changed:connect(function(arg1)
            if arg1 == "AbsoluteSize" then
                local size2 = module.Pages.CurrentPage:GetSize()
                module.PageView.CanvasSize = UDim2.new(0, 0, 0, size2.Y)
            end
        end)
    end

    function module.SwitchToPage(_, currentPage, arg1, arg2, arg3, _, arg4)
        if module.Pages.PageTable[currentPage] == nil or tbl1.FFlagPreventHiddenSwitchPage and module:GetVisibility() == false then
            return
        end

        if bool5 then
            if currentPage.Page.Name == "ReportAbuseMenuNewContainerPage" then
                module.PageViewInnerFrame.UIPadding.PaddingTop = UDim.new(0, 0)
            else
                module.PageViewInnerFrame.UIPadding.PaddingTop = UDim.new(0, 5)
            end
        end

        local uDim = UDim.new(0, 0)
        local uDim3 = UDim.new(0, 0)
        local var18 = not (Utility:IsPortrait() or Utility:IsSmallTouchScreen()) or Theme.AlwaysShowBottomBar()
        if tbl1.FFlagRelocateMobileMenuButtons
            and (tbl1.FIntRelocateMobileMenuButtonsVariant == 1
                or tbl1.FIntRelocateMobileMenuButtonsVariant == 3
                or tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and not Utility:IsSmallTouchScreen())
        then
            var18 = true
        end

        if module.HubBar and not (shouldShowHubBar(currentPage) or currentPage.DisableTopPadding) then
            uDim = UDim.new(0, module.HubBar.AbsoluteSize.Y)
        end

        if not isSideSheetEnabled and module.BottomButtonFrame and var18 and not shouldShowBottomBar(currentPage) then
            uDim3 = UDim.new(0, module.BottomButtonFrame.AbsoluteSize.Y)
        end

        local var19 = Theme.HubPadding()
        module.MenuContainerPadding.PaddingLeft = var19.PaddingLeft
        module.MenuContainerPadding.PaddingRight = var19.PaddingRight
        module.MenuContainerPadding.PaddingBottom = var19.PaddingBottom + uDim3
        module.MenuContainerPadding.PaddingTop = var19.PaddingTop + uDim

        local var20 = Theme.MenuContainerPosition(module.SettingsUIDelegate)

        local var21, anchorPoint = applySideSheetLayoutToMenuContainer(var20.Position, var20.AnchorPoint)
        module.MenuContainer.Position = var21
        module.MenuContainer.Size = var20.Size
        module.MenuContainer.AnchorPoint = anchorPoint

        if arg2 == nil
            and module.Pages.CurrentPage
            and module.Pages.CurrentPage.TabHeader
            and currentPage
            and currentPage.TabHeader
        then
            arg2 = if module.Pages.CurrentPage.TabHeader.AbsolutePosition.x < currentPage.TabHeader.AbsolutePosition.x then 1 else -1
        end

        local var23 = if arg2 == nil then 1 else arg2

        if module.Pages.CurrentPage and connection2 ~= nil then
            connection2:disconnect()
            module.Pages.CurrentPage.Active = false
        end

        if tbl1.FFlagFixDisabledScrollOnIos and connection3 ~= nil then
            connection3:Disconnect()
            connection3 = nil
        end

        local tabPosition = currentPage.TabPosition
        for k, _ in pairs(module.Pages.PageTable) do
            if k ~= currentPage then
                k:Hide(-var23, tabPosition, arg3, nil, module.PageViewInnerFrame, k == module.Pages.CurrentPage)
            end
        end

        if module.BottomButtonFrame then
            if shouldShowBottomBar(currentPage) then
                setBottomBarBindings()
                setBottomBarSelection(currentPage)
            else
                module.BottomButtonFrame.Visible = false
            end

            module.HubBar.Visible = shouldShowHubBar(currentPage)
        end
        if tbl1.FFlagIEMTabFocusNav then
            setTabHeaderSelection(currentPage)
        end

        local clipsDescendants = currentPage.IsPageClipped == true
        module.PageViewClipper.ClipsDescendants = clipsDescendants
        module.PageView.ClipsDescendants = clipsDescendants
        module.PageViewInnerFrame.ClipsDescendants = clipsDescendants

        module.Pages.CurrentPage = currentPage
        module.Pages.CurrentPage:Display(module.PageViewInnerFrame, arg3)
        module.Pages.CurrentPage.Active = true
        module.CurrentPageSignal:fire(if module.Pages.CurrentPage then module.Pages.CurrentPage.Page.Name or nil else nil)

        if isSideSheetEnabled then
            updatePageTitleHeader(module.Pages.CurrentPage)
        end

        if shouldDisableDefaultScroll(nil) then
            module.PageView.ScrollBarThickness = 0
            module.PageView.ScrollingEnabled = false
            module.PageView.CanvasPosition = Vector2.new(0, 0)
            module.PageView.CanvasSize = UDim2.new(1, 0, 1, 0)

            if tbl1.FFlagFixDisabledScrollOnIos then
                connection3 = module.PageView:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
                    if module.PageView.CanvasPosition.Magnitude > 0 then
                        module.PageView.CanvasPosition = Vector2.new(0, 0)
                    end
                end)
            end
        else
            module.PageView.ScrollBarThickness = Theme.DefaultScrollBarThickness
            module.PageView.ScrollingEnabled = true
            local size = module.Pages.CurrentPage:GetSize()
            module.PageView.CanvasSize = UDim2.new(0, 0, 0, size.Y)
        end

        connection2 = module.Pages.CurrentPage.Page.Changed:connect(function(arg5)
            if arg5 == "AbsoluteSize" and not shouldDisableDefaultScroll(nil) then
                local size = module.Pages.CurrentPage:GetSize()
                module.PageView.CanvasSize = UDim2.new(0, 0, 0, size.Y)
            end
        end)

        if module.MenuStack[#module.MenuStack] ~= module.Pages.CurrentPage and not arg1 then
            module.MenuStack[#module.MenuStack + 1] = module.Pages.CurrentPage
        end

        if currentPage.DisableTopPadding then
            onScreenSizeChanged()
        end

        local additionalArgs = ({})
        local gameId = game.GameId
        additionalArgs.universeid = tostring(gameId)
        if tbl1.GetFFlagReportAbuseMenuEntrypointAnalytics() and arg4 then
            additionalArgs = Cryo.Dictionary.join(additionalArgs, arg4)
        end

        if tbl1.FFlagRespawnChromeShortcutTelemetry and additionalArgs.used_shortcut == nil then
            additionalArgs.used_shortcut = false
        end

        if additionalArgs.playsessionid == nil then
            additionalArgs.playsessionid = module.playSessionId
        end

        if currentPage then
            if tbl1.FFlagHelpPageIXPExposure and module.HelpPage == currentPage and not module.HelpPageIXPFetched then
                IXPServiceWrapper:LogUserLayerExposure(tbl1.FStringHelpPageIXPLayer)
                module.HelpPageIXPFetched = true
            end

            if module.GameSettingsPage == currentPage then
                RbxAnalyticsService:SetRBXEventStream(
                    Constants.AnalyticsTargetName,
                    "open_GameSettings_tab",
                    Constants.AnalyticsMenuActionName,
                    additionalArgs
                )

                if Flags.FFlagIEMSettingsLogExposureIXPFlags and not module.GameSettingsPageReorderIXPFetched then
                    IXPServiceWrapper:LogFlagLinkedUserLayerExposure(tbl1.GetFStringInExperienceMenuIXPLayer())
                    module.GameSettingsPageReorderIXPFetched = true
                end
            else
                RbxAnalyticsService:SetRBXEventStream(
                    Constants.AnalyticsTargetName,
                    "open_" .. currentPage.Page.Name .. "_tab",
                    Constants.AnalyticsMenuActionName,
                    additionalArgs
                )
            end

            ExperienceMenuSessionManagerInstance:MenuSwitchToPage(currentPage.Page)
        else
            RbxAnalyticsService:SetRBXEventStream(
                Constants.AnalyticsTargetName,
                "open_unknown_tab",
                Constants.AnalyticsMenuActionName,
                additionalArgs
            )
            ExperienceMenuSessionManagerInstance:CloseOpenedMenuTab()
        end

        if tbl1.FFlagAddTraversalHistory and tbl1.FFlagIntegrateTraversalHistoryInSideSheet then
            ReactPageSignal(false).setCurrentReactPage(nil)
        end
    end

    function module.SetActive(_, active)
        module.Active = active

        if module.Pages.CurrentPage then
            module.Pages.CurrentPage.Active = active
        end
    end

    function clearMenuStack()
        while module.MenuStack and #module.MenuStack > 0 do
            module:PopMenu()
        end
    end

    function setOverrideMouseIconBehavior()
        if not module.Visible then
            return
        end

        if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 or VRService.VREnabled then
            MouseIconOverrideService.push(SettingsHubCursorOverride, Enum.OverrideMouseIconBehavior.ForceHide)
        else
            MouseIconOverrideService.push(SettingsHubCursorOverride, Enum.OverrideMouseIconBehavior.ForceShow)
        end
    end

    function checkLeaveGameUpsell()
        if not tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() then
            return
        end

        if not module.sessionStartTime then
            module.sessionStartTime = os.time()
        end
        if not module.sessionStartTime then
            return
        end

        if not module.checkedUpsell and module.leaveGameUpsellProp == Constants2.PHONE_UPSELL_VALUE_PROP.None then
            module.checkedUpsell = true
            module.leaveGameUpsellProp = default:FetchPhoneVerificationUpsell(Constants2.EXIT_CONFIRMATION_PHONE_UPSELL_IXP_LAYER, module.sessionStartTime, true)

            module.LeaveGameUpsellPage:SetUpsellProp(module.leaveGameUpsellProp)
            task.delay(num1, function()
                module.checkedUpsell = false
            end)
        elseif module.checkedUpsell then
            local leaveGameUpsellProp = default:FetchPhoneVerificationUpsell(
                Constants2.EXIT_CONFIRMATION_PHONE_UPSELL_IXP_LAYER,
                module.sessionStartTime,
                false
            )

            if module.leaveGameUpsellProp ~= leaveGameUpsellProp then
                module.leaveGameUpsellProp = leaveGameUpsellProp
                module.LeaveGameUpsellPage:SetUpsellProp(module.leaveGameUpsellProp)
            end
        end
    end

    local var18 = nil
    var18 = tbl1.FFlagSettingsHubIndependentBackgroundVisibility and function(visible, arg1, arg2)
        if not module.DarkenBackground
            or not visible and module.DarkenBackground.Visible and (InExperienceAppChatModal:getVisible() or module.Visible)
        then
            return
        end

        local quart = Enum.EasingStyle.Quart

        local shieldCloseTweenTime = getShieldCloseTweenTime(if Constants then Constants.ShieldCloseAnimationTweenTime else 0.4, arg2)
        local darkBackgroundThemeTransparency

        if visible then
            if tbl1.isInExperienceUIVREnabled then
                darkBackgroundThemeTransparency = module.SettingsUIDelegate:getDarkBackgroundTheme().Transparency
            else
                darkBackgroundThemeTransparency = Theme.transparency("DarkenBackground")
            end

            quart = Enum.EasingStyle.Quad
            shieldCloseTweenTime = getShieldOpenTweenTime(if Constants then Constants.ShieldOpenAnimationTweenTime else 0.5)
        else
            darkBackgroundThemeTransparency = 1
        end

        if arg1 then
            if module.DarkenBackgroundTween then
                module.DarkenBackgroundTween:Cancel()
                module.DarkenBackgroundTween = nil
            end
            module.DarkenBackground.BackgroundTransparency = darkBackgroundThemeTransparency
        else
            local tweenInfo = TweenInfo.new(shieldCloseTweenTime, quart, Enum.EasingDirection.Out)

            if module.DarkenBackgroundTween then
                module.DarkenBackgroundTween:Cancel()
            end
            module.DarkenBackgroundTween = TweenService:Create(module.DarkenBackground, tweenInfo, { BackgroundTransparency = darkBackgroundThemeTransparency })
            module.DarkenBackgroundTween:Play()
        end

        module.DarkenBackground.Visible = visible
    end or var18

    setVisibilityInternal = function(moduleVisible, arg1, arg2, _, source)
        local var19 = shouldUseSideSheetPeoplePageLayout()

        if isSideSheetPairedWithPeoplePage() and not moduleVisible and module.Visible then
            toggleSideSheet(false)
        end

        if tbl1.isInExperienceUIVREnabled then
            arg1 = arg1 or not module.SettingsUIDelegate:isOpenCloseAnimationAllowed()
        end

        module.OpenStateChangedCount += 1

        local bool9 = moduleVisible ~= module.Visible
        module.Visible = moduleVisible

        if tbl1.FFlagEnableInGameMenuDurationLogger and bool9 and not moduleVisible then
            PerfUtils.menuClose()
        end

        if module.ResizedConnection then
            module.ResizedConnection:disconnect()
            module.ResizedConnection = nil
        end

        if module.BackBarVisibleConnection then
            module.BackBarVisibleConnection:disconnect()
            module.BackBarVisibleConnection = nil
        end

        if tbl1.EngineFeatureTeleportHistoryButtons and module.FrontBarVisibleConnection then
            module.FrontBarVisibleConnection:disconnect()
            module.FrontBarVisibleConnection = nil
        end

        if module.PreferredTransparencyChangedConnection then
            module.PreferredTransparencyChangedConnection:disconnect()
            module.PreferredTransparencyChangedConnection = nil
        end

        local modal = module.Modal
        modal.Visible = if FFlagSideSheetOpenPeoplePage then shouldShowSettingsHubModal() else module.Visible

        if module.TabConnection then
            module.TabConnection:disconnect()
            module.TabConnection = nil
        end

        local playerListManager = require(RobloxGui.Modules.PlayerList.PlayerListManager)

        if tbl1.FFlagSettingsHubIndependentBackgroundVisibility then
            var18(module.Visible, arg1, var19)
        end

        if module.Visible then
            module.ResizedConnection = RobloxGui.Changed:connect(function(arg3)
                if arg3 == "AbsoluteSize" then
                    onScreenSizeChanged()
                end
            end)

            if tbl1.FFlagMenuButtonsMountWithIEM then
                if tbl1.FFlagRelocateMobileMenuButtons
                    and (tbl1.FIntRelocateMobileMenuButtonsVariant == 1
                        or tbl1.FIntRelocateMobileMenuButtonsVariant == 3
                        or tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and not Utility:IsSmallTouchScreen())
                then
                    var16()
                end

                if tbl1.FFlagRelocateMobileMenuButtons
                    and tbl1.FIntRelocateMobileMenuButtonsVariant == 2
                    and Utility:IsSmallTouchScreen()
                    and module.PlayersPage
                then
                    module.PlayersPage:CreateMenuButtonsContainer()
                end
            end

            if not tbl1.FFlagAddTraversalBackButton then
                if module.BackBarRef:getValue() then
                    module.BackBarVisibleConnection = module.BackBarRef:getValue():GetPropertyChangedSignal("Visible"):connect(function()
                        onScreenSizeChanged()
                    end)
                end
                if tbl1.EngineFeatureTeleportHistoryButtons and module.FrontBarRef:getValue() then
                    module.FrontBarVisibleConnection = module.FrontBarRef:getValue():GetPropertyChangedSignal("Visible"):connect(function()
                        onScreenSizeChanged()
                    end)
                end
            end
            onScreenSizeChanged()

            module.PreferredTransparencyChangedConnection = GuiService:GetPropertyChangedSignal("PreferredTransparency"):connect(function()
                onPreferredTransparencyChanged()
            end)

            onPreferredTransparencyChanged()
            module.SettingsShowSignal:fire(module.Visible)

            GuiService:SetMenuIsOpen(true, "SettingsHub")
            ExperienceMenuSessionManagerInstance:OpenExperienceMenu()
            module.Shield.Visible = module.Visible
            GuiService:CloseInspectMenu()

            if arg1 or not module.Shield:IsDescendantOf(game) then
                module.Shield.Position = UDim2.new(0, 0, 0, 0)
                if not tbl1.FFlagSettingsHubIndependentBackgroundVisibility and module.DarkenBackground then
                    if module.DarkenBackgroundTween then
                        module.DarkenBackgroundTween:Cancel()
                        module.DarkenBackgroundTween = nil
                    end
                    module.DarkenBackground.BackgroundTransparency = Theme.transparency("DarkenBackground")
                end
            else
                local shieldOpenTweenTime = getShieldOpenTweenTime(if Constants then Constants.ShieldOpenAnimationTweenTime else 0.5)

                if GameSettings.ReducedMotion then
                    if module.ReducedMotionOpenTween then
                        module.ReducedMotionOpenTween:Cancel()
                        module.ReducedMotionOpenTween = nil
                    end
                    if module.ReducedMotionCloseTween then
                        module.ReducedMotionCloseTween:Cancel()
                        module.ReducedMotionCloseTween = nil
                    end

                    module.Shield.Parent = module.CanvasGroup
                    module.CanvasGroup.GroupTransparency = 1
                    module.CanvasGroup.Visible = true
                    module.Shield.Position = UDim2.new(0, 0, 0, 0)

                    local tweenInfo = TweenInfo.new(0.25)
                    module.ReducedMotionOpenTween = TweenService:Create(module.CanvasGroup, tweenInfo, { GroupTransparency = 0 })
                    module.ReducedMotionOpenTween:Play()

                    module.ReducedMotionOpenTween.Completed:Connect(function(playbackState: Enum.PlaybackState)
                        if playbackState == Enum.PlaybackState.Completed then
                            module.Shield.Parent = module.ClippingShield
                            module.ReducedMotionOpenTween = nil
                        end

                        module.CanvasGroup.Visible = false
                    end)

                    if tbl1.FFlagEnableInGameMenuDurationLogger then
                        PerfUtils.menuOpenComplete()
                    end
                else
                    module.Shield:TweenPositionInternal(
                        UDim2.new(0, 0, 0, 0),
                        Enum.EasingDirection.InOut,
                        Enum.EasingStyle.Quart,
                        shieldOpenTweenTime,
                        true,
                        function()
                            if tbl1.FFlagEnableInGameMenuDurationLogger then
                                PerfUtils.menuOpenComplete()
                            end
                        end
                    )
                end

                if not tbl1.FFlagSettingsHubIndependentBackgroundVisibility and module.DarkenBackground then
                    local tweenInfo = TweenInfo.new(shieldOpenTweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

                    if module.DarkenBackgroundTween then
                        module.DarkenBackgroundTween:Cancel()
                    end
                    module.DarkenBackgroundTween = TweenService:Create(
                        module.DarkenBackground,
                        tweenInfo,
                        {
                            BackgroundTransparency = Theme.transparency("DarkenBackground")
                        }
                    )
                    module.DarkenBackgroundTween:Play()
                end
            end

            local functionToBind = tbl1.isInExperienceUIVREnabled and function(arg3, arg4, arg5): Enum.ContextActionResult?
                return if module.SettingsUIDelegate:isInputEventNeededBySettings(arg3, arg4, arg5) then Enum.ContextActionResult.Pass else nil
            end or function() end

            ContextActionService:BindCoreAction(
                "RbxSettingsHubStopCharacter",
                functionToBind,
                false,
                Enum.PlayerActions.CharacterForward,
                Enum.PlayerActions.CharacterBackward,
                Enum.PlayerActions.CharacterLeft,
                Enum.PlayerActions.CharacterRight,
                Enum.PlayerActions.CharacterJump,
                Enum.KeyCode.LeftShift,
                Enum.KeyCode.RightShift,
                Enum.KeyCode.Tab,
                Enum.UserInputType.Gamepad1,
                Enum.UserInputType.Gamepad2,
                Enum.UserInputType.Gamepad3,
                Enum.UserInputType.Gamepad4
            )

            if not isSideSheetEnabled then
                ContextActionService:BindCoreAction(
                    "RbxSettingsHubSwitchTab",
                    func2,
                    false,
                    Enum.KeyCode.ButtonR1,
                    Enum.KeyCode.ButtonL1
                )
            end

            ContextActionService:BindCoreAction("RbxSettingsScrollHotkey", func4, false, Enum.KeyCode.PageUp, Enum.KeyCode.PageDown)
            if shouldShowBottomBar() then
                setBottomBarBindings()
                setBottomBarSelection(module.Pages.CurrentPage)
            end

            if tbl1.ChromeEnabled and tbl1.FFlagEnableConsoleExpControls then
                require(RobloxGui.Modules.Chrome.Service):setShortcutBar(
                    require(RobloxGui.Modules.Chrome.ChromeShared.Unibar.Constants).TILTMENU_SHORTCUTBAR_ID
                )
            end
            if not isSideSheetEnabled then
                module.TabConnection = UserInputService.InputBegan:connect(func3)
            end

            setOverrideMouseIconBehavior()
            connection = UserInputService.LastInputTypeChanged:connect(setOverrideMouseIconBehavior)
            if UserInputService.MouseEnabled and not VRService.VREnabled then
                MouseIconOverrideService.push(SettingsHubCursorOverride, Enum.OverrideMouseIconBehavior.ForceShow)
            end

            module:CloseReactPage()

            if arg2 then
                removeBottomBarBindings()
                module:SwitchToPage(arg2, nil, 1, true)
            else
                module:SwitchToPage(module:GetFirstPageWithTabHeader(), nil, 1, true)
            end

            if not tbl1.isInExperienceUIVREnabled or tbl1.InExperienceUIVRIXP:isMovePanelToCenter() or not VRService.VREnabled then
                if tbl1.FFlagAddNewPlayerListMobileFocusNav then
                    if playerListManager:GetIsModal() then
                        playerListManager:SetVisibility(false)
                    else
                        playerListManager:HideTemp("SettingsMenu", true)
                    end
                else
                    playerListManager:HideTemp("SettingsMenu", true)
                end

                if not (tbl1.isInExperienceUIVREnabled
                    and tbl1.InExperienceUIVRIXP:isMovePanelToCenter()
                    and tbl1.FFlagSpatialUIFixMenuPanelChatExclusive
                    and VRService.VREnabled) then
                    ChatSelector:HideTemp("SettingsMenu", true)
                end

                if FFlagEnableNewBackpack then
                    Features.setVisibility(Features.FeatureName.Backpack, false)
                else
                    local backpackScript = require(RobloxGui.Modules.BackpackScript)
                    if backpackScript.IsOpen then
                        backpackScript:OpenClose()
                    end
                end
            end

            if tbl1.GetFFlagEnableAppChatInExperience() and InExperienceAppChatModal:getVisible() then
                bool3 = true
                InExperienceAppChatModal.default:setVisible(false)
            end

            if not tbl1.isInExperienceUIVREnabled then
                if FFlagEnableNewBackpack then
                    Features.setVisibility(Features.FeatureName.Backpack, false)
                else
                    local backpackScript = require(RobloxGui.Modules.BackpackScript)
                    if backpackScript.IsOpen then
                        backpackScript:OpenClose()
                    end
                end
            end

            module.GameSettingsPage:OpenSettingsPage()
        else
            module.CurrentPageSignal:fire("")

            if tbl1.FFlagMenuButtonsMountWithIEM and tbl1.FFlagRelocateMobileMenuButtons then
                if tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                    var17()
                end

                if tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and module.PlayersPage then
                    module.PlayersPage:UnmountMenuButtonsContainer()
                end
            end

            if tbl1.ChromeEnabled and tbl1.FFlagEnableConsoleExpControls then
                require(RobloxGui.Modules.Chrome.Service):setShortcutBar(nil)
            end

            if tbl1.GetFFlagEnableAppChatInExperience() and bool3 then
                bool3 = false
            end

            if tbl1.isInExperienceUIVREnabled and tbl1.InExperienceUIVRIXP:isMovePanelToCenter() then
                playerListManager:HideTemp("SettingsMenu", false)

                if not (tbl1.FFlagSpatialUIFixMenuPanelChatExclusive and VRService.VREnabled) then
                    ChatSelector:HideTemp("SettingsMenu", false)
                end
            end

            if arg1 then
                module.Shield.Position = SHIELD_INACTIVE_POSITION
                module.Shield.Visible = module.Visible
                module.SettingsShowSignal:fire(module.Visible)
                GuiService:SetMenuIsOpen(false, "SettingsHub")
                ExperienceMenuSessionManagerInstance:CloseExperienceMenu()
                if tbl1.FFlagEnableInGameMenuDurationLogger then
                    PerfUtils.menuCloseComplete()
                end

                if not tbl1.FFlagSettingsHubIndependentBackgroundVisibility and module.DarkenBackground then
                    if module.DarkenBackgroundTween then
                        module.DarkenBackgroundTween:Cancel()
                        module.DarkenBackgroundTween = nil
                    end
                    module.DarkenBackground.BackgroundTransparency = 1
                end
            else
                local shieldCloseTweenTime = getShieldCloseTweenTime(if Constants then Constants.ShieldCloseAnimationTweenTime else 0.4, var19)

                local function handleShieldClose()
                    if not tbl1.FFlagAddTraversalBackButton then
                        module.SettingsShowSignal:fire(module.Visible)
                    end
                    if not module.Visible then
                        GuiService:SetMenuIsOpen(false, "SettingsHub")
                        ExperienceMenuSessionManagerInstance:CloseExperienceMenu()
                    end
                    if tbl1.FFlagEnableInGameMenuDurationLogger then
                        PerfUtils.menuCloseComplete()
                    end
                end

                if tbl1.FFlagAddTraversalBackButton then
                    module.SettingsShowSignal:fire(module.Visible)
                end

                if GameSettings.ReducedMotion then
                    if module.ReducedMotionOpenTween then
                        module.ReducedMotionOpenTween:Cancel()
                        module.ReducedMotionOpenTween = nil
                    end
                    if module.ReducedMotionCloseTween then
                        module.ReducedMotionCloseTween:Cancel()
                        module.ReducedMotionCloseTween = nil
                    end

                    module.Shield.Parent = module.CanvasGroup
                    module.CanvasGroup.Visible = true

                    local tweenInfo = TweenInfo.new(0.25)
                    module.ReducedMotionCloseTween = TweenService:Create(module.CanvasGroup, tweenInfo, { GroupTransparency = 1 })
                    module.ReducedMotionCloseTween:Play()
                    module.ReducedMotionCloseTween.Completed:Connect(function(playbackState: Enum.PlaybackState)
                        if playbackState == Enum.PlaybackState.Completed then
                            module.Shield.Position = SHIELD_INACTIVE_POSITION

                            module.Shield.Visible = module.Visible
                            module.Shield.Parent = module.ClippingShield
                            module.ReducedMotionCloseTween = nil
                        end
                        module.CanvasGroup.Visible = false
                    end)

                    handleShieldClose()
                else
                    if tbl1.ChromeEnabled and tbl1.FFlagEnableConsoleExpControls then
                        require(RobloxGui.Modules.Chrome.Service):setShortcutBar(nil)
                    end
                    local _in = Enum.EasingDirection.In
                    local quad = Enum.EasingStyle.Quad

                    if shouldCloseShieldWithSideSheet(var19) then
                        _in = Enum.EasingDirection.Out
                        quad = Enum.EasingStyle.Quart
                    end

                    module.Shield:TweenPositionInternal(SHIELD_INACTIVE_POSITION, _in, quad, shieldCloseTweenTime, true, function()
                        module.Shield.Visible = module.Visible
                        handleShieldClose()
                    end)
                end

                if not tbl1.FFlagSettingsHubIndependentBackgroundVisibility and module.DarkenBackground then
                    local tweenInfo = TweenInfo.new(shieldCloseTweenTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                    if module.DarkenBackgroundTween then
                        module.DarkenBackgroundTween:Cancel()
                    end
                    module.DarkenBackgroundTween = TweenService:Create(module.DarkenBackground, tweenInfo, { BackgroundTransparency = 1 })
                    module.DarkenBackgroundTween:Play()
                end
            end

            if connection then
                connection:disconnect()
            end

            if not (tbl1.isInExperienceUIVREnabled and (tbl1.InExperienceUIVRIXP:isMovePanelToCenter() or VRService.VREnabled)) then
                playerListManager:HideTemp("SettingsMenu", false)

                ChatSelector:HideTemp("SettingsMenu", false)
            end

            if not VRService.VREnabled then
                MouseIconOverrideService.pop(SettingsHubCursorOverride)
            end

            module:CloseReactPage()

            clearMenuStack()

            if not isSideSheetEnabled then
                ContextActionService:UnbindCoreAction("RbxSettingsHubSwitchTab")
            end
            ContextActionService:UnbindCoreAction("RbxSettingsHubStopCharacter")
            ContextActionService:UnbindCoreAction("RbxSettingsScrollHotkey")

            removeBottomBarBindings(0.4)
            GuiService.SelectedCoreObject = nil

            module.GameSettingsPage:CloseSettingsPage()
        end

        local additionalArgs = {
            source = source,
            playsessionid = module.playSessionId,
            universeid = tostring(game.GameId)
        }

        if not bool9 then
            return
        end

        if moduleVisible then
            RbxAnalyticsService:SetRBXEventStream(
                Constants.AnalyticsTargetName,
                Constants.AnalyticsMenuOpenName,
                Constants.AnalyticsMenuActionName,
                additionalArgs
            )

            if tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() then
                task.spawn(checkLeaveGameUpsell)
            end
        else
            RbxAnalyticsService:SetRBXEventStream(
                Constants.AnalyticsTargetName,
                Constants.AnalyticsMenuCloseName,
                Constants.AnalyticsMenuActionName,
                additionalArgs
            )
        end
    end

    function module.SetVisibility(_, visible, arg1, arg2, arg3, arg4)
        if module.Visible == visible then
            return
        end
        setVisibilityInternal(visible, arg1, arg2, arg3, arg4)
    end

    function module.SetBackgroundVisibility(_, visible, arg1)
        if module.DarkenBackground.Visible == visible then
            return
        end
        var18(visible, arg1)
    end

    function module.GetVisibility(_): boolean
        return module.Visible
    end

    function module.ToggleVisibility(_, arg1, arg2)
        setVisibilityInternal(not module.Visible, nil, nil, arg1, arg2)
    end

    function module.AddToMenuStack(_, arg1)
        if module.MenuStack[#module.MenuStack] ~= arg1 then
            module.MenuStack[#module.MenuStack + 1] = arg1
        end
    end

    function module.InviteToGame(_)
        if game:GetEngineFeature("PlatformFriendsService")
            and PlatformFriendsService
            and PlatformFriendsService:IsInviteFriendsEnabled()
        then
            PlatformFriendsService:ShowInviteFriendsUI()
        elseif UserInputService:GetPlatform() ~= Enum.Platform.XBoxOne then
            if not tbl1.FFlagAddInviteFriendsIntegration or module.Visible then
                module:ToggleVisibility()
            end
            GameInviteModalManager:openModal({ trigger = GameInviteConstants.Triggers.GameMenu })

            if tbl1.FFlagEnableConsoleExpControls and tbl1.ChromeEnabled then
                require(RobloxGui.Modules.Chrome.Service):setShortcutBar(nil)
            end
        elseif PlatformService then
            PlatformService:PopupGameInviteUI()
        end

        if isSideSheetPairedWithPeoplePage() then
            toggleSideSheet(false)
        end
    end

    function module.PopMenu(_, _, arg1, arg2)
        if not module.MenuStack or not (#module.MenuStack > 0) then
            module.MenuStack = {}
            poppedMenu:Fire()
            if tbl1.FFlagAddUILessMode then
                module:ToggleVisibility(nil, arg2)
                return
            end
            module:ToggleVisibility(arg2)
            return
        end

        local var19 = module.MenuStack[#module.MenuStack]

        if type(var19) ~= "table" then
            poppedMenu:Fire(var19)
        end

        table.remove(module.MenuStack, #module.MenuStack)
        module:SwitchToPage(module.MenuStack[#module.MenuStack], true, 1, arg1)
        if #module.MenuStack ~= 0 then
            if tbl1.ChromeEnabled and tbl1.FFlagEnableConsoleExpControls then
                require(RobloxGui.Modules.Chrome.Service):setShortcutBar(
                    require(RobloxGui.Modules.Chrome.ChromeShared.Unibar.Constants).TILTMENU_SHORTCUTBAR_ID
                )
            end

            return
        end

        if tbl1.FFlagAddUILessMode then
            module:SetVisibility(false, nil, nil, nil, arg2)
        else
            module:SetVisibility(false)
        end

        module.Pages.CurrentPage:Hide(0, 0, nil, nil, module.PageViewInnerFrame)
    end

    function module.ShowShield(_)
        local backgroundTransparency = if UserInputService.VREnabled then 1 else BackgroundTransparency

        module.Shield.BackgroundTransparency = backgroundTransparency
    end

    function module.HideShield(_)
        module.Shield.BackgroundTransparency = 1
    end

    function module.ShowReactPage(_)
        if module.reactPage then
            module.reactPageAnalytics:openPage(module.reactPage.name)
        end

        module.ReactPage.Visible = true
        module.Page.Visible = false
    end

    function module.HideReactPage(_)
        if module.reactPage then
            module.reactPageAnalytics:closePage(module.reactPage.name)
        end
        local reactPageVisible = module.ReactPage.Visible
        module.ReactPage.Visible = false
        module.Page.Visible = true
        if module.Pages.CurrentPage and reactPageVisible and module.Visible then
            module.Pages.CurrentPage:SelectARow(true)
        end
    end

    function module.MountReactPage(_)
        ReactPageSignal(false).setCurrentReactPage(nil)
        if module.reactPageRoot then
            module:UnmountReactPage()
        end
        module.reactPageRoot = ReactRoblox.createRoot(module.ReactPage)
    end

    function module.UnmountReactPage(_)
        if module.reactPageRoot then
            module.reactPageRoot:unmount()
            module.reactPageRoot = nil
        end
    end

    function module.CloseReactPage(_)
        module:HideReactPage()
        module:UnmountReactPage()
    end

    function module.SwitchToReactPage(_, reactPage, arg1, bool9: boolean?)
        if bool9 then
            module:UnmountReactPage()
        elseif reactPage then
            module.reactPage = reactPage

            if not module.reactPageRoot then
                module:MountReactPage()
            end

            module.reactPageRoot:render(reactPage:createPage(arg1))
        end
        module:ShowReactPage()
    end

    module.GameSettingsPageReorderIXPFetched = false
    local connection5 = nil
    local var19 = nil
    local function enableVR()
        local vrHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
        local panel3D = require(CorePackages.Workspace.Packages.VrCommon).Panel3D
        local var20 = panel3D.Get("SettingsMenu")
        var20:ResizeStuds(4, 4, 250)
        var20:SetType(panel3D.Type.Standard)
        var20:SetVisible(false)
        var20:SetCanFade(false)

        module.ClippingShield.Parent = var20:GetGUI()
        module.Shield.Parent.ClipsDescendants = false
        module.VRShield.Visible = true
        module:HideShield()

        connection5 = module.SettingsShowSignal:connect(function(arg1)
            if arg1 then
                var20:SetVisible(true)

                vrHub:FireModuleOpened("SettingsMenu")
                return
            end
            var20:SetVisible(false)

            vrHub:FireModuleClosed("SettingsMenu")
        end)

        vrHub.ModuleOpened.Event:connect(function(arg1)
            if arg1 ~= "SettingsMenu" then
                module:SetVisibility(false)
            end
        end)
    end
    local function disableVR()
        module.ClippingShield.Parent = RobloxGui
        module.Shield.Parent.ClipsDescendants = true
        module.VRShield.Visible = false
        module:ShowShield()

        if connection5 then
            connection5:disconnect()
            connection5 = nil
        end
        if var19 then
            var19:disconnect()
            var19 = nil
        end

        require(CorePackages.Workspace.Packages.VrCommon).Panel3D.Get("SettingsMenu"):SetVisible(false)
    end

    local function refreshForSpatialUI() -- Luacid: Inlined by compiler; 2 call sites recovered
        onScreenSizeChanged()
        onPreferredTransparencyChanged()
        resizeBottomBarButtons()
    end

    local function OnVREnabled(property: string)
        if property ~= "VREnabled" then
            return
        end

        if UserInputService.VREnabled then
            if tbl1.isInExperienceUIVREnabled then
                module.SettingsUIDelegate:enableVR()
                refreshForSpatialUI()
                return
            end

            enableVR()
            return
        end

        if tbl1.isInExperienceUIVREnabled then
            module.SettingsUIDelegate:disableVR()
            refreshForSpatialUI()
            return
        end

        disableVR()
    end

    UserInputService.Changed:connect(OnVREnabled)
    OnVREnabled("VREnabled")

    module.ResetCharacterPage:SetHub(module)

    if InExperienceCapabilities.canNavigateHome then
        module.LeaveGamePage:SetHub(module)
    end

    if tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() then
        module.LeaveGameUpsellPage:SetHub(module)
    end

    module.GameSettingsPage = require(RobloxGui.Modules.Settings.Pages.GameSettingsWrapper)
    module.GameSettingsPage:SetHub(module)

    module.ReportAbusePage = require(RobloxGui.Modules.Settings.Pages.ReportAbuseMenuContainerPage)
    module.ReportAbusePage:SetHub(module)

    module.ReportSentPage = require(RobloxGui.Modules.Settings.Pages.ReportSentPage)
    module.ReportSentPage:SetHub(module)

    module.ReportSentPageV2 = require(RobloxGui.Modules.Settings.Pages.ReportSentPageV2)
    module.ReportSentPageV2:SetHub(module)

    module.HelpPage = require(RobloxGui.Modules.Settings.Pages.HelpWrapper)
    module.HelpPage:SetHub(module)
    if tbl1.FFlagHelpPageIXPExposure then
        module.HelpPageIXPFetched = false
    end

    if InExperienceCapabilities.canListPeopleInSameServer then
        module.PlayersPage = require(RobloxGui.Modules.Settings.Pages.PeopleWrapper)
        module.PlayersPage:SetHub(module)
        if not tbl1.FFlagMenuButtonsMountWithIEM
            and tbl1.FFlagRelocateMobileMenuButtons
            and tbl1.FIntRelocateMobileMenuButtonsVariant == 2
            and Utility:IsSmallTouchScreen()
        then
            module.PlayersPage:CreateMenuButtonsContainer()
        end
    end

    if tbl1.FFlagAddIEMProfilePage then
        module.PlayerProfilePage = require(RobloxGui.Modules.Settings.Pages.PlayerProfile)
    end

    if not tbl1.isExitModalRemoved and isSubjectToDesktopPolicies() then
        module.ExitModalPage = require(RobloxGui.Modules.Settings.Pages.ExitModal)
        module.ExitModalPage:SetHub(module)
    end

    if isSubjectToDesktopPolicies() and InExperienceCapabilities.canNavigateHome then
        module.LeaveGameToHomePage = require(RobloxGui.Modules.Settings.Pages.LeaveGameToHome)
        module.LeaveGameToHomePage:SetHub(module)
    end

    local var20 = CapturesPolicy.PolicyImplementation.read()
    local var21 = if var20 then CapturesPolicy.Mapper(var20).eligibleForCapturesFeature() else false
    local fFlagFixSpatialUiCaptures = tbl1.isInExperienceUIVREnabled and tbl1.FFlagFixSpatialUICaptures

    if var21 and not (fFlagFixSpatialUiCaptures and isSpatial()) then
        local capturesPageWrapper = require(RobloxGui.Modules.Settings.Pages.CapturesPageWrapper)

        module.CapturesApp = CapturesApp

        module.CapturesApp.mountMenuPage(capturesPageWrapper.Page, function() -- name: closeSettingsMenu
            module:SetVisibility(false, true)
        end, tbl1.ChromeEnabled)

        module.CapturesPage = capturesPageWrapper
        module.CapturesPage:ConnectHubToApp(module, module.PageViewClipper, module.CapturesApp)
    end

    if tbl1.FFlagIntegrateTraversalHistoryInSideSheet then
        module.TraversalHistoryPage = require(RobloxGui.Modules.Settings.Pages.TraversalHistoryWrapper)()
        module.TraversalHistoryPage:SetHub(module)
    end

    if module.PlayersPage then
        module:AddPage(module.PlayersPage)
    end

    module:AddPage(module.ResetCharacterPage)

    if module.LeaveGamePage then
        module:AddPage(module.LeaveGamePage)
    end

    if tbl1.GetFFlagEnableLeaveGameUpsellEntrypoint() and module.LeaveGameUpsellPage then
        module:AddPage(module.LeaveGameUpsellPage)
    end

    module:AddPage(module.GameSettingsPage)

    if module.CapturesPage then
        module:AddPage(module.CapturesPage)
    end

    if module.ReportAbusePage then
        module:AddPage(module.ReportAbusePage)
    end
    if module.ReportSentPage then
        module:AddPage(module.ReportSentPage)
    end
    if module.ReportSentPageV2 then
        module:AddPage(module.ReportSentPageV2)
    end

    module:AddPage(module.HelpPage)
    if not tbl1.isExitModalRemoved and module.ExitModalPage then
        module:AddPage(module.ExitModalPage)
    end

    if module.LeaveGameToHomePage then
        module:AddPage(module.LeaveGameToHomePage)
    end

    if module.TraversalHistoryPage then
        module:AddPage(module.TraversalHistoryPage)
    end

    module:InitInPage(module:GetFirstPageWithTabHeader())
    if not tbl1.isNewInGameMenuEnabled() and (not tbl1.FFlagAddUILessMode or tbl1.FIntAddUILessModeVariant == 0) then
        ContextActionService:BindCoreAction("RBXEscapeMainMenu", function(_, userInputState, _)
            if userInputState ~= Enum.UserInputState.Begin then
                return
            end

            if (tbl1.FFlagShowSwitchServerButton or isPioneerLaunch()) and GetSwitchServerStore(false).isConfirmationOpen(false) then
                return
            end

            if not isSideSheetEnabled then
                if tbl1.FFlagAddUILessMode then
                    module:PopMenu(false, true, Constants.AnalyticsMenuOpenTypes.Keyboard)
                else
                    module:PopMenu(false, true)
                end

                return
            end

            if getSideSheetVisibility() then
                if isSideSheetPairedWithPeoplePage() and getIsPeoplePageOpen() then
                    module:SetVisibility(false)
                    return
                end
                toggleSideSheet(false)
                return
            end

            if not module.MenuStack or not (#module.MenuStack > 0) then
                toggleSideSheet(true)
                return
            end

            if tbl1.FFlagAddUILessMode then
                module:PopMenu(false, true, Constants.AnalyticsMenuOpenTypes.Keyboard)
                return
            end
            module:PopMenu(false, true)
        end, false, Enum.KeyCode.Escape)
    end

    local var22 = require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.teamCreateUtils).isViewer()
    GuiService.ShowLeaveConfirmation:connect(function()
        if var22 then
            return
        end

        if not isSideSheetEnabled or not tbl1.FFlagSideSheetAndroidBack and not shouldAndroidBackUseSideSheet() then
            if #module.MenuStack == 0 then
                module:SetVisibility(true, nil, nil, nil, Constants.AnalyticsMenuOpenTypes.GamepadLeaveGame)
                module:SwitchToPage(module:GetFirstPageWithTabHeader(), nil, 1)
            else
                module:PopMenu(false, true)
            end

            return
        end

        if getSideSheetVisibility() then
            if isSideSheetPairedWithPeoplePage() and getIsPeoplePageOpen() then
                module:SetVisibility(false)
                return
            end
            toggleSideSheet(false)
        elseif #module.MenuStack > 0 then
            module:PopMenu(false, true)
        else
            toggleSideSheet(true)
        end
    end)

    ContextActionService:BindCoreAction("Open Dev Console", toggleDevConsole, false, Enum.KeyCode.F9)

    ContextActionService:BindCoreAction("Show Quick Profiler", toggleQuickProfilerFromHotkey, false, Enum.KeyCode.F7)

    UserInputService.InputBegan:connect(function(input: InputObject)
        if (input.KeyCode == Enum.KeyCode.Left
            or input.KeyCode == Enum.KeyCode.Right
            or input.KeyCode == Enum.KeyCode.Up
            or input.KeyCode == Enum.KeyCode.Down)
            and module.Visible
            and module.Active
            and module.Pages.CurrentPage
            and GuiService.SelectedCoreObject == nil
        then
            module.Pages.CurrentPage:SelectARow()
        end
    end)

    local bool9 = false
    local function logExitModalIXPExposureOnce() -- Luacid: Inlined by compiler; 3 call sites recovered
        if bool9 then
            return
        end
        bool9 = true
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(tbl1.GetFStringExitModalIXPLayer())
    end

    if tbl1.isExitModalRemoved and isSubjectToDesktopPolicies() then
        game:GetService("GuiService").NativeClose:Connect(function()
            if tbl1.FFlagEnableExitModalExposure then
                logExitModalIXPExposureOnce()
            end

            leaveGame(false, { shouldNativeExit = true })
        end)

        if module.FullScreenTitleBar then
            module.FullScreenTitleBar = SettingsFullScreenTitleBar.update(module.FullScreenTitleBar, {
                onClose = function()
                    if tbl1.FFlagEnableExitModalExposure then
                        logExitModalIXPExposureOnce()
                    end

                    leaveGame(false, { shouldNativeExit = true })
                end
            })
        end
    elseif module.ExitModalPage then
        local function showExitModal()
            if tbl1.FFlagEnableExitModalExposure then
                logExitModalIXPExposureOnce()
            end

            module.HubBar.Visible = false
            removeBottomBarBindings()
            if module:GetVisibility() then
                module:AddToMenuStack(module.Pages.CurrentPage)
                module:SwitchToPage(module.ExitModalPage, nil, 1, true)
                return
            end
            module:SetVisibility(true, nil, module.ExitModalPage, false)
        end

        local function handleNativeExit()
            if not module:GetVisibility() or module.Pages.CurrentPage ~= module.ExitModalPage then
                showExitModal()

                return
            end

            if tbl1.FFlagEnableInGameMenuDurationLogger then
                PerfUtils.leavingGame()
            end
            if tbl1.FFlagRelocateMobileMenuButtons and tbl1.FIntRelocateMobileMenuButtonsVariant ~= 0 then
                var17()
                if tbl1.FFlagMenuButtonsMountWithIEM and tbl1.FIntRelocateMobileMenuButtonsVariant == 2 and module.PlayersPage then
                    module.PlayersPage:UnmountMenuButtonsContainer()
                end
            end
            module.ExitModalPage.LeaveAppFunc(true)
        end
        game:GetService("GuiService").NativeClose:Connect(handleNativeExit)

        if module.FullScreenTitleBar then
            module.FullScreenTitleBar = SettingsFullScreenTitleBar.update(module.FullScreenTitleBar, { onClose = handleNativeExit })
        end
    end

    if tbl1.GetFFlagEnableAppChatInExperience() then
        local connection6 = nil

        module.SettingsShowSignal:connect(function(arg1)
            if arg1 then
                connection6 = InExperienceAppChatModal.default.visibilitySignal.Event:Connect(function(arg2)
                    if arg2 and module.Visible then
                        module:SetVisibility(false, true)
                    end
                end)

                return
            end

            if connection6 then
                connection6:Disconnect()
                connection6 = nil
            end
        end)
    end

    module.InExperienceMenuReact = Create("Folder")({ Name = "InExperienceMenuReact", Parent = module.ClippingShield })

    local buttonsContainer = module.PlayersPage.ButtonsContainer
    local leaveButtonButton = if buttonsContainer then buttonsContainer:FindFirstChild("LeaveButtonButton", true) else nil
    local leaveGameButton = if tbl1.FFlagAddTraversalHistory then module.LeaveGameButton else nil

    local function func6(arg1)
        local var23, var24 = React.useState(arg1.showSignal(false) and module.Visible)
        React.useEffect(function()
            local effect = Signals.createEffect(function(arg2)
                var24(arg1.showSignal(arg2) and module.Visible)
            end)
            local connection6 = module.SettingsShowSignal:connect(function(arg2)
                var24(arg1.showSignal(false) and arg2)
            end)

            return function()
                effect()
                connection6:Disconnect()
            end
        end, {})

        return tbl1.FFlagAddTraversalHistory
            and not (tbl1.isInExperienceUIVREnabled and isSpatial())
            and arg1.parent
            and var23
            and React.createElement(PortalWithFoundationStylelink, {
                parent = arg1.parent
            }, {
                TraversalHistoryMenu = React.createElement(
                    TraversalHistoryMenu,
                    {
                        anchorParent = arg1.parent,
                        currentPageChangeSignal = arg1.currentPageChangeSignal,
                        menuSide = arg1.menuSide
                    }
                )
            })
    end
    ReactRoblox.createRoot(module.InExperienceMenuReact):render(
        React.createElement(InExperienceMenuReact, nil, {
            InExperienceMenuReactPage = React.createElement(InExperienceMenuReactPage, {
                onMount = function()
                    module:SwitchToReactPage(nil, nil, true)
                end,
                onUnmount = function()
                    module:CloseReactPage()
                    ReactPageSignal(false).setCurrentReactPage(nil)
                end,
                mountTo = module.ReactPage
            }),
            TraversalHistoryMenuBottomBar = React.createElement(func6, {
                showSignal = module.showBottomBarSignal,
                parent = leaveGameButton,
                menuSide = Foundation.Enums.PopoverSide.Top,
                currentPageChangeSignal = module.CurrentPageSignal
            }),
            TraversalHistoryMenuMobileButton = React.createElement(func6, {
                showSignal = Signals.createComputed(function(arg1): boolean
                    return not module.showBottomBarSignal(arg1)
                end),
                parent = leaveButtonButton,
                menuSide = Foundation.Enums.PopoverSide.Bottom,
                currentPageChangeSignal = module.CurrentPageSignal
            })
        })
    )
    return module
end

local module = {
    ModuleName = "SettingsMenu",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true,
    SetVisibility = nil
}
VRHub:RegisterModule(module)

VRHub.ModuleOpened.Event:connect(function(moduleName)
    if moduleName ~= module.ModuleName and VRHub:GetModule(moduleName).VRIsExclusive then
        module:SetVisibility(false)
    end
end)

local settingsHub = CreateSettingsHub()

if FFlagSideSheetOpenPeoplePage then
    setupPeoplePageOpenTracking(settingsHub)
    setupInGameMenuPeoplePageActions(settingsHub)
end

function module.GetExperienceControlStore(_)
    return settingsHub:GetExperienceControlStore()
end

function module.SetVisibility(_, arg1, arg2, arg3, arg4, arg5)
    settingsHub:SetVisibility(arg1, arg2, arg3, arg4, arg5)
end

function module.SetBackgroundVisibility(_, arg1, arg2)
    settingsHub:SetBackgroundVisibility(arg1, arg2)
end

function module.ToggleVisibility(_, arg1, arg2)
    settingsHub:ToggleVisibility(arg1, arg2)
end

function module.SwitchToPage(_, arg1, arg2)
    settingsHub:SwitchToPage(arg1, arg2, 1)
end

if tbl1.FFlagAddUILessMode and tbl1.FIntAddUILessModeVariant ~= 0 then
    function module.PopMenu(_, arg1, arg2, arg3)
        return settingsHub:PopMenu(arg1, arg2, arg3)
    end
end

function module.GetVisibility(_): boolean
    return settingsHub.Visible
end

function module.ShowShield(_)
    settingsHub:ShowShield()
end

function module.HideShield(_)
    settingsHub:HideShield()
end

function module.GetRespawnBehaviour(_)
    return settingsHub:GetRespawnBehaviour()
end

function module.CloseReactPage(_)
    settingsHub:CloseReactPage()
end

function module.SwitchToReactPage(_, arg1, arg2, arg3)
    settingsHub:SwitchToReactPage(arg1, arg2, arg3)
end

if tbl1.FFlagAddInviteFriendsIntegration then
    function module.InviteToGame(_)
        settingsHub:InviteToGame()
    end
end

module.RespawnBehaviourChangedEvent = settingsHub.RespawnBehaviourChangedEvent

module.SettingsShowSignal = settingsHub.SettingsShowSignal

module.CurrentPageSignal = settingsHub.CurrentPageSignal

module.SettingsShowEvent = Instance.new("BindableEvent")

settingsHub.SettingsShowSignal:connect(function(arg1)
    module.SettingsShowEvent:Fire(arg1)
end)

module.Instance = settingsHub

return module
