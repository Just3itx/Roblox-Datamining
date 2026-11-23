-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local getUserDisplayName = require(AppChat.SocialLibraries).User.getUserDisplayName

local getThumbnailsForUserIds = require(script.Parent.getThumbnailsForUserIds)
local RoduxPresence = require(AppChat.Http.RoduxPresence)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)

local userPresenceUtils = require(script.Parent.userPresenceUtils)

return function(arg1, arg2, tbl1)
    local userDisplayPresence

    if FFlagAppChatPresenceStoreMigration then
        userDisplayPresence = nil
    else
        local userPresenceByUserId = RoduxPresence.Selectors.getUserPresenceByUserId(arg1, arg2.id)
        userDisplayPresence = userPresenceUtils.getUserDisplayPresence(userPresenceByUserId, arg2.id == arg1.LocalUserId)
    end

    return Cryo.Dictionary.join(arg2, {
        isLocalUser = arg1.LocalUserId == arg2.id,
        displayName = if tbl1 then tbl1.names.combinedName else getUserDisplayName(arg1, arg2),
        presenceText = if FFlagAppChatPresenceStoreMigration then nil else userDisplayPresence.text,
        presenceImage = if FFlagAppChatPresenceStoreMigration then nil else userDisplayPresence.image,
        thumbnail = getThumbnailsForUserIds({ arg2.id })[1]
    })
end
