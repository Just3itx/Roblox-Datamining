-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local function withCommonProps(arg1, arg2)
    if type(arg2) == "table" then
        arg2.AnchorPoint = arg1.AnchorPoint

        arg2.LayoutOrder = arg1.LayoutOrder

        arg2.Position = arg1.Position

        arg2.Visible = arg1.Visible

        arg2.ZIndex = arg1.ZIndex

        arg2.onAbsoluteSizeChanged = arg1.onAbsoluteSizeChanged

        arg2.onAbsolutePositionChanged = arg1.onAbsolutePositionChanged

        arg2.testId = arg1.testId
    end
    return arg2
end

return withCommonProps
