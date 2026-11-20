-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local FocusContext = require(script.Parent.FocusContext)

local function FocusControllerConsumer(arg1)
    return Roact.createElement(FocusContext.Consumer, {
        render = function(arg2)
            local focusController = if arg2 then arg2.focusNode.focusController else nil
            return arg1.render(focusController)
        end
    })
end

local function withFocusController(render)
    return Roact.createElement(FocusControllerConsumer, { render = render })
end

return withFocusController
