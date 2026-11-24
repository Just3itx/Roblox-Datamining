-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local _Types = require(InExperienceShop.Types)
local _multiGetProductInfo = require(InExperienceShop.Api.multiGetProductInfo)

local MOCK_PRODUCT_ITEMS_FOR_TESTING = {
    {
        id = "101",
        name = "product1",
        thumbnail = "rbxassetid://6789",
        price = 1,
        userBasePriceInRobux = 2,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "test",
        updated = "2026-02-09T22:14:44.486Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "102",
        name = "product2",
        displayName = "Product Two",
        thumbnail = "rbxassetid://6789",
        price = 1,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "This is the description",
        updated = "2026-02-09T22:25:41.802Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "103",
        name = "Dev2's` <3 Test",
        displayName = "Dev2's Love Test",
        thumbnail = "rbxassetid://6789",
        price = 1,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Test Description...",
        updated = "2026-02-18T00:17:01.48Z",
        creator = { name = "MockCreator2", hasVerifiedBadge = false }
    },
    {
        id = "104",
        name = "Very Long Product1",
        thumbnail = "rbxassetid://6789",
        price = 2,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Test",
        updated = "2026-04-21T04:37:16.988Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "105",
        name = "Prod3",
        thumbnail = "rbxassetid://6789",
        price = 1,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Test Description...",
        updated = "2026-04-21T04:29:53.708Z",
        creator = { name = "MockCreator3", hasVerifiedBadge = false }
    },
    {
        id = "106",
        name = "Prod5",
        thumbnail = "rbxassetid://6789",
        price = 2,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "",
        updated = "2026-04-21T04:36:12.611Z",
        creator = { name = "MockCreator44", hasVerifiedBadge = false }
    },
    {
        id = "107",
        name = "Prod7",
        thumbnail = "rbxassetid://6789",
        price = 2,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Really long description that spans more than one line but could span multiple lines.",
        updated = "2026-04-21T04:36:37.726Z",
        creator = { name = "MockCreator5", hasVerifiedBadge = false }
    },
    {
        id = "108",
        name = "Prod8",
        thumbnail = "rbxassetid://6789",
        price = 2,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Test &nbsp; Description with special characters <>#$%^&*()_+-=[]{}|\\:;\"'<>,.?/~`!",
        updated = "2026-04-21T04:37:03.186Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "109",
        name = "Prod9",
        thumbnail = "rbxassetid://6789",
        price = 5,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Test Description...",
        updated = "2026-04-21T04:36:50.442Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "110",
        name = "Prod11",
        thumbnail = "rbxassetid://6789",
        price = 100,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Test Description...",
        updated = "2026-04-25T00:01:47.859Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "111",
        name = "Tire replacement (HARD)",
        displayName = "Hard Tire Replacement",
        thumbnail = "rbxassetid://6789",
        price = 45,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "",
        updated = "2025-12-15T22:53:13.711Z",
        creator = { name = "MockCreator2", hasVerifiedBadge = false }
    },
    {
        id = "112",
        name = "Tire replacement (SOFT)",
        thumbnail = "rbxassetid://6789",
        price = 45,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Replace your car tires to SOFT",
        updated = "2025-12-15T22:44:39.501Z",
        creator = { name = "MockCreator3", hasVerifiedBadge = false }
    },
    {
        id = "113",
        name = "Steering boost",
        thumbnail = "rbxassetid://6789",
        price = 135,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "More responsive steering",
        updated = "2025-12-15T23:01:33.255Z",
        creator = { name = "MockCreator4", hasVerifiedBadge = false }
    },
    {
        id = "114",
        name = "Breaking boost",
        thumbnail = "rbxassetid://6789",
        price = 90,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Faster breaking",
        updated = "2025-12-15T23:00:34.873Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "115",
        name = "Emoji Happy",
        displayName = "😊 Happy Emoji",
        thumbnail = "rbxassetid://6789",
        price = 10,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Dev product with happy emoji",
        updated = "2026-05-11T18:35:49.447Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    },
    {
        id = "116",
        name = "Nitro",
        thumbnail = "rbxassetid://6789",
        price = 68,
        isOwned = false,
        itemType = "Product",
        universeId = "12345",
        description = "Single-use very fast acceleration",
        updated = "2025-12-15T23:02:44.396Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    }
}

local MOCK_GAMEPASS_ITEMS_FOR_TESTING = {
    {
        id = "201",
        name = "pass5",
        thumbnail = "rbxassetid://6789",
        price = 2,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "Test Description...",
        updated = "2026-04-21T04:39:24.953Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "202",
        name = "pass5",
        thumbnail = "rbxassetid://6789",
        price = 4,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "Test Description...",
        updated = "2026-04-21T04:39:59.813Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "203",
        name = "Thanks's` <3",
        displayName = "Thanks ❤️",
        thumbnail = "rbxassetid://6789",
        price = 1,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "Test Description...",
        updated = "2026-02-18T00:09:23.903Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "204",
        name = "Thanks’s <3 :heart::victory_hand:t2:",
        thumbnail = "rbxassetid://6789",
        price = 1,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "Test",
        updated = "2026-02-18T00:05:06.047Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "205",
        name = "pass1",
        thumbnail = "rbxassetid://6789",
        price = 2,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "test",
        updated = "2026-04-21T04:38:16.87Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "206",
        name = "bear animal pass",
        thumbnail = "rbxassetid://6789",
        price = 7,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "Bear animal pass description",
        updated = "2026-05-11T20:11:28.05Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "207",
        name = "Pass Coke",
        thumbnail = "rbxassetid://6789",
        price = 8,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "#########",
        updated = "2026-05-11T20:10:42.79Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "3456",
        name = "Smiley pass",
        thumbnail = "rbxassetid://6789",
        price = 2,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "root pass for other passes",
        updated = "2026-05-11T19:33:39.1Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "208",
        name = "Blue pass neutral",
        thumbnail = "rbxassetid://6789",
        price = 5,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "Get this pass with blue power",
        updated = "2026-05-11T19:40:01.477Z",
        creator = { name = "MockCreatorK", hasVerifiedBadge = false }
    },
    {
        id = "4242",
        name = "Bonus Game Pass",
        thumbnail = "rbxassetid://6789",
        price = 99,
        isOwned = false,
        itemType = "GamePass",
        universeId = "12345",
        description = "Bonus item for Robux packages",
        updated = "2026-05-20T12:00:00.000Z",
        creator = { name = "MockCreator", hasVerifiedBadge = false }
    }
}

local function buildLookup()
    local lookup = {}
    for _, value in ipairs(MOCK_PRODUCT_ITEMS_FOR_TESTING) do
        lookup["Product:" .. value.id] = value
    end
    for _, value in ipairs(MOCK_GAMEPASS_ITEMS_FOR_TESTING) do
        lookup["GamePass:" .. value.id] = value
    end
    return lookup
end

local lookup = buildLookup()

local function parseIconImageAssetId(thumbnail: string?): number -- Luacid: Inlined by compiler; 1 call site recovered
    if not thumbnail then
        return 0
    end
    return tonumber((string.match(thumbnail, "rbxassetid://(%d+)"))) or 0
end

local function shopItemToProductInfo(arg1)
    local num1 = tonumber(arg1.id) or 0
    local var1 = arg1.creator or { name = "", hasVerifiedBadge = false }
    local displayName = arg1.displayName
    return {
        Name = arg1.name,
        DisplayName = displayName,
        Description = arg1.description or "",
        PriceInRobux = arg1.price or 0,
        UserBasePriceInRobux = arg1.userBasePriceInRobux,
        ProductId = num1,
        AssetId = num1,
        IsForSale = true,
        Updated = arg1.updated,
        IconImageAssetId = parseIconImageAssetId(arg1.thumbnail),
        Creator = {
            Name = var1.name,
            HasVerifiedBadge = var1.hasVerifiedBadge
        }
    }
end

local function resolveRequest(request)
    local var1 = request.infoType.Name .. ":" .. tostring(request.id)
    local var2 = lookup[var1]
    if var2 ~= nil then
        return {
            request = request,
            ok = true,
            value = shopItemToProductInfo(var2)
        }
    end

    return {
        request = request,
        ok = false,
        err = string.format("Mock product info not found for %s id %s", request.infoType.Name, tostring(request.id))
    }
end

local function resolveStreamDelaySeconds(num1: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == nil then
        return math.random() * 0.5
    elseif num1 == 0 then
        return 0
    end

    return math.random() * num1
end

local module = {
    MOCK_PRODUCT_ITEMS_FOR_TESTING = MOCK_PRODUCT_ITEMS_FOR_TESTING,
    MOCK_GAMEPASS_ITEMS_FOR_TESTING = MOCK_GAMEPASS_ITEMS_FOR_TESTING
}

function module.multiGetProductInfo(tbl3, num1: number?)
    return Promise.delay(if num1 == nil then 0.5 else num1):andThen(function()
        local var1 = table.create(#tbl3)
        for i, value in ipairs(tbl3) do
            var1[i] = resolveRequest(value)
        end
        return var1
    end)
end

function module.streamMultiGetProductInfo(tbl3, tbl4, num1: number?)
    local num2 = #tbl3
    if num2 == 0 then
        return Promise.resolve({})
    end

    local var1 = table.create(num2)
    local num3 = 0

    return Promise.new(function(callback)
        for i, value in ipairs(tbl3) do
            Promise.delay((resolveStreamDelaySeconds(num1))):andThen(function()
                local var2 = resolveRequest(value)
                var1[i] = var2
                tbl4.onResult(var2)
                num3 += 1
                if num3 == num2 then
                    callback(var1)
                end
            end)
        end
    end)
end

return module
