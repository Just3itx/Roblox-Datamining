-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent

local _ApolloClient = require(UserProfilesParent.ApolloClient)

return function(tbl1)
    local client = tbl1.client
    local query = tbl1.query
    local userId = tbl1.userId
    local names = tbl1.names
    local combinedName = if names.alias ~= "" then names.alias elseif names.contactName ~= "" then names.contactName elseif names.displayName ~= "" then names.displayName else names.username
    client:writeQuery({
        variables = {
            userIds = { userId }
        },
        query = query,
        data = {
            userProfiles = {{
                __typename = "UserProfile",
                id = userId,
                names = {
                    __typename = "Names",
                    combinedName = combinedName,
                    alias = names.alias,
                    contactName = names.contactName,
                    displayName = names.displayName,
                    username = names.username
                }
            }}
        }
    })
end
