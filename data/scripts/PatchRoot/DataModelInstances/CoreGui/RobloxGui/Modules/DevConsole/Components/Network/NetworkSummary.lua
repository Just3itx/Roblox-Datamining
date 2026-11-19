-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Parent.Constants)

local SummaryHeaderNames = Constants.NetworkFormatting.SummaryHeaderNames
local SummaryCellWidths = Constants.NetworkFormatting.SummaryCellWidths
local HeaderFrameHeight = Constants.NetworkFormatting.HeaderFrameHeight
local EntryFrameHeight = Constants.NetworkFormatting.EntryFrameHeight

local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor
local CellPadding = Constants.NetworkFormatting.CellPadding
local ConstantsColorText = Constants.Color.Text

local CellLabel = require(script.Parent.Parent.Parent.Components.CellLabel)
local HeaderButton = require(script.Parent.Parent.Parent.Components.HeaderButton)

local num1 = 0
for _, SummaryCellWidth in pairs(SummaryCellWidths) do
    num1 += SummaryCellWidth
end

local var1 = -num1
local tbl1 = {}
local tbl2 = {}
local tbl3 = {}

table.insert(tbl1, UDim2.new(0, CellPadding, 0, 0))
table.insert(tbl2, UDim2.new(1, -num1 - CellPadding, 0, HeaderFrameHeight))
table.insert(tbl3, UDim2.new(1, -num1 - CellPadding, 0, EntryFrameHeight))

for _, SummaryCellWidth in ipairs(SummaryCellWidths) do
    table.insert(tbl1, UDim2.new(1, var1 + CellPadding, 0, 0))
    table.insert(tbl2, UDim2.new(0, SummaryCellWidth - CellPadding, 0, HeaderFrameHeight))
    table.insert(tbl3, UDim2.new(0, SummaryCellWidth - CellPadding, 0, EntryFrameHeight))
    var1 += SummaryCellWidth
end

local tbl4 = ({})
for i, value in ipairs(tbl1) do
    tbl4[i] = UDim2.new(value.X.Scale, value.X.Offset - CellPadding, value.Y.Scale, value.Y.Offset)
end

local var2 = Roact.Component:extend("NetworkSummary")

function var2.render(arg1)
    local width = arg1.props.width
    local httpSummaryTable = arg1.props.httpSummaryTable or {}
    local layoutOrder = arg1.props.layoutOrder

    local tbl5 = ({})
    tbl5.UIListLayout = Roact.createElement("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local tbl6 = ({})
    tbl6.UpperHorizontalLine = Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, LineWidth),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        }
    )
    tbl6.LowerHorizontalLine = Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, LineWidth),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = LineColor,
        BorderSizePixel = 0
    })

    for i = 2, #tbl4 do
        local str1 = string.format("VerticalLine_%d", i)
        tbl6[str1] = Roact.createElement("Frame", {
            Size = UDim2.new(0, LineWidth, 0, HeaderFrameHeight),
            Position = tbl4[i],
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        })
    end

    for i, text in ipairs(SummaryHeaderNames) do
        local createElement = Roact.createElement
        local var3 = HeaderButton
        local tbl7 = {
            text = text,
            size = tbl2[i],
            pos = tbl1[i]
        }
        tbl6[text] = createElement(var3, tbl7)
    end

    tbl5.Header = Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(0, width, 0, HeaderFrameHeight),
            BackgroundTransparency = 1,
            LayoutOrder = 1
        },
        tbl6
    )

    local num2 = 0
    for _, value in pairs(httpSummaryTable) do
        num2 += 1

        local tbl7 = {
            RequestType = Roact.createElement(CellLabel, { text = value.RequestType, size = tbl2[1], pos = tbl1[1] }),
            RequestCount = Roact.createElement(CellLabel, { text = value.RequestCount, size = tbl2[2], pos = tbl1[2] }),
            FailedCount = Roact.createElement(CellLabel, { text = value.FailedCount, size = tbl2[3], pos = tbl1[3] }),
            AverageTime = Roact.createElement(CellLabel, { text = string.format("%.3f", value.AverageTime), size = tbl2[4], pos = tbl1[4] }),
            MinTime = Roact.createElement(CellLabel, { text = string.format("%.3f", value.MinTime), size = tbl2[5], pos = tbl1[5] }),
            MaxTime = Roact.createElement(CellLabel, { text = string.format("%.3f", value.MaxTime), size = tbl2[6], pos = tbl1[6] }),
            LowerHorizontalLine = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, LineWidth),
                Position = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = LineColor,
                BorderSizePixel = 0
            })
        }

        for i = 2, #tbl4 do
            local str1 = string.format("VerticalLine_%d", i)
            tbl7[str1] = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(0, LineWidth, 1, 0),
                    Position = tbl4[i],
                    BackgroundColor3 = LineColor,
                    BorderSizePixel = 0
                }
            )
        end

        local requestType = value.RequestType
        tbl5[requestType] = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(0, width, 0, EntryFrameHeight),
                BackgroundTransparency = 1,
                LayoutOrder = num2 + 1
            },
            tbl7
        )
    end

    if num2 == 0 then
        tbl5.Padding = Roact.createElement("TextLabel", {
            Size = UDim2.new(0, width, 0, EntryFrameHeight),
            Text = "No Summary Data Found",
            TextColor3 = ConstantsColorText,
            BackgroundTransparency = 1,
            LayoutOrder = 2
        })
        num2 = 1
    end

    local yOffset = num2 * EntryFrameHeight + HeaderFrameHeight

    return Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0, yOffset),
        ScrollingEnabled = false,
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, tbl5)
end

return var2
