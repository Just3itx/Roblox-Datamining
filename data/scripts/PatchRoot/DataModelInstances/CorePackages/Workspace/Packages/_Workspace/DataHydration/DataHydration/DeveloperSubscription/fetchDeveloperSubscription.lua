-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local creatorApiHttp = require(DataHydration.creatorApiHttp)
local _DeveloperSubscriptionTypes = require(script.Parent.DeveloperSubscriptionTypes)

local function collectionUrl(str1: string, num1: number): string -- Luacid: Inlined by compiler; 6 call sites recovered
    return ("%s/experience-subscriptions/v1/experiences/%d/experience-subscriptions"):format(str1, num1)
end

local function subscriptionUrl(str1: string, num1: number, str2: string): string
    return ("%s/%s"):format(collectionUrl(str1, num1), str2)
end

local function normalize(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = table.clone(arg1)

    if var1.productType == nil and var1.developerSubscriptionProductType ~= nil then
        var1.productType = var1.developerSubscriptionProductType
        var1.developerSubscriptionProductType = nil
    end
    assert(typeof(var1.id) == "string" and var1.id ~= "", "Invalid Developer Subscription ID")
    return var1
end

local function successDecoder(func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = creatorApiHttp.jsonDecoder(function<T>(arg1: T): T
        return arg1
    end)
    return function(arg1)
        local var2, var3, var4 = var1(arg1)
        if var3 ~= nil then
            return nil, var3, var4
        end

        assert(typeof(var2.success) == "boolean", "Invalid Developer Subscription mutation success")
        return {
            success = var2.success,
            responseCode = arg1.statusCode,
            failureReason = var2.failureReason,
            subscription = if var2.success then func1() else nil
        }, nil, nil
    end
end

local function imageSuccessDecoder(id: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = creatorApiHttp.jsonDecoder(function<T>(arg1: T): T
        return arg1
    end)
    return function(arg1)
        local var2, var3, var4 = var1(arg1)
        if var3 ~= nil then
            return nil, var3, var4
        end
        assert(typeof(var2) == "table", "Invalid Developer Subscription image upload response")

        assert(typeof(var2.status) == "boolean", "Invalid Developer Subscription image upload status")
        return {
            success = var2.status,
            responseCode = arg1.statusCode,
            subscription = var2.status and { id = id } or nil
        }, nil, nil
    end
end

local function func1(arg1)
    local var1, var2, var3 = creatorApiHttp.jsonDecoder(function<T>(arg2: T): T
        return arg2
    end)(arg1)
    if var2 ~= nil then
        return nil, var2, var3
    elseif var1.success == false then
        return {
            success = false,
            responseCode = arg1.statusCode,
            failureReason = var1.failureReason
        }, nil, nil
    end
    return {
        success = true,
        responseCode = arg1.statusCode,
        subscription = normalize(var1.developerSubscription)
    }, nil, nil
end

local module = {}

function module.getPermission(num1: number, arg1)
    return creatorApiHttp.get(
        arg1,
        ("%s/permission"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), num1)),
        "developer-subscription.permission",
        function(arg2)
            return {
                canEdit = arg2.canUserEditExperienceSubscription == true
            }
        end
    )
end

function module.getPrices(num1: number, arg1)
    return creatorApiHttp.get(
        arg1,
        ("%s/prices"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), num1)),
        "developer-subscription.prices",
        function(arg2)
            return {
                priceTierPrices = arg2.priceTierPrices or {}
            }
        end
    )
end

local function listPage(universeId: number, cursor: string?, arg1)
    local var1 = creatorApiHttp.withQuery(
        collectionUrl(creatorApiHttp.baseUrl(arg1), universeId),
        { cursor = cursor, resultsPerPage = "50" }
    )
    return creatorApiHttp.get(arg1, var1, "developer-subscription.list", function(arg2)
        return {
            developerSubscriptions = arg2.developerSubscriptions or {},
            nextCursor = arg2.nextCursor,
            hasMoreResults = arg2.hasMoreResults == true
        }
    end)
end

