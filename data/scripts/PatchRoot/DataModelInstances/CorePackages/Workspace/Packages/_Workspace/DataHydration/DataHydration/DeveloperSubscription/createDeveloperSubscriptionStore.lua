-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)
local StatusCodes = require(DataHydrationParent.Http).StatusCodes
local Promise = require(DataHydrationParent.Promise)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local FFlagDataHydrationPreserveIncompleteCatalogResults = require(DataHydration.Flags.FFlagDataHydrationPreserveIncompleteCatalogResults)

local FFlagBuildExperienceMonetizationManageKinds = require(DataHydration.Flags.FFlagBuildExperienceMonetizationManageKinds)
local DataHydrationUtils = require(DataHydration.DataHydrationUtils)

local fetchDeveloperSubscription = require(script.Parent.fetchDeveloperSubscription)
local DeveloperSubscriptionTypes = require(script.Parent.DeveloperSubscriptionTypes)

local var1 = table.freeze({ errorMessage = "The local user changed while the Developer Subscription request was running" })

local function createDeveloperSubscriptionStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local getLocalPlayerUserId = tbl2.getLocalPlayerUserId or DataHydrationUtils.getLocalPlayerUserId
    local observeLocalPlayerUserId = tbl2.observeLocalPlayerUserId or DataHydrationUtils.observeLocalPlayerUserId

    local num1 = 0
    local bool1 = false
    local singleEntityResolver = createSingleEntityResolver(function(num2: number) -- name: fetchSubscriptions
        local var2 = fetchDeveloperSubscription.list(num2, tbl3)
        if not FFlagDataHydrationPreserveIncompleteCatalogResults then
            return var2
        end
        return var2:catch(function(arg1)
            if typeof(arg1) ~= "table" or arg1.code ~= "IncompleteDeveloperSubscriptionList" then
                return Promise.reject(arg1)
            end

            return {
                developerSubscriptions = arg1.developerSubscriptions,
                nextCursor = arg1.nextCursor,
                isIncomplete = true
            }
        end)
    end, {
        cache = FFlagDataHydrationPreserveIncompleteCatalogResults and {
            ttlSecondsForItem = function(arg1): number?
                return if arg1.isIncomplete then 60 else nil
            end
        } or nil,
        resolver = { replaceItems = true }
    })

    local var2 = observeLocalPlayerUserId(function()
        num1 += 1
    end)

    local function verificationError(id: string?, str2: string, subscription: boolean, cause) -- Luacid: Inlined by compiler; 2 call sites recovered
        return {
            outcome = "unverified",
            errorMessage = `The Developer Subscription request could not be confirmed: {str2}. ` .. "Do not automatically retry the write; inspect existing subscriptions first.",
            subscription = subscription or id ~= nil and { id = id } or nil,
            cause = cause
        }
    end

    local function failedError(id: string?, str2: string, cause)
        return {
            outcome = "failed",
            errorMessage = `The Developer Subscription request was rejected: {str2}.`,
            subscription = id ~= nil and { id = id } or nil,
            cause = cause
        }
    end

    local function captureMutationToken() -- Luacid: Inlined by compiler; 2 call sites recovered
        local userId = getLocalPlayerUserId()
        if userId ~= nil then
            return { generation = num1, userId = userId }, nil
        end

        return nil, {
            outcome = "failed",
            errorMessage = "The Developer Subscription request was rejected: a signed-in local user is required.",
            subscription = nil,
            cause = nil
        }
    end
    local function isTokenCurrent(tbl4): boolean -- Luacid: Inlined by compiler; 11 call sites recovered
        local bool2 = not bool1
        return bool2 and tbl4.generation == num1 and tbl4.userId == getLocalPlayerUserId()
    end

    local function currentTokenError(tbl4) -- Luacid: Inlined by compiler; 10 call sites recovered
        return if isTokenCurrent(tbl4) then nil else var1
    end

    local function refreshInventory(num2: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool1 then
            return
        end

        if FFlagBuildExperienceMonetizationManageKinds then
            singleEntityResolver.refetch(num2)
            return
        end
        singleEntityResolver.clear()
        singleEntityResolver.fetch(num2)
    end

    local function mutationResult(arg1, str1: string?) -- Luacid: unused: defined but never referenced
        return arg1:andThen(function(arg2)
            if arg2.success then
                return assert(arg2.subscription, "A successful Developer Subscription mutation must return its identity")
            end

            local reject = Promise.reject
            local func1 = failedError
            local var3 = str1
            local failureReason = arg2.failureReason
            return reject((func1(var3, `the service returned failureReason {tostring(failureReason)}`, arg2)))
        end, function(cause)
            if typeof(cause) == "table"
                and cause.responseCode ~= nil
                and cause.responseCode >= StatusCodes.BAD_REQUEST
                and cause.responseCode < StatusCodes.INTERNAL_SERVER_ERROR
                and cause.responseCode ~= StatusCodes.REQUEST_TIMEOUT
            then
                return Promise.reject((failedError(str1, cause.errorMessage or "the service rejected the write", cause)))
            end

            local reject = Promise.reject
            local id = str1
            return reject({
                outcome = "unverified",
                errorMessage = "The Developer Subscription request could not be confirmed: the write outcome is unknown. Do not automatically retry the write; inspect existing subscriptions first.",
                subscription = id ~= nil and { id = id } or nil,
                cause = cause
            })
        end)
    end
    local function verifyRead(tbl4, func1: (...any) -> (...any), func2: (...any) -> (...any), str1: string, id: string)
        local cause = currentTokenError(tbl4)

        if cause ~= nil then
            return Promise.reject({
                outcome = "unverified",
                errorMessage = "The Developer Subscription request could not be confirmed: the local user changed during readback. Do not automatically retry the write; inspect existing subscriptions first.",
                subscription = id ~= nil and { id = id } or nil,
                cause = cause
            })
        end

        return func1():andThen(function(subscription)
            local var3 = currentTokenError(tbl4)
            if var3 == nil then
                if func2(subscription) then
                    return subscription
                end

                return Promise.reject(verificationError(id, str1, subscription, nil))
            end

            local reject = Promise.reject
            local str2 = id
            return reject({
                outcome = "unverified",
                errorMessage = "The Developer Subscription request could not be confirmed: the local user changed during readback. Do not automatically retry the write; inspect existing subscriptions first.",
                subscription = str2 ~= nil and { id = str2 } or nil,
                cause = var3
            })
        end, function(cause2)
            if cause2 ~= var1 and currentTokenError(tbl4) == nil then
                return Promise.reject((verificationError(id, str1, false, cause2)))
            end

            local reject = Promise.reject
            local str2 = id
            return reject({
                outcome = "unverified",
                errorMessage = "The Developer Subscription request could not be confirmed: the local user changed during readback. Do not automatically retry the write; inspect existing subscriptions first.",
                subscription = str2 ~= nil and { id = str2 } or nil,
                cause = cause2
            })
        end)
    end
    local function tokenBoundGet(tbl4, num2: number, str1: string)
        local var3 = currentTokenError(tbl4)

        if var3 ~= nil then
            return Promise.reject(var3)
        end
        return fetchDeveloperSubscription.get(num2, str1, tbl3):andThen(function(arg1)
            local var4 = currentTokenError(tbl4)
            if var4 ~= nil then
                return (Promise.reject(var4))
            end

            return arg1
        end)
    end

    local function withMutationPreflight(num2: number, str1: string, func1: (...any) -> (...any))
        local userId = getLocalPlayerUserId()
        local tbl4, var3

        if userId == nil then
            tbl4 = nil
            var3 = {
                outcome = "failed",
                errorMessage = "The Developer Subscription request was rejected: a signed-in local user is required.",
                subscription = nil,
                cause = nil
            }
        else
            tbl4 = { generation = num1, userId = userId }
            var3 = nil
        end

        if tbl4 == nil then
            return Promise.reject(var3)
        end
        return tokenBoundGet(tbl4, num2, str1):andThen(function(arg1)
            local var4 = currentTokenError(tbl4)
            if var4 ~= nil then
                return Promise.reject((failedError(str1, var4.errorMessage, var4)))
            end
            return func1(tbl4, arg1)
        end, function(cause)
            local var4 = if typeof(cause) ~= "table" or typeof(cause.errorMessage) ~= "string" then "the subscription could not be read before the write" else cause.errorMessage

            return Promise.reject((failedError(str1, var4, cause)))
        end)
    end

    local function runMutation(tbl4, str1: string?, func1: (...any) -> (...any))
        local var3 = currentTokenError(tbl4)

        if var3 ~= nil then
            return Promise.reject((failedError(str1, var3.errorMessage, var3)))
        end

        return func1():andThen(function(cause)
            if cause.success then
                return assert(cause.subscription, "A successful Developer Subscription mutation must return its identity")
            end

            local reject = Promise.reject
            local func2 = failedError
            local var4 = str1
            local failureReason = cause.failureReason
            return reject((func2(var4, `the service returned failureReason {tostring(failureReason)}`, cause)))
        end, function(cause)
            if typeof(cause) == "table"
                and cause.responseCode ~= nil
                and cause.responseCode >= StatusCodes.BAD_REQUEST
                and cause.responseCode < StatusCodes.INTERNAL_SERVER_ERROR
                and cause.responseCode ~= StatusCodes.REQUEST_TIMEOUT
            then
                return Promise.reject((failedError(str1, cause.errorMessage or "the service rejected the write", cause)))
            end

            local reject = Promise.reject
            local id = str1
            return reject({
                outcome = "unverified",
                errorMessage = "The Developer Subscription request could not be confirmed: the write outcome is unknown. Do not automatically retry the write; inspect existing subscriptions first.",
                subscription = id ~= nil and { id = id } or nil,
                cause = cause
            })
        end):andThen(function(subscription)
            local cause = currentTokenError(tbl4)
            if cause == nil then
                return subscription
            end

            local reject = Promise.reject

            local id = str1
            return (reject({
                outcome = "unverified",
                errorMessage = "The Developer Subscription request could not be confirmed: the local user changed after the write. Do not automatically retry the write; inspect existing subscriptions first.",
                subscription = subscription or id ~= nil and { id = id } or nil,
                cause = cause
            }))
        end)
    end
    local function reconcileMutation(num2: number, arg1)
        return arg1:andThen(function<T>(arg2: T): T
            refreshInventory(num2)
            return arg2
        end, function(arg2)
            if typeof(arg2) == "table" and arg2.outcome == "unverified" then
                refreshInventory(num2)
            end
            return Promise.reject(arg2)
        end)
    end

    local tbl4 = {
        "description",
        "basePriceId",
        "currencyType",
        "priceInRobux",
        "isRegionalPricingEnabled"
    }

    local function readBackMutation(tbl5, num2: number, str1: string, arg1, bool2: boolean, bool3: boolean?)
        return tokenBoundGet(tbl5, num2, str1):andThen(function(subscription)
            if bool2 then
                local var3 = arg1
                if subscription.name ~= var3.name then
                    local reject = Promise.reject
                    local id = str1
                    return reject({
                        outcome = "unverified",
                        errorMessage = "The Developer Subscription request could not be confirmed: the stored name does not match. Do not automatically retry the write; inspect existing subscriptions first.",
                        subscription = subscription or id ~= nil and { id = id } or nil,
                        cause = nil
                    })
                end

                if subscription.productType ~= var3.productType then
                    local reject = Promise.reject
                    local id = str1
                    return reject({
                        outcome = "unverified",
                        errorMessage = "The Developer Subscription request could not be confirmed: the stored product type does not match. Do not automatically retry the write; inspect existing subscriptions first.",
                        subscription = subscription or id ~= nil and { id = id } or nil,
                        cause = nil
                    })
                end
                if subscription.productStatusType ~= DeveloperSubscriptionTypes.ProductStatusType.Inactive then
                    local reject = Promise.reject
                    local id = str1
                    return reject({
                        outcome = "unverified",
                        errorMessage = "The Developer Subscription request could not be confirmed: the new subscription is not inactive. Do not automatically retry the write; inspect existing subscriptions first.",
                        subscription = subscription or id ~= nil and { id = id } or nil,
                        cause = nil
                    })
                end
            end
            for _, value in tbl4 do
                local bool4 = bool3 == true and value == "description"

                if bool4 or arg1[value] == nil or subscription[value] == arg1[value] then
                    continue
                end

                local reject = Promise.reject
                local id = str1
                return reject({
                    outcome = "unverified",
                    errorMessage = `The Developer Subscription request could not be confirmed: {`the stored {value} does not match`}. ` .. "Do not automatically retry the write; inspect existing subscriptions first.",
                    subscription = subscription or id ~= nil and { id = id } or nil,
                    cause = nil
                })
            end

            return subscription
        end, function(cause)
            if cause == var1 or currentTokenError(tbl5) ~= nil then
                local reject = Promise.reject
                local id = str1
                return reject({
                    outcome = "unverified",
                    errorMessage = "The Developer Subscription request could not be confirmed: the local user changed during readback. Do not automatically retry the write; inspect existing subscriptions first.",
                    subscription = id ~= nil and { id = id } or nil,
                    cause = cause
                })
            end
            local reject = Promise.reject
            local id = str1
            return reject({
                outcome = "unverified",
                errorMessage = "The Developer Subscription request could not be confirmed: the authoritative readback failed. Do not automatically retry the write; inspect existing subscriptions first.",
                subscription = id ~= nil and { id = id } or nil,
                cause = cause
            })
        end)
    end
    local function describeError(cause) -- Luacid: Inlined by compiler; 1 call site recovered
        if typeof(cause) == "table" and typeof(cause.errorMessage) == "string" then
            return cause.errorMessage
        end

        return tostring(cause)
    end

    local function imageBlocker(id: string, cause) -- Luacid: Inlined by compiler; 2 call sites recovered
        local productStatusType = cause.productStatusType

        if productStatusType == DeveloperSubscriptionTypes.ProductStatusType.Inactive
            or productStatusType == DeveloperSubscriptionTypes.ProductStatusType.Active
            or productStatusType == DeveloperSubscriptionTypes.ProductStatusType.OffSale
        then
            return nil
        end

        return {
            outcome = "failed",
            errorMessage = "The Developer Subscription request was rejected: images can only be changed while a subscription is in a stable state.",
            subscription = id ~= nil and { id = id } or nil,
            cause = cause
        }
    end

    local function sendImage(tbl5, num2: number, str1: string, imageAssetId: number?, arg1)
        return runMutation(tbl5, str1, function()
            return fetchDeveloperSubscription.uploadImage(num2, str1, tbl5.userId, arg1, tbl3)
        end):andThen(function()
            return verifyRead(tbl5, function()
                return tokenBoundGet(tbl5, num2, str1)
            end, function(arg2): boolean
                return not (arg2.imageAssetId == nil or not (arg2.imageAssetId > 0)) and arg2.imageAssetId ~= imageAssetId
            end, "the uploaded image did not appear in authoritative reads", str1)
        end)
    end

    local function attachImage(tbl5, num2: number, arg1, imageFile, str1: string, str2: string)
        local var3 = imageBlocker(arg1.id, arg1)
        local var4 = if var3 ~= nil then Promise.reject(var3) else sendImage(tbl5, num2, arg1.id, arg1.imageAssetId, imageFile)

        return var4:catch(function(cause)
            local subscription = if typeof(cause) == "table" and cause.outcome == "unverified" and cause.subscription ~= nil then cause.subscription else arg1
            local reject = Promise.reject

            local str3 = str1
            local var6 = describeError(cause)
            return reject({
                outcome = "unverified",
                errorMessage = `{str3}, but its image could not be attached: {var6} {str2}`,
                subscription = subscription,
                cause = cause
            })
        end)
    end

    local function uploadImage(num2: number, str1: string, arg1)
        local var3 = withMutationPreflight(num2, str1, function(arg2, cause)
            local var3 = imageBlocker(str1, cause)
            if var3 ~= nil then
                return Promise.reject(var3)
            end
            return sendImage(arg2, num2, str1, cause.imageAssetId, arg1)
        end)
        return reconcileMutation(num2, var3)
    end

    return {
        getSubscriptions = singleEntityResolver.get,
        fetchSubscriptions = singleEntityResolver.fetch,
        getAndFetchSubscriptions = singleEntityResolver.getAndFetch,
        getAccountResetGeneration = singleEntityResolver.getAccountResetGeneration,
        getPermission = function(num2: number)
            return fetchDeveloperSubscription.getPermission(num2, tbl3)
        end,
        getPrices = function(num2: number)
            return fetchDeveloperSubscription.getPrices(num2, tbl3)
        end,
        list = function(num2: number)
            return fetchDeveloperSubscription.list(num2, tbl3)
        end,
        get = function(num2: number, str1: string)
            return fetchDeveloperSubscription.get(num2, str1, tbl3)
        end,
        create = function(num2: number, arg1)
            local var3, var4 = captureMutationToken()

            if var3 == nil then
                return Promise.reject(var4)
            end
            local var5 = runMutation(var3, nil, function()
                return fetchDeveloperSubscription.create(num2, arg1, tbl3)
            end):andThen(function(arg2)
                return readBackMutation(var3, num2, arg2.id, arg1, true):andThen(function(arg3)
                    local imageFile = arg1.imageFile
                    if imageFile == nil then
                        return arg3
                    end
                    return attachImage(
                        var3,
                        num2,
                        arg3,
                        imageFile,
                        "The subscription was created and is inactive",
                        "Do not create it again. Retry only the image with an update action."
                    )
                end)
            end)
            return reconcileMutation(num2, var5)
        end,
        update = function(num2: number, str1: string, arg1, arg2)
            local imageFile = arg1.imageFile
            if imageFile ~= nil then
                local bool2 = false
                for _, value in tbl4 do
                    if arg1[value] ~= nil then
                        bool2 = true
                        break
                    end
                end

                if not bool2 then
                    return uploadImage(num2, str1, imageFile)
                end
            end

            local var3, var4 = captureMutationToken()

            if var3 == nil then
                return Promise.reject(var4)
            end
            local var5 = runMutation(var3, str1, function()
                return fetchDeveloperSubscription.update(num2, str1, arg1, tbl3)
            end):andThen(function()
                local func1 = readBackMutation
                local var5 = var3
                local num3 = num2
                local str2 = str1
                local var6 = arg1
                local bool2 = false
                local bool3 = not (arg2 == nil) and arg2.acceptModeratedText == true

                return func1(var5, num3, str2, var6, bool2, bool3):andThen(function(arg3)
                    if imageFile == nil then
                        return arg3
                    end
                    return attachImage(var3, num2, arg3, imageFile, "The subscription fields were updated", "Retry only the image.")
                end)
            end)

            return reconcileMutation(num2, var5)
        end,
        uploadImage = uploadImage,
        activate = function(num2: number, str1: string)
            local var3 = withMutationPreflight(num2, str1, function(arg1, cause)
                if cause.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.Inactive
                    or cause.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.OffSale
                then
                    return runMutation(arg1, str1, function()
                        return fetchDeveloperSubscription.activate(num2, str1, tbl3)
                    end):andThen(function()
                        return verifyRead(arg1, function()
                            return tokenBoundGet(arg1, num2, str1)
                        end, function(arg2): boolean
                            return arg2.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.Active
                        end, "the subscription did not become active", str1)
                    end)
                end

                local reject = Promise.reject
                local id = str1
                return reject({
                    outcome = "failed",
                    errorMessage = "The Developer Subscription request was rejected: only an inactive or off-sale subscription can be activated.",
                    subscription = id ~= nil and { id = id } or nil,
                    cause = cause
                })
            end)
            return reconcileMutation(num2, var3)
        end,
        deactivate = function(num2: number, id: string, bool2: boolean)
            if typeof(bool2) ~= "boolean" then
                return Promise.reject({
                    outcome = "failed",
                    errorMessage = "The Developer Subscription request was rejected: cancelRenewals must be chosen explicitly.",
                    subscription = id ~= nil and { id = id } or nil,
                    cause = nil
                })
            end

            local var3 = withMutationPreflight(num2, id, function(arg1, cause)
                if not bool2 and cause.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.OffSale then
                    return Promise.resolve(cause)
                end

                if cause.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.Active
                    or bool2 and cause.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.OffSale
                then
                    return runMutation(arg1, id, function()
                        return fetchDeveloperSubscription.deactivate(num2, id, bool2, tbl3)
                    end):andThen(function()
                        return verifyRead(arg1, function()
                            return tokenBoundGet(arg1, num2, id)
                        end, function(arg2): boolean
                            if bool2 then
                                return arg2.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.ToBeDeactivated
                                    or arg2.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.Inactive
                            end

                            return arg2.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.OffSale
                        end, if bool2 then "the subscription did not begin deactivation" else "the subscription did not go off sale", id)
                    end)
                end

                local reject = Promise.reject

                local str1 = id
                return reject({
                    outcome = "failed",
                    errorMessage = "The Developer Subscription request was rejected: the subscription cannot be deactivated from its current state.",
                    subscription = str1 ~= nil and { id = str1 } or nil,
                    cause = cause
                })
            end)

            return reconcileMutation(num2, var3)
        end,
        delete = function(num2: number, str1: string)
            local var3 = withMutationPreflight(num2, str1, function(arg1, cause)
                if cause.productStatusType ~= DeveloperSubscriptionTypes.ProductStatusType.Inactive then
                    local str2 = if cause.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.ToBeDeactivated then "Wait for the subscription to become inactive before deleting it" else "Deactivate the subscription and wait for it to become inactive before deleting it"

                    return Promise.reject((failedError(str1, str2, cause)))
                end
                return runMutation(arg1, str1, function()
                    return fetchDeveloperSubscription.delete(num2, str1, tbl3)
                end):andThen(function()
                    return tokenBoundGet(arg1, num2, str1):andThen(function(subscription)
                        if subscription.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.ToBeDeleted
                            or subscription.productStatusType == DeveloperSubscriptionTypes.ProductStatusType.Deleted
                        then
                            return subscription
                        end

                        local reject = Promise.reject
                        local id = str1
                        return reject({
                            outcome = "unverified",
                            errorMessage = "The Developer Subscription request could not be confirmed: the subscription did not enter a deletion state. Do not automatically retry the write; inspect existing subscriptions first.",
                            subscription = subscription or id ~= nil and { id = id } or nil,
                            cause = nil
                        })
                    end, function(cause2)
                        if cause2 == var1 or currentTokenError(arg1) ~= nil then
                            local reject = Promise.reject

                            local id = str1
                            return reject({
                                outcome = "unverified",
                                errorMessage = "The Developer Subscription request could not be confirmed: the local user changed during deletion readback. Do not automatically retry the write; inspect existing subscriptions first.",
                                subscription = id ~= nil and { id = id } or nil,
                                cause = cause2
                            })
                        end

                        if typeof(cause2) == "table" and cause2.responseCode == StatusCodes.NOT_FOUND then
                            return nil
                        end
                        local reject = Promise.reject
                        local id = str1
                        return reject({
                            outcome = "unverified",
                            errorMessage = "The Developer Subscription request could not be confirmed: the deletion readback failed. Do not automatically retry the write; inspect existing subscriptions first.",
                            subscription = id ~= nil and { id = id } or nil,
                            cause = cause2
                        })
                    end)
                end)
            end)

            return reconcileMutation(num2, var3)
        end,
        clear = function()
            singleEntityResolver.clear()
        end,
        dispose = function()
            bool1 = true
            num1 += 1
            var2()
            singleEntityResolver.dispose()
        end
    }
end
return createDeveloperSubscriptionStore
