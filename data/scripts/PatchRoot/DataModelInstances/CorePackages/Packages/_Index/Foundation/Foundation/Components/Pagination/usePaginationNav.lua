-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)

local PaginationDirection = require(Foundation.Enums.PaginationDirection)

local _PaginationSize = require(Foundation.Enums.PaginationSize)

local withCommonProps = require(Foundation.Utility.withCommonProps)

local NavPaginationLayout = require(script.Parent.Nav.NavPaginationLayout)

local paginationSlotsUtils = require(script.Parent.paginationSlotsUtils)

local usePaginationSelectionChain = require(script.Parent.usePaginationSelectionChain)

local function useNavCallbacks(arg1, tbl1)
    return {
        onDirectionActivated = React.useCallback(function(arg2)
            if arg2 == PaginationDirection.First then
                arg1.onActivated(1)
                return
            end

            if arg2 == PaginationDirection.Last then
                if arg1.count ~= nil then
                    arg1.onActivated(arg1.count)
                end
            else
                if arg2 == PaginationDirection.Backward then
                    arg1.onActivated(arg1.page - 1)
                    return
                end
                arg1.onActivated(arg1.page + 1)
            end
        end, { arg1.count, arg1.onActivated, arg1.page }),
        isFirstDisabled = tbl1.isFirstDisabled or tbl1.isBackDisabled
    }
end

local function mergeNavPaginationLayoutProps(arg1, tbl1: {hasFirstLastButtons: any, isBackDisabled: any, isFirstDisabled: any, isForwardDisabled: any, isLastDisabled: any, onDirectionActivated: any, pageContent: any, selection: any, size: any, testId: any}, ref) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = withCommonProps(arg1, tbl1)
    var1.ref = ref
    return var1
end

local function usePaginationNav(arg1, tbl1, func1: ((...any) -> (...any))?)
    local disabledState = tbl1.disabledState

    local var1 = React.useMemo(function()
        return paginationSlotsUtils.getPaginationSelectableSlotOrder({
            hasFirstLastButtons = tbl1.hasFirstLastButtons,
            isFirstDisabled = disabledState.isFirstDisabled,
            isBackDisabled = disabledState.isBackDisabled,
            isForwardDisabled = disabledState.isForwardDisabled,
            isLastDisabled = disabledState.isLastDisabled,
            pageSlots = tbl1.pageSlots,
            currentPage = tbl1.currentPage
        })
    end, {
        tbl1.hasFirstLastButtons,
        tbl1.currentPage,
        tbl1.pageSlots,
        disabledState.isBackDisabled,
        disabledState.isFirstDisabled,
        disabledState.isForwardDisabled,
        disabledState.isLastDisabled
    })

    local selection = usePaginationSelectionChain(
        var1,
        {
            NextSelectionUp = arg1.NextSelectionUp,
            NextSelectionDown = arg1.NextSelectionDown
        },
        func1
    )

    local tbl2 = useNavCallbacks(
        arg1,
        {
            isBackDisabled = disabledState.isBackDisabled,
            isFirstDisabled = disabledState.isFirstDisabled
        }
    )
    return {
        selection = selection,
        createLayout = React.useCallback(function(pageContent, ref)
            return React.createElement(
                NavPaginationLayout,
                (mergeNavPaginationLayoutProps(arg1, {
                    pageContent = pageContent,
                    size = arg1.size,
                    isBackDisabled = disabledState.isBackDisabled,
                    isFirstDisabled = tbl2.isFirstDisabled,
                    isForwardDisabled = disabledState.isForwardDisabled,
                    isLastDisabled = disabledState.isLastDisabled,
                    onDirectionActivated = tbl2.onDirectionActivated,
                    selection = selection,
                    hasFirstLastButtons = tbl1.hasFirstLastButtons,
                    testId = arg1.testId
                }, ref))
            )
        end, {
            tbl1.hasFirstLastButtons,
            disabledState.isBackDisabled,
            disabledState.isForwardDisabled,
            disabledState.isLastDisabled,
            tbl2.isFirstDisabled,
            tbl2.onDirectionActivated,
            arg1,
            selection
        })
    }
end
return usePaginationNav
