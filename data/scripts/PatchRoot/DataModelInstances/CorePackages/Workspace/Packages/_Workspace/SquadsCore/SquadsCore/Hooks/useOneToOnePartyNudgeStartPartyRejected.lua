-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Players = game:GetService("Players")

local Constants = require(SquadsCore.Common.Constants)
local RealtimeDelivery = require(SquadsCoreParent.RealtimeDelivery)
local FFlagEnablePartyNudgeAfterJoin = require(SquadsCoreParent.SharedFlags).FFlagEnablePartyNudgeAfterJoin

local function useOneToOnePartyNudgeStartPartyRejected(callback)
    if not FFlagEnablePartyNudgeAfterJoin then
        return
    end

    RealtimeDelivery.useRealtimeNamespace(Constants.PARTY_NUDGE_RTN_NAMESPACE, function(arg1)
        if Players.LocalPlayer
            and arg1.nudgeType == Constants.ONE_TO_ONE_NUDGE_IN_EXPERIENCE_TYPE
            and arg1.inviteeId == Players.LocalPlayer.UserId
            and arg1.status == Constants.START_PARTY_REJECTED_STATUS
        then
            callback(arg1)
        end
    end, { callback })
end

return useOneToOnePartyNudgeStartPartyRejected
