-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local Signals = require(ServerDrivenUiParent.Signals)

local var1 = nil

return {
    getInGameFriendsByGame = function(arg1)
        if var1 == nil then
            var1 = Signals.createSignal({})
        end
        return var1(arg1)
    end,
    setInGameFriendsByGameSignal = function(arg1)
        var1 = arg1
    end
}
