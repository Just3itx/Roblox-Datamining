-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Parent.Constants)

local uDim = UDim.new(0, 6)

local function FreezeToggle(tbl1)
    return Roact.createElement(
        "TextButton",
        {
            Text = if tbl1.frozen then "Frozen" else "Freeze",
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.new(0, 0, 0, 16),
            LayoutOrder = tbl1.layoutOrder,
            Font = Constants.Font.MainWindow,
            TextSize = Constants.DefaultFontSize.MainWindow + -2,
            TextColor3 = tbl1.frozen and Constants.Color.HighlightBlue or Constants.Color.Text,
            BackgroundColor3 = Constants.Color.UnselectedGray,
            BorderSizePixel = 1,
            BorderColor3 = Constants.Color.Text,
            [Roact.Event.Activated] = tbl1.onToggle
        },
        {
            Padding = Roact.createElement("UIPadding", { PaddingLeft = uDim, PaddingRight = uDim })
        }
    )
end

return FreezeToggle
