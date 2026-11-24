-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpService = game:GetService("HttpService")

local AvatarExperienceModel = require(DataHydrationParent.AvatarExperienceModel)
local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)

local _AvatarInventoryStoreTypes = require(script.Parent.AvatarInventoryStoreTypes)

local InventoryOutfitTypeToInventoryTypeId = AvatarExperienceModel.Constants.InventoryOutfitTypeToInventoryTypeId

local function parseAvatarInventoryResponse(arg1)
    local items = (typeof(arg1) ~= "table" or typeof(arg1.avatarInventoryItems) ~= "table") and {} or arg1.avatarInventoryItems
    local nextPageToken = if typeof(arg1) == "table" then arg1.nextPageToken else nil
    local tbl1 = { items = items, nextPageToken = 0 }

    if typeof(nextPageToken) ~= "string" or nextPageToken == "" then
        nextPageToken = nil
    end

    tbl1.nextPageToken = nextPageToken
    return tbl1
end

local function buildQueryString(arg1, input: string?)
    local tbl1 = {
        pageLimit = arg1.pageLimit or 25,
        sortOption = arg1.sortOption or "recentAdded",
        pageToken = if input then HttpService:UrlEncode(input) else nil
    }
    local num1 = 0
    local function addCategory(str1: string, num2: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl1[`itemCategories[{num1}].itemType`] = str1
        tbl1[`itemCategories[{num1}].itemSubType`] = num2
        num1 += 1
    end
    for _, value in arg1.assetTypeIds or {} do
        addCategory("asset", value)
    end

    for _, value in arg1.outfitInventoryTypes or {} do
        local var1 = InventoryOutfitTypeToInventoryTypeId[value]
        if var1 == nil then
            error(`AvatarInventory: unknown outfit inventory type {value}`)
        end

        addCategory("outfit", var1)
    end

    return Http.Url:makeQueryString(tbl1)
end

local function fetchAvatarInventoryPage(arg1, str1: string?, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = string.gsub(tbl2.baseUrl or Http.Url.AVATAR_URL, "/$", "")
    local var2 = HttpClient.fetch({
        network = tbl2.network,
        method = "GET",
        url = `{var1}/v1/avatar-inventory?{buildQueryString(arg1, str1)}`,
        analyticsKey = "avatar.avatar-inventory.get",
        decode = parseAvatarInventoryResponse
    })
    return HttpClient.asPromise(var2)
end

return fetchAvatarInventoryPage
