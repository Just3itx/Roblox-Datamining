-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)
local HeaderBarContext = require(Foundation.Components.HeaderBar.HeaderBarContext)
local HeaderBarSlot = require(Foundation.Enums.HeaderBarSlot)
local View = require(Foundation.Components.View)
local constants = require(Foundation.Components.HeaderBar.constants)
local useHeaderBarContext = require(Foundation.Components.HeaderBar.useHeaderBarContext)

local function HeaderBarLeading(tbl1)
    local var1 = useHeaderBarContext()

    if not Flags.FoundationHeaderBarSlotSizing then
        return React.createElement(
            HeaderBarContext.Provider,
            {
                testId = var1.testId,
                slot = HeaderBarSlot.Leading
            },
            React.createElement(View, {
                tag = "row align-y-center shrink gap-small size-full",
                LayoutOrder = constants.LEADING_LAYOUT_ORDER,
                testId = `{var1.testId}--leading`
            }, tbl1.children)
        )
    end

    local onSideWidthChanged = var1.onSideWidthChanged

    React.useLayoutEffect(function()
        return function()
            if onSideWidthChanged then
                onSideWidthChanged(HeaderBarSlot.Leading, 0)
            end
        end
    end, { onSideWidthChanged })

    return React.createElement(
        HeaderBarContext.Provider,
        {
            testId = var1.testId,
            slot = HeaderBarSlot.Leading,
            leadingWidth = var1.leadingWidth,
            trailingWidth = var1.trailingWidth,
            onSideWidthChanged = onSideWidthChanged
        },
        React.createElement(View, {
            tag = "row align-x-left align-y-center size-full",
            LayoutOrder = constants.LEADING_LAYOUT_ORDER,
            ZIndex = 2,
            testId = `{var1.testId}--leading`
        }, {
            Content = React.createElement(View, {
                tag = "row align-y-center gap-small size-0-full auto-x",
                LayoutOrder = 1,
                onAbsoluteSizeChanged = function(arg1)
                    if onSideWidthChanged then
                        onSideWidthChanged(HeaderBarSlot.Leading, arg1.AbsoluteSize.X)
                    end
                end,
                testId = `{var1.testId}--leading--content`
            }, tbl1.children)
        })
    )
end

return HeaderBarLeading
