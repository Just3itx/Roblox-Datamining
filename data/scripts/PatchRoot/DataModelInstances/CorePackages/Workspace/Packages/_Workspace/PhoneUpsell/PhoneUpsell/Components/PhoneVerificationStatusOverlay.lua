-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent

local React = require(PhoneUpsellParent.React)
local normalizeFontFace = require(PhoneUpsellParent.Foundation).Utility.normalizeFontFace

local UIBlox = require(PhoneUpsellParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local Colors = UIBlox.App.Style.Colors

local function PhoneVerificationStatusOverlay(tbl1)
    local var1 = useStyle()
    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 0.3,
            BackgroundColor3 = Colors.Black,
            Size = UDim2.new(1, 0, 1, 0)
        },
        {
            MiddleContent = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1
                },
                {
                    ListLayout = React.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 24)
                    }),
                    Image = tbl1.image,
                    Padding = React.createElement(
                        "UIPadding",
                        {
                            PaddingLeft = UDim.new(0, var1.Tokens.Size.Size_600),
                            PaddingRight = UDim.new(0, var1.Tokens.Size.Size_600)
                        }
                    ),
                    VerifyingText = React.createElement("TextLabel", {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        TextSize = var1.Font.BaseSize * var1.Font.Header1.RelativeSize,
                        TextColor3 = Colors.White,
                        Text = tbl1.text,
                        FontFace = normalizeFontFace(var1.Tokens.Typography.HeadingSmall.Font),
                        LayoutOrder = 1,
                        BackgroundTransparency = 1,
                        TextWrapped = true
                    })
                }
            )
        }
    )
end

return PhoneVerificationStatusOverlay
