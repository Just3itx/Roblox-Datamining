-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local SearchInput = Foundation.SearchInput
local View = Foundation.View

local GetSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore)
local _createSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore.createSearchQueryStore)

local function BuildSearchBar(tbl1)
    local var1 = useLocalization({ placeholder = LocalizationStrings.BUILD_SEARCH_PLACEHOLDER })

    local var2 = tbl1.store or GetSearchQueryStore()
    local text = var2.useDraftQuery()

    local onChanged = React.useCallback(function(str1: string)
        if str1 == "" then
            var2.clear()
            return
        end
        var2.setQuery(str1)
    end, { var2 })

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.LayoutOrder,
            tag = "size-full-0 auto-y",
            testId = "build-search-bar"
        },
        {
            Input = React.createElement(SearchInput, {
                text = text,
                placeholder = var1.placeholder,
                onChanged = onChanged,
                width = UDim.new(1, 0),
                testId = "build-search-bar-input"
            })
        }
    )
end

return BuildSearchBar
