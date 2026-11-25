-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfiles = script:FindFirstAncestor("UserProfiles")
local UserProfilesParent = UserProfiles.Parent
local Queries = require(UserProfiles.Common.Queries)
local Cryo = require(UserProfilesParent.Cryo)
local _ApolloClient = require(UserProfilesParent.ApolloClient)

return function(arg1, tbl1, tbl2)
    local query = if tbl2 and tbl2.query then tbl2.query else Queries.userProfilesAllNamesByUserIds

    for value, value2 in tbl1 do
        local tbl3 = {
            variables = { userIds = value },
            query = query,
            data = 0
        }
        local tbl4 = {
            userProfiles = {{
                __typename = "UserProfile",
                id = value,
                platformProfileId = "",
                names = Cryo.Dictionary.join(
                    {
                        __typename = "Names",
                        alias = "",
                        contactName = "",
                        displayName = "",
                        username = "",
                        platformName = ""
                    },
                    value2
                )
            }}
        }
        tbl3.data = tbl4
        arg1:writeQuery(tbl3)
    end
end
