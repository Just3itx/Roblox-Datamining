-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local CoreScriptsRoactCommon = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon)
local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local ExpChat = require(CorePackages.Workspace.Packages.ExpChat)

local GamepadConnector = require(script.Parent.GamepadConnector)
local Scrim = CoreScriptsRoactCommon.Scrim

local FFlagEnableUISelector = CoreGuiCommon.Flags.FFlagEnableUISelector
local GetUiSelectorSignalStore = if FFlagEnableUISelector then CoreGuiCommon.Stores.GetUiSelectorSignalStore else nil

local function createComputedScrimVisible()
    return Signals.createComputed(function(arg1)
        local var1 = GamepadConnector:topBarFocused(arg1)
        local var2 = ExpChat.Stores.GetFocusNavigationStore(arg1).getChatInputBarFocused(arg1)
        local var3 = FFlagEnableUISelector and GetUiSelectorSignalStore(arg1).getVisibility(arg1)
        return var1 or var2 or var3
    end)
end

return React.memo(function() -- name: TopBarScrim
    local var1 = SignalsReact.useSignalBinding(createComputedScrimVisible())

    return React.createElement(Scrim, { Visible = var1 })
end)
