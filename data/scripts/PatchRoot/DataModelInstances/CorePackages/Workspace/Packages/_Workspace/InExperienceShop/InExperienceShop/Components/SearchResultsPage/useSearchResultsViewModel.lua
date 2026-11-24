-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)

local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local FFlagShopUseFuzzySearch = require(InExperienceShop.Flags.FFlagShopUseFuzzySearch)

local _SearchResultsView = require(script.Parent.SearchResultsView)
local searchMatchers = require(script.Parent.searchMatchers)

local tbl1 = {}

local function compositeKey(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.id .. "|" .. tostring(arg1.itemType)
end

local function collectUniqueItems(sections)
    local tbl2 = ({})
    local result = {}
    for _, section in sections do
        for _, item in section.items do
            local var1 = compositeKey(item)

            if not tbl2[var1] then
                tbl2[var1] = true
                table.insert(result, item)
            end
        end
    end
    return result
end

local function computeState(committedQuery: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if committedQuery == "" then "hint" elseif num1 == 0 then "empty" else "results"
end

local function useSearchResultsViewModel(tbl2)
    local committedQuery = tbl2.committedQuery
    local sections = tbl2.sections

    local var1 = React.useMemo(function()
        if committedQuery == "" then
            return {}
        end
        local tbl3 = collectUniqueItems(sections)

        return (if FFlagShopUseFuzzySearch then searchMatchers.fuzzyMatch else searchMatchers.substringMatch)(
            tbl3,
            committedQuery,
            Constants.MAX_SEARCH_RESULTS
        )
    end, { sections, committedQuery })

    local num1 = math.min(tbl2.itemsPerRow, Constants.ITEMS_PER_SECTION)
    local itemsPerRow = tbl2.itemsPerRow

    local rows = React.useMemo(function()
        if #var1 == 0 then
            return tbl1
        end
        local result = {}
        for i = 1, #var1, num1 do
            local tbl3 = {}
            local move = table.move
            local var2 = var1
            local num2 = i + num1 - 1
            local num3 = #var1
            move(var2, i, math.min(num2, num3), 1, tbl3)
            table.insert(result, tbl3)
        end
        return result
    end, { var1, num1 })

    local onItemActivated = tbl2.onItemActivated

    local state = computeState(committedQuery, #rows)

    return {
        rows = rows,
        columnCount = itemsPerRow,
        onItemActivated = onItemActivated,
        LayoutOrder = tbl2.LayoutOrder,
        state = state
    }
end

return useSearchResultsViewModel
