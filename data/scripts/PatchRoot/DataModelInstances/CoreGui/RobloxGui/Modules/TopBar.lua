-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local IXPService = game:GetService("IXPService")
local LocalizationService = game:GetService("LocalizationService")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagBuildExperienceInGameShell = SharedFlags.FFlagBuildExperienceInGameShell
local shouldSkipHistoricalMessage = require(CorePackages.Workspace.Packages.ExpChat).shouldSkipHistoricalMessage

local FFlagAddTopBarScrim = require(script.Flags.FFlagAddTopBarScrim)

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider
local DesignTokenProvider = require(CorePackages.Workspace.Packages.Style).DesignTokenProvider
local CrossExperienceVoice = require(CorePackages.Workspace.Packages.CrossExperienceVoice)
local ReactSceneUnderstanding = require(CorePackages.Packages.ReactSceneUnderstanding)

local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local Signals = if FFlagBuildExperienceInGameShell then require(CorePackages.Packages.Signals) else nil
local UIBlox = require(CorePackages.Packages.UIBlox)

local ColorMode = require(CorePackages.Packages.Foundation).Enums.ColorMode

local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)
local RoactAppPolicy = UniversalAppPolicy.RoactAppPolicy
local AppFeaturePolicies = UniversalAppPolicy.AppFeaturePolicies

local Constants = UIBlox.App.Style.Constants
local Display = require(CorePackages.Workspace.Packages.Display)
local UiModeStyleProvider = require(CorePackages.Workspace.Packages.Style).UiModeStyleProvider
local VoiceStateContext = require(RobloxGui.Modules.VoiceChat.VoiceStateContext)

local Utility = require(RobloxGui.Modules.Settings.Utility)
local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)
local isNewInGameMenuEnabled = require(RobloxGui.Modules.isNewInGameMenuEnabled)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local Service = nil
local TopBarScrim = nil
if var1 then
    Service = require(RobloxGui.Modules.Chrome.Service)
    TopBarScrim = require(script.Components.TopBarScrim)
end
local Constants2 = require(script.Constants)
local MenuNavigationPromptTokenMapper = require(script.TokenMappers.MenuNavigationPromptTokenMapper)

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeSetCores = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagTopBarSignalizeSetCores
local FFlagTopBarSignalizeMenuOpen = CoreGuiCommon.Flags.FFlagTopBarSignalizeMenuOpen
local FFlagTopBarDeprecateGameInfoRodux = require(script.Flags.FFlagTopBarDeprecateGameInfoRodux)

local FFlagTopBarDeprecateGamepadNavigationDialogRodux = require(script.Flags.FFlagTopBarDeprecateGamepadNavigationDialogRodux)

local CoreScriptsErrorBoundary = require(CorePackages.Workspace.Packages.CoreScriptsErrorBoundary)
local CoreScriptsErrorBoundary2 = CoreScriptsErrorBoundary.CoreScriptsErrorBoundary
local Surfaces = CoreScriptsErrorBoundary.Surfaces

local FFlagCoreScriptsReactTreeCrashCounter = CoreScriptsErrorBoundary.Flags.FFlagCoreScriptsReactTreeCrashCounter

local FFlagTopBarDeprecateChatRodux = require(script.Flags.FFlagTopBarDeprecateChatRodux)
local FFlagTopBarDeprecateDisplayOptionsRodux = require(script.Flags.FFlagTopBarDeprecateDisplayOptionsRodux)
local FFlagTopBarRefactor = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagTopBarRefactor
local FFlagEnablePlaytestModeUnibar = SharedFlags.FFlagEnablePlaytestModeUnibar

local effect = nil
if var1 then
    if FFlagBuildExperienceInGameShell then
        local displayStore = Display.GetDisplayStore(false)
        displayStore.setGuiInset(function(arg1)
            return {
                left = arg1.left,
                top = Constants2.ApplyDisplayScale(Constants2.TopBarHeight),
                right = arg1.right,
                bottom = arg1.bottom
            }
        end)
        effect = Signals.createEffect(function(arg1)
            local guiInset = displayStore.getGuiInset(arg1)
            GuiService:SetGlobalGuiInset(guiInset.left, guiInset.top, guiInset.right, guiInset.bottom)
        end)
    else
        local function SetGlobalGuiInset()
            local vector2, vector2_2 = GuiService:GetGuiInset()
            GuiService:SetGlobalGuiInset(vector2.X, Constants2.ApplyDisplayScale(Constants2.TopBarHeight), vector2_2.X, vector2_2.Y)

            Display.GetDisplayStore().setGuiInset({
                left = vector2.X,
                top = Constants2.ApplyDisplayScale(Constants2.TopBarHeight),
                right = vector2_2.X,
                bottom = vector2_2.Y
            })
        end

        SetGlobalGuiInset()
    end
