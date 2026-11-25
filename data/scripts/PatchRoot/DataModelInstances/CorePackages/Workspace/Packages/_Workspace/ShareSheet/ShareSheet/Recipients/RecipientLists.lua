-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ShareSheet = script:FindFirstAncestor("ShareSheet")

local _Types = require(ShareSheet.Types)
local RecipientSource = require(script.Parent.RecipientSource)
local createChatInboxRecipientList = require(ShareSheet.Recipients.Sources.createChatInboxRecipientList)
local createOneToOneFriendsRecipientList = require(ShareSheet.Recipients.Sources.createOneToOneFriendsRecipientList)

return {
    [RecipientSource.RecipientSource.ChatInbox] = createChatInboxRecipientList,
    [RecipientSource.RecipientSource.OneToOneFriends] = createOneToOneFriendsRecipientList
}
