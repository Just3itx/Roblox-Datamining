-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")
local VRService = game:GetService("VRService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local platform = game:GetService("UserInputService"):GetPlatform()
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local LocalPlayer = Players.LocalPlayer
local DevEnableMouseLockChanged = LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock")

local IsUsingCameraYInvertedChanged = UserGameSettings:GetPropertyChangedSignal("IsUsingCameraYInverted")

local FocusHandler = require(script.Parent.Parent.Connection.FocusHandler)

local scriptParentParentParent = script.Parent.Parent.Parent

local Divider = require(scriptParentParentParent.Components.Divider)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)
local Page = require(scriptParentParentParent.Components.Page)
local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)
local Assets = require(scriptParentParentParent.Resources.Assets)

local SetCurrentPage = require(scriptParentParentParent.Actions.SetCurrentPage)

local AutoPropertyToggleEntry = require(script.Parent.AutoPropertyToggleEntry)
local SafetyBubbleModeEntry = require(script.Parent.SafetyBubbleModeEntry)
local ComfortSettingsEntry = if game:GetEngineFeature("VRMoreComfortSettings") then require(script.Parent.ComfortSettingsEntry) else nil

local CameraModeEntry = require(script.Parent.CameraModeEntry)
local CameraSensitivityEntry = require(script.Parent.CameraSensitivityEntry)
local CategoryHeader = require(script.Parent.CategoryHeader)
local DeviceSelectionEntry = require(script.Parent.DeviceSelectionEntry)
local GraphicsQualityEntry = require(script.Parent.GraphicsQualityEntry)
local MovementModeEntry = require(script.Parent.MovementModeEntry)
local ToggleEntry = require(script.Parent.ToggleEntry)
local VolumeEntry = require(script.Parent.VolumeEntry)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Flags = scriptParentParentParent.Flags
local GetFFlagIGMGamepadSelectionHistory = require(Flags.GetFFlagIGMGamepadSelectionHistory)
local GetFFlagAlwaysShowVRToggle = require(RobloxGui.Modules.Flags.GetFFlagAlwaysShowVRToggle)

local engineFeature = game:GetEngineFeature("VRMoreComfortSettings")

local VREnabledChanged = UserGameSettings:GetPropertyChangedSignal("VREnabled")
local IsVRAppBuild = require(CorePackages.Workspace.Packages.AppCommonLib).IsVRAppBuild

local var3 = Roact.PureComponent:extend("BasicPage")
var3.validateProps = t.strictInterface({
    switchToAdvancedPage = t.callback,
    switchToVRComfortSettingsPage = t.callback,
    pageTitle = t.string,
    isMenuOpen = t.boolean,
    currentPage = t.optional(t.string),
    canCaptureFocus = t.optional(t.boolean),
    canGamepadCaptureFocus = t.optional(t.boolean),
    vrService = t.optional(t.union(t.Instance, t.table)),
    isVRAppBuild = t.optional(t.callback),
    currentZone = if GetFFlagIGMGamepadSelectionHistory() then t.optional(t.number) or nil else nil
})

var3.defaultProps = { vrService = VRService, isVRAppBuild = IsVRAppBuild }

local VREnabled = UserGameSettings.VREnabled

function var3.init(arg1)
    arg1:setState({
        shiftLockEnabled = LocalPlayer.DevEnableMouseLock,
        fullScreenEnabled = UserGameSettings:InFullScreen(),
        invertedCameraEnabled = UserGameSettings.IsUsingCameraYInverted,
        vrActive = arg1.props.vrService.VREnabled,
        vrEnabled = UserGameSettings.VREnabled,
        voiceChatEnabled = false
    })

    local pageSize, setPageSize = Roact.createBinding(UDim2.new(0, 0, 0, 0))
    arg1.pageSize = pageSize
    arg1.setPageSize = setPageSize

    arg1.cameraModeButton = Roact.createRef()
    arg1.volumeButton = Roact.createRef()
end

