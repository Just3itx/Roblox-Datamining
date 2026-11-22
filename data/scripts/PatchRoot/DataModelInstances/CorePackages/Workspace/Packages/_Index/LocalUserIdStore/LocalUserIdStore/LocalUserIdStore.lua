-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalUserIdStoreParent = script:FindFirstAncestor("LocalUserIdStore").Parent
local getCurrentUserId, setCurrentUserId = require(LocalUserIdStoreParent.Signals).createSignal("")

return {
    getCurrentUserId = getCurrentUserId,
    setCurrentUserId = setCurrentUserId,
    reset = function()
        setCurrentUserId("")
    end
}
