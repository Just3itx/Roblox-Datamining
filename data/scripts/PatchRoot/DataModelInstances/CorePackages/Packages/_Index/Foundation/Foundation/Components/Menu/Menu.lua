-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BaseMenu = require(Foundation.Components.BaseMenu)
local Popover = require(Foundation.Components.Popover)
local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local InputSize = require(Foundation.Enums.InputSize)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local Radius = require(Foundation.Enums.Radius)

local tbl1 = {
    size = InputSize.Medium,
    side = PopoverSide.Bottom,
    align = PopoverAlign.Start,
    testId = "--foundation-menu"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Menu
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local standard = var2.Stroke.Standard

    return React.createElement(Popover.Root, {
        isOpen = var1.isOpen,
        testId = var1.testId
    }, {
        Anchor = React.createElement(
            Popover.Anchor,
            withCommonProps(var1, { anchorRef = var1.anchorRef }),
            if var1.anchorRef then nil else var1.children
        ),
        Content = React.createElement(
            Popover.Content,
            {
                side = {
                    position = var1.side,
                    offset = standard + var2.Padding.Small
                },
                align = var1.align,
                hasArrow = false,
                onPressedOutside = var1.onPressedOutside,
                backgroundStyle = var2.Color.Surface.Surface_200,
                radius = Radius.Medium,
                ref = ref,
                selection = var1.selection,
                selectionGroup = var1.selectionGroup
            },
            React.createElement(React.Fragment, nil, {
                Menu = React.createElement(BaseMenu.Root, {
                    items = var1.items,
                    size = var1.size,
                    width = var1.width,
                    maxHeight = var1.maxHeight,
                    onActivated = var1.onActivated,
                    onNestedLeafActivated = var1.onPressedOutside,
                    radius = Radius.Medium
                })
            })
        )
    })
end))
