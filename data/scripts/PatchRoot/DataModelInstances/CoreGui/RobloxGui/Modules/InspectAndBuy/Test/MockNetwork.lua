-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Promise = require(CorePackages.Packages.Promise)
local PlayabilityStatusEnum = require(CorePackages.Workspace.Packages.DiscoveryTypes).PlayabilityStatusEnum

local MockAssetData = {
    {
        id = 100425207,
        name = "Reinforced Wizard",
        assetType = { id = 8, name = "Hat" }
    },
    {
        id = 2510238627,
        name = "Rthro Run",
        assetType = { id = 53, name = "Run Animation" }
    },
    {
        id = 2807164805,
        name = "Mech Golem - Head",
        assetType = { id = 17, name = "Head" }
    }
}

local MockAssetBundlesData = {
    data = {{
        id = 451,
        name = "test name",
        description = "test description",
        bundleType = "testBundleType",
        items = {
            { owned = false, id = 2510230574, name = "test asset name" },
            { owned = false, id = 2510233257, name = "test asset name 2" },
            { owned = false, type = "UserOutfit", id = 2510233258, name = "Outfit" }
        },
        creator = { id = 1, name = "test creator name" },
        product = { id = 480872498, isForSale = true, priceInRobux = 250 }
    }}
}

local humanoidDescription = Instance.new("HumanoidDescription")
humanoidDescription.HatAccessory = 1
humanoidDescription.LeftArm = 2
humanoidDescription.ClimbAnimation = 3
humanoidDescription.BodyTypeScale = 0.3
humanoidDescription.LeftLegColor = Color3.new(0, 0, 0)
humanoidDescription.GraphicTShirt = 4

local humanoidDescription2 = Instance.new("HumanoidDescription")
humanoidDescription2:SetEmotes({ Wave = { 1 }, Laugh = { 2 }, Cheer = { 3 } })

local humanoidDescription3 = Instance.new("HumanoidDescription")

local tbl3 = { assetId = 123, userId = 401784814, created = "" }

local ProductInfo = {
    Name = "test name",
    Description = "test description",
    PriceInRobux = 100,
    Creator = { Id = 1, Name = "TEST CREATOR" },
    AssetId = 100425207,
    AssetTypeId = 8,
    ProductId = 18929548
}

local tbl5 = { Owned = true, IsPurchasable = false, Id = 100425207, ItemType = "Asset" }

local EconomyProductInfo = {
    purchasable = false,
    reason = "InsufficientFunds",
    price = 200,
    assetId = 10
}

local tbl7 = {
    playabilityStatus = PlayabilityStatusEnum.Playable,
    universeId = 13,
    isPlayable = true
}

local tbl8 = { name = "fakename", id = 13, rootPlaceId = 17 }

local function getRobloxProductInfo(assetId)
    local var1 = Cryo.Dictionary.join(ProductInfo, { AssetId = assetId })
    return Promise.resolve(var1)
end

local function getProductInfo(assetId)
    local var1 = Cryo.Dictionary.join(ProductInfo, { AssetId = assetId })
    var1.Creator.Id = 2
    return Promise.resolve(var1)
end

local function getItemDetails(id, itemType)
    local var1 = Cryo.Dictionary.join(tbl5, { Id = id, ItemType = itemType })
    return Promise.resolve(var1)
end

local function getBatchItemDetails(arg1)
    local tbl9 = {}
    for _, id in ipairs(arg1) do
        table.insert(tbl9, Cryo.Dictionary.join(tbl5, { Id = id }))
    end
    return Promise.resolve(tbl9)
end

local VersionInfo = {
    data = {{ assetId = 17, creatingUniverseId = 13 }}
}

local function getVersionInfo(assetId)
    local var1 = Cryo.Dictionary.join(VersionInfo, { AssetId = assetId })
    return Promise.resolve(var1)
end

local function getExperiencePlayability(universeId)
    local var1 = Cryo.Dictionary.join(tbl7, { universeId = universeId })
    return Promise.resolve({ var1 })
end

local function getExperienceInfo(id)
    local var1 = Cryo.Dictionary.join(tbl8, { id = id })
    return Promise.resolve({ data = { var1 } })
end

local function getAssetBundles(_)
    return Promise.resolve(MockAssetBundlesData)
