-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialReducerAdaptors = script:FindFirstAncestor("SocialReducerAdaptors")
local dependencies = require(SocialReducerAdaptors.dependencies)
local Players = dependencies.Players
local llama = dependencies.llama

return function(arg1, str1: string?)
    local function friendshipCreatedWithUser(tbl1)
        local friendshipCreated = arg1.Actions.FriendshipCreated
        local id = tbl1.id
        local var1 = str1 or tostring(Players.LocalPlayer.UserId)
        return friendshipCreated(id, var1)
    end

    return {
        AddUser = function(tbl1): {any} | {{[any]: any}}
            return if tbl1.user.isFriend then { friendshipCreatedWithUser(tbl1.user) } else { tbl1 }
        end,
        AddUsers = function(tbl1)
            return llama.Dictionary.values(llama.Dictionary.map(tbl1.users, function(arg2, _)
                if arg2.isFriend then
                    return friendshipCreatedWithUser(arg2)
                end

                return nil
            end))
        end,
        SetFriendRequestsCount = function(tbl1)
            return { arg1.Actions.RequestReceivedCountUpdated(tbl1.count) }
        end
    }
end
