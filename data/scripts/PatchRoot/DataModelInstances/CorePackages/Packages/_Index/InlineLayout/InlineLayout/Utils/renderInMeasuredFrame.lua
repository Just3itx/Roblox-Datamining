-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:39:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UtilsParentParent = script:FindFirstAncestor("Utils").Parent.Parent

local React = require(UtilsParentParent.React)
local Flags = require(UtilsParentParent.MarkdownCore).Flags

local function renderInMeasuredFrame(element, xOffset: number, layoutOrder: number)
    return React.createElement(
        "Frame",
        {
            key = tostring(layoutOrder),
            LayoutOrder = layoutOrder,
            Size = UDim2.fromOffset(xOffset, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        not (Flags.FFlagMarkdownTables or Flags.FFlagMarkdownTagFallbacks) and { Element = element } or element
    )
end

return renderInMeasuredFrame
