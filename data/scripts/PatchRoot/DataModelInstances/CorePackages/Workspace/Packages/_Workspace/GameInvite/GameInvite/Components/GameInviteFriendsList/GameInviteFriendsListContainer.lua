-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent
local React = require(GameInviteParent.React)

local GameInviteFriendsListView = require(script.Parent.GameInviteFriendsListView)
local useGameInviteFriendsListViewModel = require(script.Parent.useGameInviteFriendsListViewModel)

local function GameInviteFriendsListContainer(arg1)
    local var1 = useGameInviteFriendsListViewModel(arg1)
    return React.createElement(GameInviteFriendsListView, var1)
end

return GameInviteFriendsListContainer
