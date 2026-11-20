-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local GamepadService = game:GetService("GamepadService")
local AppCommonLib = require(CorePackages.Workspace.Packages.AppCommonLib)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local inputModeStore = Responsive.GetInputModeStore(false)
local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local AppUserLayers = require(CorePackages.Workspace.Packages.ExperimentLayers).AppUserLayers
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local Signals = require(CorePackages.Packages.Signals)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagShowUnibarOnVirtualCursor = SharedFlags.FFlagShowUnibarOnVirtualCursor
local FFlagConsoleChatUseChromeFocusUtils = SharedFlags.FFlagConsoleChatUseChromeFocusUtils
local FFlagExperienceMenuGamepadExposureEnabled = SharedFlags.FFlagExperienceMenuGamepadExposureEnabled
local engineFeature = game:GetEngineFeature("PTFBackButtonAlwaysAsButtonB")

local FFlagAddNewPlayerListFocusNav = PlayerList.Flags.FFlagAddNewPlayerListFocusNav
local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav

local scriptParentParentParent = script.Parent.Parent.Parent
local TopBar = scriptParentParentParent.TopBar

local FFlagAddTopBarScrim = require(TopBar.Flags.FFlagAddTopBarScrim)
local FFlagUseObservableDefaultForChromeFocused = require(TopBar.Flags.FFlagUseObservableDefaultForChromeFocused)

local isSpatial = AppCommonLib.isSpatial
local LogGamepadOpenExperienceControlsMenu = require(TopBar:WaitForChild("Telemetry")).LogGamepadOpenExperienceControlsMenu
local Chrome = scriptParentParentParent.Chrome
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local Service = if var1 then require(Chrome.Service) else nil
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local FocusUtils = require(CorePackages.Workspace.Packages.Chrome).FocusUtils
local ObservableValue = if FFlagUseObservableDefaultForChromeFocused or var1 and FFlagEnableConsoleExpControls then ChromeUtils.ObservableValue else nil
local Constants = if var1 then require(Chrome.ChromeShared.Unibar.Constants) else nil
local ToastNotificationConstants = require(CorePackages.Workspace.Packages.ToastNotification).ToastNotificationConstants
local Constants2 = require(script.Parent.Parent.Constants)
local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal
local PlayerList2 = scriptParentParentParent.PlayerList
local PlayerListManager = require(PlayerList2.PlayerListManager)
local MenuIconSelectedSignal = FocusUtils.MenuIconSelectedSignal
local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagEnableUISelector = CoreGuiCommon.Flags.FFlagEnableUISelector
local GetUiSelectorSignalStore = if FFlagEnableUISelector then CoreGuiCommon.Stores.GetUiSelectorSignalStore else nil
local var2 = require(CorePackages.Workspace.Packages.ExpChat).Stores.GetFocusNavigationStore(false)

local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav
local getSideSheetVisibility = require(CorePackages.Workspace.Packages.InExperienceSideSheet).getSideSheetVisibility

local ToastNotification = nil
local ToastNotificationWrapper = nil
local Toast = nil
task.spawn(function()
    ToastNotification = CoreGui:WaitForChild("ToastNotification", 3)
    ToastNotificationWrapper = if ToastNotification == nil then nil else ToastNotification:WaitForChild("ToastNotificationWrapper", 3)
    Toast = if ToastNotificationWrapper == nil then nil else ToastNotificationWrapper:FindFirstChild("Toast", true)
end)

local function createSelectedCoreObject() -- Luacid: Inlined by compiler; 1 call site recovered
    local observableValue = ObservableValue.new(GuiService.SelectedCoreObject)
    GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function()
        observableValue:set(GuiService.SelectedCoreObject)
    end)

    return observableValue
end

local function isInputGamepad(userInputType: Enum.UserInputType) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in Constants2.GamepadInputTypes do
        if userInputType == value then
            return true
        end
    end
    return false
end

local module = ({})
module.__index = module

