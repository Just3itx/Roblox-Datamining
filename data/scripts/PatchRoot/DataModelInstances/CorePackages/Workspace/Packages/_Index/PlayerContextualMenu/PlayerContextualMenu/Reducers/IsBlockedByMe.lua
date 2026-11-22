-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerContextualMenu = script:FindFirstAncestor("PlayerContextualMenu")
local PlayerContextualMenuParent = PlayerContextualMenu.Parent
local Rodux = require(PlayerContextualMenuParent.Rodux)
local Dash = require(PlayerContextualMenuParent.Dash)
local Blocking = require(PlayerContextualMenu.Http.Blocking)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[Blocking.GetBlockedUsers.Succeeded.name] = function(_, arg1)
    local var1 = arg1.responseBody and arg1.responseBody.blockedUsers or {}
    local result = {}
    for _, value in ipairs(var1) do
        local userId = value.userId
        result[tostring(userId)] = true
    end
    return result
end

tbl1[Blocking.BlockUserById.Succeeded.name] = function(arg1, arg2)
    local str1 = tostring(arg2.namedIds.users)
    return Dash.join(arg1, { [str1] = true })
end

tbl1[Blocking.UnblockUserById.Succeeded.name] = function(arg1, arg2)
    local str1 = tostring(arg2.namedIds.users)
    return Dash.join(arg1, { [str1] = false })
end

return createReducer({}, tbl1)
