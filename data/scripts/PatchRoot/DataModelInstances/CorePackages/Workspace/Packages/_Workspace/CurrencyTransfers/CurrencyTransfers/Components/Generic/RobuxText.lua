-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(CurrencyTransfersParent.React)
local formatNumber = require(CurrencyTransfers.Utils.formatNumber)

local Foundation = require(CurrencyTransfersParent.Foundation)
local Icon = Foundation.Icon
local View = Foundation.View
local FoundationText = Foundation.Text
local getIconRichText = Foundation.Utility.getIconRichText
local useTokens = Foundation.Hooks.useTokens

local GetFFlagCurrencyTransferCenterRobuxIcon = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferCenterRobuxIcon)

local function RobuxText(tbl1)
    local var1 = React.useMemo(function()
        return formatNumber(LocalizationService.RobloxLocaleId, tbl1.amount or 0)
    end, { tbl1.amount, LocalizationService.RobloxLocaleId })

    if not GetFFlagCurrencyTransferCenterRobuxIcon() then
        return React.createElement(
            View,
            {
                tag = "row align-x-center align-y-center auto-xy",
                LayoutOrder = tbl1.layoutOrder
            },
            {
                RobuxIcon = React.createElement(FoundationText, {
                    Text = getIconRichText("robux"),
                    tag = "auto-xy text-heading-large content-emphasis text-align-x-center",
                    RichText = true,
                    LayoutOrder = 1
                }),
                Spacer = React.createElement(View, { tag = "auto-xy", Size = UDim2.new(0, 4, 0, 0), LayoutOrder = 2 }),
                RobuxAmount = React.createElement(
                    FoundationText,
                    {
                        Text = var1,
                        tag = "auto-xy text-display-small content-emphasis text-align-x-center",
                        LayoutOrder = 3
                    }
                )
            }
        )
    end

    local var2 = useTokens()
    local fontSize = var2.Typography.HeadingLarge.FontSize
    local xOffset = math.round(fontSize)
    local yOffset = math.round(var2.Typography.DisplaySmall.FontSize)

    return (React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.fromOffset(0, yOffset),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }, {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4)
        }),
        IconWrapper = React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(xOffset, yOffset),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            },
            {
                RobuxIcon = React.createElement(Icon, {
                    name = "robux",
                    size = fontSize,
                    style = var2.Color.Content.Emphasis,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 4)
                })
            }
        ),
        RobuxAmount = React.createElement(FoundationText, {
            Text = var1,
            fontStyle = var2.Typography.DisplaySmall,
            textStyle = var2.Color.Content.Emphasis,
            Size = UDim2.fromOffset(0, yOffset),
            AutomaticSize = Enum.AutomaticSize.X,
            TextXAlignment = Enum.TextXAlignment.Center,
            LayoutOrder = 2
        })
    }))
end

return RobuxText