function module.new()
    local tbl1 = {
        _loggedExperienceMenuGamepadExposure = false,
        _devSetCoreGuiNavEnabled = GuiService.CoreGuiNavigationEnabled,
        _chromeFocused = if Service then Service:inFocusNav() elseif FFlagUseObservableDefaultForChromeFocused then ObservableValue.new(false) else false,
        _lastMenuButtonPress = 0,
        _dismissFocusConnections = {},
        _selectedCoreObject = if var1 and FFlagEnableConsoleExpControls then createSelectedCoreObject() else nil,
        _connections = {}
    }

    if var1 and FFlagEnableConsoleExpControls then
        tbl1._gamepadActive = ObservableValue.new((isInputGamepad((UserInputService:GetLastInputType()))))
        tbl1._tiltMenuOpen = ObservableValue.new(false)
        tbl1._playerListModalOpen = if FFlagAddNewPlayerListFocusNav then ObservableValue.new(false) else nil

        tbl1._showTopBar = ObservableValue.new(true)

        UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
            tbl1._gamepadActive:set((isInputGamepad(lastInputType)))
        end)

        SettingsShowSignal:connect(function(arg1)
            tbl1._tiltMenuOpen:set(arg1)
        end)

        if FFlagAddNewPlayerListFocusNav then
            PlayerListManager:GetVisibilityChangedEvent().Event:Connect(function()
                local var3 = not FFlagAddNewPlayerListMobileFocusNav or PlayerListManager:GetIsModal()
                tbl1._playerListModalOpen:set(var3 and PlayerListManager:GetVisibility())
            end)
        end

        if not isSpatial() then
            local function func1()
                local var3 = not tbl1._gamepadActive:get()
                    or tbl1._chromeFocused:get()
                    or tbl1._selectedCoreObject:get() ~= nil
                        and not (FFlagEnableUISelector and GetUiSelectorSignalStore(false).getVisibility())
                    or UserInputService.TouchEnabled
                    or tbl1._tiltMenuOpen:get()
                    or FFlagAddNewPlayerListFocusNav and tbl1._playerListModalOpen:get()
                    or FFlagShowUnibarOnVirtualCursor and GamepadService.GamepadCursorEnabled
                    or GamepadService.GamepadCursorEnabled
                tbl1._showTopBar:set(var3)
                if var3 then
                    GuiService.CoreGuiNavigationEnabled = true
                    return
                end
                GuiService.CoreGuiNavigationEnabled = tbl1._devSetCoreGuiNavEnabled
            end

            tbl1._selectedCoreObject:connect(func1)
            tbl1._chromeFocused:connect(func1)
            tbl1._tiltMenuOpen:connect(func1)
            GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(func1)
            tbl1._gamepadActive:connect(func1, true)
        end
    end

    if FFlagEnableConsoleExpControls then
        GuiService:GetPropertyChangedSignal("CoreGuiNavigationEnabled"):Connect(function()
            tbl1._devSetCoreGuiNavEnabled = GuiService.CoreGuiNavigationEnabled
        end)
    end
    function tbl1._isTopBarFocused()
        return not GamepadService.GamepadCursorEnabled and (tbl1._chromeFocused:get() or MenuIconSelectedSignal:get())
    end

    if FFlagAddTopBarScrim then
        local var3 = tbl1._isTopBarFocused()
        local _topBarFocused, _setTopBarFocused = Signals.createSignal(var3)
        tbl1._topBarFocused = _topBarFocused
        tbl1._setTopBarFocused = _setTopBarFocused
    end

    return (setmetatable(tbl1, module))
end

function module:connectToTopbar()
    if not var1 then
        return
    end

    if FFlagEnableConsoleExpControls then
        self:disconnectFromTopbar()
    end
    ContextActionService:BindCoreAction(
        "FocusGamepadToTopbar",
        self:_bindSelf(self._toggleTopbar),
        false,
        Enum.KeyCode.ButtonStart
    )
    if engineFeature then
        ContextActionService:BindCoreAction(
            "ToggleUISelector",
            self:_bindSelf(self._toggleUiSelector),
            false,
            Enum.KeyCode.ButtonB
        )
    end
    local function func1()
        local open = self:_isTopBarFocused()
        GuiService:SetMenuIsOpen(open, "TopbarMenu")
        if FFlagAddTopBarScrim then
            self._setTopBarFocused(open)
        end

        if open then
            Service:setShortcutBar(Constants.UNIBAR_SHORTCUTBAR_ID)
            self:_addDismissFocusConnections()
            return
        end
        self:_removeDismissFocusConnections()
    end

    table.insert(self._connections, self._chromeFocused:connect(func1))
    table.insert(self._connections, MenuIconSelectedSignal:connect(func1))
end

function module:disconnectFromTopbar()
    for _, _connection in self._connections do
        _connection:disconnect()
    end
    self._connections = {}
    self:_removeDismissFocusConnections()

    ContextActionService:UnbindCoreAction("FocusGamepadToTopbar")
    if engineFeature then
        ContextActionService:UnbindCoreAction("ToggleUISelector")
    end
end

function module:getSelectedCoreObject()
    return self._selectedCoreObject
end

function module:getShowTopBar()
    return self._showTopBar
end

function module:getGamepadActive()
    return self._gamepadActive
end

function module:topBarFocused(arg1)
    if FFlagAddTopBarScrim then
        return self._topBarFocused(arg1)
    end
end

function module:_addDismissFocusConnections()
    self._dismissFocusConnections = {
        (UserInputService.InputEnded:Connect(function(input: InputObject, gameProcessedEvent: boolean)
            local lastInputType = inputModeStore.getLastInputType(false)
            local bool1 = lastInputType == Responsive.Input.Pointer and input.UserInputType ~= Enum.UserInputType.Keyboard
            local bool2 = lastInputType == Responsive.Input.Touch
            if bool1 or bool2 and not gameProcessedEvent then
                self:_unfocusGamepadFromTopBar()
            end
        end))
    }
end

