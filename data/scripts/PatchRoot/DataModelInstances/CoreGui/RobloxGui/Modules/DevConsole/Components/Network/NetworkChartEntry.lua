-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Parent.Constants)
local EntryFrameHeight = Constants.NetworkFormatting.EntryFrameHeight
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local ResponseStrHeight = Constants.NetworkFormatting.ResponseStrHeight
local ResponseWidthRatio = Constants.NetworkFormatting.ResponseWidthRatio
local xScale = (1 - ResponseWidthRatio) / 2
local var1 = (1 - ResponseWidthRatio) / 4

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local HeaderButton = require(Components.HeaderButton)
local BannerButton = require(Components.BannerButton)

return function(arg1)
    local size = arg1.size
    local entry = arg1.entry
    local entryCellSize = arg1.entryCellSize
    local cellOffset = arg1.cellOffset
    local verticalOffsets = arg1.verticalOffsets
    local layoutOrder = arg1.layoutOrder
    local showResponse = arg1.showResponse
    local responseBodyHeight = arg1.responseBodyHeight

    local onButtonPress = arg1.onButtonPress

    local tbl1 = ({})
    tbl1.Num = Roact.createElement(CellLabel, { text = entry.Num, size = entryCellSize[1], pos = cellOffset[1] })

    tbl1.Method = Roact.createElement(CellLabel, { text = entry.Method, size = entryCellSize[2], pos = cellOffset[2] })

    tbl1.Status = Roact.createElement(CellLabel, { text = entry.Status, size = entryCellSize[3], pos = cellOffset[3] })

    tbl1.Time = Roact.createElement(
        CellLabel,
        {
            text = string.format("%.3f", entry.Time),
            size = entryCellSize[4],
            pos = cellOffset[4]
        }
    )
    tbl1.RequestType = Roact.createElement(CellLabel, { text = entry.RequestType, size = entryCellSize[5], pos = cellOffset[5] })

    tbl1.Url = Roact.createElement(CellLabel, { text = entry.Url, size = entryCellSize[6], pos = cellOffset[6] })

    tbl1.LowerHorizontalLine = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = LineColor, BorderSizePixel = 0 })

    for i = 2, #verticalOffsets do
        local str1 = string.format("VerticalLine_%d", i)
        tbl1[str1] = Roact.createElement("Frame", {
            Size = UDim2.new(0, LineWidth, 0, EntryFrameHeight),
            Position = verticalOffsets[i],
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        })
    end

    return Roact.createElement("Frame", {
        Size = size,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder
    }, {
        Button = Roact.createElement(BannerButton, {
            size = UDim2.new(1, 0, 0, EntryFrameHeight),
            pos = UDim2.new(),
            isExpanded = showResponse,
            onButtonPress = onButtonPress
        }, tbl1),
        Response = showResponse
            and Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, responseBodyHeight),
                Position = UDim2.new(xScale, 0, 0, EntryFrameHeight),
                BackgroundTransparency = 1
            }, {
                Text = Roact.createElement(
                    HeaderButton,
                    {
                        text = "Response Body:",
                        size = UDim2.new(1, 0, 0, ResponseStrHeight),
                        pos = UDim2.new(-var1, 0, 0, 0)
                    }
                ),
                ResponseBody = Roact.createElement(
                    CellLabel,
                    {
                        text = entry.Response,
                        size = UDim2.new(0.8, 0, 1, -ResponseStrHeight),
                        pos = UDim2.new(0, 0, 0, ResponseStrHeight)
                    }
                )
            })
    })
end
