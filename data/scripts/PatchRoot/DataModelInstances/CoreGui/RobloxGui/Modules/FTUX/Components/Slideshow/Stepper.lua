-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)

local function Stepper(tbl1)
    local numberOfSteps = tbl1.numberOfSteps
    local layoutOrder = tbl1.layoutOrder
    local numberActivated = tbl1.numberActivated

    local tbl2 = ({})
    for i = 1, numberOfSteps do
        tbl2[i] = i
    end

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(0.9, 0, 0.12, 0),
            Position = UDim2.new(0, 0, 0, 0),
            LayoutOrder = layoutOrder
        },
        React.createElement("UIListLayout", {
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        (LuauPolyfill.Array.map(tbl2, function(_, layoutOrder2)
            return React.createElement("Frame", {
                LayoutOrder = layoutOrder2,
                BackgroundTransparency = if layoutOrder2 <= numberActivated then 0 else 0.7,
                Size = UDim2.new(1 / numberOfSteps, 0, 0.5, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }, { React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }) })
        end))
    )
end

return Stepper
