-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Promise = require(CorePackages.Packages.Promise)
local AvatarEditorService = game:GetService("AvatarEditorService")
local Url = require(CorePackages.Workspace.Packages.Http).Url
local _LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)
local _AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)

local str1 = string.format("https://develop.%s", Url.DOMAIN)

local bool1 = game:DefineFastFlag("AXEnableIaBRbxClientFeature", false)
local str2 = game:DefineFastString("InspectAndBuyFeature", "InspectAndBuy")

local function request(options, bool2: boolean, callback, callback2) -- Luacid: Inlined by compiler; 1 call site recovered
    return HttpService:RequestInternal(options):Start(function(arg1, arg2)
        if not arg1 or arg2.StatusCode ~= 200 then
            callback2(arg2)

            return
        end

        local success = true
        local body

        if bool2 and arg2.Body ~= "null" then
            success, body = pcall(HttpService.JSONDecode, HttpService, arg2.Body)
        else
            body = arg2.Body
        end

        if success then
            callback(body)
            return
        end
        callback2("Could not parse JSON.")
    end)
end

local function createYieldingPromise(options, bool2: boolean)
    if bool1 then
        options.Headers = options.Headers or {}
        options.Headers["rbx-client-feature"] = str2
    end
    return Promise.new(function(callback, arg1)
        coroutine.wrap(function()
            request(options, bool2, callback, arg1)
        end)()
    end)
end

local function getPreviewAvatar(assets)
    local options = {
        Url = Url.APIS_URL .. "look-api/v1/looks/purchase-details",
        Method = "POST",
        Body = HttpService:JSONEncode({ assets = assets }),
        Headers = { ["Content-Type"] = "application/json" }
    }

    return createYieldingPromise(options, true)
end

local function getProductInfo(assetId: number)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            return MarketplaceService:GetProductInfoAsync(assetId)
        end)

        if success then
            callback(result)
            return
        end
        callback2("Failure in getProductInfo: ", tostring(result))
    end)
end

local function getBatchItemDetails(itemIds, avatarItemType: Enum.AvatarItemType)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            return AvatarEditorService:GetBatchItemDetailsAsync(itemIds, avatarItemType)
        end)

        if success then
            callback(result)
            return
        end
        callback2("Failure in batchGetItemDetails: ", tostring(result))
    end)
end

local function getBatchItemDetailsV2(items)
    local options = {
        Url = Url.CATALOG_URL .. "v1/catalog/items/details",
        Method = "POST",
        Body = HttpService:JSONEncode({ items = items }),
        Headers = { ["Content-Type"] = "application/json" }
    }

    return createYieldingPromise(options, true)
end

local function getItemDetails(itemId: number, avatarItemType: Enum.AvatarItemType)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function()
            return AvatarEditorService:GetItemDetailsAsync(itemId, avatarItemType)
        end)

        if success then
            callback(result)
            return
        end
        callback2("Failure in getItemDetails: ", tostring(result))
    end)
end

local function getPlayerName(userId: number | User)
    return Promise.new(function(callback, callback2)
        local success, result = pcall(function(): string
            return Players:GetNameFromUserIdAsync(userId)
        end)

        if success then
            callback(result)
            return
        end
        callback2("Failure in getPlayerName: ", tostring(result))
    end)
end

local function getAssetBundles(arg1)
    local options = {
        Url = Url.CATALOG_URL .. "v1/assets/" .. tostring(arg1) .. "/bundles",
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local function getHumanoidDescriptionFromCostumeId(outfitId: number)
    return Promise.new(function(callback, _)
        spawn(function()
            local humanoidDescription = Players:GetHumanoidDescriptionFromOutfitIdAsync(outfitId)

            if humanoidDescription then
                callback(humanoidDescription)
            end
        end)
    end)
end

local function getAssetFavoriteCount(arg1)
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/assets/" .. tostring(arg1) .. "/count",
        Method = "GET"
    }

    return createYieldingPromise(options, false)
end

local function getBundleFavoriteCount(arg1)
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/bundles/" .. tostring(arg1) .. "/count",
        Method = "GET"
    }

    return createYieldingPromise(options, false)
end

