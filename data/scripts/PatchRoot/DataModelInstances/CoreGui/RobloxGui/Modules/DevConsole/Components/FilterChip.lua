-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)

local tbl1 = {
    on = {
        background = Color3.fromRGB(14, 26, 14),
        border = Color3.fromRGB(32, 64, 32),
        text = Color3.fromRGB(130, 220, 130)
    },
    off = {
        background = Color3.fromRGB(18, 18, 18),
        border = Color3.fromRGB(40, 40, 40),
        text = Color3.fromRGB(150, 150, 150)
    }
}

local uDim = UDim.new(0, 9)

local uDim2 = UDim.new(0, 8)

local function FilterChip(tbl2)
    local tbl3 = tbl2.isOn and tbl1.on or tbl1.off
    return Roact.createElement("TextButton", {
        Text = tbl2.name,
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 0, 18),
        LayoutOrder = tbl2.layoutOrder,
        Font = Constants.Font.MainWindow,
        TextSize = Constants.DefaultFontSize.MainWindow + -3,
        TextColor3 = tbl3.text,
        BackgroundColor3 = tbl3.background,
        AutoButtonColor = false,
        [Roact.Event.Activated] = tbl2.onActivated
    }, {
        Corner = Roact.createElement("UICorner", { CornerRadius = uDim }),
        Stroke = Roact.createElement("UIStroke", { Color = tbl3.border, Thickness = 1 }),
        Padding = Roact.createElement("UIPadding", { PaddingLeft = uDim2, PaddingRight = uDim2 })
    })
end

return FilterChip
