-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)

return React.memo(function(tbl1) -- name: SelectableUsername
    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }, {
        layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 0)
        }),
        username = React.createElement("TextButton", {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Text = tbl1.prefixText,
            RichText = true,
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            TextWrapped = false,
            FontFace = tbl1.fontFace,
            TextSize = tbl1.textSize,
            AutoButtonColor = false,
            SelectionImageObject = tbl1.selectionCursor,
            LayoutOrder = 1,
            ref = tbl1.buttonRef
        })
    })
end)
