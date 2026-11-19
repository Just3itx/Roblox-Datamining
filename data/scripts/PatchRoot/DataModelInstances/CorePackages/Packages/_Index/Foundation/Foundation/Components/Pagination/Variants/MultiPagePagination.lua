-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:28Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useChipVariants = require(Foundation.Components.Chip.useChipVariants)

local ChipSize = require(Foundation.Enums.ChipSize)

local ChipVariant = require(Foundation.Enums.ChipVariant)
local PaginationSize = require(Foundation.Enums.PaginationSize)

local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local Ellipsis = require(script.Parent.Parent.Nav.Ellipsis)
local PageNumberSlot = require(script.Parent.Parent.Nav.PageNumberSlot)
local paginationSlotsUtils = require(script.Parent.Parent.paginationSlotsUtils)
local paginationUtils = require(script.Parent.Parent.paginationUtils)
local usePaginationAnimatedHighlight = require(script.Parent.Parent.usePaginationAnimatedHighlight)
local usePaginationNav = require(script.Parent.Parent.usePaginationNav)

local tbl1 = {
    size = PaginationSize.Medium,
    hasFirstLastButtons = false,
    testId = "--foundation-pagination"
}

return React.memo(React.forwardRef(function(arg1, arg2) -- name: MultiPagePagination
    local var1 = withDefaults(arg1, tbl1)
    local size = var1.size
    local var2 = useTokens()

    local bool1 = var1.page <= 1
    local bool2 = var1.page >= var1.count

    local pageSlots = React.useMemo(function()
        return paginationSlotsUtils.getVisiblePageSlots(var1.page, var1.count)
    end, { var1.page, var1.count })

    local var4, var5 = React.useState(nil)

    local var6 = usePaginationNav(var1, {
        hasFirstLastButtons = var1.hasFirstLastButtons,
        currentPage = var1.page,
        pageSlots = pageSlots,
        disabledState = {
            isBackDisabled = bool1,
            isFirstDisabled = bool1,
            isForwardDisabled = bool2,
            isLastDisabled = bool2
        }
    }, var5)

    React.useImperativeHandle(arg2, function()
        return var4
    end, { var4 })

    local ref = React.useRef(nil)

    local var8 = React.useMemo(function()
        local result = ({})
        for _, value in pageSlots do
            if value ~= "ellipsis" then
                local pageSlotId = paginationSlotsUtils.getPageSlotId(value)
                result[pageSlotId] = var6.selection.getSlotBindings(pageSlotId).ref
            end
        end
        return result
    end, { pageSlots, var6.selection })

    local pageSlotId = paginationSlotsUtils.getPageSlotId(var1.page)
    local var9 = usePaginationAnimatedHighlight(pageSlotId, ref, var8, size, pageSlots)
    local var10 = if size == PaginationSize.Small then ChipSize.Small else ChipSize.Medium
    local var11 = useChipVariants(var2, var10, ChipVariant.Utility, true, false, false)

    local var12 = React.useMemo(function()
        local result = ({})

        for layoutOrder, page in pageSlots do
            if page == "ellipsis" then
                local createElement = React.createElement
                local var12 = Ellipsis
                local tbl2 = {
                    slotSize = size,
                    LayoutOrder = layoutOrder,
                    testId = `{var1.testId}--ellipsis-{layoutOrder}`
                }
                result[if layoutOrder == 2 then "ellipsis-leading" else "ellipsis-trailing"] = createElement(var12, tbl2)
            else
                local pageSlotId2 = paginationSlotsUtils.getPageSlotId(page)
                local slotBindings = var6.selection.getSlotBindings(pageSlotId2)
                local str1 = `Page-{page}`
                result[str1] = React.createElement(PageNumberSlot, {
                    slotSize = size,
                    isChecked = page == var1.page,
                    LayoutOrder = layoutOrder,
                    onPageActivated = var1.onActivated,
                    page = page,
                    testId = `{var1.testId}--page-{page}`,
                    ref = var6.selection.getSlotRef(pageSlotId2),
                    Selectable = slotBindings.Selectable,
                    NextSelectionLeft = slotBindings.NextSelectionLeft,
                    NextSelectionRight = slotBindings.NextSelectionRight,
                    NextSelectionUp = slotBindings.NextSelectionUp,
                    NextSelectionDown = slotBindings.NextSelectionDown
                })
            end
        end

        return result
    end, {
        pageSlots,
        var1.page,
        size,
        var1.testId,
        var1.onActivated,
        var6.selection
    })

    local onAbsoluteSizeChanged = React.useCallback(function()
        local var13 = var8[pageSlotId]
        if var13 and var13.current and ref.current then
            var9.updateHighlight(var13, true)
        end
    end, { pageSlotId, var8, var9.updateHighlight })

    local createLayout = var6.createLayout
    local createElement = React.createElement
    local var14 = View
    local tbl2 = {
        LayoutOrder = 2,
        tag = "auto-xy",
        testId = `{var1.testId}--pages`,
        ref = ref
    }
    local tbl3 = { ActivePageHighlight = 0, PagesRow = 0 }
    local element

    if paginationUtils.needsWidePageSlot(var1.page) then
        element = nil
    else
        element = React.createElement(View, {
            Active = false,
            backgroundStyle = var11.chip.backgroundStyle,
            tag = "radius-circle clip",
            Size = React.joinBindings({ var9.highlightWidth, var9.activeItemHeight }):map(function(tbl4: {number}): UDim2
                return UDim2.fromOffset(tbl4[1], tbl4[2])
            end),
            Position = var9.highlightPosition:map(function(xOffset: number): UDim2
                return UDim2.fromOffset(xOffset, 0)
            end),
            Visible = var9.isVisible,
            ZIndex = 1,
            selection = { Selectable = false },
            testId = `{var1.testId}--active-page-highlight`
        })
    end

    tbl3.ActivePageHighlight = element

    tbl3.PagesRow = React.createElement(
        View,
        {
            tag = "row gap-xsmall auto-xy",
            LayoutOrder = 1,
            ZIndex = 2,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged
        },
        var12
    )
    return createLayout(createElement(var14, tbl2, tbl3), nil)
end))
