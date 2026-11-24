-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)

local _AvatarBackgroundStoreTypes = require(script.Parent.AvatarBackgroundStoreTypes)

local function parseAvatarBackground(arg1)
    local avatarConfigurations = if typeof(arg1) == "table" then arg1.avatarConfigurations else nil
    local background = if typeof(avatarConfigurations) == "table" then avatarConfigurations.background else nil
    local backgroundAsset = if typeof(background) == "table" then background.backgroundAsset else nil
    local var1 = if typeof(backgroundAsset) == "table" then tonumber(backgroundAsset.id) else nil
    return {
        assetId = var1 and var1 > 0 and var1 or nil
    }
end

local function fetchAvatarBackground(num1: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = string.gsub(tbl2.baseUrl or Http.Url.AVATAR_URL, "/$", "")
    local var2 = HttpClient.fetch({
        network = tbl2.network,
        method = "GET",
        url = `{var1}/v4/avatar/users/{num1}?selectionTypes=Background`,
        analyticsKey = "avatar.avatar-background.get",
        decode = parseAvatarBackground
    })
    return HttpClient.asPromise(var2)
end

return fetchAvatarBackground
