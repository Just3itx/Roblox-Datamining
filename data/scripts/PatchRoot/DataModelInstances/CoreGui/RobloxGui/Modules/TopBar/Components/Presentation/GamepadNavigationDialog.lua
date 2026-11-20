-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _AppStorageService = game:GetService("AppStorageService")
local _HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local React = require(CorePackages.Packages.React)

local _Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local _t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local RoactAppExperiment = require(CorePackages.Packages.RoactAppExperiment)

local _withStyle = UIBlox.Core.Style.withStyle
local GamepadNavigationDialogShowCounter = require(script.GamepadNavigationDialogShowCounter)

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = script.Parent.Parent.Parent
local Actions = scriptParentParent.Parent.Actions
local SetGamepadNavigationDialogOpen = require(Actions.SetGamepadNavigationDialogOpen)

local GetFStringGamepadNavigationDialogABTestLayerName = require(scriptParentParentParent.Flags.GetFStringGamepadNavigationDialogABTestLayerName)

local FFlagAlwaysShowGamepadNavigationDialog = require(scriptParentParentParent.Flags.FFlagAlwaysShowGamepadNavigationDialog)

local FFlagTopBarDeprecateGamepadNavigationDialogRodux = require(scriptParentParentParent.Flags.FFlagTopBarDeprecateGamepadNavigationDialogRodux)

local function GamepadNavigationDialogContainer(_)
    local isGamepadNavigationDialogOpen, setGamepadNavigationDialogOpen = React.useState(false)

    React.useEffect(function()
        local connection = nil
        local function disconnectGamepadConnected() -- Luacid: Inlined by compiler; 1 call site recovered
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
        if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
            setGamepadNavigationDialogOpen(true)
        else
            connection = UserInputService.GamepadConnected:Connect(function()
                setGamepadNavigationDialogOpen(true)
                disconnectGamepadConnected()
            end)
        end

        GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(disconnectGamepadConnected)

        return disconnectGamepadConnected
    end, {})

    if not isGamepadNavigationDialogOpen then
        return nil
    end

    return (React.createElement(GamepadNavigationDialogShowCounter, {
        isGamepadNavigationDialogEnabled = FFlagAlwaysShowGamepadNavigationDialog,
        selectButtonDismissesGamepadNavigationDialog = false,
        appStorageKey = "GamepadMenuVirtualCursorPromptShown",
        maxShownCount = 1,
        isGamepadNavigationDialogOpen = isGamepadNavigationDialogOpen,
        SetGamepadNavigationDialogOpen = setGamepadNavigationDialogOpen
    }))
end
local fStringGamepadNavigationDialogABTestLayerName = GetFStringGamepadNavigationDialogABTestLayerName()
local var1 = RoactAppExperiment.connectUserLayer({ fStringGamepadNavigationDialogABTestLayerName }, function(arg1, _)
    local var1 = arg1[fStringGamepadNavigationDialogABTestLayerName] or {}
    return {
        isGamepadNavigationDialogEnabled = FFlagAlwaysShowGamepadNavigationDialog or var1.isGamepadNavigationDialogEnabled,
        selectButtonDismissesGamepadNavigationDialog = var1.selectButtonDismissesGamepadNavigationDialog,
        appStorageKey = "GamepadMenuVirtualCursorPromptShown",
        maxShownCount = 1
    }
end)(GamepadNavigationDialogShowCounter)

if FFlagTopBarDeprecateGamepadNavigationDialogRodux then
    return GamepadNavigationDialogContainer
end
return RoactRodux.connect(function(arg1)
    return {
        isGamepadNavigationDialogOpen = arg1.displayOptions.isGamepadNavigationDialogOpen
    }
end, function(arg1)
    return {
        SetGamepadNavigationDialogOpen = function(arg2)
            return arg1(SetGamepadNavigationDialogOpen(arg2))
        end
    }
end)(var1)
