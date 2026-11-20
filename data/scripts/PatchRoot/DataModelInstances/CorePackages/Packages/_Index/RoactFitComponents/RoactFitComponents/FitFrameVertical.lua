-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Cryo = require(scriptParentParent.Cryo)
local Roact = require(scriptParentParent.Roact)

local FitFrameOnAxis = require(script.Parent.FitFrameOnAxis)
local isRoact17 = require(script.Parent.isRoact17)

return Roact.forwardRef(function(arg1, arg2)
    arg1 = arg1 or {}
    local width = arg1.width

    local var1 = if isRoact17() then "forwardedRef" else Roact.Ref
    local var2 = Cryo.Dictionary.join(arg1, {
        axis = FitFrameOnAxis.Axis.Vertical,
        minimumSize = UDim2.new(width, UDim.new(0, 0)),
        [var1] = arg2,
        width = Cryo.None
    })

    return Roact.createElement(FitFrameOnAxis, var2)
end)
