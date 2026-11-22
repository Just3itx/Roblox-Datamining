-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsParent = script:FindFirstAncestor("Squads").Parent

local createLazyComponent = require(SquadsParent.RoactUtils).Components.createLazyComponent
return {
    AppSquadEventReceiver = createLazyComponent(function()
        return (require(script.AppSquadEventReceiver))
    end),
    ScheduledSquadsListSheet = createLazyComponent(function()
        return (require(script.ScheduledSquads.ScheduledSquadsListSheet))
    end),
    ScheduledSquadsMoreInfoSheet = createLazyComponent(function()
        return (require(script.ScheduledSquads.ScheduledSquadsMoreInfoSheet))
    end),
    SquadComponentAccessWrapper = createLazyComponent(function()
        return (require(script.SquadComponentAccessWrapper))
    end),
    SquadInviteFriends = createLazyComponent(function()
        return (require(script.SquadInviteFriends))
    end),
    SquadJoinButton = createLazyComponent(function()
        return (require(script.SquadJoinButton))
    end),
    SquadLobby = createLazyComponent(function()
        return (require(script.SquadLobby))
    end),
    SquadTopBanner = createLazyComponent(function()
        return (require(script.SquadTopBanner))
    end),
    SquadVoiceAbuseReportScreen = createLazyComponent(function()
        return (require(script.SquadVoiceAbuseReportScreen))
    end)
}
