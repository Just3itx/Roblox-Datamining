-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IsLocalUserSoothsayerStoreParent = script:FindFirstAncestor("IsLocalUserSoothsayerStore").Parent

local Signals = require(IsLocalUserSoothsayerStoreParent.Signals)
local SignalsUtils = require(IsLocalUserSoothsayerStoreParent.SignalsUtils)

return Signals.createComputed(function()
    local getIsLocalUserSoothsayer, var2 = SignalsUtils.createSessionScopedSignal(false)

    return {
        getIsLocalUserSoothsayer = getIsLocalUserSoothsayer,
        setIsLocalUserSoothsayer = function(bool1: boolean)
            var2(bool1)
        end,
        reset = function()
            var2(false)
        end
    }
end)
