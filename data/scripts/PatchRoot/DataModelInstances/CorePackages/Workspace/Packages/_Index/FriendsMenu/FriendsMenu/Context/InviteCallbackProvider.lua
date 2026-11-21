-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local React = require(scriptParentParentParent.React)
local InviteCallbackContext = require(scriptParent.InviteCallbackContext)

return function(tbl1)
    return React.createElement(
        InviteCallbackContext.Provider,
        {
            value = {
                inviteSingleFriend = tbl1.inviteSingleFriend,
                inviteMultiFriends = tbl1.inviteMultiFriends
            }
        },
        tbl1.children
    )
end
