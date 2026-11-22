-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayWithRewardState = script:FindFirstAncestor("PlayWithRewardState")

local SetPlayWithRewardState = require(PlayWithRewardState.SetPlayWithRewardState)
local _PlayWithRewardAdData = require(PlayWithRewardState.PlayWithRewardAdData)

local tbl1 = { flowId = "", universeId = "", isAdDataExpected = false, adData = nil }

return function(tbl2, arg1)
    local var1 = tbl2 or table.clone(tbl1)

    if arg1.type ~= SetPlayWithRewardState.name then
        return var1
    end

    return {
        flowId = arg1.flowId,
        universeId = arg1.universeId,
        isAdDataExpected = arg1.isAdDataExpected,
        adData = arg1.adData
    }
end
