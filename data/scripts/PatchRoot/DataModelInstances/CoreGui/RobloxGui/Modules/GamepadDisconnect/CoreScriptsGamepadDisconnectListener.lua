-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local EventIngestService = game:GetService("EventIngestService")
local React = require(CorePackages.Packages.React)
local InputUi = require(CorePackages.Workspace.Packages.InputUi)
local GamepadDisconnectedModal = InputUi.Gamepad.GamepadDisconnectedModal
local useGamepadDisconnectOverlayEffect = InputUi.Gamepad.useGamepadDisconnectOverlayEffect
local InGameMenuConstants = require(CoreGui.RobloxGui.Modules.InGameMenuConstants)
local var1 = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest.new(EventIngestService)

local function CoreScriptsGamepadDisconnectListener()
    local var2, var3 = React.useState(false)
    local var4 = React.useCallback(function()
        var3(false)
    end, { var3 })
    local var5 = React.useCallback(function()
        var3(true)
    end, { var3 })

    useGamepadDisconnectOverlayEffect(var5, var4, var1, "InExperience")

    if not var2 then
        return nil
    end

    return React.createElement("ScreenGui", {
        DisplayOrder = InGameMenuConstants.DisplayOrder.HeadsetDisconnectedDialog,
        IgnoreGuiInset = true,
        OnTopOfCoreBlur = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }, {
        GamepadDisconnectedModal = React.createElement(GamepadDisconnectedModal)
    })
end

return CoreScriptsGamepadDisconnectListener
