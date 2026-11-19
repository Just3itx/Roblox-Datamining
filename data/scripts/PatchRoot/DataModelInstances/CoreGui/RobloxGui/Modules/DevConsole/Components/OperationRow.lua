-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(script.Parent.Parent.Constants)

local uDim = UDim.new(0, 3)

local tbl1 = {
    snt = {
        background = Color3.fromRGB(16, 32, 16),
        text = Color3.fromRGB(120, 220, 110)
    },
    srv = {
        background = Color3.fromRGB(16, 30, 42),
        text = Color3.fromRGB(110, 185, 240)
    },
    op = {
        background = Color3.fromRGB(28, 22, 44),
        text = Color3.fromRGB(180, 150, 240)
    }
}

local function OperationRow(tbl2)
    local var1 = tbl1[tbl2.tag]

    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            LayoutOrder = tbl2.layoutOrder,
            BackgroundTransparency = 1
        },
        {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6)
            }),
            Timestamp = Roact.createElement("TextLabel", {
                Text = tbl2.timestampText,
                Size = UDim2.new(0, 66, 1, 0),
                LayoutOrder = 1,
                Font = Constants.Font.MainWindow,
                TextSize = Constants.DefaultFontSize.MainWindow + -2,
                TextColor3 = Constants.Color.BorderGray,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }),
            Tag = Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(0, 30, 0, 16),
                    LayoutOrder = 2,
                    BackgroundColor3 = var1.background,
                    BorderSizePixel = 0
                },
                {
                    Corner = Roact.createElement("UICorner", { CornerRadius = uDim }),
                    Label = Roact.createElement("TextLabel", {
                        Text = tbl2.tag,
                        Size = UDim2.new(1, 0, 1, 0),
                        Font = Constants.Font.MainWindow,
                        TextSize = Constants.DefaultFontSize.MainWindow + -3,
                        TextColor3 = var1.text,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        BackgroundTransparency = 1
                    })
                }
            ),
            Name = Roact.createElement("TextLabel", {
                Text = tbl2.name,
                Size = UDim2.new(1, -108, 1, 0),
                LayoutOrder = 3,
                Font = Constants.Font.MainWindow,
                TextSize = Constants.DefaultFontSize.MainWindow,
                TextColor3 = Constants.Color.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1
            })
        }
    )
end

return OperationRow
