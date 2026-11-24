-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local _Signals = require(FriendsChatParent.Signals)

local createMessageDisplayStore = require(script.Parent.createMessageDisplayStore)

local function useMessageDisplayStore(str1: string?, str2: string?)
    return React.useMemo(function()
        return createMessageDisplayStore(str1, str2)
    end, { str1, str2 })
end

return useMessageDisplayStore
