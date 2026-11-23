-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceModelParent = script:FindFirstAncestor("AvatarExperienceModel").Parent

local _Signals = require(AvatarExperienceModelParent.Signals)
local createSessionScopedSignal = require(AvatarExperienceModelParent.SignalsUtils).createSessionScopedSignal

local function createEmptyLastSavedSort() -- Luacid: Inlined by compiler; 1 call site recovered
    return {}
end

local function createLayeredClothingLastSavedSortStore()
    local getLastSavedSort, var2 = createSessionScopedSignal(createEmptyLastSavedSort)

    return {
        getLastSavedSort = getLastSavedSort,
        setLastSavedSort = function(tbl1)
            var2(tbl1)
        end,
        reset = function()
            local emptyLastSavedSort = createEmptyLastSavedSort()
            var2(emptyLastSavedSort)
        end
    }
end
return createLayeredClothingLastSavedSortStore
