-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local Profile = DataHydration.Profile
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder
local myHttpRequest = require(Profile.Networking.myHttpRequest)

local FFlagJoinabilityCTARefactor = require(DataHydrationParent.SharedFlags).FFlagJoinabilityCTARefactor
local FFlagUserListActionsV2 = require(DataHydrationParent.SharedFlags).FFlagUserListActionsV2

local var1 = UrlBuilder.new({ base = Url.APIS_URL, path = "profile-platform-api/v1/profiles/batch/get" })()

local tbl1 = {{ component = "Actions", excludeContextualActions = true }}

return function(profileIds, components)
    local tbl2

    if FFlagJoinabilityCTARefactor then
        tbl2 = {
            profileType = "User",
            profileIds = profileIds,
            components = components or tbl1
        }
    else
        tbl2 = {
            profileType = "User",
            profileIds = profileIds,
            components = {{ component = "Actions" }},
            excludeContextualActions = true
        }

        if FFlagUserListActionsV2 and components then
            tbl2.components = components
        end
    end
    return myHttpRequest(var1, "POST", { postBody = tbl2 }):catch(function(arg1)
        error(arg1)
    end)
end
