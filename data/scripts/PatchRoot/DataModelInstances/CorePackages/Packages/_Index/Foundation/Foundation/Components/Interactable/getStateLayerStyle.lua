-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:36Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(Foundation.Components.Types)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)

local StateLayerMode = require(Foundation.Enums.StateLayerMode)

local ControlState = require(Foundation.Enums.ControlState)

function guiStateToStateLayer(arg1): string
    if arg1 == ControlState.Pressed then
        return "Press"
    end

    if arg1 == ControlState.SelectedPressed then
        return "Press"
    end

    if arg1 == ControlState.Hover then
        return "Hover"
    end

    return "Idle"
end

function stateLayerModeToTokenNamespace(arg1)
    if arg1 == StateLayerMode.Default then
        return ColorNamespace.Color
    end

    if arg1 == StateLayerMode.Inverse then
        return ColorNamespace.Inverse
    end

    if arg1 == StateLayerMode.Light then
        return ColorNamespace.LightMode
    end

    if arg1 == StateLayerMode.Dark then
        return ColorNamespace.DarkMode
    end

    return ColorNamespace.Color
end

local function getStateLayerStyle(arg1, arg2, arg3)
    local var1 = stateLayerModeToTokenNamespace(arg2)
    local var2 = guiStateToStateLayer(arg3)

    return arg1[var1].State[var2]
end

return getStateLayerStyle