local function getFavoriteForAsset(arg1)
    local userId = Players.LocalPlayer.UserId
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/users/" .. tostring(userId) .. "/assets/" .. tostring(arg1) .. "/favorite",
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local function getFavoriteForBundle(arg1)
    local userId = Players.LocalPlayer.UserId
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/users/" .. tostring(userId) .. "/bundles/" .. tostring(arg1) .. "/favorite",
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local function createFavoriteForAsset(arg1)
    local userId = Players.LocalPlayer.UserId
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/users/" .. tostring(userId) .. "/assets/" .. tostring(arg1) .. "/favorite",
        Method = "POST",
        Body = HttpService:JSONEncode({})
    }

    return createYieldingPromise(options, true)
end

local function deleteFavoriteForAsset(arg1)
    local userId = Players.LocalPlayer.UserId
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/users/" .. tostring(userId) .. "/assets/" .. tostring(arg1) .. "/favorite",
        Method = "DELETE"
    }

    return createYieldingPromise(options, true)
end

local function createFavoriteForBundle(arg1)
    local userId = Players.LocalPlayer.UserId
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/users/" .. tostring(userId) .. "/bundles/" .. tostring(arg1) .. "/favorite",
        Method = "POST",
        Body = HttpService:JSONEncode({})
    }

    return createYieldingPromise(options, true)
end

local function deleteFavoriteForBundle(arg1)
    local userId = Players.LocalPlayer.UserId
    local options = {
        Url = Url.CATALOG_URL .. "v1/favorites/users/" .. tostring(userId) .. "/bundles/" .. tostring(arg1) .. "/favorite",
        Method = "DELETE"
    }

    return createYieldingPromise(options, true)
end

local function getEconomyProductInfo(arg1)
    local options = {
        Url = Url.ECONOMY_URL .. "v1/products/" .. tostring(arg1) .. "?showPurchasable=true",
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local function getModelFromUserId(userId: number | User)
    return Promise.new(function(callback, callback2)
        spawn(function()
            local model = Players:CreateHumanoidModelFromUserIdAsync(userId)

            if model then
                callback(model)
                return
            end
            callback2("Failure in getModelFromUserId")
        end)
    end)
end

local function getCollectibleResellableInstances(arg1, arg2)
    local var1 = Url:makeQueryString({ ownerId = tostring(arg2), ownerType = "User", cursor = "", limit = 500 })

    local options = {
        Url = string.format("%smarketplace-sales/v1/item/%s/resellable-instances?%s", Url.APIS_URL, arg1, var1),
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local function getVersionInfo(arg1)
    local options = {
        Url = string.format("%sv1/assets/%s/saved-versions", str1, arg1),
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local function getExperiencePlayability(arg1)
    local options = {
        Url = string.format("%sv1/games/multiget-playability-status?universeIds=%s", Url.GAME_URL, arg1),
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local function getExperienceInfo(arg1)
    local options = {
        Url = string.format("%sv1/games?universeIds=%s", Url.GAME_URL, arg1),
        Method = "GET"
    }

    return createYieldingPromise(options, true)
end

local module = {}

function module.new()
    local tbl1 = {
        getProductInfo = getProductInfo,
        getEconomyProductInfo = getEconomyProductInfo,
        getPlayerName = getPlayerName,
        getAssetBundles = getAssetBundles,
        getHumanoidDescriptionFromCostumeId = getHumanoidDescriptionFromCostumeId,
        getAssetFavoriteCount = getAssetFavoriteCount,
        getBundleFavoriteCount = getBundleFavoriteCount,
        getFavoriteForAsset = getFavoriteForAsset,
        getFavoriteForBundle = getFavoriteForBundle,
        createFavoriteForAsset = createFavoriteForAsset,
        deleteFavoriteForAsset = deleteFavoriteForAsset,
        createFavoriteForBundle = createFavoriteForBundle,
        deleteFavoriteForBundle = deleteFavoriteForBundle,
        getModelFromUserId = getModelFromUserId,
        getCollectibleResellableInstances = getCollectibleResellableInstances,
        getVersionInfo = getVersionInfo,
        getExperiencePlayability = getExperiencePlayability,
        getExperienceInfo = getExperienceInfo,
        getItemDetails = getItemDetails,
        getPreviewAvatar = getPreviewAvatar,
        getBatchItemDetails = getBatchItemDetails,
        getBatchItemDetailsV2 = getBatchItemDetailsV2
    }

    setmetatable(tbl1, {
        __tostring = function(): string
            return "Service(Network)"
        end
    })

    return tbl1
end

return module
