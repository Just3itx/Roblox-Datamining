-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:26Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Chip = require(Foundation.Components.Chip)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)

local ChipSize = require(Foundation.Enums.ChipSize)
local ChipVariant = require(Foundation.Enums.ChipVariant)
local PaginationSize = require(Foundation.Enums.PaginationSize)

local PaginationVariant = require(Foundation.Enums.PaginationVariant)

local withDefaults = require(Foundation.Utility.withDefaults)

local _MultiPagePagination = require(script.Parent.MultiPagePagination)
local paginationUtils = require(script.Parent.Parent.paginationUtils)
local usePaginationNav = require(script.Parent.Parent.usePaginationNav)

local tbl1 = {
    size = PaginationSize.Medium,
    testId = "--foundation-pagination"
}

return React.memo(React.forwardRef(function(arg1, arg2) -- name: DirectionalPagination
    local var1 = withDefaults(arg1, tbl1)
    local size = var1.size

    local count = var1.count
    local hasFirstLastButtons = not (count == nil) and var1.hasFirstLastButtons == true
    local bool2 = var1.variant == PaginationVariant.SinglePage
    local bool3 = if var1.hasPreviousPage ~= nil then var1.hasPreviousPage ~= true else var1.page <= 1
    local bool4 = if count ~= nil then count <= var1.page else var1.hasNextPage == nil or var1.hasNextPage ~= true
    local var2, var3 = React.useState(nil)

    local var4 = usePaginationNav(var1, {
        hasFirstLastButtons = hasFirstLastButtons,
        currentPage = var1.page,
        disabledState = {
            isBackDisabled = bool3,
            isFirstDisabled = bool3,
            isForwardDisabled = bool4,
            isLastDisabled = bool4
        }
    }, var3)

    React.useImperativeHandle(arg2, function()
        return var2
    end, { var2 })

    local var5 = React.useMemo(function()
        if not bool2 then
            return nil
        end

        local text = tostring(var1.page)

        if not paginationUtils.needsWidePageSlot(var1.page) then
            return React.createElement(
                View,
                {
                    LayoutOrder = 2,
                    tag = paginationUtils.getCircularSlotTag(size),
                    testId = `{var1.testId}--page-label`
                },
                {
                    Text = React.createElement(Text, { Text = text, tag = paginationUtils.getPageLabelTag(size), LayoutOrder = 1 })
                }
            )
        end

        return React.createElement(Chip, {
            LayoutOrder = 2,
            isChecked = false,
            isDisabled = true,
            onActivated = function() end,
            size = if size == PaginationSize.Small then ChipSize.Small else ChipSize.Medium,
            testId = `{var1.testId}--page-label`,
            text = text,
            variant = ChipVariant.Utility
        })
    end, {
        bool2,
        var1.page,
        size,
        var1.testId
    })
    return var4.createLayout(var5)
end))
