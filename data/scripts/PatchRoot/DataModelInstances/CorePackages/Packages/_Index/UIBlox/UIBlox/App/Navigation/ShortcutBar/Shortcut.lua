-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local React = require(scriptParentParentParentParentParent.React)
local Object = require(scriptParentParentParentParentParent.LuauPolyfill).Object
local Foundation = require(scriptParentParentParentParentParent.Foundation)

local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)

local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local KeyLabel = require(scriptParentParentParent.Menu.KeyLabel.KeyLabel)

local ProgressIconAnimated = require(script.Parent.ProgressIconAnimated)
local _Types = require(script.Parent.Types)

local tbl1 = {
    iconLabelGap = 6,
    actionTextSpacingLeading = 12,
    size = UDim2.fromOffset(0, 0),
    automaticSize = Enum.AutomaticSize.XY
}

local tbl2 = {
    hasProgress = false,
    animationTriggerTime = 0.3,
    animationKeyHoldingTime = 1.5,
    animationCoolDownTime = 0.75
}

local function renderIcon(tbl3, arg1)
    local layoutOrder = tbl3.layoutOrder
    local itemProps = tbl3.itemProps
    local var1 = Foundation.Hooks.useTokens()
    local var2 = if UIBloxConfig.useTokenizedShortcutBar then var1.Size.Size_600 else getIconSize(IconSize.Medium)
    local hasProgress = itemProps.hasProgress
    local var3 = if hasProgress then itemProps else nil
    local icon = itemProps.icon

    local automaticSizeX = nil
    local bool1 = typeof(icon) == "EnumItem"
    local bool2 = typeof(icon) == "table" and #icon > 0

    if bool1 or bool2 then
        automaticSizeX = Enum.AutomaticSize.X
    end

    local element

    if bool1 then
        element = React.createElement(KeyLabel, { keyCode = icon, iconThemeKey = "IconEmphasis" })
    elseif bool2 then
        local tbl4 = {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center
            })
        }
        for value, keyCode in icon do
            tbl4["KeyLabel" .. value] = React.createElement(KeyLabel, { keyCode = keyCode, LayoutOrder = value, iconThemeKey = "IconEmphasis" })
        end

        element = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1
            },
            tbl4
        )
    else
        element = React.createElement(ImageSetComponent.Label, {
            Size = UDim2.fromScale(1, 1),
            Image = icon,
            ImageColor3 = arg1.Theme.TextEmphasis.Color,
            ImageTransparency = arg1.Theme.TextEmphasis.Transparency,
            BackgroundTransparency = 1
        })
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        LayoutOrder = layoutOrder,
        Size = UDim2.fromOffset(var2, var2),
        AutomaticSize = automaticSizeX,
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }

    local tbl5 = {
        ProgressIcon = if hasProgress then React.createElement(ProgressIconAnimated, var3) else nil,
        Image = 0
    }

    if hasProgress then
        element = nil
    end

    tbl5.Image = element
    return createElement(str1, tbl4, tbl5)
end

local function Shortcut(arg1)
    local var1 = Object.assign({}, tbl1, arg1)
    local itemProps = Object.assign({}, tbl2, var1.publicProps)

    local var3 = useStyle()
    local var4 = Foundation.Hooks.useTokens()
    local index = var1.index

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = index,
        Size = if UIBloxConfig.enableShortcutCustomization then var1.size else UDim2.fromOffset(0, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AutomaticSize = if UIBloxConfig.enableShortcutCustomization then var1.automaticSize else Enum.AutomaticSize.XY
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.iconLabelGap)
        }),
        ActionText = 0,
        Icon = 0,
        LabelText = 0
    }
    local element

    if itemProps.actionText then
        element = React.createElement("Frame", {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(0, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.XY
        }, {
            Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var1.actionTextSpacingLeading) }),
            Label = React.createElement(GenericTextLabel, {
                Size = UDim2.fromOffset(0, 0),
                AutomaticSize = Enum.AutomaticSize.XY,
                Text = itemProps.actionText,
                colorStyle = var3.Theme.TextEmphasis,
                fontStyle = var3.Font.SubHeader1,
                BackgroundTransparency = 1
            })
        })
    else
        element = nil
    end

    tbl4.ActionText = element

    tbl4.Icon = if UIBloxConfig.enableShortcutCustomization and var1.renderIcon then var1.renderIcon({ layoutOrder = 2 }) else renderIcon({ layoutOrder = 2, itemProps = itemProps }, var3)

    tbl4.LabelText = React.createElement(GenericTextLabel, {
        LayoutOrder = 3,
        Size = UDim2.fromOffset(0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        Text = itemProps.text,
        TextSize = if UIBloxConfig.enableShortcutCustomization and var1.labelTextSize then var1.labelTextSize elseif UIBloxConfig.useTokenizedShortcutBar then var4.FontSize.FontSize_50 else nil,
        colorStyle = if UIBloxConfig.enableShortcutCustomization and var1.labelColorStyle then var1.labelColorStyle else var3.Theme.TextEmphasis,
        fontStyle = if UIBloxConfig.enableShortcutCustomization and var1.labelFontStyle then var1.labelFontStyle else var3.Font.SubHeader1,
        BackgroundTransparency = 1
    })
    return createElement(str1, tbl3, tbl4)
end

return Shortcut
