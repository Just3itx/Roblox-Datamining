-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

local UserProfiles = require(UserSearchParent.UserProfiles)

local function useProfileNames(tbl1)
    local var1 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = { tbl1.userId },
            query = UserProfiles.Queries.userProfilesCombinedNameAndUsernameByUserIds
        }
    )
    local usernameFromId = if var1.data then UserProfiles.Selectors.getUsernameFromId(var1.data, tbl1.userId) else nil
    return {
        username = if usernameFromId then UserProfiles.Formatters.formatUsername(usernameFromId) else nil,
        combinedName = if var1.data then UserProfiles.Selectors.getCombinedNameFromId(var1.data, tbl1.userId) else nil
    }
end

return useProfileNames
