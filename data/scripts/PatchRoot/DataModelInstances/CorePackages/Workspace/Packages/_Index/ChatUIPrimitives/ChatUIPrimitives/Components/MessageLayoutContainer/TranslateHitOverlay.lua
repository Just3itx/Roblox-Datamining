-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local React = require(ChatUIPrimitivesParent.React)

return React.memo(function(tbl1) -- name: TranslateHitOverlay
    local createElement = React.createElement
    local tbl2 = {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }
    local tbl3 = {
        layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 0)
        }),
        prefixSpacer = React.createElement("TextButton", {
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Text = tbl1.prefixText .. " ",
            RichText = true,
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            TextWrapped = false,
            FontFace = tbl1.fontFace,
            TextSize = tbl1.textSize,
            Active = false,
            AutoButtonColor = false,
            Selectable = false,
            LayoutOrder = 1
        }),
        icon = React.createElement("ImageButton", {
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/translateIcon.png",
            HoverImage = "rbxasset://textures/translateIconDark.png",
            PressedImage = "rbxasset://textures/translateIconDark.png",
            Size = UDim2.fromOffset(tbl1.textSize - 2, tbl1.textSize - 2),
            AutoButtonColor = false,
            Selectable = false,
            LayoutOrder = 2,
            [React.Event.Activated] = tbl1.onActivated
        })
    }
    return createElement("Frame", tbl2, tbl3)
end)
