-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local CellLabel = require(script.Parent.CellLabel)
local Constants = require(script.Parent.Parent.Constants)

local function InfoBanner(tbl1)
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        LayoutOrder = tbl1.layoutOrder,
        BackgroundColor3 = Constants.Color.TextBoxGray,
        BorderSizePixel = 0
    }, {
        Accent = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(0, 2, 1, 0),
                BackgroundColor3 = Constants.Color.HighlightBlue,
                BorderSizePixel = 0
            }
        ),
        Label = Roact.createElement(CellLabel, { text = tbl1.text, size = UDim2.new(1, -10, 1, 0), pos = UDim2.new(0, 10, 0, 0) })
    })
end

return InfoBanner
