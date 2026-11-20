-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local View = require(Foundation.Components.View)

local _PaginationSize = require(Foundation.Enums.PaginationSize)

local PaginationDirection = require(Foundation.Enums.PaginationDirection)

local NavButton = require(script.Parent.NavButton)
local paginationSlotsUtils = require(script.Parent.Parent.paginationSlotsUtils)
local _usePaginationSelectionChain = require(script.Parent.Parent.usePaginationSelectionChain)

local tbl1 = {
    start = { PaginationDirection.First, PaginationDirection.Backward },
    ["end"] = { PaginationDirection.Forward, PaginationDirection.Last }
}

local tbl2 = { start = "left-nav", ["end"] = "right-nav" }

local function shouldShowNavButton(arg1, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1 == PaginationDirection.First or arg1 == PaginationDirection.Last) or tbl3.hasFirstLastButtons
end

local function getIsDisabled(arg1, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == PaginationDirection.First then
        return tbl3.isFirstDisabled
    end

    if arg1 == PaginationDirection.Backward then
        return tbl3.isBackDisabled
    end

    if arg1 == PaginationDirection.Forward then
        return tbl3.isForwardDisabled
    end

    return tbl3.isLastDisabled
end

return React.memo(function(tbl3) -- name: NavControls
    local var1 = tbl1[tbl3.side]

    local tbl4 = ({})
    local num1 = 0

    for i = 1, #var1 do
        local direction = var1[i]

        if not shouldShowNavButton(direction, tbl3) then
            continue
        end

        num1 += 1
        local var3 = paginationSlotsUtils.NAV_SLOT_IDS[direction]
        local slotBindings = tbl3.selection.getSlotBindings(var3)
        tbl4[direction] = React.createElement(NavButton, {
            baseTestId = tbl3.testId,
            slotSize = tbl3.size,
            direction = direction,
            isDisabled = getIsDisabled(direction, tbl3),
            LayoutOrder = num1,
            onDirectionActivated = tbl3.onDirectionActivated,
            ref = tbl3.selection.getSlotRef(var3),
            Selectable = slotBindings.Selectable,
            NextSelectionLeft = slotBindings.NextSelectionLeft,
            NextSelectionRight = slotBindings.NextSelectionRight,
            NextSelectionUp = slotBindings.NextSelectionUp,
            NextSelectionDown = slotBindings.NextSelectionDown
        })
    end

    return React.createElement(View, {
        LayoutOrder = tbl3.LayoutOrder,
        tag = "row gap-xsmall auto-xy",
        testId = `{tbl3.testId}--{tbl2[tbl3.side]}`
    }, tbl4)
end)
