-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary

local Actions = ExpChat.Actions
local AutocompleteDropdownActivated = require(Actions.AutocompleteDropdownActivated)
local AutocompleteDropdownResultsChanged = require(Actions.AutocompleteDropdownResultsChanged)
local AutocompleteDropdownSelectionChanged = require(Actions.AutocompleteDropdownSelectionChanged)
local AutocompleteDropdownTypeChanged = require(Actions.AutocompleteDropdownTypeChanged)
local AutocompleteDropdownDeactivated = require(Actions.AutocompleteDropdownDeactivated)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AutocompleteDropdownActivated.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { activated = arg1.activated })
end

tbl1[AutocompleteDropdownResultsChanged.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { results = arg1.results, query = arg1.query or "", selectedIndex = 1 })
end

tbl1[AutocompleteDropdownSelectionChanged.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { selectedIndex = arg1.selectedIndex })
end

tbl1[AutocompleteDropdownTypeChanged.name] = function(tbl2, arg1)
    if arg1.autocompleteType == tbl2.autocompleteType then
        return tbl2
    end

    return Dictionary.join(
        tbl2,
        {
            autocompleteType = arg1.autocompleteType,
            activated = false,
            results = {},
            query = "",
            selectedIndex = 1
        }
    )
end

tbl1[AutocompleteDropdownDeactivated.name] = function(tbl2, _)
    return Dictionary.join(tbl2, { autocompleteType = "none", activated = false, results = {}, query = "", selectedIndex = 1 })
end

return createReducer({ activated = false, results = {}, query = "", selectedIndex = 1, autocompleteType = "none" }, tbl1)
