-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local BaseKnob = require(scriptParent.BaseKnob)
local ControlState = require(scriptParentParentParentParent.Core.Control.Enum.ControlState)
local Colors = require(scriptParentParentParent.Style.Colors)

local tbl1 = {
    contextual = {
        [ControlState.Default] = {
            Color = Colors.White,
            Transparency = 0
        },
        [ControlState.Hover] = {
            Color = Colors.White,
            Transparency = 0
        },
        [ControlState.Pressed] = {
            Color = Colors.Green,
            Transparency = 0
        },
        [ControlState.Disabled] = {
            Color = Colors.Pumice,
            Transparency = 0
        },
        [ControlState.Selected] = {
            Color = Colors.White,
            Transparency = 0
        },
        [ControlState.SelectedPressed] = {
            Color = Colors.White,
            Transparency = 0
        }
    },
    system = {
        [ControlState.Default] = {
            Color = Colors.White,
            Transparency = 0
        },
        [ControlState.Hover] = {
            Color = Colors.White,
            Transparency = 0
        },
        [ControlState.Pressed] = {
            Color = Colors.Pumice,
            Transparency = 0
        },
        [ControlState.Disabled] = {
            Color = Colors.Pumice,
            Transparency = 0
        },
        [ControlState.Selected] = {
            Color = Colors.White,
            Transparency = 0
        },
        [ControlState.SelectedPressed] = {
            Color = Colors.White,
            Transparency = 0
        }
    }
}

local function buildKnob(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Roact.forwardRef(function(arg1, forwardedRef)
        local colorMap = tbl1[str1]
        local var2 = Cryo.Dictionary.join({}, arg1, { colorMap = colorMap, forwardedRef = forwardedRef })

        return Roact.createElement(BaseKnob, var2)
    end)
end

return {
    ContextualKnob = buildKnob("contextual"),
    SystemKnob = buildKnob("system")
}