function var3.didUpdate(arg1, arg2)
    if GetFFlagIGMGamepadSelectionHistory()
        or not arg1.props.canCaptureFocus
        or not arg1.props.canGamepadCaptureFocus
        or arg2.canCaptureFocus and arg2.canGamepadCaptureFocus
    then
        return
    end
    if not arg1.state.vrActive then
        GuiService.SelectedCoreObject = arg1.cameraModeButton:getValue()
        return
    end
    GuiService.SelectedCoreObject = arg1.volumeButton:getValue()
end

local function createLayoutOrderGenerator(): () -> number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 0
    return function(): number
        num1 += 1
        return num1
    end
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local layoutOrderGenerator = createLayoutOrderGenerator()
    local var4 = arg1.state.voiceChatEnabled and not arg1.props.isVRAppBuild()
    local bool1 = if GetFFlagAlwaysShowVRToggle() then platform == Enum.Platform.Windows or platform == Enum.Platform.UWP else (arg1.state.vrActive or UserGameSettings.HasEverUsedVR) and not arg1.props.isVRAppBuild()
    local createElement = Roact.createElement
    local var5 = Page
    local tbl1 = {
        pageTitle = arg1.props.pageTitle,
        position = arg1.props.position
    }
    local tbl2 = { FocusHandler = 0, PageContents = 0 }
    local element

    if GetFFlagIGMGamepadSelectionHistory() then
        element = Roact.createElement(FocusHandler, {
            isFocused = arg1.props.canCaptureFocus and arg1.props.canGamepadCaptureFocus,
            shouldForgetPreviousSelection = arg1.props.currentPage == Constants.MainPagePageKey or arg1.props.currentZone == 0,
            didFocus = function(selectedCoreObject)
                if selectedCoreObject then
                    GuiService.SelectedCoreObject = selectedCoreObject
                elseif not arg1.state.vrActive then
                    GuiService.SelectedCoreObject = arg1.cameraModeButton:getValue()
                else
                    GuiService.SelectedCoreObject = arg1.volumeButton:getValue()
                end
            end
        })
            or nil
    else
        element = nil
    end

    tbl2.FocusHandler = element

    local createElement2 = Roact.createElement
    local str1 = "ScrollingFrame"
    local tbl3 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = arg1.pageSize,
        Position = arg1.props.position,
        Size = UDim2.new(1, 0, 1, 0),
        Selectable = false
    }
    local tbl4 = {}
    local createElement3 = Roact.createElement
    local tbl5 = {
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top
    }

    tbl5[Roact.Change.AbsoluteContentSize] = function(arg3)
        arg1.setPageSize(UDim2.new(0, 0, 0, arg3.AbsoluteContentSize.Y))
    end

    tbl4.Layout = createElement3("UIListLayout", tbl5)

    tbl4.VRControlsHeader = if arg1.state.vrActive then Roact.createElement(
        CategoryHeader,
        {
            LayoutOrder = layoutOrderGenerator(),
            localizationKey = "CoreScripts.InGameMenu.GameSettings.VrControlsTitle"
        }
    ) else nil

    tbl4.VignetteEnabled = if engineFeature or not arg1.state.vrActive then nil else Roact.createElement(
        AutoPropertyToggleEntry,
        {
            LayoutOrder = layoutOrderGenerator(),
            labelKey = "CoreScripts.InGameMenu.GameSettings.VignetteEnabled",
            instance = UserGameSettings,
            valueKey = "VignetteEnabled"
        }
    )

    tbl4.VRSmoothRotationEnabled = if engineFeature or not arg1.state.vrActive then nil else Roact.createElement(
        AutoPropertyToggleEntry,
        {
            LayoutOrder = layoutOrderGenerator(),
            labelKey = "CoreScripts.InGameMenu.GameSettings.VRSmoothRotationEnabled",
            instance = UserGameSettings,
            valueKey = "VRSmoothRotationEnabled"
        }
    )

    tbl4.VRComfortSettings = if engineFeature and arg1.state.vrActive then Roact.createElement(ComfortSettingsEntry, { LayoutOrder = layoutOrderGenerator() }) else nil
    local var6

    if engineFeature and arg1.state.vrActive then
        local createElement4 = Roact.createElement
        local tbl6 = {
            LayoutOrder = layoutOrderGenerator(),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 54),
            Text = "",
            [Roact.Event.Activated] = arg1.props.switchToVRComfortSettingsPage
        }

        var6 = createElement4("TextButton", tbl6, {
            Text = withLocalization({ text = "CoreScripts.InGameMenu.GameSettings.SwitchToVRComfortSettings" })(function(arg3)
                return Roact.createElement(ThemedTextLabel, {
                    Text = arg3.text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    fontKey = "Body",
                    themeKey = "TextDefault",
                    Size = UDim2.new(1, -96, 1, 0),
                    Position = UDim2.new(0, 24, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5)
                })
            end),
            Icon = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = Assets.Images.NavigateForward,
                Size = UDim2.new(0, 36, 0, 36),
                Position = UDim2.new(1, -36, 0.5, 0),
                AnchorPoint = Vector2.new(1, 0.5)
            })
        })
    else
        var6 = nil
    end

    tbl4.VRComfortSettingsPageButton = var6

    tbl4.VRMode = if bool1 then Roact.createElement(AutoPropertyToggleEntry, {
        LayoutOrder = layoutOrderGenerator(),
        labelKey = "CoreScripts.InGameMenu.GameSettings.VREnabled",
        instance = UserGameSettings,
        valueKey = "VREnabled",
        subtextEnabled = arg1.state.vrEnabled ~= VREnabled,
        subtextKey = "CoreScripts.InGameMenu.GameSettings.RestartPending"
    }) else nil

    tbl4.VRSafetyBubbleMode = if arg1.state.vrActive then Roact.createElement(SafetyBubbleModeEntry, { LayoutOrder = layoutOrderGenerator() }) else nil

    tbl4.VRControlsDivider = if arg1.state.vrActive then Roact.createElement(Divider, { LayoutOrder = layoutOrderGenerator(), Size = UDim2.new(1, -24, 0, 1) }) else nil

    tbl4.CameraHeader = if arg1.state.vrActive then nil else Roact.createElement(
        CategoryHeader,
        {
            LayoutOrder = layoutOrderGenerator(),
            localizationKey = "CoreScripts.InGameMenu.GameSettings.CameraTitle"
        }
    )

    tbl4.CameraMode = not arg1.state.vrActive
        and Roact.createElement(CameraModeEntry, {
            LayoutOrder = layoutOrderGenerator(),
            ButtonRef = arg1.cameraModeButton,
            canOpen = arg1.props.canCaptureFocus,
            canCaptureFocus = arg1.props.canGamepadCaptureFocus
        })
    tbl4.InvertedCamera = not arg1.state.vrActive
        and arg1.state.invertedCameraEnabled
        and Roact.createElement(AutoPropertyToggleEntry, {
            LayoutOrder = layoutOrderGenerator(),
            labelKey = "CoreScripts.InGameMenu.GameSettings.InvertedCamera",
            instance = UserGameSettings,
            valueKey = "CameraYInverted"
        })

    tbl4.CameraSensitivity = not arg1.state.vrActive
        and Roact.createElement(CameraSensitivityEntry, {
            LayoutOrder = layoutOrderGenerator(),
            canCaptureFocus = arg1.props.canCaptureFocus and arg1.props.canGamepadCaptureFocus,
            isMenuOpen = arg1.props.isMenuOpen
        })
    tbl4.CameraDivider = if arg1.state.vrActive then nil else Roact.createElement(Divider, { LayoutOrder = layoutOrderGenerator(), Size = UDim2.new(1, -24, 0, 1) })

    tbl4.ControlsHeader = Roact.createElement(
        CategoryHeader,
        {
            LayoutOrder = layoutOrderGenerator(),
            localizationKey = "CoreScripts.InGameMenu.GameSettings.ControlsAudio"
        }
    )
    tbl4.ShiftLock = not arg1.state.vrActive
        and Roact.createElement(AutoPropertyToggleEntry, {
            LayoutOrder = layoutOrderGenerator(),
            labelKey = "CoreScripts.InGameMenu.GameSettings.ShiftLock",
            instance = UserGameSettings,
            valueKey = "ControlMode",
            onValue = Enum.ControlMode.MouseLockSwitch,
            offValue = Enum.ControlMode.Classic,
            lockedToOff = not arg1.state.shiftLockEnabled
        })
    tbl4.MovementMode = not arg1.state.vrActive
        and Roact.createElement(MovementModeEntry, {
            LayoutOrder = layoutOrderGenerator(),
            canOpen = arg1.props.canCaptureFocus,
            canCaptureFocus = arg1.props.canGamepadCaptureFocus
        })
    tbl4.VolumeEntry = Roact.createElement(VolumeEntry, {
        LayoutOrder = layoutOrderGenerator(),
        buttonRef = arg1.volumeButton,
        canCaptureFocus = arg1.props.canCaptureFocus and arg1.props.canGamepadCaptureFocus,
        isMenuOpen = arg1.props.isMenuOpen
    })
    tbl4.HapticsToggle = Roact.createElement(AutoPropertyToggleEntry, {
        LayoutOrder = layoutOrderGenerator(),
        labelKey = "Feature.Accessibility.Header.Haptics",
        instance = UserGameSettings,
        valueKey = "HapticStrength",
        onValue = 1,
        offValue = 0
    })

    tbl4.InputDevice = var4
        and Roact.createElement(DeviceSelectionEntry, {
            LayoutOrder = layoutOrderGenerator(),
            deviceType = DeviceSelectionEntry.DeviceType.Input,
            isMenuOpen = arg1.props.isMenuOpen,
            canOpen = arg1.props.canCaptureFocus,
            canCaptureFocus = arg1.props.canGamepadCaptureFocus
        })
    tbl4.OutputDevice = var4
        and Roact.createElement(DeviceSelectionEntry, {
            LayoutOrder = layoutOrderGenerator(),
            deviceType = DeviceSelectionEntry.DeviceType.Output,
            isMenuOpen = arg1.props.isMenuOpen,
            canOpen = arg1.props.canCaptureFocus,
            canCaptureFocus = arg1.props.canGamepadCaptureFocus
        })
    tbl4.ControlsDivider = Roact.createElement(Divider, { LayoutOrder = layoutOrderGenerator(), Size = UDim2.new(1, -24, 0, 1) })

    tbl4.GraphicsHeader = Roact.createElement(
        CategoryHeader,
        {
            LayoutOrder = layoutOrderGenerator(),
            localizationKey = "CoreScripts.InGameMenu.GameSettings.GraphicsTitle"
        }
    )
    tbl4.GraphicsQualityEntry = Roact.createElement(GraphicsQualityEntry, {
        LayoutOrder = layoutOrderGenerator(),
        canCaptureFocus = arg1.props.canCaptureFocus and arg1.props.canGamepadCaptureFocus,
        isMenuOpen = arg1.props.isMenuOpen
    })
    tbl4.FullScreen = not arg1.state.vrActive
        and Roact.createElement(ToggleEntry, {
            LayoutOrder = layoutOrderGenerator(),
            labelKey = "CoreScripts.InGameMenu.GameSettings.FullScreen",
            checked = arg1.state.fullScreenEnabled,
            onToggled = function()
                GuiService:ToggleFullscreen()
                SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
            end
        })
    tbl4.GraphicsDivider = Roact.createElement(Divider, { LayoutOrder = layoutOrderGenerator(), Size = UDim2.new(1, -24, 0, 1) })

    local createElement4 = Roact.createElement
    local tbl6 = {
        LayoutOrder = layoutOrderGenerator(),
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 54),
        Text = "",
        SelectionImageObject = arg2(var2.Square),
        [Roact.Event.Activated] = arg1.props.switchToAdvancedPage
    }

    tbl4.AdvancedSettings = createElement4("TextButton", tbl6, {
        Text = withLocalization({ text = "CoreScripts.InGameMenu.GameSettings.SwitchToAdvancedSettings" })(function(arg3)
            return Roact.createElement(ThemedTextLabel, {
                Text = arg3.text,
                TextXAlignment = Enum.TextXAlignment.Left,
                fontKey = "Body",
                themeKey = "TextDefault",
                Size = UDim2.new(1, -96, 1, 0),
                Position = UDim2.new(0, 24, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
            })
        end),
        Icon = Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Image = Assets.Images.NavigateForward,
            Size = UDim2.new(0, 36, 0, 36),
            Position = UDim2.new(1, -36, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5)
        })
    })
    tbl4.AdvancedDivider = Roact.createElement(Divider, { LayoutOrder = layoutOrderGenerator(), Size = UDim2.new(1, -24, 0, 1) })

    tbl4.ShiftLockEnabledListener = Roact.createElement(ExternalEventConnection, {
        event = DevEnableMouseLockChanged,
        callback = function()
            arg1:setState({ shiftLockEnabled = LocalPlayer.DevEnableMouseLock })
        end
    })

    tbl4.FullScreenListener = Roact.createElement(ExternalEventConnection, {
        event = UserGameSettings.FullscreenChanged,
        callback = function(arg3)
            arg1:setState({ fullScreenEnabled = arg3 })

            SendAnalytics(Constants.AnalyticsInGameMenuName, Constants.AnalyticsFullscreenModeName, { enabled = arg3 })
        end
    })

    tbl4.CameraYInvertedListener = Roact.createElement(ExternalEventConnection, {
        event = IsUsingCameraYInvertedChanged,
        callback = function()
            arg1:setState({ invertedCameraEnabled = UserGameSettings.IsUsingCameraYInverted })
        end
    })

    tbl4.VRActiveListener = Roact.createElement(ExternalEventConnection, {
        event = arg1.props.vrService:GetPropertyChangedSignal("VREnabled"),
        callback = function()
            if arg1.props.vrService.VREnabled then
                UserGameSettings.HasEverUsedVR = true
            end
            arg1:setState({ vrActive = arg1.props.vrService.VREnabled })
        end
    })

    tbl4.VREnabledListener = Roact.createElement(ExternalEventConnection, {
        event = VREnabledChanged,
        callback = function()
            arg1:setState({ vrEnabled = UserGameSettings.VREnabled })
        end
    })

    tbl2.PageContents = createElement2(str1, tbl3, tbl4)
    return createElement(var5, tbl1, tbl2)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

function var3.didMount(arg1)
    spawn(function()
        require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default:asyncInit():andThen(function()
            arg1:setState({ voiceChatEnabled = true })
        end):catch(function() end)
    end)
end

return RoactRodux.UNSTABLE_connect2(function(arg1)
    local canCaptureFocus = arg1.menuPage == "GameSettings" and arg1.isMenuOpen and not arg1.respawn.dialogOpen
    local canGamepadCaptureFocus = arg1.displayOptions.inputType == Constants.InputType.Gamepad and arg1.currentZone == 1
    local currentZone = if GetFFlagIGMGamepadSelectionHistory() then arg1.currentZone else nil
    return {
        isMenuOpen = arg1.isMenuOpen,
        currentPage = arg1.menuPage,
        currentZone = currentZone,
        canCaptureFocus = canCaptureFocus,
        canGamepadCaptureFocus = canGamepadCaptureFocus
    }
end, function(callback)
    return {
        switchToAdvancedPage = function()
            callback(SetCurrentPage(Constants.advancedSettingsPageKey))
        end,
        switchToVRComfortSettingsPage = function()
            callback(SetCurrentPage(Constants.vrComfortSettingsPageKey))
        end
    }
end)(var3)
