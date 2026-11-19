-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local ComputerCameraMovementModeChanged = UserGameSettings:GetPropertyChangedSignal("ComputerCameraMovementMode")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CoreUtility = require(RobloxGui.Modules.CoreUtility)

local LocalPlayer = Players.LocalPlayer
local var1 = CoreUtility.waitForChildOfClass(LocalPlayer, "PlayerScripts")
local DevComputerMovementModeChanged = LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local DropDownSelection = require(scriptParentParentParent.Components.DropDownSelection)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local InputLabel = require(script.Parent.InputLabel)
local DeveloperLockLabel = require(script.Parent.DeveloperLockLabel)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local tbl1 = {
    [Enum.ComputerCameraMovementMode.Classic] = "CoreScripts.InGameMenu.GameSettings.CameraModeClassic",
    [Enum.ComputerCameraMovementMode.Follow] = "CoreScripts.InGameMenu.GameSettings.CameraModeFollow",
    [Enum.ComputerCameraMovementMode.Default] = "CoreScripts.InGameMenu.GameSettings.Default",
    [Enum.ComputerCameraMovementMode.CameraToggle] = "CoreScripts.InGameMenu.GameSettings.CameraModeCameraToggle"
}

local var2 = Roact.PureComponent:extend("CameraModeEntry")
var2.validateProps = t.strictInterface({
    LayoutOrder = t.integer,
    canOpen = t.optional(t.boolean),
    canCaptureFocus = t.optional(t.boolean),
    ButtonRef = t.optional(t.union(t.callback, t.table))
})

var2.defaultProps = { canOpen = true }

function var2.init(arg1)
    arg1:setState({
        selectedComputerMode = UserGameSettings.ComputerCameraMovementMode,
        computerOptions = var1 and var1:GetRegisteredComputerCameraMovementModes() or {},
        developerComputerMode = LocalPlayer.DevComputerCameraMode
    })
end

function var2.render(arg1)
    local tbl2 = {
        ComputerCameraMovementModeListener = Roact.createElement(ExternalEventConnection, {
            event = ComputerCameraMovementModeChanged,
            callback = function()
                arg1:setState({ selectedComputerMode = UserGameSettings.ComputerCameraMovementMode })
            end
        }),
        ComputerCameraMovementModeRegisteredListener = var1
            and Roact.createElement(ExternalEventConnection, {
                event = var1.ComputerCameraMovementModeRegistered,
                callback = function()
                    arg1:setState({ computerOptions = var1:GetRegisteredComputerCameraMovementModes() })
                end
            }),
        LocalPlayerComputerMovementMode = Roact.createElement(ExternalEventConnection, {
            event = DevComputerMovementModeChanged,
            callback = function()
                arg1:setState({ developerComputerMode = LocalPlayer.DevComputerCameraMode })
            end
        })
    }

    if #arg1.state.computerOptions == 0 then
        return Roact.createFragment(tbl2)
    end

    local bool1 = arg1.state.developerComputerMode ~= Enum.DevComputerCameraMovementMode.UserChoice
    local selections = ({})
    local num1 = 0

    if not bool1 then
        for i, computerOption in ipairs(arg1.state.computerOptions) do
            selections[i] = tbl1[computerOption]
            assert(selections[i] ~= nil, "Camera movement mode " .. computerOption.Name .. " has no localization key")

            if arg1.state.selectedComputerMode.Value == computerOption.Value then
                num1 = i
            end
        end
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, 120),
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.LayoutOrder,
        ZIndex = 2
    }
    local tbl5 = {
        Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
        InputLabel = Roact.createElement(InputLabel, {
            localizationKey = "CoreScripts.InGameMenu.GameSettings.CameraMode",
            Size = UDim2.new(1, 0, 0, 56),
            Position = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0, 0)
        }),
        Dropdown = 0,
        LockedLabel = 0
    }
    local var3 = withLocalization
    local tbl6 = {
        placeholder = if bool1 then tbl1[arg1.state.developerComputerMode] or nil else nil
    }

    tbl5.Dropdown = var3(tbl6)(function(_)
        return Roact.createElement(DropDownSelection, {
            Size = UDim2.new(1, 0, 0, 44),
            Position = UDim2.new(0, 0, 0, 56),
            selections = selections,
            selectedIndex = num1,
            placeHolderText = arg1.state.developerComputerMode.Name,
            enabled = not bool1,
            localize = true,
            selectionChanged = function(arg2)
                UserGameSettings.ComputerCameraMovementMode = arg1.state.computerOptions[arg2]
                SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
            end,
            selectionParentName = "cameraModeDropdown",
            canOpen = arg1.props.canOpen,
            canCaptureFocus = arg1.props.canCaptureFocus,
            ButtonRef = arg1.props.ButtonRef
        })
    end)
    tbl5.LockedLabel = bool1
        and Roact.createElement(
            DeveloperLockLabel,
            {
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(0, 0, 1, 0),
                Size = UDim2.new(1, -72, 0.25, 0)
            }
        )
    tbl2.CameraModeEntrySelector = createElement(str1, tbl4, tbl5)

    return Roact.createFragment(tbl2)
end

return var2
