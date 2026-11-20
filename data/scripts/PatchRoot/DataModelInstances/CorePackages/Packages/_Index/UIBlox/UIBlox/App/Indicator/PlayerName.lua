-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local _ImagesTypes = require(scriptParentParent.ImageSet.ImagesTypes)
local _StyleTypes = require(scriptParentParent.Style.StyleTypes)

local Label = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent).Label
local Skeleton = Foundation.Skeleton

local useStyle = require(scriptParentParentParent.Core.Style.useStyle)

local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)
local OpenTypeSupport = require(scriptParentParentParent.Utility.OpenTypeSupport)

local function getStyleDefaults(tokens) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        iconLabelSpacing = tokens.Size.Size_50,
        iconSize = tokens.Size.Size_400,
        iconColorStyle = tokens.Color.Content.Default,
        labelTypography = tokens.Typography.CaptionMedium,
        labelColorStyle = tokens.Color.Content.Default
    }
end

local function getDisplayNameStyleDefaults(tokens) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        iconLabelSpacing = tokens.Size.Size_50,
        iconSize = tokens.Size.Size_400,
        labelTypography = tokens.Typography.TitleLarge,
        labelColorStyle = tokens.Color.Content.Emphasis
    }
end

local function getUserNameStyleDefaults(tokens) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        iconLabelSpacing = tokens.Size.Size_50,
        iconSize = tokens.Size.Size_300,
        iconColorStyle = tokens.Color.Content.Default,
        labelTypography = tokens.Typography.CaptionMedium,
        labelColorStyle = tokens.Color.Content.Default
    }
end

local function NameItem(tbl1)
    local layoutOrder = tbl1.layoutOrder
    local isReversed = tbl1.isReversed
    local itemProps = tbl1.itemProps
    local itemStyleDefaults = tbl1.itemStyleDefaults

    local icon = itemProps.icon
    local labelText = itemProps.labelText
    local useTextAsIcon = itemProps.useTextAsIcon
    local onActivated = itemProps.onActivated
    local isLoading = not (itemProps.isLoading == nil) and itemProps.isLoading
    local var1 = Cryo.Dictionary.join(itemStyleDefaults, itemProps.styleProps or {})
    local iconLabelSpacing = var1.iconLabelSpacing
    local iconSize = var1.iconSize
    local iconColorStyle = var1.iconColorStyle or {}
    local labelTypography = var1.labelTypography
    local labelColorStyle = var1.labelColorStyle

    local bool1 = not not (not isLoading and icon)
    local bool2 = not not (not isLoading and onActivated)
    local fontSize = if isLoading then if icon then math.max(iconSize, labelTypography.FontSize) else labelTypography.FontSize else nil
    local element

    if bool1 then
        if useTextAsIcon then
            element = React.createElement("TextLabel", {
                LayoutOrder = if isReversed then 2 else 1,
                Size = UDim2.fromOffset(iconSize, iconSize),
                BackgroundTransparency = 1,
                Text = icon,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                FontFace = normalizeFontFace(labelTypography.Font),
                TextSize = iconSize,
                TextColor3 = iconColorStyle.Color3,
                TextTransparency = if iconColorStyle.Transparency then iconColorStyle.Transparency else 0,
                Selectable = false
            })
        else
            element = React.createElement(Label, {
                LayoutOrder = if isReversed then 2 else 1,
                Size = UDim2.fromOffset(iconSize, iconSize),
                Image = icon,
                ImageColor3 = iconColorStyle.Color3,
                ImageTransparency = if iconColorStyle.Transparency then iconColorStyle.Transparency else 0,
                BackgroundTransparency = 1,
                Selectable = false
            })
        end
    else
        element = nil
    end

    local createElement = React.createElement
    local str1 = if bool2 then "TextButton" else "Frame"
    local tbl2 = {
        Text = if bool2 then "" else nil,
        AutoButtonColor = not bool2 and nil,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
        Selectable = not not bool2
    }
    local activated = React.Event.Activated

    if not bool2 then
        onActivated = nil
    end

    tbl2[activated] = onActivated
    local tbl3 = {
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, iconLabelSpacing)
        }),
        Shimmer = if isLoading then React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, fontSize) }) else nil,
        Icon = element,
        Label = 0
    }
    local element2

    if isLoading then
        element2 = nil
    else
        element2 = React.createElement("TextLabel", {
            LayoutOrder = if isReversed then 1 else 2,
            AutomaticSize = Enum.AutomaticSize.XY,
            Size = UDim2.fromScale(0, 0),
            BackgroundTransparency = 1,
            Text = labelText,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            FontFace = normalizeFontFace(labelTypography.Font),
            TextSize = labelTypography.FontSize,
            TextColor3 = labelColorStyle.Color3,
            TextTransparency = labelColorStyle.Transparency,
            Selectable = false,
            OpenTypeFeatures = if UIBloxConfig.enableOpenTypeSupport and tbl1.openTypeFeatures then tbl1.openTypeFeatures else nil
        })
    end

    tbl3.Label = element2
    return createElement(str1, tbl2, tbl3)
end

local function PlayerName(tbl1)
    local var1 = useStyle()
    local position = tbl1.position
    local anchorPoint = tbl1.anchorPoint
    local size = tbl1.size
    local automaticSize = tbl1.automaticSize or Enum.AutomaticSize.Y
    local layoutOrder = tbl1.layoutOrder

    local offset = tbl1.namesSpacing or var1.Tokens.Size.Size_100
    local displayNameItem = tbl1.displayNameItem
    local userNameItem = tbl1.userNameItem
    local vendorNameItem = tbl1.vendorNameItem
    local aliasItem = tbl1.aliasItem

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Position = position,
        AnchorPoint = anchorPoint,
        Size = size,
        AutomaticSize = automaticSize,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
        Selectable = false
    }
    local tbl3 = {
        ListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, offset)
        }),
        DisplayName = if displayNameItem then React.createElement(NameItem, {
            layoutOrder = 1,
            isReversed = true,
            itemProps = displayNameItem,
            itemStyleDefaults = getDisplayNameStyleDefaults(var1.Tokens)
        }) else nil,
        UserName = if userNameItem then React.createElement(NameItem, {
            layoutOrder = 2,
            itemProps = userNameItem,
            openTypeFeatures = if UIBloxConfig.enableOpenTypeSupport then OpenTypeSupport:getUserNameStylisticAlternative() else nil,
            itemStyleDefaults = getUserNameStyleDefaults(var1.Tokens)
        }) else nil,
        VendorName = if vendorNameItem then React.createElement(
            NameItem,
            {
                layoutOrder = 3,
                itemProps = vendorNameItem,
                itemStyleDefaults = getStyleDefaults(var1.Tokens)
            }
        ) else nil,
        Alias = if aliasItem then React.createElement(
            NameItem,
            {
                layoutOrder = 4,
                itemProps = aliasItem,
                itemStyleDefaults = getStyleDefaults(var1.Tokens)
            }
        ) else nil
    }
    return createElement(str1, tbl2, tbl3)
end

return PlayerName
