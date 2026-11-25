-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)
local Dash = require(RoactUtilsParent.Dash)
local useIsGamepad = require(script.Parent.Hooks.useIsGamepad)

local function withIsGamepadInput(arg1)
    return function(arg2)
        local isGamepadInput = useIsGamepad()
        return React.createElement(arg1, Dash.join(arg2, { isGamepadInput = isGamepadInput }))
    end
end

return withIsGamepadInput
