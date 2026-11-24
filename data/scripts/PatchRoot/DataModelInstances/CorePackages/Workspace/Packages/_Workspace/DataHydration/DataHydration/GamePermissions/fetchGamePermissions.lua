-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Http = require(DataHydrationParent.Http)
local t = require(DataHydrationParent.t)

local _GamePermissionsStoreTypes = require(script.Parent.GamePermissionsStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local var1 = t.interface({ permissions = t.map(t.string, t.boolean) })

local function decodeUniversePermissions(arg1)
    local var2, var3 = var1(arg1)
    assert(var2, `Invalid universe permissions response: {tostring(var3)}`)
    local permissions = arg1.permissions
    return {
        canEdit = permissions.canEdit == true,
        canEditOnBuild = permissions.canEditOnBuild == true,
        canPublish = permissions.canPublish == true,
        canMonetize = permissions.canMonetize == true,
        canViewAnalytics = permissions.canViewAnalytics == true,
        canPreview = permissions.canPreview == true,
        canAdvertise = permissions.canAdvertise == true,
        canViewOnCreatorHub = permissions.canViewOnCreatorHub == true
    }
end

return {
    fetchUniversePermissions = function(num1: number, tbl1)
        local tbl2 = tbl1 or {}
        local var2 = tbl2.baseUrl or Http.Url.GROUPS_URL
        local var3 = fetch({
            network = tbl2.network,
            method = "GET",
            url = `{var2}v2/universes/{num1}/permissions/resolved`,
            analyticsKey = "groups.universe-permissions",
            decode = decodeUniversePermissions
        })
        return asPromise(var3)
    end
}
