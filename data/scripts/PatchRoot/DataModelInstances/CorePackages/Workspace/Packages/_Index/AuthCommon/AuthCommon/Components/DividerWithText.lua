-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local React = require(AuthCommonParent.React)
local GetTextSize = require(AuthCommonParent.Style).GetTextSize
local normalizeFontFace = require(AuthCommonParent.Foundation).Utility.normalizeFontFace

return function(tbl1)
    local textSizeX = GetTextSize(tbl1.text, tbl1.fontSize, tbl1.font, Vector2.new(math.huge, tbl1.fontSize), { addTemporaryPadding = false }).X

    return React.createElement(
        "Frame",
        {
            LayoutOrder = tbl1.layoutOrder,
            Size = if tbl1.size then tbl1.size else UDim2.new(0, tbl1.width, 0, tbl1.height),
            BackgroundTransparency = 1
        },
        React.createElement("Frame", {
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0.5, -textSizeX / 2 - tbl1.padding, 0, 1),
            BackgroundTransparency = tbl1.transparency,
            BackgroundColor3 = tbl1.color3
        }),
        React.createElement("Frame", {
            Position = UDim2.new(0.5, textSizeX / 2 + tbl1.padding, 0.5, 0),
            Size = UDim2.new(0.5, -textSizeX / 2 - tbl1.padding, 0, 1),
            BackgroundTransparency = tbl1.transparency,
            BackgroundColor3 = tbl1.color3
        }),
        React.createElement("TextLabel", {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Text = tbl1.text,
            TextSize = tbl1.fontSize,
            FontFace = normalizeFontFace(tbl1.font),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTransparency = tbl1.transparency,
            TextColor3 = tbl1.color3,
            BackgroundTransparency = 1
        })
    )
end
