-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local React = require(ExpChatParent.React)

local function Carat(tbl1)
    local chatSettings = tbl1.chatSettings

    return React.createElement(
        "ImageLabel",
        {
            LayoutOrder = tbl1.layoutOrder,
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 1, -1),
            Size = UDim2.fromOffset(12, 8),
            Image = "rbxasset://textures/ui/InGameChat/Caret.png",
            ImageColor3 = chatSettings.BackgroundColor3,
            ImageTransparency = chatSettings.BackgroundTransparency
        },
        {
            CaratGradient = chatSettings.UIGradient and React.createElement("UIGradient", chatSettings.UIGradient)
        }
    )
end
return Carat
