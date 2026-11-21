-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local dependencyArray = require(GameJoinCardParent.RoactUtils).Hooks.dependencyArray

local FFlagGameJoinCardAnalyticsCardId = require(GameJoinCardParent.SharedFlags).FFlagGameJoinCardAnalyticsCardId

local GameJoinCardButtonAction = require(script.Parent.AnalyticsConstants).GameJoinCardButtonAction
local useGameJoinCardAnalytics = require(script.Parent.useGameJoinCardAnalytics)

return {
    useAgeCheckCompletionLogger = function(universeId: string)
        if universeId == "" then
            universeId = nil
        end

        return React.useCallback(function(outcome)
            useGameJoinCardAnalytics.logJoinCardAgeCheckVerificationOutcome({ universeId = universeId, outcome = outcome })
        end, { universeId })
    end,
    useAgeCheckPressLogger = function(tbl1)
        local userId = tbl1.userId
        local absolutePosition = tbl1.absolutePosition
        local joinGameCardId = tbl1.joinGameCardId
        local joinAgeCheckUpsellFlow = tbl1.joinAgeCheckUpsellFlow
        local universeId = if tbl1.universeId == "" then nil else tbl1.universeId

        return React.useCallback(function()
            useGameJoinCardAnalytics.logGameJoinCardButtonEvent(GameJoinCardButtonAction.AgeCheckUnlock, {
                friendId = userId,
                universeId = universeId,
                absolutePosition = absolutePosition,
                joinGameCardId = if FFlagGameJoinCardAnalyticsCardId then joinGameCardId else nil
            })
            joinAgeCheckUpsellFlow()
        end, if FFlagGameJoinCardAnalyticsCardId then dependencyArray(userId, universeId, absolutePosition, joinGameCardId, joinAgeCheckUpsellFlow) else dependencyArray(userId, universeId, absolutePosition, joinAgeCheckUpsellFlow))
    end
}
