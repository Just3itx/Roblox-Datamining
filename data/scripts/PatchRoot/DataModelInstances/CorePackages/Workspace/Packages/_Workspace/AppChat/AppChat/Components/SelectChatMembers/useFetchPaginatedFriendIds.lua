-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local UserProfiles = require(AppChatParent.UserProfiles)

local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useFriendsListOrderedByPresence = require(AppChatParent.FriendsCommon).Hooks.useFriendsListOrderedByPresence

function useFetchPaginatedFriendIds()
    local userId = useLocalUserId()
    local var2 = React.useRef({})

    local var3 = useFriendsListOrderedByPresence({ userId = userId, pageSize = 50 })

    local var4 = Cryo.List.join(var3.onlineFriends, var3.offlineFriends)
    local current = Cryo.List.map(var4, function(arg1)
        return arg1.id
    end)
    local var6 = Cryo.List.toSet(var2.current)
    local var7 = Cryo.List.filter(current, function(arg1): boolean
        return not var6[arg1]
    end)
    if #var7 > 0 then
        UserProfiles.Stores.UserProfileStore.get().fetchNamesByUserIds(var7)
    end
    var2.current = current

    return var2.current, var3.fetchMoreFriends, var3.isEndOfList, var3
end

return useFetchPaginatedFriendIds
