-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local NotificationTypeEnum = require(scriptParent.type).NotificationTypeEnum

return {
    ChatMessageGroup = { NotificationTypeEnum.ChatNewMessage, NotificationTypeEnum.SquadInvitation },
    ChatLandingNotificationsGroup = {
        NotificationTypeEnum.ChatNewMessage,
        NotificationTypeEnum.SquadInvitation,
        NotificationTypeEnum.SquadStartPartyPrompt,
        NotificationTypeEnum.SquadNudgeInvite
    },
    SquadNudgeInviteGroup = { NotificationTypeEnum.SquadNudgeInvite },
    SquadStartPartyPromptGroup = { NotificationTypeEnum.SquadStartPartyPrompt }
}
