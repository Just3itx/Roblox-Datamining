-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParentParent.React)
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)

local _Types = require(scriptParent.Types)
local TooltipController = require(scriptParent.TooltipController)
local HoverController = require(scriptParent.HoverController)

local function createControllerFunction(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(tooltipProps, arg2, renderTriggerPoint)
        local var1 = LuauPolyfill.Object.assign({}, arg2, { tooltipProps = tooltipProps, renderTriggerPoint = renderTriggerPoint })

        return React.createElement(arg1, var1)
    end
end

return {
    withTooltip = createControllerFunction(TooltipController),
    withHoverTooltip = createControllerFunction(HoverController)
}
