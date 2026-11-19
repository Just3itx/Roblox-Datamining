-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Packages = game:GetService("CorePackages").Packages
local React = require(Packages.React)

local UIBlox = require(Packages.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local useCameraOn = require(script.Parent.Parent.Hooks.useCameraOn)

local uDim2 = UDim2.fromScale(1, 1)

local function CameraStatusIcon(tbl1)
    local var1 = useCameraOn()

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }, {
        Icon = React.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Image = var1 and Images["icons/controls/video"] or Images["icons/controls/videoOff"],
            Size = tbl1.iconSize or uDim2,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ImageTransparency = tbl1.transparency or 0
        })
    })
end

return CameraStatusIcon
