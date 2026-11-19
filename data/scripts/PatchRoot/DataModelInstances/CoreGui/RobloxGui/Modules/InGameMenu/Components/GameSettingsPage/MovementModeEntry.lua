-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local ComputerMovementModeChanged = UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode")

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
    [Enum.ComputerMovementMode.KeyboardMouse] = "CoreScripts.InGameMenu.GameSettings.ComputerMoveModeKeyboardMouse",
    [Enum.ComputerMovementMode.ClickToMove] = "CoreScripts.InGameMenu.GameSettings.ComputerMoveModeClickToMove",
    [Enum.ComputerMovementMode.Default] = "CoreScripts.InGameMenu.GameSettings.Default"
}

local tbl2 = {
    [Enum.DevComputerMovementMode.KeyboardMouse] = "CoreScripts.InGameMenu.GameSettings.ComputerMoveModeKeyboardMouse",
    [Enum.DevComputerMovementMode.ClickToMove] = "CoreScripts.InGameMenu.GameSettings.ComputerMoveModeClickToMove"
}

local var2 = Roact.PureComponent:extend("MovementModeEntry")
var2.validateProps = t.strictInterface({ LayoutOrder = t.integer, canOpen = t.optional(t.boolean), canCaptureFocus = t.optional(t.boolean) })

var2.defaultProps = { canOpen = true }

function var2.init(arg1)
    arg1:setState({
        selectedComputerMode = UserGameSettings.ComputerMovementMode,
        computerOptions = var1 and var1:GetRegisteredComputerMovementModes() or {},
        developerComputerMode = LocalPlayer.DevComputerMovementMode
    })
end

function var2.render(arg1)
    local tbl3 = {
        ComputerMovementModeListener = Roact.createElement(ExternalEventConnection, {
            event = ComputerMovementModeChanged,
            callback = function()
                arg1:setState({ selectedComputerMode = UserGameSettings.ComputerMovementMode })
            end
        }),
        ComputerMovementModeRegisteredListener = var1 and Roact.createElement(ExternalEventConnection, {
            event = var1.ComputerMovementModeRegistered,
            callback = function()
                arg1:setState({ computerOptions = var1:GetRegisteredComputerMovementModes() })
            end
        }),
        DevComputerMovementMode = Roact.createElement(ExternalEventConnection, {
            event = DevComputerMovementModeChanged,
            callback = function()
                arg1:setState({ developerComputerMode = LocalPlayer.DevComputerMovementMode })
            end
        })
    }

    if #arg1.state.computerOptions == 0 then
        return Roact.createFragment(tbl3)
    end

    local bool1 = arg1.state.developerComputerMode ~= Enum.DevComputerMovementMode.UserChoice
    local selections = ({})
    local num1 = 0

    if not bool1 then
        for i, computerOption in ipairs(arg1.state.computerOptions) do
            selections[i] = tbl1[computerOption]
            assert(selections[i] ~= nil, "Movement mode " .. computerOption.Name .. " has no localization key")

            if arg1.state.selectedComputerMode.Value == computerOption.Value then
                num1 = i
            end
        end
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl5 = {
        Size = UDim2.new(1, 0, 0, 120),
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.LayoutOrder,
        ZIndex = 2
    }
    local tbl6 = {
        Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24) }),
        InputLabel = Roact.createElement(InputLabel, {
            localizationKey = "CoreScripts.InGameMenu.GameSettings.MovementMode",
            Size = UDim2.new(1, 0, 0, 56),
            Position = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0, 0)
        }),
        Dropdown = 0,
        LockedLabel = 0
    }
    local var3 = withLocalization
    local tbl7 = {
        placeholder = if bool1 then tbl2[arg1.state.developerComputerMode] or nil else nil
    }

    tbl6.Dropdown = var3(tbl7)(function(arg2)
        return Roact.createElement(DropDownSelection, {
            Size = UDim2.new(1, 0, 0, 44),
            Position = UDim2.new(0, 0, 0, 56),
            selections = selections,
            selectedIndex = num1,
            placeHolderText = arg2.placeholder,
            enabled = not bool1,
            localize = true,
            selectionParentName = "MovementModeEntryDropdown",
            canOpen = arg1.props.canOpen,
            canCaptureFocus = arg1.props.canCaptureFocus,
            selectionChanged = function(arg3)
                UserGameSettings.ComputerMovementMode = arg1.state.computerOptions[arg3]
                SendAnalytics(Constants.AnalyticsSettingsChangeName, nil, {}, true)
            end
        })
    end)
    tbl6.LockedLabel = bool1
        and Roact.createElement(
            DeveloperLockLabel,
            {
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(0, 0, 1, 0),
                Size = UDim2.new(1, -72, 0.25, 0)
            }
        )
    tbl3.MovementModeEntrySelector = createElement(str1, tbl5, tbl6)

    return Roact.createFragment(tbl3)
end

return var2
