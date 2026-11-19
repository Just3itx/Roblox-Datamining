-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local getIconSize = UIBlox.App.ImageSet.getIconSize
local IconSize = UIBlox.App.ImageSet.Enum.IconSize

return {
    Images = {
        RoundedRect = {
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 9, 9),
            Image = Images["component_assets/circle_17"]
        },
        BiometricIcon = {
            Size = UDim2.fromOffset(getIconSize(IconSize.Medium), getIconSize(IconSize.Medium)),
            Image = Images["icons/menu/biometric"]
        },
        FeedbackBarHintIcon = {
            Size = UDim2.fromOffset(getIconSize(IconSize.Medium), getIconSize(IconSize.Medium)),
            Image = Images["icons/actions/edit/add"]
        }
    }
}
