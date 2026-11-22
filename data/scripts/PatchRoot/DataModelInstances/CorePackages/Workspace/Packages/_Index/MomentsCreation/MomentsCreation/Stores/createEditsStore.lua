-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local createSignal = require(MomentsCreationParent.Signals).createSignal

local function createEditsStore()
    local getMap, var2 = createSignal({})

    return {
        getMap = getMap,
        setCommitted = function(str1: string, arg1)
            local var3 = table.clone(getMap(false))
            var3[str1] = arg1
            var2(var3)
        end,
        clear = function()
            var2({})
        end
    }
end
return createEditsStore
