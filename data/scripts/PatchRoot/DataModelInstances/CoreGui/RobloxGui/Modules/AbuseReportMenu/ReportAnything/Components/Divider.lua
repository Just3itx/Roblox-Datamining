-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local UIBlox = require(CorePackages.Packages.UIBlox)
local React = require(CorePackages.Packages.React)
local Cryo = require(CorePackages.Packages.Cryo)

local withStyle = UIBlox.Core.Style.withStyle

local function Divider(tbl1)
    return withStyle(function(arg1)
        return React.createElement(
            "Frame",
            Cryo.Dictionary.join({
                Size = UDim2.new(1, 0, 0, 1)
            }, tbl1, {
                BorderSizePixel = 0,
                BackgroundColor3 = arg1.Theme.Divider.Color,
                BackgroundTransparency = arg1.Theme.Divider.Transparency
            })
        )
    end)
end

return Divider
