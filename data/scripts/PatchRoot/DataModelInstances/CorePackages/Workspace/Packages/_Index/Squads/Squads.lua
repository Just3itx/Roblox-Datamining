-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _ModelTypes = require(script.Common.ModelTypes)

return {
    AppSquadEventReceiver = require(script.Components).AppSquadEventReceiver,
    Enums = require(script.Enums),
    Logger = require(script.Logger),
    QuickStartSquadInviteFriendsContainer = require(script.Components.SquadInviteFriends).QuickStartSquadInviteFriendsContainer,
    ScheduledSquadSheet = require(script.Components.ScheduledSquads).ScheduledSquadSheet,
    ScheduledSquadsListSheet = require(script.Components).ScheduledSquadsListSheet,
    ScheduledSquadsMoreInfoSheet = require(script.Components).ScheduledSquadsMoreInfoSheet,
    SquadComponentAccessWrapper = require(script.Components).SquadComponentAccessWrapper,
    SquadInviteFriends = require(script.Components.SquadInviteFriends).SquadInviteFriends,
    SquadInviteFriendsContainer = require(script.Components.SquadInviteFriends).SquadInviteFriendsContainer,
    SquadVoiceChangers = require(script.Components.SquadVoiceChangers).SquadVoiceChangers,
    SquadVoiceChangerOverlay = require(script.Components.SquadVoiceChangers).SquadVoiceChangerOverlay,
    SquadJoinButton = require(script.Components).SquadJoinButton,
    SquadLobby = require(script.Components).SquadLobby,
    SquadTopBanner = require(script.Components).SquadTopBanner,
    SquadVoiceAbuseReportScreen = require(script.Components).SquadVoiceAbuseReportScreen,
    Thunks = require(script.Thunks),
    Hooks = {
        useCanAccessParty = require(script.Hooks.useCanAccessParty),
        useIsExperienceInvitePending = require(script.Hooks.useIsExperienceInvitePending)
    },
    ["jest.config"] = script["jest.config"]
}
