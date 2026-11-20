-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local PaginationDirection = require(Foundation.Enums.PaginationDirection)

local NAV_SLOT_IDS = {
    [PaginationDirection.First] = "first",
    [PaginationDirection.Backward] = "back",
    [PaginationDirection.Forward] = "forward",
    [PaginationDirection.Last] = "last"
}

local function getPageSlotId(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `page-{num1}`
end

return {
    NAV_SLOT_IDS = NAV_SLOT_IDS,
    getPageSlotId = getPageSlotId,
    getPaginationSelectableSlotOrder = function(tbl2)
        local paginationSelectableSlotOrder = {}

        if tbl2.hasFirstLastButtons and not tbl2.isFirstDisabled then
            table.insert(paginationSelectableSlotOrder, NAV_SLOT_IDS[PaginationDirection.First])
        end

        if not tbl2.isBackDisabled then
            table.insert(paginationSelectableSlotOrder, NAV_SLOT_IDS[PaginationDirection.Backward])
        end

        if tbl2.pageSlots then
            for _, pageSlot in tbl2.pageSlots do
                if pageSlot ~= "ellipsis" and pageSlot ~= tbl2.currentPage then
                    table.insert(paginationSelectableSlotOrder, (getPageSlotId(pageSlot)))
                end
            end
        end

        if not tbl2.isForwardDisabled then
            table.insert(paginationSelectableSlotOrder, NAV_SLOT_IDS[PaginationDirection.Forward])
        end

        if tbl2.hasFirstLastButtons and not tbl2.isLastDisabled then
            table.insert(paginationSelectableSlotOrder, NAV_SLOT_IDS[PaginationDirection.Last])
        end

        return paginationSelectableSlotOrder
    end,
    getVisiblePageSlots = function(num1: number, num2: number): {number}
        if num2 <= 7 then
            local visiblePageSlots = {}
            for i = 1, num2 do
                table.insert(visiblePageSlots, i)
            end
            return visiblePageSlots
        end

        local visiblePageSlots = {}

        if not (num1 <= 4) then
            if num2 - 4 + 1 <= num1 then
                table.insert(visiblePageSlots, 1)
                table.insert(visiblePageSlots, "ellipsis")
                for i = num2 - 4, num2 do
                    table.insert(visiblePageSlots, i)
                end

                return visiblePageSlots
            end

            table.insert(visiblePageSlots, 1)
            table.insert(visiblePageSlots, "ellipsis")
            for i = num1 - 1, num1 + 1 do
                table.insert(visiblePageSlots, i)
            end
            table.insert(visiblePageSlots, "ellipsis")
            table.insert(visiblePageSlots, num2)

            return visiblePageSlots
        end

        for i = 1, 5 do -- Luacid: Re-rolled loop
            table.insert(visiblePageSlots, i)
        end
        table.insert(visiblePageSlots, "ellipsis")
        table.insert(visiblePageSlots, num2)
        return visiblePageSlots
    end
}
