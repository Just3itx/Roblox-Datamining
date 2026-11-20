-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local _Shell = CoreGui:FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Shell")

local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local module = {}

function module.CreateShadow(zIndex)
    return Create("ImageLabel")({
        Name = "Shadow",
        Image = "rbxasset://textures/ui/Shell/Buttons/Generic9ScaleShadow.png",
        Size = UDim2.new(1, 3, 1, 3),
        Position = UDim2.new(0, 0, 0, 0),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 28, 28),
        BackgroundTransparency = 1,
        ZIndex = zIndex or 1
    })
end

return module
