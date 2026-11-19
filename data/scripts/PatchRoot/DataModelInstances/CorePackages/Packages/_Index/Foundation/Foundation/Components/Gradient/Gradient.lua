-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:51:23Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local function Gradient(tbl1)
    return React.createElement("UIGradient", {
        Rotation = if tbl1.fillDirection == Enum.FillDirection.Vertical then 90 else 0,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, if tbl1.top then 0 else 1),
            NumberSequenceKeypoint.new(0.5, if tbl1.top then 0 else 1),
            NumberSequenceKeypoint.new(0.50001, if tbl1.top then 1 else 0),
            NumberSequenceKeypoint.new(1, if tbl1.top then 1 else 0)
        })
    })
end

return Gradient
