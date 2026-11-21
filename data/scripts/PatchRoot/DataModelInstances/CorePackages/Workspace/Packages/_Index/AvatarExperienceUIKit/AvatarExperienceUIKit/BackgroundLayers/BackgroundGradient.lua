-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Dash = require(AvatarExperienceUIKitParent.Dash)

local tbl1 = {
    offset = Vector2.new(),
    rotation = 90,
    transparency = NumberSequence.new(0)
}

local function BackgroundGradient(tbl2)
    tbl2 = Dash.join(tbl1, tbl2)

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        ZIndex = tbl2.ZIndex,
        [React.Tag] = tbl2.tag
    }, {
        CornerRadius = React.createElement("UICorner", { CornerRadius = tbl2.cornerRadius }),
        UIGradient = React.createElement(
            "UIGradient",
            {
                Color = tbl2.colorSequence,
                Offset = tbl2.offset,
                Rotation = tbl2.rotation,
                Transparency = tbl2.transparency
            }
        )
    })
end
return BackgroundGradient
