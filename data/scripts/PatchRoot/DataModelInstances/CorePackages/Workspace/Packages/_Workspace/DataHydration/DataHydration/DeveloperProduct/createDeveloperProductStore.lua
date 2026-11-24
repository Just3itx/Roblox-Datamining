-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchDeveloperProduct = require(script.Parent.fetchDeveloperProduct)
local _DeveloperProductStoreTypes = require(script.Parent.DeveloperProductStoreTypes)

local function createDeveloperProductStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchDeveloperProduct.list(num1, tbl3)
    end)

    local function imageVerificationError(product, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local tbl4 = { errorMessage = 0, product = 0 }

        local productId = product.productId
        tbl4.errorMessage = ("Developer product %s was created, but its uploaded image could not be verified because %s. Do not create another product; inspect the existing product before retrying."):format(
            tostring(productId),
            str1
        )
        tbl4.product = product
        return tbl4
    end

    local function readBackMutation(num1: number, product, iconImageAssetId: number?, bool1: boolean?)
        local var1 = fetchDeveloperProduct.get(num1, product.productId, tbl3)

        local var2 = if iconImageAssetId == nil then var1:catch(function()
            if not bool1 then
                return product
            end

            singleEntityResolver.fetch(num1)
            return Promise.reject({
                errorMessage = "The developer product update may have saved, but its text could not be verified because the follow-up read failed. List the product before retrying.",
                product = {
                    productId = product.productId
                },
                outcome = "unverified"
            })
        end) else var1:catch(function()
            return Promise.reject((imageVerificationError(product, "the product could not be read back")))
        end)

        return var2:andThen(function(arg1)
            singleEntityResolver.fetch(num1)
            if iconImageAssetId ~= nil and arg1.iconImageAssetId ~= iconImageAssetId then
                return Promise.reject((imageVerificationError(product, "the stored icon did not match the returned icon")))
            end
            return arg1
        end)
    end

    return {
        getProducts = singleEntityResolver.get,
        fetchProducts = singleEntityResolver.fetch,
        getAndFetchProducts = singleEntityResolver.getAndFetch,
        getAccountResetGeneration = singleEntityResolver.getAccountResetGeneration,
        list = function(num1: number)
            return fetchDeveloperProduct.list(num1, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver.update(num1, arg1)
                return arg1
            end)
        end,
        get = function(num1: number, num2: number)
            return fetchDeveloperProduct.get(num1, num2, tbl3)
        end,
        create = function(num1: number, arg1)
            return fetchDeveloperProduct.create(num1, arg1, tbl3):andThen(function(product)
                if arg1.imageFile ~= nil and product.iconImageAssetId == nil then
                    return Promise.reject((imageVerificationError(product, "the API did not return an image asset ID")))
                end
                return readBackMutation(num1, product, if arg1.imageFile == nil then nil else product.iconImageAssetId)
            end)
        end,
        update = function(num1: number, num2: number, arg1, bool1: boolean?)
            return fetchDeveloperProduct.update(num1, num2, arg1, tbl3):andThen(function(product)
                return readBackMutation(num1, product, nil, bool1)
            end)
        end,
        activate = function(num1: number, num2: number)
            return fetchDeveloperProduct.activate(num1, num2, tbl3):andThen(function(product)
                return readBackMutation(num1, product)
            end)
        end,
        deactivate = function(num1: number, num2: number)
            return fetchDeveloperProduct.deactivate(num1, num2, tbl3):andThen(function(product)
                return readBackMutation(num1, product)
            end)
        end,
        clear = function()
            singleEntityResolver.clear()
        end,
        dispose = function()
            singleEntityResolver.dispose()
        end
    }
end
return createDeveloperProductStore
