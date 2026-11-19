-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BuilderIcons = require(FoundationParent.BuilderIcons)
local Icon = require(Foundation.Components.Icon)
local Image = require(Foundation.Components.Image)
local StatusIndicator = require(Foundation.Components.StatusIndicator)
local _StatusIndicatorShape = require(Foundation.Enums.StatusIndicatorShape)
local _StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local uiblox = BuilderIcons.Migration.uiblox
local FillBehavior = require(Foundation.Enums.FillBehavior)
local Flags = require(Foundation.Utility.Flags)
local _InputSize = require(Foundation.Enums.InputSize)
local getIconScale = require(Foundation.Utility.getIconScale)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon

local Constants = require(Foundation.Constants)

local TabItemAccessory = require(script.Parent.TabItemAccessory)
local TabItemAccessory2 = TabItemAccessory.TabItemAccessory
local resolve = TabItemAccessory.resolve
local useTabItemVariants = require(script.Parent.useTabItemVariants)

return React.memo(React.forwardRef(function(arg1, ref) -- name: TabItem
    local var1 = useTokens()
    local var2 = if arg1.isActive then var1.Color.Content.Default else var1.Color.Content.Emphasis
    local bool1 = arg1.fillBehavior == FillBehavior.Fill

    local var3 = useTabItemVariants(var1, arg1.size, bool1)

    local cursor = React.useMemo(function()
        return {
            radius = UDim.new(0, 0),
            offset = 0,
            borderWidth = var1.Stroke.Thicker
        }
    end, { var1 })

    local var5 = React.useMemo(function()
        if arg1.icon == nil then
            return nil
        end

        if typeof(arg1.icon) == "string" then
            return {
                name = arg1.icon,
                variant = BuilderIcons.IconVariant.Regular
            }
        end

        return arg1.icon
    end, { arg1.icon })

    local var6, var7

    if Flags.FoundationTabsAccessory then
        var6, var7 = resolve(arg1.leading, arg1.trailing, arg1.icon, arg1.indicator)
    else
        var6 = nil
        var7 = nil
    end

    local element = nil
    if var5 and not Flags.FoundationTabsAccessory then
        if isBuilderOrMigratedIcon(var5.name) then
            element = React.createElement(Icon, {
                name = if isMigrated(var5.name) then uiblox[var5.name].name else var5.name,
                variant = if isMigrated(var5.name) then uiblox[var5.name].variant else var5.variant,
                size = var3.icon.size,
                style = var2
            })
        else
            local var8, scale = getIconScale(var5.name, var3.icon.size)
            if var8 then
                element = React.createElement(
                    Image,
                    {
                        Image = var5.name,
                        Size = UDim2.fromOffset(var8.X, var8.Y),
                        imageStyle = var2,
                        scale = scale
                    }
                )
            end
        end
    end
    local createElement = React.createElement
    local var8 = View
    local tbl1 = {
        tag = var3.container.tag,
        GroupTransparency = if arg1.isDisabled then Constants.DISABLED_TRANSPARENCY else nil,
        testId = arg1.testId
    }

    local tbl2 = {
        Interactive = React.createElement(View, {
            LayoutOrder = 1,
            Size = UDim2.fromScale(1, 1),
            onActivated = function()
                arg1.onActivated(arg1.id)
            end,
            selection = {
                Selectable = not arg1.isDisabled
            },
            cursor = cursor,
            isDisabled = arg1.isDisabled,
            ref = ref
        }),
        Content = 0
    }
    local createElement2 = React.createElement
    local var9 = View
    local tbl3 = {
        LayoutOrder = 2,
        tag = var3.content.tag,
        Size = var3.content.Size
    }
    local tbl4 = { Icon = 0, Leading = 0, Text = 0, Indicator = 0, Trailing = 0 }
    if Flags.FoundationTabsAccessory or not arg1.icon then
        element = nil
    end

    tbl4.Icon = element
    tbl4.Leading = if Flags.FoundationTabsAccessory and var6 then React.createElement(TabItemAccessory2, {
        accessory = var6,
        contentStyle = var2,
        iconSize = var3.icon.size,
        LayoutOrder = 1,
        testId = `{arg1.testId}--leading`
    }) else nil

    tbl4.Text = React.createElement(Text, { Text = arg1.text, style = var2, tag = var3.text.tag, LayoutOrder = 2 })
    local element2

    if Flags.FoundationTabsAccessory or not arg1.indicator then
        element2 = nil
    else
        element2 = React.createElement(
            StatusIndicator,
            arg1.indicator.value
                and {
                    value = arg1.indicator.value,
                    variant = arg1.indicator.variant,
                    max = arg1.indicator.max,
                    LayoutOrder = 3,
                    testId = `{arg1.testId}--indicator`
                }
                or {
                    variant = arg1.indicator.variant,
                    shape = arg1.indicator.shape,
                    LayoutOrder = 3,
                    testId = `{arg1.testId}--indicator`
                }
        )
    end

    tbl4.Indicator = element2

    tbl4.Trailing = if Flags.FoundationTabsAccessory and var7 then React.createElement(TabItemAccessory2, {
        accessory = var7,
        contentStyle = var2,
        iconSize = var3.icon.size,
        LayoutOrder = 3,
        testId = `{arg1.testId}--trailing`
    }) else nil
    tbl2.Content = createElement2(var9, tbl3, tbl4)
    return createElement(var8, tbl1, tbl2)
end))
