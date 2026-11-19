-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:30:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local useMotion = require(FoundationParent.Motion).useMotion

local Components = Foundation.Components
local Icon = require(Components.Icon)
local Image = require(Components.Image)
local Text = require(Components.Text)
local _Types = require(Components.Types)
local View = require(Components.View)

local Constants = require(Foundation.Constants)
local escapeRichText = require(Foundation.Utility.escapeRichText)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon
local normalizeIconName = iconMigrationUtils.normalizeIconName
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useOptionSelectorGroupItemMotionStates = require(script.Parent.useOptionSelectorGroupItemMotionStates)
local useOptionSelectorGroupItemVariants = require(script.Parent.useOptionSelectorGroupItemVariants)

local FillBehavior = require(Foundation.Enums.FillBehavior)

local _IconSize = require(Foundation.Enums.IconSize)

local InputSize = require(Foundation.Enums.InputSize)

local OptionSelectorGroupSize = require(Foundation.Enums.OptionSelectorGroupSize)

local Orientation = require(Foundation.Enums.Orientation)

local useOptionSelectorGroup = require(script.Parent.Parent.useOptionSelectorGroup)

local function getTransparency(transparency: number?, transparency2) -- Luacid: Inlined by compiler; 1 call site recovered
    return transparency2:map(function(arg1)
        if transparency == nil then
            return arg1
        end

        return transparency + (1 - transparency) * arg1
    end)
end

local function getTextStyle<T>(textTransparency: T, transparency: T, color3: Color3)
    return React.joinBindings({ textTransparency, transparency }):map(function(arg1)
        local var1 = arg1[2]
        return { Color3 = color3, Transparency = var1 }
    end)
end

local function renderIcon(tbl1)
    if not tbl1.icon then
        return nil
    end
    if not isBuilderOrMigratedIcon(tbl1.icon) then
        local iconExtent = tbl1.iconExtent
        return React.createElement(Image, {
            Image = tbl1.icon,
            Size = UDim2.fromOffset(iconExtent, iconExtent),
            imageStyle = tbl1.transparency:map(function(transparency)
                return {
                    Color3 = tbl1.contentColor,
                    Transparency = transparency
                }
            end),
            LayoutOrder = tbl1.layoutOrder,
            testId = `{tbl1.testId}--icon`
        })
    end

    local var1 = normalizeIconName(tbl1.icon)

    local tbl2 = {
        name = var1.name,
        size = tbl1.iconSize,
        style = tbl1.transparency:map(function(transparency)
            return {
                Color3 = tbl1.contentColor,
                Transparency = transparency
            }
        end),
        LayoutOrder = tbl1.layoutOrder,
        testId = `{tbl1.testId}--icon`
    }
    if var1.variant then
        tbl2.variant = var1.variant
    end

    return React.createElement(Icon, tbl2)
end

local tbl1 = {
    isDisabled = false,
    size = InputSize.Medium,
    width = UDim.new(0, 0)
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: OptionSelectorGroupItem
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useOptionSelectorGroup()

    local bool1 = var2.value == var1.value
    local var3 = if var2.size ~= nil then var2.size elseif var1.size == InputSize.Large then OptionSelectorGroupSize.Medium else var1.size
    local var4 = if var2.orientation == Orientation.Vertical then Orientation.Horizontal else Orientation.Vertical
    local fillBehavior = if var2.fillBehavior ~= nil then var2.fillBehavior else var1.fillBehavior
    local var5 = if var4 == Orientation.Horizontal then FillBehavior.Fill else fillBehavior or FillBehavior.Fit
    local scale = if var4 == Orientation.Vertical and var5 == FillBehavior.Fit then nil else UDim2.fromScale(1, 0)
    local var6 = useTokens()
    local var7 = useOptionSelectorGroupItemVariants(var6, var3, var4, var5, bool1)

    local color3 = var7.content.Color3
    local var8 = if var7.supportingContent then var7.supportingContent.Color3 else color3
    local stroke = var7.container.stroke

    local var9 = useOptionSelectorGroupItemMotionStates(0, Constants.DISABLED_TRANSPARENCY)
    local var10, var11 = useMotion(var9.Default)
    local var12, _ = useMotion(var9.Default)

    React.useEffect(function()
        if var1.isDisabled then
            var11(var9.Disabled)
            return
        end
        var11(var9.Default)
    end, { var1.isDisabled })

    local onActivated = React.useCallback(function()
        var2.onValueChanged(if var2.value == var1.value then nil else var1.value)
    end, {
        var1.isDisabled,
        var1.value,
        var2.onValueChanged,
        var2.value
    })

    var1.testId = `{var2.testId}--item-{var1.value}`

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, var7.container.radius),
            offset = var6.Size.Size_200,
            borderWidth = var6.Stroke.Thicker
        }
    end, { var6, var7.container.radius })
    local tbl2 = {
        Icon = renderIcon({
            icon = var1.icon,
            iconExtent = var7.icon.extent,
            iconSize = var7.icon.size,
            contentColor = color3,
            transparency = var10.transparency,
            layoutOrder = 1,
            testId = var1.testId
        }),
        Text = 0
    }
    local createElement = React.createElement
    local var15 = View
    local tbl3 = {
        tag = var7.textContainer.tag,
        LayoutOrder = 2,
        testId = `{var1.testId}--body`
    }
    local tbl4 = {
        Label = React.createElement(Text, {
            Text = escapeRichText(var1.label or var1.value),
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
            tag = var7.label.tag,
            textStyle = getTextStyle(var12.textTransparency, var10.transparency, color3),
            LayoutOrder = 1,
            testId = `{var1.testId}--label`
        }),
        Metadata = 0,
        Description = 0
    }
    local element

    if var1.metadata then
        element = React.createElement(Text, {
            Text = escapeRichText(var1.metadata),
            TextTruncate = Enum.TextTruncate.None,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
            tag = var7.metadata.tag,
            textStyle = getTextStyle(var12.textTransparency, var10.transparency, var8),
            LayoutOrder = 2,
            testId = `{var1.testId}--metadata`
        })
    else
        element = nil
    end

    tbl4.Metadata = element
    local element2

    if var1.description then
        element2 = React.createElement(Text, {
            Text = escapeRichText(var1.description),
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            RichText = true,
            tag = var7.description.tag,
            textStyle = getTextStyle(var12.textTransparency, var10.transparency, var8),
            LayoutOrder = 3,
            testId = `{var1.testId}--description`
        })
    else
        element2 = nil
    end

    tbl4.Description = element2
    tbl2.Text = createElement(var15, tbl3, tbl4)

    local createElement2 = React.createElement
    local var16 = View
    local var17 = withCommonProps
    local tbl5 = {
        stroke = {
            Color = stroke.Color3,
            Transparency = getTransparency(stroke.Transparency, var10.transparency)
        },
        Size = scale,
        padding = var7.container.padding,
        selection = {
            Selectable = not var1.isDisabled and var2.Selectable
        },
        cursor = cursor,
        onActivated = onActivated,
        isDisabled = var1.isDisabled,
        tag = var7.container.tag,
        ref = ref
    }
    return createElement2(var16, var17(var1, tbl5), {
        ItemInner = React.createElement(
            View,
            {
                tag = var7.itemInner.tag,
                Size = scale,
                testId = `{var1.testId}--content`
            },
            tbl2
        )
    })
end))
