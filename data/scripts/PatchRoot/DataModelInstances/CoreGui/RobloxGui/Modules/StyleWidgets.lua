-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local _RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local module = { TabSelectionHeight = 6 }

function module.MakeTabSelectionWidget(arg1)
    return (Create("ImageLabel")({
        Name = "TabSelection",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuSelection.png",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(3, 1, 4, 5),
        Visible = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, module.TabSelectionHeight),
        Position = UDim2.new(0, 0, 1, -module.TabSelectionHeight),
        Parent = arg1
    }))
end

return module
