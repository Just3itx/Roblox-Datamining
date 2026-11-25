-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParent = script.Parent.Parent.Parent
local Signals = require(scriptParentParentParent.Signals)
local var1 = require(scriptParentParentParent.LeaderboardStore).createLeaderboardStore()

local var2, var3 = Signals.createSignal(nil)
local getLeaderboardStoreInstance = var2
local var5 = var3

return {
    createLeaderboardStoreInstance = function()
        var5(var1())
    end,
    getLeaderboardStoreInstance = getLeaderboardStoreInstance,
    cleanUpInstance = function()
        local var6 = getLeaderboardStoreInstance(false)
        if var6 ~= nil then
            var6.cleanUp()
            var5(nil)
        end
    end
}
