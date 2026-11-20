-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function removeFriendFromCache(arg1, tbl1)
    local id = arg1.cache:identify({ __typename = "Friend", id = tbl1.userId, targetUserId = tbl1.targetUserId })

    arg1.cache:evict({ id = id })
    arg1.cache:gc()
end

return removeFriendFromCache
