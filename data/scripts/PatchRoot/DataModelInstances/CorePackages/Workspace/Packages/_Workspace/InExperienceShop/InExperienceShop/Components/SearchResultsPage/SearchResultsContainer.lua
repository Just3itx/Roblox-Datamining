-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local React = require(InExperienceShopParent.React)

local SearchResultsView = require(script.Parent.SearchResultsView)
local useSearchResultsViewModel = require(script.Parent.useSearchResultsViewModel)

local function SearchResultsContainer(arg1)
    local var1 = useSearchResultsViewModel(arg1)
    return React.createElement(SearchResultsView, var1)
end

return SearchResultsContainer
