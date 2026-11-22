-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local dependencies = require(Squads.dependencies)

local React = dependencies.React
local useCurrentSquadSelector = dependencies.Hooks.useCurrentSquadSelector

local GetFFlagEnablePartyVoiceOnlyForEligibleUsers = require(SquadsParent.SquadsCore.Flags).GetFFlagEnablePartyVoiceOnlyForEligibleUsers

local GetFStringPartyVoiceEligibilityAllowList = require(SquadsParent.SquadsCore.Flags).GetFStringPartyVoiceEligibilityAllowList

function getIsUserWhitelisted(userId: number)
    for value in GetFStringPartyVoiceEligibilityAllowList():gmatch("%d+") do
        if tonumber(value) == userId then
            return true
        end
    end
    return false
end

function useIsAnyOtherUserPartyVoiceEligible()
    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId or 0
    local var1 = useCurrentSquadSelector()
    local var2 = React.useMemo(function()
        return if var1 then var1.members else {}
    end, { var1 })

    return React.useMemo(function()
        if userId ~= 0 then
            for _, value in ipairs(var2) do
                if value.userId ~= userId and (value.partyVoiceEligible or getIsUserWhitelisted(value.userId)) then
                    return true
                end
            end
        end

        return false
    end, { userId, var2 })
end

return if GetFFlagEnablePartyVoiceOnlyForEligibleUsers() then useIsAnyOtherUserPartyVoiceEligible else function(): boolean
    return true
end