end

local TopBarApp = if FFlagTopBarRefactor then require(script.ComponentsV2.TopBarApp) else require(script.Components.TopBarApp)
local Reducer = require(script.Reducer)
local TopBarAppPolicy = require(script.TopBarAppPolicy)

local SetSmallTouchDevice = require(script.Actions.SetSmallTouchDevice)
local SetInspectMenuOpen = require(script.Actions.SetInspectMenuOpen)
local SetGamepadMenuOpen = require(script.Actions.SetGamepadMenuOpen)
local SetGamepadNavigationDialogOpen = require(script.Actions.SetGamepadNavigationDialogOpen)
local UpdateUnreadMessagesBadge = require(script.Actions.UpdateUnreadMessagesBadge)

local GetCanChat = require(script.Thunks.GetCanChat)
local GetGameName = require(script.Thunks.GetGameName)

local registerSetCores = require(script.registerSetCores)

local GlobalConfig = require(script.GlobalConfig)

local RoactAppExperiment = require(CorePackages.Packages.RoactAppExperiment)
local FFlagAddMenuNavigationToggleDialog = SharedFlags.FFlagAddMenuNavigationToggleDialog
local FFlagShowGameAgeRating = SharedFlags.FFlagShowGameAgeRating
local FFlagGamepadNavigationDialogABTest = require(script.Flags.FFlagGamepadNavigationDialogABTest)

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local Component = CrossExperienceVoice.Component

local FTUX = RobloxGui.Modules.FTUX
local GetFFlagEnableVRFTUXExperience = require(FTUX.Flags.GetFFlagEnableVRFTUXExperience)
local GetFFlagDebugEnableVRFTUXExperienceInStudio = require(FTUX.Flags.GetFFlagDebugEnableVRFTUXExperienceInStudio)
local PlatformEnum = require(FTUX.Enums.PlatformEnum)
local IsFTUXExperience = require(FTUX.Utility.IsFTUXExperience)
local FTUX2 = require(script.Parent.FTUX)
local isRunningInStudio = require(CorePackages.Workspace.Packages.AppCommonLib).isRunningInStudio
local isSpatial = require(CorePackages.Workspace.Packages.AppCommonLib).isSpatial
local connectToIsSpatialChanged = require(CorePackages.Workspace.Packages.AppCommonLib).connectToIsSpatialChanged
local FFlagStudioDeviceSimVRSwitchFixes = SharedFlags.FFlagStudioDeviceSimVRSwitchFixes

local function SpatialRemountGate()
    local var2, var3 = React.useState(isSpatial())
    React.useEffect(function()
        local var4 = connectToIsSpatialChanged(var3, true)
        return function()
            var4:Disconnect()
        end
    end, {})

    return React.createElement(
        React.Fragment,
        {
            key = if var2 then "spatial" else "flat"
        },
        {
            TopBarApp = React.createElement(TopBarApp)
        }
    )
end
local tbl1 = {}
tbl1.__index = tbl1
if FFlagBuildExperienceInGameShell then
    tbl1._disposeGlobalGuiInsetEffect = effect
end

