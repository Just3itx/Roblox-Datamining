-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local Cryo = require(MomentsParent.Cryo)

local createSignal = Signals.createSignal

local function createDeletedMomentsStore()
    local getDeletedIds, var2 = createSignal({})

    return {
        getDeletedIds = getDeletedIds,
        markDeleted = function(str1: string)
            local var3 = getDeletedIds(false)
            if not table.find(var3, str1) then
                var2((Cryo.List.join(var3, { str1 })))
            end
        end
    }
end

return createDeletedMomentsStore
