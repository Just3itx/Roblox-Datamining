-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)
local Logger = require(scriptParentParentParent.Logger)

local ControlState = require(scriptParentParentParent.Core.Control.Enum.ControlState)
local StateLayer = require(scriptParentParentParent.Core.Control.StateLayer)
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local Label = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent).Label
local NavigationTabLayout = require(scriptParentParentParent.App.Navigation.Enum.NavigationTabLayout)
local _ImagesTypes = require(scriptParentParentParent.App.ImageSet.ImagesTypes)
local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)
local GetTextSize = require(scriptParentParentParent.Core.Text.GetTextSize)

local isBuilderIcon = Foundation.Utility.isBuilderIcon
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local Radius = Foundation.Enums.Radius
local Icon = Foundation.Icon
local Popover = Foundation.Popover
local StatusIndicator = Foundation.StatusIndicator
local FoundationText = Foundation.Text
local View = Foundation.View

local migrateBadgeVariant = require(scriptParentParentParent.Utility.migrateBadgeVariant)

local vector2 = Vector2.new(math.huge, math.huge)

local tbl1 = {
    hasLabel = false,
    isChecked = false,
    badgeValue = nil,
    layout = NavigationTabLayout.Stacked,
    tooltipSide = PopoverSide.Right,
    tooltipAlign = PopoverAlign.Center
}

local function NavigationTabTooltip(tbl2)
    local tokens = useStyle().Tokens

    return React.createElement(Popover.Root, {
        isOpen = tbl2.isOpen
    }, {
        Anchor = React.createElement(Popover.Anchor, { anchorRef = tbl2.anchorRef }),
        Content = React.createElement(
            Popover.Content,
            {
                hasArrow = false,
                align = tbl2.align,
                side = {
                    position = tbl2.side,
                    offset = tbl2.offset or tokens.Size.Size_200
                },
                radius = Radius.Small,
                backgroundStyle = tokens.Inverse.Surface.Surface_0,
                selectionGroup = false
            },
            React.createElement(View, { tag = "auto-xy padding-x-small padding-y-xsmall" }, {
                Title = React.createElement(FoundationText, { Text = tbl2.labelText, tag = "auto-xy text-body-small content-inverse-emphasis" })
            })
        )
    })
end

