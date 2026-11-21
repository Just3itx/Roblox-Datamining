-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local script2 = script
local FFlagUpdateInvitesToUsePaginatedFriends = require(script2.Flags.FFlagUpdateInvitesToUsePaginatedFriends)

return {
    ["jest.config"] = script["jest.config"],
    FriendsListContext = require(script.Context.FriendsListContext),
    FriendsMenuContextWrapper = require(script.Context.FriendsMenuContextWrapper),
    FriendsMenuFriendsList = require(script.Components.FriendsMenuFriendsList),
    FriendsMenuSearch = require(script.Components.FriendsMenuSearch),
    FriendsMenuShareGameInviteLink = require(script.Components.FriendsMenuShareGameInviteLink),
    InviteFriendContext = require(script.Context.InviteFriendContext),
    InviteCallbackContext = require(script.Context.InviteCallbackContext),
    FriendsListContextProvider = if FFlagUpdateInvitesToUsePaginatedFriends then require(script.Context.FriendsListContextProvider2) else require(script.Context.FriendsListContextProvider),
    InviteStatus = require(script.Constants).InviteStatus,
    FriendMenuType = require(script.Enums.FriendMenuType),
    SelectedUsersContext = require(script.Context.SelectedUsersContext),
    SelectedUsersScroller = require(script.Components.SelectedUsersScroller)
}
