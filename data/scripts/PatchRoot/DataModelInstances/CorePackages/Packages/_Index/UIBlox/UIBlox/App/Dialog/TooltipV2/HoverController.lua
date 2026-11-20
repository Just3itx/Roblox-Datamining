-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local LuauPolyfill = require(scriptParentParentParentParentParent.LuauPolyfill)

local _Types = require(scriptParent.Types)
local Constants = require(scriptParent.Constants)
local TooltipController = require(scriptParent.TooltipController)
local ControlState = require(scriptParentParentParentParent.Core.Control.Enum.ControlState)

local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local function HoverController(arg1)
    local active, var2 = React.useState(false)
    local var3 = React.useRef(tick())

    React.useEffect(function()
        return function()
            var3.current = tick()
        end
    end, UIBloxConfig.enableTooltipV2HoverControllerReRenderFix and {} or nil)

    local var4 = arg1.delayTime or Constants.DEFAULT_DELAY_TIME

    local var5 = React.useCallback(function(arg2, arg3)
        if arg1.disabled then
            var2(false)
            return
        end

        if arg3 == ControlState.Hover or arg3 == ControlState.Selected then
            local current = var3.current
            delay(var4, function()
                if var3.current == current then
                    var2(true)
                end
            end)
        elseif arg2 == ControlState.Hover or arg2 == ControlState.Selected then
            var3.current = tick()
            var2(false)
        end
    end, { var4 })

    local var6 = LuauPolyfill.Object.assign({}, arg1, {
        delayTime = LuauPolyfill.Object.None,
        active = active,
        renderTriggerPoint = function(arg2)
            return arg1.renderTriggerPoint(arg2, var5)
        end
    })

    return React.createElement(TooltipController, var6)
end

return HoverController