return (React.forwardRef(function(tbl2, ref)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local tokens = useStyle().Tokens

    local addNavigationTabTooltipAndTruncation = UIBloxConfig.addNavigationTabTooltipAndTruncation

    if addNavigationTabTooltipAndTruncation then
        if var1.layout == NavigationTabLayout.Stacked then
            addNavigationTabTooltipAndTruncation = var1.width ~= nil or var1.fillWidth == true
        else
            addNavigationTabTooltipAndTruncation = false
        end
    end

    local xScale = if var1.width then var1.width.Scale else 0
    local xOffset = if var1.width then var1.width.Offset else 0

    local var2, var3 = React.useBinding(Vector2.zero)
    local var4 = React.useCallback(function(arg1)
        local absoluteSize = arg1.AbsoluteSize
        local value = var2:getValue()

        if if addNavigationTabTooltipAndTruncation then value.Y ~= absoluteSize.Y else value ~= absoluteSize then
            var3(absoluteSize)
        end
    end, { addNavigationTabTooltipAndTruncation })

    local var5 = React.useMemo(function()
        return var2:map(function(vector2_2: Vector2): UDim2
            if addNavigationTabTooltipAndTruncation then
                return UDim2.new(xScale, xOffset, 0, vector2_2.Y)
            end
            return UDim2.fromOffset(vector2_2.X, vector2_2.Y)
        end)
    end, { addNavigationTabTooltipAndTruncation, xScale, xOffset })

    local anchorRef = React.useRef(nil)

    local isOpen, var8 = React.useState(false)

    local enableTooltip = UIBloxConfig.addNavigationTabTooltipAndTruncation and var1.enableTooltip

    if enableTooltip then
        if var1.layout == NavigationTabLayout.Stacked then
            enableTooltip = var1.hasLabel and var1.labelText ~= nil
        else
            enableTooltip = false
        end
    end
    if UIBloxConfig.addNavigationTabTooltipAndTruncation
        and var1.enableTooltip
        and (not var1.hasLabel or var1.labelText == nil)
    then
        Logger:warning("NavigationTab enableTooltip requires hasLabel and labelText")
    end

    local var9 = React.useRef(nil)

    local var10 = React.useCallback(function()
        if var9.current then
            task.cancel(var9.current)
            var9.current = nil
        end
    end, {})

    React.useEffect(function()
        return var10
    end, { var10 })

    local var11 = React.useCallback(function(arg1, arg2)
        if var1.onStateChanged then
            var1.onStateChanged(arg1, arg2)
        end

        if not enableTooltip then
            return
        end

        var10()

        if arg2 ~= ControlState.Hover and arg2 ~= ControlState.Selected and arg2 ~= ControlState.SelectedPressed then
            var8(false)
            return
        end

        local var11 = nil
        var11 = task.delay(tokens.Time.Time_500, function()
            if var9.current ~= var11 then
                return
            end
            var9.current = nil
            var8(true)
        end)
        var9.current = var11
    end, {
        var1.onStateChanged,
        enableTooltip,
        var10,
        tokens.Time.Time_500
    })

    local var12 = nil
    if var1.labelTypography then
        var12 = var1.labelTypography.FontSize
        if var12 ~= nil and typeof(var12) ~= "number" then
            var12 = var12:getValue()
        end
    end
    local var13 = React.useMemo(function()
        if not (var1.hasLabel and var1.labelText and var1.labelTypography) then
            return nil
        end

        local textSize = GetTextSize(var1.labelText, var12, var1.labelTypography.Font, vector2)
        return UDim2.new(0, textSize.X + 2, 0, textSize.Y + 2)
    end, {
        var1.hasLabel,
        var1.labelText,
        var1.labelTypography,
        var12
    })

    local uDim2 = UDim2.fromOffset(tokens.Size.Size_700, tokens.Size.Size_700)
    local element

    if var1.renderIcon then
        element = var1.renderIcon(var1.isChecked)
    else
        local image = if var1.isChecked and var1.iconCheckedImage then var1.iconCheckedImage else var1.iconImage
        local style = if var1.isChecked then tokens.Color.Content.Emphasis else tokens.Color.Content.Default
        local name = nil
        local variant = nil
        if UIBloxConfig.addFoundationNavigationTabIcon then
            if typeof(image) == "string" then
                if isBuilderIcon(image) then
                    name = image
                end
            elseif typeof(image) == "table" and image.name ~= nil and isBuilderIcon(image.name) then
                name = image.name
                variant = image.variant
            end
        end

        if UIBloxConfig.addFoundationNavigationTabIcon and name ~= nil then
            element = React.createElement(
                View,
                { tag = "size-0-0 auto-xy padding-xxsmall" },
                {
                    Icon = React.createElement(Icon, { name = name, size = InputSize.Large, variant = variant, style = style })
                }
            )
        else
            element = React.createElement(Label, {
                BackgroundTransparency = 1,
                Size = uDim2,
                Image = image,
                ScaleType = Enum.ScaleType.Fit,
                ImageColor3 = style.Color3,
                ImageTransparency = style.Transparency
            })
        end
    end
    if var1.layout == NavigationTabLayout.Stacked and var1.badgeValue ~= nil then
        local createElement = React.createElement

        local tbl3 = {
            Icon = element,
            Badge = React.createElement(StatusIndicator, {
                Position = UDim2.fromScale(1, 0),
                AnchorPoint = Vector2.new(0.6, 0.35),
                value = tonumber(var1.badgeValue),
                variant = migrateBadgeVariant(var1.badgeVariant),
                max = if tonumber(var1.badgeValue) then 99 else nil
            })
        }
        element = createElement("Frame", { BackgroundTransparency = 1, Size = uDim2, LayoutOrder = 1 }, tbl3)
    end

    local var14

    if var1.hasLabel and var1.labelText then
        local var15 = if var1.isChecked then tokens.Color.Content.Emphasis else tokens.Color.Content.Default
        local createElement = React.createElement
        local str1 = "TextLabel"
        local tbl3 = {
            AutomaticSize = if addNavigationTabTooltipAndTruncation then Enum.AutomaticSize.Y elseif var13 then nil else Enum.AutomaticSize.XY,
            Size = 0,
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            TextXAlignment = 0,
            TextWrapped = false,
            TextTruncate = 0,
            Text = 0,
            FontFace = 0,
            TextSize = 0,
            LineHeight = 0,
            TextColor3 = 0,
            TextTransparency = 0
        }

        if addNavigationTabTooltipAndTruncation then
            var13 = UDim2.fromScale(1, 0)
        end

        tbl3.Size = var13

        tbl3.TextXAlignment = Enum.TextXAlignment.Center

        tbl3.TextTruncate = if addNavigationTabTooltipAndTruncation then Enum.TextTruncate.AtEnd else nil
        tbl3.Text = var1.labelText
        tbl3.FontFace = if var1.labelTypography then normalizeFontFace(var1.labelTypography.Font) else nil
        tbl3.TextSize = if var1.labelTypography then var1.labelTypography.FontSize else nil
        tbl3.LineHeight = if var1.labelTypography then var1.labelTypography.LineHeight else nil
        tbl3.TextColor3 = var15.Color3
        tbl3.TextTransparency = var15.Transparency
        var14 = createElement(str1, tbl3, {
            UITextSizeConstraint = if UIBloxConfig.addNavigationTabTooltipAndTruncation and var1.labelMaxTextSize then React.createElement("UITextSizeConstraint", { MaxTextSize = var1.labelMaxTextSize }) else nil
        })
    else
        var14 = nil
    end

    local var15 = nil
    local var16 = nil
    if var1.layout == NavigationTabLayout.Stacked then
        var16 = UDim.new(0, tokens.Radius.Medium)
        local size1200 = tokens.Size.Size_1200
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl3 = {
            AutomaticSize = if addNavigationTabTooltipAndTruncation then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            Size = if addNavigationTabTooltipAndTruncation then UDim2.new(1, 0, 0, size1200) else UDim2.fromOffset(size1200, size1200),
            ref = if UIBloxConfig.addNavigationTabTooltipAndTruncation then anchorRef else nil,
            [React.Change.AbsoluteSize] = var4
        }
        local tbl4 = {
            UIPadding = React.createElement(
                "UIPadding",
                {
                    PaddingTop = UDim.new(0, tokens.Size.Size_200),
                    PaddingBottom = UDim.new(0, tokens.Size.Size_200)
                }
            ),
            UIListLayout = React.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = if UIBloxConfig.removeStackedNavigationTabIconLabelSpacing then nil else UDim.new(0, tokens.Size.Size_100)
            }),
            Icon = element,
            Label = var14
        }
        var15 = createElement(str1, tbl3, tbl4)
    elseif var1.layout == NavigationTabLayout.Inline then
        var16 = UDim.new(0, tokens.Size.Size_300)
        local var17 = not var1.isChecked and { Transparency = 1, Color3 = nil } or tokens.Color.State.Press

        local createElement = React.createElement
        local str1 = "Frame"
        local tbl3 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = var17.Transparency,
            BackgroundColor3 = var17.Color3,
            Size = UDim2.fromOffset(tokens.Size.Size_1200, tokens.Size.Size_1000),
            [React.Change.AbsoluteSize] = var4
        }
        local tbl4 = {
            UIPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, tokens.Size.Size_100),
                PaddingBottom = UDim.new(0, tokens.Size.Size_100),
                PaddingLeft = UDim.new(0, tokens.Size.Size_300),
                PaddingRight = UDim.new(0, tokens.Size.Size_300)
            }),
            UIListLayout = React.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, tokens.Size.Size_300)
            }),
            UICorner = React.createElement("UICorner", { CornerRadius = var16 }),
            Icon = element,
            Label = var14,
            Badge = if var1.badgeValue == nil then nil else React.createElement(StatusIndicator, {
                LayoutOrder = 3,
                value = tonumber(var1.badgeValue),
                variant = migrateBadgeVariant(var1.badgeVariant),
                max = if tonumber(var1.badgeValue) then 99 else nil
            })
        }
        var15 = createElement(str1, tbl3, tbl4)
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        ref = ref,
        Size = var5,
        BackgroundTransparency = 1,
        AnchorPoint = var1.anchorPoint,
        Position = var1.position,
        LayoutOrder = var1.layoutOrder
    }
    local tbl4 = {
        UIFlexItem = if UIBloxConfig.addNavigationTabTooltipAndTruncation and var1.layout == NavigationTabLayout.Stacked and var1.fillWidth then React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }) else nil,
        Contents = var15,
        StateLayer = 0,
        Tooltip = 0
    }
    local createElement2 = React.createElement
    local var17 = StateLayer
    local tbl5 = {
        affordance = "Background",
        cornerRadius = var16,
        zIndex = 10,
        onActivated = var1.onActivated,
        onStateChanged = 0
    }

    if not UIBloxConfig.addNavigationTabTooltipAndTruncation then
        var11 = var1.onStateChanged
    end

    tbl5.onStateChanged = var11
    tbl4.StateLayer = createElement2(var17, tbl5)

    tbl4.Tooltip = if UIBloxConfig.addNavigationTabTooltipAndTruncation and enableTooltip then React.createElement(
        NavigationTabTooltip,
        {
            isOpen = isOpen,
            anchorRef = anchorRef,
            labelText = var1.labelText,
            side = var1.tooltipSide,
            align = var1.tooltipAlign,
            offset = var1.tooltipOffset
        }
    ) else nil
    return createElement(str1, tbl3, tbl4)
end))
