-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local React = require(AppBloxParent.React)
local UIBlox = require(AppBloxParent.UIBlox)
local normalizeFontFace = require(AppBloxParent.Foundation).Utility.normalizeFontFace
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useDesignTokens = require(AppBloxParent.Style).useDesignTokens

return function(tbl1)
    local var1 = useDesignTokens()
    local offset = tbl1.padding or var1.Size.Size_100
    local iconSize = tbl1.iconSize or 18

    local font = var1.Typography.BodyLarge.Font

    local fontSize350 = var1.FontSize.FontSize_350
    local default = var1.Color.Content.Default
    local font2 = var1.Typography.TitleLarge.Font
    local fontSize = var1.Typography.TitleLarge.FontSize
    local emphasis = var1.Color.Content.Emphasis

    local element = React.createElement("TextLabel", {
        LayoutOrder = 2,
        AutomaticSize = Enum.AutomaticSize.XY,
        Text = tbl1.bodyText,
        FontFace = normalizeFontFace(font2),
        TextSize = fontSize,
        TextColor3 = emphasis.Color3,
        TextTransparency = emphasis.Transparency,
        BackgroundTransparency = 1,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        TextTransparency = 1,
        Text = "",
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        [React.Event.Activated] = tbl1.onActivated
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, offset)
        }),
        Header = React.createElement("TextLabel", {
            LayoutOrder = 1,
            AutomaticSize = Enum.AutomaticSize.XY,
            Text = tbl1.headerText,
            FontFace = normalizeFontFace(font),
            TextSize = fontSize350,
            TextColor3 = default.Color3,
            TextTransparency = default.Transparency,
            BackgroundTransparency = 1,
            TextYAlignment = Enum.TextYAlignment.Center
        }),
        Body = 0
    }
    if tbl1.icon then
        element = React.createElement(
            "Frame",
            {
                LayoutOrder = 2,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            {
                BodyLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, var1.Size.Size_100)
                }),
                Icon = React.createElement(ImageSetLabel, {
                    LayoutOrder = 1,
                    Size = UDim2.fromOffset(iconSize, iconSize),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Image = tbl1.icon,
                    ImageColor3 = emphasis.Color3,
                    ImageTransparency = emphasis.Transparency
                }),
                BodyText = element
            }
        )
    end

    tbl3.Body = element
    return createElement(str1, tbl2, tbl3)
end
