-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local populateUserWithState = require(AppChat.Users.populateUserWithState)
local Logger = require(script.Parent.Parent.Logger)

return function(arg1, arg2, tbl1)
    local users = arg1.Users

    local result = {}

    for k, value in pairs(arg2) do
        local user = users[value]
        local var1 = if tbl1 then tbl1[k] else nil

        if user then
            local var2 = populateUserWithState(arg1, user, var1)
            result[user.id] = var2
        else
            Logger:warning("user is required in selectChatUserEntryModelList")
        end
    end

    return result
end
