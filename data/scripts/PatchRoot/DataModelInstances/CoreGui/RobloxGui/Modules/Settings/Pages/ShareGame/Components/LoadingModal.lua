-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local LoadingBar = require(CorePackages.Workspace.Packages.AppBlox).LoadingBar

local black = Color3.fromRGB(41, 41, 41)

return function()
    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(0, 160, 0, 160),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = black,
            BackgroundTransparency = 0.1
        },
        { Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }), Roact.createElement(LoadingBar) }
    )
end