function module.list(universeId: number, arg1)
    local developerSubscriptions = {}
    local tbl2 = ({})
    local tbl3 = {}

    local function fetchNext(cursor: string?, num1: number)
        return listPage(universeId, cursor, arg1):andThen(function(arg2)
            for _, developerSubscription in arg2.developerSubscriptions do
                local var1 = normalize(developerSubscription)
                assert(
                    var1.universeId == nil or var1.universeId == universeId,
                    "Developer Subscription list contains an item from another universe"
                )

                assert(not tbl3[var1.id], "Developer Subscription list contains a duplicate ID")
                tbl3[var1.id] = true
                table.insert(developerSubscriptions, var1)
            end

            local nextCursor = arg2.nextCursor
            if not arg2.hasMoreResults then
                return { developerSubscriptions = developerSubscriptions }
            end

            if nextCursor == nil or nextCursor == "" then
                return Promise.reject({
                    code = "IncompleteDeveloperSubscriptionList",
                    message = "The service reported another page without a cursor",
                    developerSubscriptions = developerSubscriptions
                })
            end
            if not (tbl2[nextCursor] or num1 >= 50) then
                tbl2[nextCursor] = true
                return fetchNext(nextCursor, num1 + 1)
            end

            return Promise.reject({
                code = "IncompleteDeveloperSubscriptionList",
                message = if tbl2[nextCursor] then "Repeated cursor" else "Page limit reached",
                developerSubscriptions = developerSubscriptions,
                nextCursor = nextCursor
            })
        end)
    end

    return fetchNext(nil, 1)
end

function module.get(universeId: number, id: string, arg1)
    return creatorApiHttp.get(
        arg1,
        ("%s/%s"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), universeId), id),
        "developer-subscription.get",
        function(arg2)
            local var1 = normalize(arg2)
            assert(var1.id == id, "Developer Subscription response ID does not match the requested ID")

            assert(
                var1.universeId == nil or var1.universeId == universeId,
                "Developer Subscription response universe does not match the requested universe"
            )

            return var1
        end
    )
end

function module.create(num1: number, arg1, arg2)
    return creatorApiHttp.json(
        creatorApiHttp.mutatingNetwork(arg2),
        "POST",
        collectionUrl(creatorApiHttp.baseUrl(arg2), num1),
        {
            productName = arg1.name,
            productDescription = arg1.description,
            productType = arg1.productType,
            basePriceId = arg1.basePriceId,
            currencyType = arg1.currencyType,
            priceInRobux = arg1.priceInRobux,
            isRegionalPricingEnabled = arg1.isRegionalPricingEnabled
        },
        "developer-subscription.create",
        func1
    )
end

function module.update(num1: number, id: string, arg1, arg2)
    return creatorApiHttp.json(
        creatorApiHttp.mutatingNetwork(arg2),
        "PATCH",
        ("%s/%s"):format(collectionUrl(creatorApiHttp.baseUrl(arg2), num1), id),
        {
            description = arg1.description,
            basePriceId = arg1.basePriceId,
            currencyType = arg1.currencyType,
            priceInRobux = arg1.priceInRobux,
            isRegionalPricingEnabled = arg1.isRegionalPricingEnabled
        },
        "developer-subscription.update",
        (successDecoder(function()
            return {
                id = id,
                description = arg1.description,
                basePriceId = arg1.basePriceId,
                priceInRobux = arg1.priceInRobux
            }
        end))
    )
end

function module.uploadImage(num1: number, str1: string, num2: number, arg1, arg2)
    return creatorApiHttp.multipart(
        creatorApiHttp.mutatingNetwork(arg2),
        "POST",
        ("%s/upload-image"):format(subscriptionUrl(creatorApiHttp.baseUrl(arg2), num1, str1)),
        {
            {
                name = "ActingUserId",
                value = tostring(num2)
            },
            creatorApiHttp.imagePart(arg1)
        },
        "developer-subscription.upload-image",
        (imageSuccessDecoder(str1))
    )
end

function module.activate(num1: number, id: string, arg1)
    return creatorApiHttp.json(
        creatorApiHttp.mutatingNetwork(arg1),
        "POST",
        ("%s/activate"):format(subscriptionUrl(creatorApiHttp.baseUrl(arg1), num1, id)),
        nil,
        "developer-subscription.activate",
        (successDecoder(function()
            return { id = id }
        end))
    )
end

function module.deactivate(num1: number, id: string, bool1: boolean, arg1)
    local var1 = creatorApiHttp.withQuery(
        ("%s/deactivate"):format(subscriptionUrl(creatorApiHttp.baseUrl(arg1), num1, id)),
        {
            cancelRenewals = tostring(bool1)
        }
    )

    return creatorApiHttp.json(
        creatorApiHttp.mutatingNetwork(arg1),
        "POST",
        var1,
        nil,
        "developer-subscription.deactivate",
        (successDecoder(function()
            return { id = id }
        end))
    )
end

function module.delete(num1: number, id: string, arg1)
    return creatorApiHttp.json(
        creatorApiHttp.mutatingNetwork(arg1),
        "DELETE",
        ("%s/%s"):format(collectionUrl(creatorApiHttp.baseUrl(arg1), num1), id),
        nil,
        "developer-subscription.delete",
        (successDecoder(function()
            return { id = id }
        end))
    )
end

return module
