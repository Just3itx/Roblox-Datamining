-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local UIBlox = require(scriptParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParent.Foundation).Utility.normalizeFontFace
local React = require(scriptParentParentParent.React)

local withStyle = UIBlox.Style.withStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Roact = require(scriptParentParentParent.Roact)
local t = require(scriptParentParentParent.t)
local var1 = Roact.PureComponent:extend("SubscriptionTitle")

var1.validateProps = t.strictInterface({
    name = t.string,
    displayPrice = t.string,
    subscriptionProviderName = t.string,
    period = t.string,
    disclaimerText = t.string,
    layoutOrder = t.number,
    contentHeight = t.number,
    itemIcon = t.any
})

local function createSubscriptionInfo(props, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    return withStyle(function(arg1)
        local theme = arg1.Theme

        return React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = props.layoutOrder
        }, {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = bool1 and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 8)
            })
        }, {
            AppName = React.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = props.subscriptionProviderName,
                TextSize = 16,
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                TextXAlignment = bool1 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
                TextWrapped = true,
                LayoutOrder = props.layoutOrder
            })
        }, {
            Title = React.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = props.name,
                TextSize = 20,
                TextColor3 = theme.TextEmphasis.Color,
                TextTransparency = theme.TextEmphasis.Transparency,
                FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                TextXAlignment = bool1 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
                TextWrapped = true,
                LayoutOrder = props.layoutOrder + 1
            })
        }, {
            PriceFrame = React.createElement("Frame", {
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = props.layoutOrder + 2
            }, {
                Layout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = bool1 and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal
                }),
                Price = React.createElement("TextLabel", {
                    Size = UDim2.new(0, 0, 0, 16),
                    BackgroundTransparency = 1,
                    Text = props.displayPrice,
                    TextSize = 16,
                    TextColor3 = theme.TextEmphasis.Color,
                    TextTransparency = theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    RichText = true,
                    TextXAlignment = bool1 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
                    TextWrapped = true,
                    LayoutOrder = props.layoutOrder + 1,
                    AutomaticSize = Enum.AutomaticSize.X
                }),
                Period = React.createElement("TextLabel", {
                    Size = UDim2.new(0, 0, 0, 16),
                    BackgroundTransparency = 1,
                    Text = props.period,
                    TextSize = 16,
                    TextColor3 = theme.TextDefault.Color,
                    TextTransparency = theme.TextDefault.Transparency,
                    FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                    RichText = true,
                    TextXAlignment = bool1 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
                    TextWrapped = true,
                    LayoutOrder = props.layoutOrder + 1,
                    AutomaticSize = Enum.AutomaticSize.X
                })
            })
        }, {
            DisclaimerText = React.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 16),
                BackgroundTransparency = 1,
                Text = props.disclaimerText,
                TextSize = 16,
                TextColor3 = theme.TextDefault.Color,
                FontFace = normalizeFontFace(arg1.Tokens.Typography.BodyLarge.Font),
                TextXAlignment = bool1 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
                TextWrapped = true,
                LayoutOrder = props.layoutOrder + 3
            })
        })
    end)
end

local function createCompactSubscriptionTitle(props)
    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1
        },
        {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 24)
            }),
            Icon = React.createElement(ImageSetLabel, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 96, 0, 96),
                ScaleType = Enum.ScaleType.Fit,
                AutomaticSize = Enum.AutomaticSize.X,
                Image = props.itemIcon
            }),
            SubscriptionInfo = createSubscriptionInfo(props, true)
        }
    )
end

local function createNormalSubscriptionTitle(props)
    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1
        },
        {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 24)
            }),
            Icon = React.createElement(ImageSetLabel, {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 96, 0, 96),
                ScaleType = Enum.ScaleType.Fit,
                AutomaticSize = Enum.AutomaticSize.X,
                Image = props.itemIcon
            }),
            SubscriptionInfo = createSubscriptionInfo(props, false)
        }
    )
end

function var1.getTitleHeight(_, arg1): number
    return if arg1 > 216 then 216 else 96
end

function var1.render(arg1)
    if arg1.props.contentHeight > 216 then
        return createNormalSubscriptionTitle(arg1.props)
    end
    return createCompactSubscriptionTitle(arg1.props)
end

return var1
