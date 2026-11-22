-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayWithRewardState = script:FindFirstAncestor("PlayWithRewardState")
local PlayWithRewardStateParent = PlayWithRewardState.Parent
local makeActionCreator = require(PlayWithRewardStateParent.Rodux).makeActionCreator

local _PlayWithRewardAdData = require(PlayWithRewardState.PlayWithRewardAdData)

return makeActionCreator(script.Name, function(flowId: string, universeId: string, isAdDataExpected: boolean, adData)
    return {
        flowId = flowId,
        universeId = universeId,
        isAdDataExpected = isAdDataExpected,
        adData = adData
    }
end)
