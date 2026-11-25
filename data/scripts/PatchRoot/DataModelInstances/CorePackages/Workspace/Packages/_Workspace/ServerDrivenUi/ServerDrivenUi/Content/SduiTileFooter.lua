-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local UIBlox = require(ServerDrivenUiParent.UIBlox)
local Foundation = require(ServerDrivenUiParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local TextSize = require(ServerDrivenUiParent.TextSize)

return React.memo(function(tbl1) -- name: SduiTileFooter
    local layoutOrder = tbl1.layoutOrder
    local anchorPoint = tbl1.anchorPoint
    local automaticSize = tbl1.automaticSize
    local size = tbl1.size
    local zIndex = tbl1.zIndex
    local position = tbl1.position
    local selectable = tbl1.selectable

    local var1 = TextSize.getTextSizeStore(false).getTextSizeOffset(false)

    local var2 = useTokens()

    local var3 = tbl1.fontStyle or var2.Typography.BodyMedium
    local fontFace = normalizeFontFace(var3.Font)
    local textColor3 = tbl1.textColor or var2.Color.Content.Default.Color3
    local uDim2 = if tbl1.iconWidth then UDim2.new(0, tbl1.iconWidth, 0, tbl1.iconWidth) else UDim2.new(0, var2.Size.Size_350, 0, var2.Size.Size_350)
    local imageColor3 = tbl1.iconColor or textColor3
    local yOffset = math.ceil(var3.LineHeight * var3.FontSize + var1)

    local offset = tbl1.textIconGap or var2.Gap.XSmall
    local var7 = tbl1.sectionGap or var2.Gap.Small

    local active = tbl1.onActivated ~= nil

    if not (tbl1.leftIcon or tbl1.leftIconComponent or tbl1.rightIcon or tbl1.rightIconComponent or tbl1.rightText or active) then
        return React.createElement("TextLabel", {
            [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil,
            Position = position,
            AnchorPoint = anchorPoint,
            AutomaticSize = automaticSize or Enum.AutomaticSize.X,
            Size = size or UDim2.new(0, 0, 0, yOffset),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = layoutOrder,
            ZIndex = zIndex,
            Text = tbl1.leftText or "",
            FontFace = fontFace,
            TextSize = var3.FontSize,
            TextTransparency = 0,
            TextColor3 = textColor3,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = Enum.TextXAlignment.Left
        }, {
            UIFlexItem = tbl1.leftTextFlexMode and React.createElement("UIFlexItem", { FlexMode = tbl1.leftTextFlexMode }) or nil
        })
    end

    local bool2 = tbl1.rightIcon ~= nil or tbl1.rightIconComponent ~= nil or tbl1.rightText ~= nil

    local createElement = React.createElement
    local str1 = if active then "TextButton" else "Frame"
    local tbl2 = {
        [React.Tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil,
        Position = position,
        AnchorPoint = anchorPoint,
        AutomaticSize = automaticSize or Enum.AutomaticSize.X,
        Size = size or UDim2.new(0, 0, 0, yOffset),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        Text = if active then "" else nil,
        TextTransparency = if active then 1 else nil,
        AutoButtonColor = not active and nil,
        [React.Event.Activated] = if active then tbl1.onActivated else nil,
        Active = active
    }

    if selectable == nil then
        selectable = false
    end

    tbl2.Selectable = selectable
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.Name,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, offset),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        })
    }

    local leftIconComponent = tbl1.leftIconComponent

    if not leftIconComponent then
        if tbl1.leftIcon then
            leftIconComponent = React.createElement(ImageSetLabel, {
                LayoutOrder = 1,
                Size = uDim2,
                BackgroundTransparency = 1,
                ImageColor3 = imageColor3,
                ImageTransparency = 0,
                Image = tbl1.leftIcon
            })
                or nil
        else
            leftIconComponent = nil
        end
    end

    tbl3["1_LeftIcon"] = leftIconComponent

    tbl3["2_LeftText"] = React.createElement("TextLabel", {
        BackgroundTransparency = 1,
        Text = tbl1.leftText or "",
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 0, yOffset),
        FontFace = fontFace,
        TextSize = var3.FontSize,
        TextTransparency = 0,
        TextColor3 = textColor3,
        TextWrapped = false,
        TextTruncate = Enum.TextTruncate.SplitWord,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 2
    }, {
        UIFlexItem = if tbl1.leftTextFlexMode then React.createElement("UIFlexItem", { FlexMode = tbl1.leftTextFlexMode }) or nil else nil,
        UIPadding = if bool2 then React.createElement("UIPadding", { PaddingRight = UDim.new(0, var7 - offset) }) else nil
    })

    local rightIconComponent = tbl1.rightIconComponent

    if not rightIconComponent then
        if tbl1.rightIcon then
            rightIconComponent = React.createElement(ImageSetLabel, {
                LayoutOrder = 3,
                Size = uDim2,
                BackgroundTransparency = 1,
                ImageColor3 = imageColor3,
                ImageTransparency = 0,
                Image = tbl1.rightIcon
            })
                or nil
        else
            rightIconComponent = nil
        end
    end

    tbl3["3_RightIcon"] = rightIconComponent
    local element

    if tbl1.rightText then
        element = React.createElement(
            "TextLabel",
            {
                BackgroundTransparency = 1,
                Text = tbl1.rightText or "",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.new(0, 0, 0, yOffset),
                FontFace = fontFace,
                TextSize = var3.FontSize,
                TextTransparency = 0,
                TextColor3 = textColor3,
                TextWrapped = false,
                TextTruncate = Enum.TextTruncate.SplitWord,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = 4
            },
            {
                UIFlexItem = React.createElement("UIFlexItem", { FlexMode = tbl1.rightTextFlexMode or Enum.UIFlexMode.Shrink })
            }
        )
            or nil
    else
        element = nil
    end

    tbl3["4_RightText"] = element
    return createElement(str1, tbl2, tbl3)
end)