end

local function getPlayerName(_)
    return Promise.resolve("TEST")
end

local function createFavoriteForAsset(_)
    return Promise.resolve()
end

local function createFavoriteForBundle(_)
    return Promise.resolve()
end

local function deleteFavoriteForAsset(_)
    return Promise.resolve()
end

local function deleteFavoriteForBundle(_)
    return Promise.resolve()
end

local function getAssetFavoriteCount(_)
    return Promise.resolve(120)
end

local function getBundleFavoriteCount(_)
    return Promise.resolve(120)
end

local function getFavoriteForAsset(arg1)
    if arg1 == "GetFavoriteModel" then
        return Promise.resolve(tbl3)
    end
    return Promise.resolve("null")
end

local function getFavoriteForBundle(arg1)
    if arg1 == "GetFavoriteModel" then
        return Promise.resolve(tbl3)
    end
    return Promise.resolve("null")
end

local function getEconomyProductInfo(_)
    return Promise.resolve(EconomyProductInfo)
end

local function getModelFromUserId(_)
    return Promise.resolve()
end

local function networkFailure(_, _)
    return Promise.reject("Failed to access network service")
end

local module = {}
module.__index = module

function module.new(arg1, arg2)
    local var1 = arg1
        and {
            getProductInfo = networkFailure,
            getPlayerName = networkFailure,
            getAssetBundles = networkFailure,
            createFavoriteForAsset = networkFailure,
            createFavoriteForBundle = networkFailure,
            deleteFavoriteForAsset = networkFailure,
            deleteFavoriteForBundle = networkFailure,
            getAssetFavoriteCount = networkFailure,
            getBundleFavoriteCount = networkFailure,
            getFavoriteForAsset = networkFailure,
            getFavoriteForBundle = networkFailure,
            getEconomyProductInfo = networkFailure,
            getModelFromUserId = networkFailure,
            getVersionInfo = networkFailure,
            getExperiencePlayability = networkFailure,
            getExperienceInfo = networkFailure,
            getItemDetails = networkFailure,
            getBatchItemDetails = networkFailure
        }
        or {
            getProductInfo = arg2 and getProductInfo or getRobloxProductInfo,
            getPlayerName = getPlayerName,
            getAssetBundles = getAssetBundles,
            createFavoriteForAsset = createFavoriteForAsset,
            createFavoriteForBundle = createFavoriteForBundle,
            deleteFavoriteForAsset = deleteFavoriteForAsset,
            deleteFavoriteForBundle = deleteFavoriteForBundle,
            getAssetFavoriteCount = getAssetFavoriteCount,
            getBundleFavoriteCount = getBundleFavoriteCount,
            getFavoriteForAsset = getFavoriteForAsset,
            getFavoriteForBundle = getFavoriteForBundle,
            getEconomyProductInfo = getEconomyProductInfo,
            getModelFromUserId = getModelFromUserId,
            getVersionInfo = getVersionInfo,
            getExperiencePlayability = getExperiencePlayability,
            getExperienceInfo = getExperienceInfo,
            getItemDetails = getItemDetails,
            getBatchItemDetails = getBatchItemDetails
        }

    setmetatable(var1, {
        __tostring = function(): string
            return "MockService(Network)"
        end
    })

    return var1
end

function module.GetMockAssetData()
    return MockAssetData
end

function module.GetMockHumanoidDescription()
    return humanoidDescription
end

function module.GetMockHumanoidDescriptionEmpty()
    return humanoidDescription3
end

function module.GetMockPlayerName(): string
    return "TEST"
end

function module.GetMockAssetBundlesData()
    return MockAssetBundlesData
end

function module.GetMockFavoriteCount(): number
    return 120
end

function module.GetFavoriteModelId(): string
    return "GetFavoriteModel"
end

function module.GetProductInfo()
    return ProductInfo
end

function module.GetEconomyProductInfo()
    return EconomyProductInfo
end

function module.GetMockHumanoidDescriptionEmotes()
    return humanoidDescription2
end

function module.GetVersionInfo()
    return VersionInfo
end

function module.GetExperiencePlayability()
    return { tbl7 }
end

function module.GetExperienceInfo()
    return {
        data = { tbl8 }
    }
end
return module
