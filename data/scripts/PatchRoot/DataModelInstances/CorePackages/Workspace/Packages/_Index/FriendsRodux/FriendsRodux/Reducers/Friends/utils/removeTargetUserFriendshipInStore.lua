-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local llama = require(FriendsRoduxParent.llama)
local removeUser = require(script.Parent.removeUser)

return function(arg1, arg2)
    local str1 = tostring(arg2.additionalData.currentUserId)
    local str2 = tostring(arg2.namedIds.users)

    local var1 = llama.Dictionary.join(arg1, { [str1] = removeUser(arg1[str1], str2), [str2] = removeUser(arg1[str2], str1) })

    var1[str2] = nil

    return var1
end
