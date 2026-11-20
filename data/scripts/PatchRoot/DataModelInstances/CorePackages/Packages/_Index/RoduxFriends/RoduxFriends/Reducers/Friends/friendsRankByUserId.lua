-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Rodux = require(scriptParentParentParentParent.Rodux)
local llama = require(scriptParentParentParentParent.llama)

local _roduxFriendsTypes = require(scriptParentParentParent.roduxFriendsTypes)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFriendsFromUserId.Succeeded.name] = function(arg2, arg3)
        if not (arg3.queryArgs and arg3.queryArgs.userSort) then
            return arg2
        end

        local str1 = tostring(arg3.namedIds.users)
        local data = arg3.responseBody.data or {}

        local var1 = llama.Dictionary.map(data, function<T>(arg4, arg5: T): (T, string)
            return arg5, tostring(arg4.id)
        end)

        return llama.Dictionary.join(arg2, { [str1] = var1 })
    end

    return createReducer(tbl2, tbl3)
end
