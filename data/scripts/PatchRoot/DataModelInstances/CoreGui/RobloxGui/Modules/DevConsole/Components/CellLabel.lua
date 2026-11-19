-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local MainWindow = Constants.DefaultFontSize.MainWindow
local ConstantsColorText = Constants.Color.Text
local MainWindow2 = Constants.Font.MainWindow
local MainWindowBold = Constants.Font.MainWindowBold

local function CellLabel(tbl1)
    local text = tbl1.text
    local size = tbl1.size
    local pos = tbl1.pos
    local bold = tbl1.bold
    local layoutOrder = tbl1.layoutOrder
    local richText = tbl1.richText
    local textWrapped = tbl1.textWrapped == nil or tbl1.textWrapped
    local textTruncate = if tbl1.textTruncate == nil then nil else tbl1.textTruncate
    return Roact.createElement("TextLabel", {
        Text = text,
        TextSize = MainWindow,
        TextColor3 = ConstantsColorText,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = textWrapped,
        TextTruncate = textTruncate,
        Font = bold and MainWindowBold or MainWindow2,
        Size = size,
        Position = pos,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
        RichText = richText
    })
end

return CellLabel
