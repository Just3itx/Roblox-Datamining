-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BaseMenu = require(Foundation.Components.BaseMenu)
local Popover = require(Foundation.Components.Popover)
local _Types = require(Foundation.Components.Types)

local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputSize = require(Foundation.Enums.InputSize)
local InputVariant = require(Foundation.Enums.InputVariant)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local Radius = require(Foundation.Enums.Radius)

local DropdownControl = require(script.Parent.DropdownControl)
local markSelectedItem = require(script.Parent.markSelectedItem)

local tbl1 = {
    variant = InputVariant.Standard,
    width = UDim.new(0, 400),
    size = InputSize.Medium,
    testId = "--foundation-dropdown"
}

local side = {
    position = PopoverSide.Bottom,
    offset = 5
}
return React.memo(React.forwardRef(function(arg1, arg2) -- name: Dropdown
    local var1 = withDefaults(arg1, tbl1)
    local var2, var3 = React.useState(false)
    local anchorRef = React.useRef(nil)
    local var5, var6 = React.useState(nil)
    local inputRef = React.useCallback(function(current)
        anchorRef.current = current
        var6(current)
    end, {})
    React.useImperativeHandle(arg2, function()
        return var5
    end, { var5 })

    local width, var9 = React.useBinding(var1.width)

    local items, var11 = markSelectedItem(var1.items, var1.value)

    local onActivated = React.useCallback(function()
        var3(function(arg3): boolean
            return not arg3
        end)
    end, {})

    local onPressedOutside = React.useCallback(function()
        var3(false)
    end, {})

    local var4 = React.useCallback(function(arg3)
        var3(false)
        var1.onItemChanged(arg3)
    end, { var1.onItemChanged })

    var1.onAbsoluteSizeChanged = React.useCallback(function(arg3)
        if arg1.onAbsoluteSizeChanged then
            arg1.onAbsoluteSizeChanged(arg3)
        end
        var9(UDim.new(0, arg3.AbsoluteSize.X))
    end, { var9, arg1.onAbsoluteSizeChanged })

    return React.createElement(Popover.Root, { isOpen = var2 }, {
        DropdownControl = React.createElement(
            DropdownControl,
            withCommonProps(var1, {
                variant = var1.variant,
                onActivated = onActivated,
                hasError = var1.hasError,
                isDisabled = var1.isDisabled,
                item = var11,
                placeholder = var1.placeholder,
                isMenuOpen = var2,
                width = var1.width,
                size = var1.size,
                label = var1.label,
                hint = var1.hint,
                inputRef = inputRef,
                Selectable = var1.Selectable,
                NextSelectionUp = var1.NextSelectionUp,
                NextSelectionDown = var1.NextSelectionDown,
                NextSelectionLeft = var1.NextSelectionLeft,
                NextSelectionRight = var1.NextSelectionRight
            })
        ),
        Anchor = React.createElement(Popover.Anchor, { anchorRef = anchorRef }),
        Menu = React.createElement(
            Popover.Content,
            {
                hasArrow = false,
                align = PopoverAlign.End,
                side = side,
                onPressedOutside = onPressedOutside,
                radius = Radius.Medium,
                selection = var1.selection,
                selectionGroup = var1.selectionGroup
            },
            React.createElement(BaseMenu.Root, {
                size = var1.size,
                couldGrow = true,
                width = width,
                items = items,
                maxHeight = var1.maxHeight,
                onActivated = var4,
                radius = Radius.Medium,
                scrollingFrameRef = var1.scrollingFrameRef,
                testId = `{var1.testId}--menu`
            })
        )
    })
end))
