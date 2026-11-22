-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialReducerAdaptors = script:FindFirstAncestor("SocialReducerAdaptors")
local llama = require(SocialReducerAdaptors.dependencies).llama

return function(arg1)
    local function userUpdatedFromUser(tbl1)
        return arg1.Actions.UserUpdated({
            id = tbl1.id,
            username = tbl1.name,
            displayName = tbl1.displayName,
            hasVerifiedBadge = tbl1.hasVerifiedBadge,
            created = tbl1.created
        })
    end

    return {
        AddUser = function(arg2)
            return { userUpdatedFromUser(arg2.user) }
        end,
        AddUsers = function(arg2)
            return llama.Dictionary.values(llama.Dictionary.map(arg2.users, userUpdatedFromUser))
        end
    }
end