function module:_removeDismissFocusConnections()
    for _, _dismissFocusConnection in self._dismissFocusConnections do
        _dismissFocusConnection:Disconnect()
    end
    self._dismissFocusConnections = {}
end

function module._toggleTopbar(arg1, arg2, userInputState, arg3)
    if not var1
        or arg1:_focusToastNotification(userInputState)
        or (FFlagEnableConsoleExpControls or userInputState ~= Enum.UserInputState.End)
            and (not FFlagEnableConsoleExpControls or userInputState ~= Enum.UserInputState.Begin)
    then
        return Enum.ContextActionResult.Pass
    end

    if not engineFeature
        and FFlagEnableUISelector
        and not UserInputService:GamepadSupports(UserInputService:GetLastInputType(), Enum.KeyCode.ButtonSelect)
    then
        return arg1:_toggleUiSelector(arg2, userInputState, arg3)
    end

    if FFlagEnableConsoleExpControls then
        if Service:integrations().nine_dot == nil then
            return Enum.ContextActionResult.Pass
        end
        if isSideSheetEnabled and FFlagSideSheetFocusNav and getSideSheetVisibility() then
            return Enum.ContextActionResult.Pass
        end
        local bool1 = not (arg1:_isTopBarFocused() or var2.getChatInputBarFocused(false))
        if bool1 then
            arg1:_focusGamepadToTopBar()
        else
            arg1:_unfocusGamepadFromTopBar()
        end
        arg1:_logExperienceMenuGamepadExposure()
        LogGamepadOpenExperienceControlsMenu(bool1)
    else
        arg1:_toggleUnibarMenu()
    end

    if FFlagAddNewPlayerListMobileFocusNav and PlayerListManager:GetIsModal() and PlayerListManager:GetVisibility() then
        PlayerListManager:SetVisibility(false)
    end

    return Enum.ContextActionResult.Sink
end

function module._toggleUiSelector(arg1, _, userInputState, _)
    if FFlagEnableUISelector
        and var1
        and not arg1:_focusToastNotification(userInputState)
        and (not FFlagEnableConsoleExpControls and userInputState == Enum.UserInputState.End
            or FFlagEnableConsoleExpControls and userInputState == Enum.UserInputState.Begin)
        and not UserInputService:GamepadSupports(UserInputService:GetLastInputType(), Enum.KeyCode.ButtonSelect)
    then
        if GamepadService.GamepadCursorEnabled or GuiService.SelectedObject ~= nil then
            GamepadService:DisableGamepadCursor()
            GuiService.SelectedObject = nil
            return Enum.ContextActionResult.Sink
        end

        local uiSelectorSignalStore = GetUiSelectorSignalStore(false)
        if uiSelectorSignalStore.getVisibility(false) then
            uiSelectorSignalStore.setVisibility(false)
            return Enum.ContextActionResult.Sink
        end

        if not arg1:_isTopBarFocused() then
            uiSelectorSignalStore.setVisibility(true)
            return Enum.ContextActionResult.Sink
        end
    end

    return Enum.ContextActionResult.Pass
end

function module:_toggleUnibarMenu()
    local var3 = self._chromeFocused:get()
    if var3 then
        if FFlagEnableConsoleExpControls then
            self:_unfocusGamepadFromTopBar()
        else
            Service:disableFocusNav()
        end
    elseif FFlagEnableConsoleExpControls then
        self:_focusGamepadToTopBar()
    else
        Service:enableFocusNav()
    end

    self:_logExperienceMenuGamepadExposure()
    LogGamepadOpenExperienceControlsMenu(var3)
end

function module:_focusGamepadToTopBar()
    FocusUtils.FocusOnChrome()
end

function module:_unfocusGamepadFromTopBar()
    FocusUtils.FocusOffChrome(function()
        if FFlagConsoleChatUseChromeFocusUtils and var2.getChatInputBarFocused(false) then
            var2.unfocusChatInputBar()
        end
        GuiService.SelectedCoreObject = nil
    end)
end

function module:_focusToastNotification(userInputState)
    local function buttonHoldTime() -- Luacid: Inlined by compiler; 1 call site recovered
        return tick() - self._lastMenuButtonPress
    end

    local toastVisible = not (Toast == nil) and Toast.Visible

    if userInputState == Enum.UserInputState.Begin then
        self._lastMenuButtonPress = tick()
        return false
    end

    return userInputState == Enum.UserInputState.End
        and toastVisible
        and buttonHoldTime() < ToastNotificationConstants.MenuButtonPressHoldTime
end

function module:_logExperienceMenuGamepadExposure()
    if FFlagExperienceMenuGamepadExposureEnabled and not self._loggedExperienceMenuGamepadExposure then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(AppUserLayers.ExperienceMenuGamepadExposureLayer)
        self._loggedExperienceMenuGamepadExposure = true
    end
end

function module:_bindSelf(func1: (...any) -> (...any))
    return function(...)
        return func1(self, ...)
    end
end

if FFlagEnableConsoleExpControls then
    return (module.new())
end
return module
