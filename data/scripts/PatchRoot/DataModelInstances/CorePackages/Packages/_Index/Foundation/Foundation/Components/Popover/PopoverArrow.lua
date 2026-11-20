-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local function PopoverArrow(tbl1)
    return React.createElement(View, {
        Size = UDim2.fromOffset(tbl1.size, tbl1.size),
        Position = tbl1.position,
        Rotation = 45,
        ZIndex = tbl1.ZIndex,
        backgroundStyle = tbl1.backgroundStyle,
        tag = "anchor-center-center",
        testId = tbl1.testId
    })
end

return PopoverArrow
