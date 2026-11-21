-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local var1 = if require(scriptParentParent.Flags.FFlagUpdateInvitesToUsePaginatedFriends) then require(scriptParent.FriendsListContextProvider2) else require(scriptParent.FriendsListContextProvider)
local InviteCallbackProvider = require(scriptParent.InviteCallbackProvider)
local SelectedUsersContextProvider = require(scriptParent.SelectedUsersContextProvider)

local Cryo = require(scriptParentParentParent.Cryo)
local React = require(scriptParentParentParent.React)

return function(tbl1)
    local excludedFriendsSet = tbl1.excludedFriendsSet
    if tbl1.preselectedUsersUnremovable and tbl1.preselectedUsers then
        excludedFriendsSet = Cryo.Dictionary.union(excludedFriendsSet or {}, Cryo.List.toSet(tbl1.preselectedUsers))
    end

    return React.createElement(
        var1,
        {
            excludedFriendsSet = excludedFriendsSet,
            isLoadingCustomParams = tbl1.isLoadingCustomParams
        },
        React.createElement(
            InviteCallbackProvider,
            {
                inviteSingleFriend = tbl1.inviteSingleFriend,
                inviteMultiFriends = tbl1.inviteMultiFriends
            },
            React.createElement(SelectedUsersContextProvider, {
                selectionLimit = tbl1.selectionLimit,
                preselectedUsers = tbl1.preselectedUsers,
                preselectedUsersUnremovable = tbl1.preselectedUsersUnremovable,
                onRemoveCallback = tbl1.onRemoveCallback
            }, tbl1.children)
        )
    )
end
