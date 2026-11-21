-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local ArgCheck = require(GameFiltersParent.ArgCheck)
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag

local module = {}

function module.new()
    return {}
end

function module.mockFromExploreApi(filterId: string, selectedOptionDisplayName: string?)
    local fromExploreJsonData = module.fromExploreJsonData
    local tbl1 = {
        filterId = filterId,
        filterType = "",
        filterDisplayName = "",
        filterOptions = {{
            optionId = filterId .. "_option",
            optionDisplayName = "",
            optionContextTag = if FFlagLuaAppChartsFilterOptionTextTag then filterId .. "_context" else nil
        }},
        defaultOptionId = filterId .. "_option",
        selectedOptionId = filterId .. "_option",
        inactiveOptionIds = { filterId .. "_option" }
    }
    local exploreJsonData = fromExploreJsonData(tbl1)

    exploreJsonData.selectedOptionDisplayName = selectedOptionDisplayName or ""

    return exploreJsonData
end

function module.fromExploreJsonData(arg1)
    local module2 = module.new()

    module2.filterId = arg1.filterId
    module2.filterType = arg1.filterType
    module2.filterDisplayName = arg1.filterDisplayName
    module2.defaultOptionId = arg1.defaultOptionId
    module2.selectedOptionId = arg1.selectedOptionId
    if arg1.inactiveOptionIds then
        local inactiveOptionIds = ({})
        for _, inactiveOptionId in arg1.inactiveOptionIds do
            inactiveOptionIds[inactiveOptionId] = true
        end
        module2.inactiveOptionIds = inactiveOptionIds
    end

    local filterOptions = {}

    for _, filterOption in ipairs(arg1.filterOptions) do
        table.insert(filterOptions, {
            optionId = filterOption.optionId,
            optionDisplayName = filterOption.optionDisplayName,
            optionContextTag = if FFlagLuaAppChartsFilterOptionTextTag then filterOption.optionContextTag else nil
        })
        if filterOption.optionId == arg1.selectedOptionId then
            ArgCheck.assert(module2.selectedOptionDisplayName == nil, "Multiple selected options found")

            module2.selectedOptionDisplayName = filterOption.optionDisplayName
        end
    end

    module2.filterOptions = filterOptions

    return module2
end

return module
