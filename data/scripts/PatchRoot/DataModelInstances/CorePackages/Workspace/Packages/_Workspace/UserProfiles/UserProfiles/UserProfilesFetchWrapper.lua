-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent

local _ApolloClient = require(UserProfilesParent.ApolloClient)
local _React = require(UserProfilesParent.React)

local useUserProfilesFetch = require(script.Parent.Hooks).useUserProfilesFetch

return function(tbl1)
    local var1 = useUserProfilesFetch({ userIds = tbl1.userIds, query = tbl1.query })

    return tbl1.renderComponent(var1)
end
