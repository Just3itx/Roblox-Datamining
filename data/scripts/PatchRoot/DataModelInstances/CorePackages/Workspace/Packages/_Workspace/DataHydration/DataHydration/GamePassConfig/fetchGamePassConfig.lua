-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local creatorApiHttp = require(DataHydration.creatorApiHttp)
local _GamePassConfigTypes = require(script.Parent.GamePassConfigTypes)
local incompleteListCode = require(script.Parent.incompleteListCode)

local FFlagDataHydrationPreserveIncompleteCatalogResults = require(DataHydration.Flags.FFlagDataHydrationPreserveIncompleteCatalogResults)

local function collectionUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 4 call sites recovered
    return ("%s/game-passes/v1/universes/%d/game-passes"):format(str1, num1)
end

local function passUrl(str1: string, num1: number, gamePassId: number): string
    return ("%s/%d"):format(collectionUrl(str1, num1), gamePassId)
end

local function requestParts(arg1)
    local result = {}
    if arg1.name ~= nil then
        table.insert(result, { name = "name", value = arg1.name })
    end
    if arg1.description ~= nil then
        table.insert(result, { name = "description", value = arg1.description })
    end
    if arg1.priceInRobux ~= nil then
        table.insert(result, { name = "price", value = tostring(arg1.priceInRobux) })
    end
    if arg1.isForSale ~= nil then
        table.insert(result, { name = "isForSale", value = tostring(arg1.isForSale) })
    end
    if arg1.isManagedPricingEnabled ~= nil then
        table.insert(result, { name = "isManagedPricingEnabled", value = tostring(arg1.isManagedPricingEnabled) })
    end
    if arg1.imageFile ~= nil then
        table.insert(result, creatorApiHttp.imagePart(arg1.imageFile))
    end
    return result
end

local module = {}

local function listPage(num1: number, pageToken: string?, arg1)
    local var1 = creatorApiHttp.withQuery(
        ("%s/creator"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), num1)),
        { pageToken = pageToken }
    )
    return creatorApiHttp.get(arg1, var1, "game-pass.list", function<T>(arg2: T): T
        return arg2
    end)
end

function module.list(num1: number, arg1)
    local gamePasses = {}
    local tbl2 = ({})
    local tbl3 = {}

    local function fetchNext(pageToken: string?, num2: number)
        return listPage(num1, pageToken, arg1):andThen(function(arg2)
            for _, value in arg2.gamePasses do
                if FFlagDataHydrationPreserveIncompleteCatalogResults then
                    assert(not tbl3[value.gamePassId], "Game Pass list contains a duplicate ID")
                    tbl3[value.gamePassId] = true
                end
                table.insert(gamePasses, value)
            end

            local nextPageToken = arg2.nextPageToken
            if nextPageToken == nil or nextPageToken == "" then
                return { gamePasses = gamePasses }
            end

            if not (tbl2[nextPageToken] or num2 >= 50) then
                tbl2[nextPageToken] = true
                return fetchNext(nextPageToken, num2 + 1)
            end

            return Promise.reject({
                code = incompleteListCode,
                message = if tbl2[nextPageToken] then "Repeated page token" else "Page limit reached",
                gamePasses = gamePasses,
                nextPageToken = nextPageToken
            })
        end)
    end

    return fetchNext(nil, 1)
end

function module.get(num1: number, gamePassId: number, arg1)
    return creatorApiHttp.get(
        arg1,
        ("%s/creator"):format(passUrl(creatorApiHttp.baseUrl(arg1), num1, gamePassId)),
        "game-pass.get",
        function(arg2)
            assert(arg2.gamePassId == gamePassId, "Game Pass response ID does not match the requested ID")
            return arg2
        end
    )
end

function module.batchGet(num1: number, gamePassIds, arg1)
    return creatorApiHttp.json(
        creatorApiHttp.mutatingNetwork(arg1),
        "POST",
        ("%s/creator:batchGet"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), num1)),
        { gamePassIds = gamePassIds },
        "game-pass.batch-get",
        creatorApiHttp.jsonDecoder(function(arg2)
            local tbl1 = ({})
            for _, gamePassId in gamePassIds do
                tbl1[gamePassId] = true
            end
            for _, value in arg2.gamePasses do
                assert(tbl1[value.gamePassId], "Game Pass batch contains an unexpected or duplicate ID")
                tbl1[value.gamePassId] = nil
            end
            return arg2
        end)
    )
end

function module.create(num1: number, arg1, arg2)
    local tbl1 = requestParts({
        name = arg1.name,
        description = arg1.description,
        priceInRobux = arg1.priceInRobux,
        isForSale = not (arg1.isForSale == nil) and arg1.isForSale,
        isManagedPricingEnabled = arg1.isManagedPricingEnabled,
        imageFile = arg1.imageFile
    })

    return creatorApiHttp.multipart(
        creatorApiHttp.mutatingNetwork(arg2),
        "POST",
        collectionUrl(creatorApiHttp.baseUrl(arg2), num1),
        tbl1,
        "game-pass.create",
        creatorApiHttp.jsonDecoder(function(arg3)
            assert(
                type(arg3.gamePassId) == "number" and arg3.gamePassId % 1 == 0 and arg3.gamePassId > 0,
                "Created Game Pass response has an invalid ID"
            )

            return arg3
        end)
    )
end

function module.update(num1: number, gamePassId: number, arg1, arg2)
    return creatorApiHttp.multipart(
        creatorApiHttp.mutatingNetwork(arg2),
        "PATCH",
        ("%s/%d"):format(collectionUrl(creatorApiHttp.baseUrl(arg2), num1), gamePassId),
        requestParts(arg1),
        "game-pass.update",
        creatorApiHttp.noContentDecoder(function()
            return { gamePassId = gamePassId }
        end)
    )
end

function module.setArchived(num1: number, num2: number, bool1: boolean, arg1)
    return creatorApiHttp.multipart(
        creatorApiHttp.mutatingNetwork(arg1),
        "PATCH",
        ("%s/%d"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), num1), num2),
        {{
            name = "isArchived",
            value = tostring(bool1)
        }},
        "game-pass.set-archived",
        creatorApiHttp.noContentDecoder(function()
            return nil
        end)
    )
end

function module.getSalesLimit(num1: number, arg1)
    return creatorApiHttp.get(
        arg1,
        ("%s/game-passes/v1/game-passes/universes/%d/sales-limit"):format(creatorApiHttp.baseUrl(arg1), num1),
        "game-pass.sales-limit",
        function<T>(arg2: T): T
            return arg2
        end
    )
end

return module
