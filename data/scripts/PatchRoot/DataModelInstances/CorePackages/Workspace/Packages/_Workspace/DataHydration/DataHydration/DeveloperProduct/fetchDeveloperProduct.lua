-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local creatorApiHttp = require(DataHydration.creatorApiHttp)
local _DeveloperProductStoreTypes = require(script.Parent.DeveloperProductStoreTypes)

local function collectionUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 6 call sites recovered
    return ("%s/developer-products/v2/universes/%d/developer-products"):format(str1, num1)
end

local function listUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%s/creator"):format(collectionUrl(str1, num1))
end

local function getUrl(str1: string, num1: number, num2: number): string -- Luacid: unused: defined but never referenced
    return ("%s/%d/creator"):format(collectionUrl(str1, num1), num2)
end

local function productUrl(str1: string, num1: number, productId: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return ("%s/%d"):format(collectionUrl(str1, num1), productId)
end

local function requestParts(tbl1)
    local result = {}
    if tbl1.name ~= nil then
        table.insert(result, { name = "name", value = tbl1.name })
    end
    if tbl1.description ~= nil then
        table.insert(result, { name = "description", value = tbl1.description })
    end
    if tbl1.priceInRobux ~= nil then
        table.insert(result, { name = "price", value = tostring(tbl1.priceInRobux) })
    end
    if tbl1.isForSale ~= nil then
        table.insert(result, { name = "isForSale", value = tostring(tbl1.isForSale) })
    end
    if tbl1.isManagedPricingEnabled ~= nil then
        table.insert(result, { name = "isManagedPricingEnabled", value = tostring(tbl1.isManagedPricingEnabled) })
    end
    if tbl1.imageFile ~= nil then
        table.insert(result, {
            name = "imageFile",
            value = tbl1.imageFile.content,
            fileName = tbl1.imageFile.fileName,
            contentType = tbl1.imageFile.contentType
        })
    end
    return result
end

local var1 = creatorApiHttp.jsonDecoder(function<T>(arg1: T): T
    return arg1
end)

local function synthesizedDecoder(func1: (...any) -> (...any))
    return creatorApiHttp.jsonDecoder(function(_)
        return func1()
    end)
end

local module = {}

local function listPage(num1: number, pageToken: string?, arg1)
    local str1 = listUrl(creatorApiHttp.baseUrl(arg1), num1)

    local var2 = creatorApiHttp.withQuery(str1, { pageToken = pageToken })
    return creatorApiHttp.get(arg1, var2, "developer-product.list", function<T>(arg2: T): T
        return arg2
    end)
end

function module.list(num1: number, arg1)
    local developerProducts = {}

    local function fetchNext(pageToken: string?, num2: number)
        return listPage(num1, pageToken, arg1):andThen(function(arg2)
            for _, developerProduct in arg2.developerProducts do
                table.insert(developerProducts, developerProduct)
            end

            local nextPageToken = arg2.nextPageToken
            if nextPageToken ~= nil and nextPageToken ~= "" and num2 < 50 then
                return fetchNext(nextPageToken, num2 + 1)
            end

            local tbl2 = { developerProducts = developerProducts, nextPageToken = 0 }
            if not (num2 >= 50) then
                nextPageToken = nil
            end

            tbl2.nextPageToken = nextPageToken
            return tbl2
        end)
    end

    return fetchNext(nil, 1)
end

function module.get(num1: number, num2: number, arg1)
    return creatorApiHttp.get(
        arg1,
        ("%s/%d/creator"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), num1), num2),
        "developer-product.get",
        function<T>(arg2: T): T
            return arg2
        end
    )
end

function module.create(num1: number, arg1, arg2)
    local var2 = creatorApiHttp.baseUrl(arg2)
    local isForSale = not (arg1.isForSale == nil) and arg1.isForSale
    local tbl1 = requestParts({
        name = arg1.name,
        description = arg1.description,
        priceInRobux = arg1.priceInRobux,
        isForSale = isForSale,
        isManagedPricingEnabled = arg1.isManagedPricingEnabled,
        imageFile = arg1.imageFile
    })
    return creatorApiHttp.multipart(
        creatorApiHttp.mutatingNetwork(arg2),
        "POST",
        collectionUrl(var2, num1),
        tbl1,
        "developer-product.create",
        var1
    )
end

function module.update(num1: number, productId: number, arg1, arg2)
    local var2 = creatorApiHttp.baseUrl(arg2)
    local tbl1 = requestParts({
        name = arg1.name,
        description = arg1.description,
        priceInRobux = arg1.priceInRobux,
        isForSale = arg1.isForSale,
        isManagedPricingEnabled = arg1.isManagedPricingEnabled,
        imageFile = nil
    })

    return creatorApiHttp.multipart(
        creatorApiHttp.mutatingNetwork(arg2),
        "PATCH",
        productUrl(var2, num1, productId),
        tbl1,
        "developer-product.update",
        synthesizedDecoder(function()
            return {
                productId = productId,
                name = arg1.name,
                description = arg1.description,
                isForSale = arg1.isForSale,
                isManagedPricingEnabled = arg1.isManagedPricingEnabled,
                priceInformation = arg1.priceInRobux ~= nil and {
                    defaultPriceInRobux = arg1.priceInRobux
                } or nil
            }
        end)
    )
end

function module.setForSale(num1: number, productId: number, isForSale: boolean, arg1)
    local var2 = creatorApiHttp.baseUrl(arg1)

    return creatorApiHttp.multipart(
        creatorApiHttp.mutatingNetwork(arg1),
        "PATCH",
        productUrl(var2, num1, productId),
        {{
            name = "isForSale",
            value = tostring(isForSale)
        }},
        "developer-product.set-for-sale",
        synthesizedDecoder(function()
            return { productId = productId, isForSale = isForSale }
        end)
    )
end

function module.activate(num1: number, productId: number, arg1)
    return module.setForSale(num1, productId, true, arg1)
end

function module.deactivate(num1: number, productId: number, arg1)
    return module.setForSale(num1, productId, false, arg1)
end

return module
