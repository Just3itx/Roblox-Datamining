-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)
local HoverGreen = Constants.Color.HoverGreen
local LineWidth = Constants.GeneralFormatting.LineWidth
local TextPadding = Constants.Graph.TextPadding
local InnerPaddingY = Constants.Graph.InnerPaddingY

return function(arg1)
    local hoverLineX = arg1.hoverLineX
    local hoverLineY = arg1.hoverLineY

    local hoverValX = arg1.hoverValX
    local hoverValY = arg1.hoverValY

    local stringFormatX = arg1.stringFormatX
    local stringFormatY = arg1.stringFormatY

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl2 = {
        hoverLine = Roact.createElement("Frame", {
            Size = UDim2.new(0, LineWidth, 1, 0),
            Position = UDim2.new(0, hoverLineX, 0, 0),
            BackgroundColor3 = HoverGreen,
            BorderSizePixel = 0
        }),
        HoverHorizontal = Roact.createElement("Frame", {
            Size = UDim2.new(0, hoverLineX + TextPadding, 0, LineWidth),
            Position = UDim2.new(0, -TextPadding, 1 - InnerPaddingY, -hoverLineY),
            BackgroundColor3 = HoverGreen,
            BorderSizePixel = 0
        }),
        HoverTextY = 0,
        HoverTextX = 0
    }

    local createElement2 = Roact.createElement
    local str2 = "TextLabel"
    local tbl3 = {
        Text = 0,
        TextColor3 = 0,
        TextXAlignment = 0,
        Position = 0,
        BackgroundTransparency = 1
    }

    if stringFormatY then
        hoverValY = stringFormatY(hoverValY) or hoverValY
    end

    tbl3.Text = hoverValY
    tbl3.TextColor3 = HoverGreen
    tbl3.TextXAlignment = Enum.TextXAlignment.Right

    tbl3.Position = UDim2.new(0, -TextPadding - 2, 1 - InnerPaddingY, -hoverLineY)
    tbl2.HoverTextY = createElement2(str2, tbl3)

    local createElement3 = Roact.createElement
    local str3 = "TextLabel"
    local tbl4 = {
        Text = 0,
        TextColor3 = 0,
        TextXAlignment = 0,
        Position = 0,
        BackgroundTransparency = 1
    }

    if stringFormatX then
        hoverValX = stringFormatX(hoverValX) or hoverValX
    end

    tbl4.Text = hoverValX
    tbl4.TextColor3 = HoverGreen
    tbl4.TextXAlignment = Enum.TextXAlignment.Center

    tbl4.Position = UDim2.new(0, hoverLineX, 1, TextPadding)
    tbl2.HoverTextX = createElement3(str3, tbl4)
    return createElement(str1, tbl1, tbl2)
end
