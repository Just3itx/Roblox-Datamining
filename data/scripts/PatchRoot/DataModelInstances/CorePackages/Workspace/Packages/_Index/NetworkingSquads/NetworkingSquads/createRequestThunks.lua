-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _networkingSquadTypes = require(script.Parent.networkingSquadTypes)

local networkRequests = script.Parent.networkRequests
local createCreateOrJoinSquad = require(networkRequests.createCreateOrJoinSquad)
local createGetSquadActive = require(networkRequests.createGetSquadActive)

local createGetSquadFromSquadId = require(networkRequests.createGetSquadFromSquadId)
local createJoinSquad = require(networkRequests.createJoinSquad)
local createActOnPartyNudge = require(networkRequests.createActOnPartyNudge)
local createLeaveSquad = require(networkRequests.createLeaveSquad)
local createSquadInvite = require(networkRequests.createSquadInvite)

local createCreateExperienceInvite = require(networkRequests.createCreateExperienceInvite)

local createGetExperienceInvite = require(networkRequests.createGetExperienceInvite)

local createVoteForExperienceInvite = require(networkRequests.createVoteForExperienceInvite)

local createSendSquadVoiceAbuseReport = require(networkRequests.createSendSquadVoiceAbuseReport)
local createReinviteToSquad = require(networkRequests.createReinviteToSquad)

local createSetRegroupPromptShown = require(networkRequests.createSetRegroupPromptShown)

return function(arg1)
    return {
        CreateOrJoinSquad = createCreateOrJoinSquad(arg1),
        GetSquadActive = createGetSquadActive(arg1),
        GetSquadFromSquadId = createGetSquadFromSquadId(arg1),
        JoinSquad = createJoinSquad(arg1),
        ActOnPartyNudge = createActOnPartyNudge(arg1),
        LeaveSquad = createLeaveSquad(arg1),
        SquadInvite = createSquadInvite(arg1),
        CreateExperienceInvite = createCreateExperienceInvite(arg1),
        GetExperienceInvite = createGetExperienceInvite(arg1),
        VoteForExperienceInvite = createVoteForExperienceInvite(arg1),
        ReinviteToSquad = createReinviteToSquad(arg1),
        SendSquadVoiceAbuseReport = createSendSquadVoiceAbuseReport(arg1),
        SetRegroupPromptShown = createSetRegroupPromptShown(arg1)
    }
end
