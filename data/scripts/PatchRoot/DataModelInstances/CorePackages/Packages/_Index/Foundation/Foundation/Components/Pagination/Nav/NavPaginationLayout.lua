-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local _PaginationDirection = require(Foundation.Enums.PaginationDirection)

local _PaginationSize = require(Foundation.Enums.PaginationSize)

local withCommonProps = require(Foundation.Utility.withCommonProps)

local NavControls = require(script.Parent.NavControls)
local _usePaginationSelectionChain = require(script.Parent.Parent.usePaginationSelectionChain)

return React.memo(React.forwardRef(function(arg1, ref) -- name: NavPaginationLayout
    return React.createElement(View, withCommonProps(arg1, { tag = "row align-y-center gap-small auto-xy", ref = ref }), {
        LeftNav = React.createElement(NavControls, {
            side = "start",
            size = arg1.size,
            LayoutOrder = 1,
            isFirstDisabled = arg1.isFirstDisabled,
            isBackDisabled = arg1.isBackDisabled,
            isForwardDisabled = arg1.isForwardDisabled,
            isLastDisabled = arg1.isLastDisabled,
            onDirectionActivated = arg1.onDirectionActivated,
            hasFirstLastButtons = arg1.hasFirstLastButtons,
            testId = arg1.testId,
            selection = arg1.selection
        }),
        PageContent = arg1.pageContent,
        RightNav = React.createElement(NavControls, {
            side = "end",
            size = arg1.size,
            LayoutOrder = if arg1.pageContent then 3 else 2,
            isFirstDisabled = arg1.isFirstDisabled,
            isBackDisabled = arg1.isBackDisabled,
            isForwardDisabled = arg1.isForwardDisabled,
            isLastDisabled = arg1.isLastDisabled,
            onDirectionActivated = arg1.onDirectionActivated,
            hasFirstLastButtons = arg1.hasFirstLastButtons,
            testId = arg1.testId,
            selection = arg1.selection
        })
    })
end))
