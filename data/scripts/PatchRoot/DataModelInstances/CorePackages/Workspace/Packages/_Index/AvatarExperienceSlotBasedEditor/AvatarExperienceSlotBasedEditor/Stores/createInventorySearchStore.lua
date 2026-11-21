-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local Signals = require(AvatarExperienceSlotBasedEditorParent.Signals)

local function createInventorySearchStore()
    local getQuery, var2 = Signals.createSignal("")
    return {
        getQuery = getQuery,
        getIsSearchActive = Signals.createComputed(function(arg1): boolean
            return getQuery(arg1) ~= ""
        end),
        setQuery = function(str1: string)
            var2(str1)
        end,
        clearQuery = function()
            var2("")
        end
    }
end
return createInventorySearchStore
