-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:21:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Icon = BuilderIcons.Icon

local ButtonVariant = require(Foundation.Enums.ButtonVariant)

local InputSize = require(Foundation.Enums.InputSize)

local LinkVariant = require(Foundation.Enums.LinkVariant)

local Icon2 = require(Foundation.Components.Icon)
local IconButton = require(Foundation.Components.IconButton)
local Link = require(Foundation.Components.Link)
local Menu = require(Foundation.Components.Menu)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local BreadcrumbAccessory = require(script.Parent.BreadcrumbAccessory)

local useBreadcrumbVariants = require(script.Parent.useBreadcrumbVariants)

local useTokens = require(Foundation.Providers.Style.useTokens)

local tbl1 = {
    size = InputSize.Medium,
    testId = "--foundation-breadcrumb"
}

local function BreadcrumbItem(tbl2)
    local item = tbl2.item
    local variantProps = tbl2.variantProps
    local testId = tbl2.testId
    local element

    if tbl2.isCurrent or item.onActivated == nil then
        element = React.createElement(Text, {
            Text = item.text,
            tag = if tbl2.isCurrent then variantProps.current.tag else variantProps.label.tag,
            LayoutOrder = 1,
            testId = `{testId}--text`
        })
    else
        element = React.createElement(Link, {
            text = item.text,
            onActivated = item.onActivated,
            variant = LinkVariant.Standard,
            size = tbl2.size,
            hasUnderline = false,
            LayoutOrder = 1,
            testId = `{testId}--link`
        })
    end

    local createElement = React.createElement
    local var1 = View
    local tbl3 = {
        tag = variantProps.item.tag,
        ref = item.ref,
        onActivated = if tbl2.hasDropdown then tbl2.onDropdownActivated else nil,
        LayoutOrder = tbl2.LayoutOrder,
        testId = testId
    }
    local tbl4 = {
        Leading = if item.leading == nil then nil else React.createElement(
            BreadcrumbAccessory,
            {
                config = item.leading,
                variant = variantProps.accessory,
                LayoutOrder = 1,
                testId = `{testId}--leading`
            }
        ),
        ItemText = React.createElement(View, {
            tag = variantProps.itemText.tag,
            LayoutOrder = 2
        }, {
            Text = element,
            Chevron = if tbl2.hasDropdown then React.createElement(Icon2, {
                name = Icon.ChevronLargeDown,
                size = variantProps.accessory.iconSize,
                style = variantProps.accessory.style,
                LayoutOrder = 2,
                testId = `{testId}--chevron`
            }) else nil
        })
    }
    return createElement(var1, tbl3, tbl4)
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: Breadcrumb
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local variantProps = useBreadcrumbVariants(var2, var1.size)

    local itemsLen = #var1.items
    local bool1 = itemsLen > 4
    local var4 = React.useRef(nil)
    local isOpen, var6 = React.useState(false)

    React.useEffect(function()
        if not bool1 then
            var6(false)
        end
    end, { bool1 })

    local onActivated = React.useCallback(function()
        var6(function(arg2): boolean
            return not arg2
        end)
    end, {})
    local onPressedOutside = React.useCallback(function()
        var6(false)
    end, {})

    local var3 = React.useCallback(function(arg2)
        var6(false)
        local item = var1.items[arg2]
        if item and item.onActivated then
            item.onActivated()
        end
    end, { var1.items })

    local var10 = React.useMemo(function()
        if not bool1 then
            local result = {}
            for index, item in var1.items do
                table.insert(result, { item = item, index = index })
            end
            return result
        end

        return {
            {
                item = var1.items[1],
                index = 1
            },
            { overflow = true },
            {
                item = var1.items[itemsLen],
                index = itemsLen
            }
        }
    end, { var1.items, itemsLen, bool1 })

    local items = React.useMemo(function()
        local result = {}
        if bool1 then
            for id = 2, itemsLen - 1 do
                local item = var1.items[id]
                table.insert(result, { id = id, text = item.text, isDisabled = item.onActivated == nil })
            end
        end

        return result
    end, { var1.items, itemsLen, bool1 })

    local tbl2 = {}
    for value, value2 in var10 do
        if value2.overflow then
            tbl2.Overflow = React.createElement(IconButton, {
                icon = Icon.ThreeDotsHorizontal,
                onActivated = onActivated,
                ref = var4,
                size = variantProps.overflow.size,
                variant = ButtonVariant.Standard,
                LayoutOrder = 2 * value - 1,
                testId = `{var1.testId}--overflow`
            })
        else
            local item = value2.item
            local index = value2.index
            local isCurrent = index == itemsLen
            local str1 = `Item{index}`
            tbl2[str1] = React.createElement(BreadcrumbItem, {
                item = item,
                isCurrent = isCurrent,
                hasDropdown = isCurrent and var1.onDropdownActivated ~= nil,
                onDropdownActivated = if isCurrent then var1.onDropdownActivated else nil,
                size = var1.size,
                variantProps = variantProps,
                LayoutOrder = 2 * value - 1,
                testId = item.testId or `{var1.testId}--item-{index}`
            })
        end

        if value == #var10 then
            continue
        end

        local var12 = if value2.overflow then "overflow" else value2.index
        local str1 = `Separator{var12}`
        local createElement = React.createElement
        local var13 = View
        local tbl3 = {
            tag = variantProps.separator.tag,
            LayoutOrder = 2 * value,
            testId = `{var1.testId}--separator-{var12}`
        }
        local tbl4 = {
            Slash = React.createElement(Text, {
                Text = "/",
                tag = variantProps.separator.textTag,
                LayoutOrder = 1,
                testId = `{var1.testId}--separator-{var12}--text`
            })
        }
        tbl2[str1] = createElement(var13, tbl3, tbl4)
    end

    if bool1 then
        tbl2.OverflowMenu = React.createElement(Menu, {
            isOpen = isOpen,
            items = items,
            size = var1.size,
            anchorRef = var4,
            onActivated = var3,
            onPressedOutside = onPressedOutside,
            LayoutOrder = #var10 * 2,
            testId = `{var1.testId}--overflow-menu`
        })
    end

    return React.createElement(View, withCommonProps(var1, { tag = variantProps.container.tag, ref = ref }), tbl2)
end))
