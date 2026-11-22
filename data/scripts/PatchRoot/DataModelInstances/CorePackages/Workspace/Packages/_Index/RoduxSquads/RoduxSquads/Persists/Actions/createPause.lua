-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquadsParent = script:FindFirstAncestor("RoduxSquads").Parent
local Rodux = require(RoduxSquadsParent.Rodux)

return function(arg1)
    local storage = arg1.storage
    assert(storage ~= nil, "Persist storage is required")

    local memStorageKey = storage.memStorageKey or ""
    return Rodux.makeActionCreator(memStorageKey .. "Pause", function()
        return {}
    end)
end