function tbl1.new()
    local self = setmetatable({}, tbl1)

    if GlobalConfig.propValidation then
        Roact.setGlobalConfig({ propValidation = true })
    end

    if GlobalConfig.elementTracing then
        Roact.setGlobalConfig({ elementTracing = true })
    end

    if not (TenFootInterface:IsEnabled() or var1) then
        GuiService:SetGlobalGuiInset(0, Constants2.TopBarHeight, 0, 0)
    end

    if FFlagEnablePlaytestModeUnibar then
        require(script.initPlaytestMode)()
    end

    self.store = Rodux.Store.new(Reducer, nil, { Rodux.thunkMiddleware })

    if not FFlagTopBarSignalizeSetCores then
        registerSetCores(self.store)
    end

    if not FFlagTopBarDeprecateChatRodux then
        self.store:dispatch(GetCanChat)
    end

    if not FFlagTopBarDeprecateGameInfoRodux then
        self.store:dispatch(GetGameName)
    end

    if GetFFlagDebugEnableVRFTUXExperienceInStudio() and isRunningInStudio() then
        FTUX2.mountFtuxMenu(PlatformEnum.QuestVR)
    end

    if GetFFlagEnableVRFTUXExperience() and IsFTUXExperience(PlatformEnum.QuestVR) then
        FTUX2.mountFtuxMenu(PlatformEnum.QuestVR)
    end

    if isNewInGameMenuEnabled() then
        require(RobloxGui.Modules.InGameMenuInit).mountInGameMenu()
    end

    if not FFlagTopBarDeprecateDisplayOptionsRodux then
        coroutine.wrap(function()
            self.store:dispatch(SetSmallTouchDevice(Utility:IsSmallTouchScreen()))
        end)()
    end

    local style = {
        themeName = ColorMode.Dark,
        fontName = Constants.FontName.Gotham
    }

    local function wrapWithUiModeStyleProvider(tbl3: {LocalizationProvider: number})
        return {
            UiModeStyleProvider = Roact.createElement(UiModeStyleProvider, { style = style }, tbl3)
        }
    end

    local element = if FFlagStudioDeviceSimVRSwitchFixes then Roact.createElement(SpatialRemountGate) else Roact.createElement(TopBarApp)

    if FFlagAddMenuNavigationToggleDialog or FFlagGamepadNavigationDialogABTest then
        element = Roact.createElement(DesignTokenProvider, {
            tokenMappers = {
                MenuNavigationPrompt = if FFlagGamepadNavigationDialogABTest then MenuNavigationPromptTokenMapper else nil
            }
        }, { TopBarApp = element })
    end

    local topBarScrim = Service
        and FFlagAddTopBarScrim
        and React.createElement(
            "ScreenGui",
            {
                IgnoreGuiInset = true,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = -2
            },
            {
                TopBarScrim = React.createElement(TopBarScrim)
            }
        )
    local createElement = Roact.createElement
    local storeProvider = RoactRodux.StoreProvider
    local tbl3 = {
        store = self.store
    }
    local tbl4 = { PolicyProvider = 0 }
    local createElement2 = Roact.createElement
    local provider = if FFlagTopBarRefactor or FFlagShowGameAgeRating then RoactAppPolicy.Provider else TopBarAppPolicy.Provider
    local tbl5 = {
        policy = (FFlagTopBarRefactor or FFlagShowGameAgeRating) and { AppFeaturePolicies } or { TopBarAppPolicy.Mapper }
    }
    local tbl6 = {
        LocalizationProvider = Roact.createElement(
            LocalizationProvider,
            {
                localization = Localization.new(LocalizationService.RobloxLocaleId)
            },
            {
                ExperimentProvider = Roact.createFragment({
                    RoactAppExperimentProvider = Roact.createElement(
                        RoactAppExperiment.Provider,
                        { value = IXPService },
                        { TopBarApp = element, TopBarScrim = topBarScrim }
                    ),
                    CrossExperienceVoice = if GetFFlagEnableCrossExpVoice() then Roact.createElement(Component) or nil else nil
                })
            }
        )
    }
    tbl4.PolicyProvider = createElement2(provider, tbl5, (wrapWithUiModeStyleProvider(tbl6)))
    self.root = createElement(storeProvider, tbl3, tbl4)

    self.root = Roact.createElement(ReactSceneUnderstanding.SceneAnalysisProvider, nil, self.root)

    self.root = Roact.createElement(VoiceStateContext.Provider, nil, self.root)

    self.root = Roact.createElement("Folder", { Name = "TopBarApp" }, self.root)

    if FFlagCoreScriptsReactTreeCrashCounter then
        self.root = Roact.createElement(CoreScriptsErrorBoundary2, { surface = Surfaces.TopBar }, self.root)
    end

    if not require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.teamCreateUtils).isViewer() then
        self.element = Roact.mount(self.root, CoreGui, "TopBar")
    end

    if not FFlagTopBarDeprecateChatRodux then
        game:GetService("TextChatService").MessageReceived:Connect(function(textChatMessage: TextChatMessage)
            if shouldSkipHistoricalMessage(textChatMessage) then
                return
            end
            self.store:dispatch(UpdateUnreadMessagesBadge(1))
        end)
    end

    if FFlagGamepadNavigationDialogABTest and not FFlagTopBarDeprecateGamepadNavigationDialogRodux then
        local UserInputService = game:GetService("UserInputService")
        local connection = nil
        local function disconnectGamepadConnected() -- Luacid: Inlined by compiler; 1 call site recovered
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
        if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
            self:setGamepadNavigationDialogOpen(true)
        else
            connection = UserInputService.GamepadConnected:Connect(function()
                self:setGamepadNavigationDialogOpen(true)
                disconnectGamepadConnected()
            end)
        end

        GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(disconnectGamepadConnected)
    end

    return self
end

function tbl1:setInspectMenuOpen(arg1)
    if FFlagTopBarSignalizeMenuOpen then
        return
    end
    self.store:dispatch(SetInspectMenuOpen(arg1))
end

function tbl1:setGamepadMenuOpen(arg1)
    self.store:dispatch(SetGamepadMenuOpen(arg1))
end

function tbl1:setGamepadNavigationDialogOpen(arg1)
    if not FFlagTopBarDeprecateDisplayOptionsRodux then
        self.store:dispatch(SetGamepadNavigationDialogOpen(arg1))
    end
end

return tbl1.new()
