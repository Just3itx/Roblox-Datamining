-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:01:00Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local HeaderBarContext = require(Foundation.Components.HeaderBar.HeaderBarContext)
local HeaderBarSlot = require(Foundation.Enums.HeaderBarSlot)
local View = require(Foundation.Components.View)
local constants = require(Foundation.Components.HeaderBar.constants)
local useHeaderBarContext = require(Foundation.Components.HeaderBar.useHeaderBarContext)

local function HeaderBarTrailing(tbl1)
    local var1 = useHeaderBarContext()

    return React.createElement(
        HeaderBarContext.Provider,
        {
            testId = var1.testId,
            slot = HeaderBarSlot.Trailing
        },
        React.createElement(View, {
            tag = "row align-x-right align-y-center shrink gap-small size-full",
            LayoutOrder = constants.TRAILING_LAYOUT_ORDER,
            testId = `{var1.testId}--trailing`
        }, tbl1.children)
    )
end

return HeaderBarTrailing
