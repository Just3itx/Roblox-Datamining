-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Colors = require(scriptParent.Colors)

local function getSelectionImageObjectRounded(): ImageLabel
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Image = "rbxasset://textures/ui/InspectMenu/selection_rounded.png"
    imageLabel.ImageColor3 = Colors.White
    imageLabel.ScaleType = Enum.ScaleType.Slice
    imageLabel.SliceCenter = Rect.new(5, 5, 120, 20)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Size = UDim2.new(1, 0, 1, 0)

    return imageLabel
end

return getSelectionImageObjectRounded
