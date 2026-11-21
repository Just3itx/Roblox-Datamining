-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
return (require(scriptParentParentParent.React).createContext({
    selectedFriendsSize = 0,
    selectedFriends = {},
    addFriend = function() end,
    removeFriend = function() end,
    isFriendSelected = function(): boolean
        return false
    end,
    preselectedUsers = {},
    onRemoveCallback = function() end
}))
