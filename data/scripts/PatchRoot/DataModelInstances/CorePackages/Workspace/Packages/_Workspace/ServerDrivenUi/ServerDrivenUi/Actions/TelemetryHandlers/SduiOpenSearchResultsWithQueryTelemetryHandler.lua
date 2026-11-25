-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local openSearchResultsWithQueryDeeplink = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.openSearchResultsWithQueryDeeplink

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local openSearchResultsWithQueryParams = require(ServerDrivenUi.Actions.openSearchResultsWithQueryParams)
local FFlagLuaAppSduiSearchAutocomplete = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiSearchAutocomplete

return function(arg1, _, arg2)
    local kwd = openSearchResultsWithQueryParams.resolveSearchQuery(arg1)
    local searchType = openSearchResultsWithQueryParams.resolveSearchType(arg1)
    if kwd ~= nil
        and searchType ~= nil
        and not (FFlagLuaAppSduiSearchAutocomplete and openSearchResultsWithQueryParams.resolveIsAutocompleteSuggestion(arg1))
    then
        openSearchResultsWithQueryDeeplink(arg2.appPage, { kwd = kwd, searchType = searchType })
    end
end
