-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _gameInviteModalType = require(script.gameInviteModalType)

return {
    renderCoreScriptGameInviteModalContainer = require(script.renderCoreScriptGameInviteModalContainer),
    GetCustomizedInvitePromptTrigger = require(script.utils.getCustomizedInvitePromptTrigger),
    GameInviteModalManager = require(script.GameInviteModalManager),
    GameInviteModal = require(script.Components.GameInviteModal),
    GameInviteConstants = require(script.GameInviteConstants),
    GameInviteAnalytics = require(script.analytics.GameInviteAnalytics),
    GameInviteEvents = require(script.analytics.GameInviteEvents),
    GameInviteAnalyticsManager = require(script.analytics.GameInviteAnalyticsManager),
    GameInvitesStatusReducer = require(script.State.Reducers.Invites),
    GetCanSendAndCanCustomizeInvites = require(script.Requests.GetCanSendAndCanCustomizeInvites),
    PostSendExperienceInvite = require(script.Requests.PostSendExperienceInvite),
    ["jest.config"] = script["jest.config"]
}
