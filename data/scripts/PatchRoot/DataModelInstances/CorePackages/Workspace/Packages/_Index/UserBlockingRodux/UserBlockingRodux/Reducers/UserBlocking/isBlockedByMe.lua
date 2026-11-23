-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserBlockingRoduxParent = script:FindFirstAncestor("UserBlockingRodux").Parent
local Rodux = require(UserBlockingRoduxParent.Rodux)
local Cryo = require(UserBlockingRoduxParent.Cryo)

return function(arg1)
    local userBlockingNetworking = arg1.userBlockingNetworking

    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[userBlockingNetworking.BlockUserById.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        return Cryo.Dictionary.join(arg2, { [str1] = true })
    end

    tbl1[userBlockingNetworking.UnblockUserById.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        return Cryo.Dictionary.join(arg2, { [str1] = false })
    end

    tbl1[userBlockingNetworking.IsBlockedById.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        local responseBody = arg3.responseBody or false
        return Cryo.Dictionary.join(arg2, { [str1] = responseBody })
    end

    return createReducer({}, tbl1)
end
