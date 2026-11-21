-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local ColorGradientCircle = require(AvatarExperienceSlotBasedEditorParent.AXCommon).Components.ColorGradientCircle
local React = require(AvatarExperienceSlotBasedEditorParent.React)

local function SlotCircularGradientFrame(tbl1)
    return React.createElement(ColorGradientCircle, {
        hasBorder = true,
        Colors = tbl1.Colors,
        Size = UDim2.fromScale(0.4, 0.4),
        Position = UDim2.fromScale(0.5, 0.5),
        Rotation = tbl1.Rotation,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Transparency = tbl1.Transparency,
        Offset = tbl1.Offset
    })
end

return SlotCircularGradientFrame
