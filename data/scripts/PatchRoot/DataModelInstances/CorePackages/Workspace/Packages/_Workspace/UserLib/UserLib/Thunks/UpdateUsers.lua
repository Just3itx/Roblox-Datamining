-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local User = require(UserLib.Models.User)
local AddUsers = require(UserLib.Actions.AddUsers)
local SetFriendCount = require(UserLibParent.LegacyFriendsRodux).Actions.SetFriendCount
local FFlagRemoveUnusedFriendCountRoduxSlice = require(UserLibParent.SharedFlags).FFlagRemoveUnusedFriendCountRoduxSlice

return function(arg1)
    return function(arg2)
        local num1 = 0
        local tbl1 = ({})

        for _, value in pairs(arg1) do
            local bool1 = false
            local id = value.id
            local isFriend = value.isFriend
            local num2 = 0

            assert(typeof(isFriend) == "boolean", "Expected isFriend to be a string")

            local user = arg2:getState().Users[id]
            if user then
                if not User.compare(user, value) then
                    bool1 = true
                    if user.isFriend ~= isFriend then
                        num2 = if isFriend then 1 else -1
                    end
                end
            else
                bool1 = true
                num2 = if isFriend then 1 else 0
            end

            if bool1 then
                num1 += num2
                tbl1[id] = value
            end
        end

        if next(tbl1) then
            arg2:dispatch(AddUsers(tbl1))
        end

        if not FFlagRemoveUnusedFriendCountRoduxSlice and num1 ~= 0 then
            local friendCount = arg2:getState().FriendCount
            arg2:dispatch(SetFriendCount(friendCount + num1))
        end
    end
end
