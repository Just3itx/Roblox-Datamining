-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiSharedUtilities = require(ServerDrivenUiParent.SduiSharedUtilities)

local function isAutocompleteSelectionFresh(str1: string?, prefix: string, num1: number, searchQuery: string): boolean
    local var1 = if str1 then SduiSharedUtilities.getSduiApiStore().getInputData(str1, "suggestions") else nil
    local suggestion = if var1 and var1.suggestions then var1.suggestions[num1] else nil
    return not (var1 == nil or var1.prefix ~= prefix or suggestion == nil) and suggestion.search_query == searchQuery
end

return isAutocompleteSelectionFresh
