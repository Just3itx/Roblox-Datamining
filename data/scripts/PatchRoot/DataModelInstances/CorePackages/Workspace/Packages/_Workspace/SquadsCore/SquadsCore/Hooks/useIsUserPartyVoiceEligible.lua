-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local useCurrentSquadMember = require(script.Parent.useCurrentSquadMember)

local React = require(SquadsCoreParent.React)
local _RoduxSquads = require(SquadsCoreParent.RoduxSquads)

local GetFFlagEnablePartyVoiceOnlyForEligibleUsers = require(SquadsCore.Flags.GetFFlagEnablePartyVoiceOnlyForEligibleUsers)
local GetFStringPartyVoiceEligibilityAllowList = require(SquadsCore.Flags.GetFStringPartyVoiceEligibilityAllowList)

function getIsUserWhitelisted(num1: number)
    for value in GetFStringPartyVoiceEligibilityAllowList():gmatch("%d+") do
        if tonumber(value) == num1 then
            return true
        end
    end
    return false
end

function useIsUserPartyVoiceEligible(num1: number)
    local var1 = useCurrentSquadMember(num1)

    local var2 = React.useMemo(function()
        return var1 and var1.partyVoiceEligible == true
    end, { var1 })

    local var3 = React.useMemo(function()
        return getIsUserWhitelisted(num1)
    end, { num1 })

    return var2 or var3
end

return if GetFFlagEnablePartyVoiceOnlyForEligibleUsers() then useIsUserPartyVoiceEligible else function(_: number): boolean
    return true
end
