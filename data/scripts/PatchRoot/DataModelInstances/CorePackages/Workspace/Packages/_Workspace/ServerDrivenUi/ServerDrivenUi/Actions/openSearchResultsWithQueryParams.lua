-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SearchTypes = require(ServerDrivenUiParent.RobloxAppEnums).SearchTypes

local isSearchTypeInOmniSearch = require(ServerDrivenUiParent.DiscoveryUtils).isSearchTypeInOmniSearch

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

return {
    resolveSearchQuery = function(arg1)
        local actionParams = if arg1 then arg1.actionParams else nil

        if actionParams == nil then
            return nil
        end

        local searchQuery = actionParams.searchQuery
        return if typeof(searchQuery) == "string" and searchQuery ~= "" then searchQuery else nil
    end,
    resolveSearchType = function(arg1)
        local actionParams = if arg1 then arg1.actionParams else nil
        local searchType = if actionParams then actionParams.searchType else nil

        if searchType == nil or searchType == "" then
            return SearchTypes.TopResults
        end

        if typeof(searchType) == "string" and SearchTypes[searchType] ~= nil then
            if isSearchTypeInOmniSearch(searchType) then
                return searchType
            end

            return nil
        end

        return nil
    end,
    resolveIsAutocompleteSuggestion = function(arg1): boolean
        local actionParams = if arg1 then arg1.actionParams else nil
        return (if actionParams then actionParams.isAutocompleteSuggestion else nil) == true
    end
}
