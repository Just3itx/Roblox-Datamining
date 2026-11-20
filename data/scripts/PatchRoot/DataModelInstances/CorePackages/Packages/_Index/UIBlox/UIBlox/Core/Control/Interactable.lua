-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)

local ControlState = require(scriptParentParent.Control.Enum.ControlState)
local _useGuiControlState = require(scriptParentParent.Control.Hooks.useGuiControlState)

local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)

local stateLayer = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}

return (React.forwardRef(function(tbl2, ref) -- name: Interactable
    local var1 = table.clone(tbl2)
    var1.isDisabled = var1.isDisabled or var1.userInteractionEnabled == false
    var1.userInteractionEnabled = nil
    var1.ref = ref
    var1.component = var1.component or ImageSetComponent.Button
    var1.stateLayer = stateLayer

    local var2 = React.useRef(ControlState.Initialize)
    if tbl2.onStateChanged then
        function var1.onStateChanged(arg1)
            local current = ControlState[arg1]
            tbl2.onStateChanged(var2.current, current)
            var2.current = current
        end
    end

    return React.createElement(Foundation.UNSTABLE.Interactable, var1)
end))
