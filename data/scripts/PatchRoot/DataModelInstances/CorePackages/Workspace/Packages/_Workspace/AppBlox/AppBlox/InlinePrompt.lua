-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local UIBlox = require(AppBloxParent.UIBlox)
local React = require(AppBloxParent.React)
local Cryo = require(AppBloxParent.Cryo)
local Responsive = require(AppBloxParent.Responsive)
local Foundation = require(AppBloxParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local Core = UIBlox.Core
local App = UIBlox.App
local useStyle = Core.Style.useStyle
local useTokens = Foundation.Hooks.useTokens
local FFlagSduiComponentsUseFoundationTokens = require(AppBloxParent.SharedFlags).FFlagSduiComponentsUseFoundationTokens
local Button = UIBlox.App.Button.Button
local Images = App.ImageSet.Images
local IconButton = App.Button.IconButton
local IconSize = App.ImageSet.Enum.IconSize
local ImageSetLabel = Core.ImageSet.ImageSetLabel
local getIconSize = App.ImageSet.getIconSize

local iconsNavigationClose = Images["icons/navigation/close"]

local function InlinePrompt(tbl1)
    local var1 = if FFlagSduiComponentsUseFoundationTokens then useTokens() else useStyle().Tokens
    local var2 = if tbl1.onDismiss then getIconSize(IconSize.Small) else 0
    local var3 = (if tbl1.iconImage then 36 else 0) + var2

    local var4 = React.useRef(nil)
    local var5 = Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1
    }
    local tbl3 = {
        UILayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = if var5 then Enum.VerticalAlignment.Top else Enum.VerticalAlignment.Center
        }),
        Icon = 0,
        MiddleFrame = 0,
        DismissButtonFrame = 0
    }
    local element

    if tbl1.iconImage then
        element = React.createElement(ImageSetLabel, {
            LayoutOrder = 1,
            Selectable = false,
            Size = UDim2.fromOffset(36, 36),
            Image = tbl1.iconImage,
            ImageColor3 = var1.Color.Content.Emphasis.Color3,
            ImageTransparency = var1.Color.Content.Emphasis.Transparency,
            BackgroundTransparency = 1
        })
    else
        element = nil
    end

    tbl3.Icon = element

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        LayoutOrder = 2,
        Size = UDim2.new(1, -var3, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl5 = {
        UILayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
        }),
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 12) }),
        Text = 0,
        Button = 0
    }
    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl6 = {
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY
    }
    local tbl7 = {
        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
        TextLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 12) }),
        Title = React.createElement("TextLabel", {
            LayoutOrder = 1,
            Text = tbl1.titleMessage,
            BackgroundTransparency = 1,
            TextColor3 = var1.Color.Content.Emphasis.Color3,
            TextTransparency = var1.Color.Content.Emphasis.Transparency,
            TextSize = var1.Typography.CaptionLarge.FontSize,
            FontFace = normalizeFontFace(var1.Typography.CaptionLarge.Font),
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            TextScaled = false,
            LineHeight = var1.LineHeight.LineHeight_140
        }),
        Subline = 0
    }
    local element2

    if tbl1.sublineMessage then
        element2 = React.createElement("TextLabel", {
            LayoutOrder = 2,
            Text = tbl1.sublineMessage,
            BackgroundTransparency = 1,
            TextColor3 = var1.Color.Content.Default.Color3,
            TextTransparency = var1.Color.Content.Default.Transparency,
            TextSize = var1.Typography.BodySmall.FontSize,
            FontFace = normalizeFontFace(var1.Typography.BodySmall.Font),
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            TextScaled = false,
            LineHeight = 1
        })
    else
        element2 = nil
    end

    tbl7.Subline = element2
    tbl5.Text = createElement3(str3, tbl6, tbl7)

    tbl5.Button = if var5 or not tbl1.buttonProps then nil else React.createElement(
        Button,
        Cryo.Dictionary.join(
            {
                size = UDim2.new(0, 0, 0, 0),
                automaticSize = Enum.AutomaticSize.XY,
                layoutOrder = 2
            },
            tbl1.buttonProps
        )
    )
    tbl3.MiddleFrame = createElement2(str2, tbl4, tbl5)

    tbl3.DismissButtonFrame = if tbl1.onDismiss then React.createElement(IconButton, {
        backgroundTransparency = 1,
        icon = iconsNavigationClose,
        iconSize = IconSize.Small,
        size = UDim2.new(0, IconSize.Small, 0, IconSize.Small),
        onActivated = tbl1.onDismiss,
        layoutOrder = 3
    }) else nil
    local horizontalContent = createElement(str1, tbl2, tbl3)

    local createElement4 = React.createElement
    local str4 = "Frame"
    local tbl8 = {
        BackgroundTransparency = tbl1.backgroundTransparency or var1.Color.Surface.Surface_300.Transparency,
        BackgroundColor3 = tbl1.backgroundColor3 or var1.Color.Surface.Surface_300.Color3,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        ref = var4
    }
    local tbl9 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        ContainerRef = React.createElement(Responsive.ContainerRef.Provider, { value = var4 }, {
            UIPadding = React.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 12),
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12)
            }),
            UILayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 12)
            }),
            HorizontalContent = horizontalContent,
            Button = if var5 and tbl1.buttonProps then React.createElement(
                Button,
                Cryo.Dictionary.join(
                    {
                        size = UDim2.new(1, 0, 0, 0),
                        fitContent = false,
                        automaticSize = Enum.AutomaticSize.XY,
                        layoutOrder = 2
                    },
                    tbl1.buttonProps
                )
            ) else nil
        })
    }
    return createElement4(str4, tbl8, tbl9)
end

return InlinePrompt
