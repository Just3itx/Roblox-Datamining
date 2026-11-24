-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)

local FFlagBuildExperienceMonetizationManageKinds = require(DataHydration.Flags.FFlagBuildExperienceMonetizationManageKinds)
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)
local DataHydrationUtils = require(DataHydration.DataHydrationUtils)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local getGamePassConfigStore = require(DataHydration.GamePassConfig.getGamePassConfigStore)
local _GamePassConfigTypes = require(DataHydration.GamePassConfig.GamePassConfigTypes)
local fetchMonetizationOptions = require(script.Parent.fetchMonetizationOptions)
local _MonetizationOptionsTypes = require(script.Parent.MonetizationOptionsTypes)

local error = table.freeze({ errorMessage = "The local user changed while the bulk Game Pass request was running" })

local function updateEntryPoint(arg1, isEnabled: boolean)
    local var2 = table.clone(arg1)
    local entryPoints = {}
    local bool1 = false
    for _, value in arg1.entryPoints or {} do
        local var3 = table.clone(value)
        if var3.name == "InExperienceGlobalIconEnabled" then
            var3.isEnabled = isEnabled
            bool1 = true
        end

        table.insert(entryPoints, var3)
    end
    if not bool1 then
        table.insert(entryPoints, { name = "InExperienceGlobalIconEnabled", isEnabled = isEnabled })
    end

    var2.entryPoints = entryPoints
    return var2
end

local function createMonetizationOptionsStore(tbl1)
    local tbl2 = tbl1 or {}
    local function logError(str1: string, arg1)
        if tbl2.logError ~= nil then
            tbl2.logError(str1, arg1)
            return
        end

        if typeof(arg1) == "table" then
            local warn = warn
            local str2 = tostring(arg1.responseCode)
            local errorMessage = arg1.errorMessage
            warn(`[MonetizationOptions] {str1} request failed (responseCode={str2}): {tostring(errorMessage)}`)
        else
            warn(`[MonetizationOptions] {str1} request failed: {tostring(arg1)}`)
        end
    end

    local tbl3 = {
        network = tbl2.network,
        readNetwork = tbl2.readNetwork,
        mutatingNetwork = tbl2.mutatingNetwork,
        baseUrl = tbl2.baseUrl,
        groupsBaseUrl = tbl2.groupsBaseUrl
    }
    local getLocalPlayerUserId = tbl2.getLocalPlayerUserId or DataHydrationUtils.getLocalPlayerUserId
    local observeLocalPlayerUserId = tbl2.observeLocalPlayerUserId or DataHydrationUtils.observeLocalPlayerUserId
    local bool1 = false
    local num1 = 0
    local var2 = observeLocalPlayerUserId(function()
        num1 += 1
    end)

    local function captureMutationToken()
        local userId = getLocalPlayerUserId()
        if userId == nil then
            return nil, {
                outcome = "failed",
                errorMessage = "A signed-in local user is required for bulk Game Pass mutations."
            }
        end

        return { generation = num1, userId = userId }, nil
    end

    local function isTokenCurrent(tbl4): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        local bool2 = not bool1
        return bool2 and tbl4.generation == num1 and tbl4.userId == getLocalPlayerUserId()
    end
    local function isShopQueueCurrent(tbl4): boolean -- Luacid: Inlined by compiler; 9 call sites recovered
        local bool2 = not bool1
        return bool2 and tbl4.generation == num1 and tbl4.userId == getLocalPlayerUserId()
    end

    local function bulkFetchOptions(tbl4)
        return {
            network = tbl3.network,
            readNetwork = tbl3.readNetwork,
            mutatingNetwork = tbl3.mutatingNetwork,
            baseUrl = tbl3.baseUrl,
            groupsBaseUrl = tbl3.groupsBaseUrl,
            isRequestCurrent = function(): boolean
                return (isTokenCurrent(tbl4))
            end
        }
    end

    local function guardBulkGamePassResult(tbl4, arg1) -- Luacid: unused: defined but never referenced
        return arg1:andThen(function(arg2)
            if isTokenCurrent(tbl4) then
                return arg2
            end
            local tbl5 = {
                errors = arg2.errors,
                results = {}
            }

            for _, result in arg2.results do
                local var3 = table.clone(result)
                if result.status ~= "failed" then
                    var3.status = "unverified"
                    var3.reason = "session_changed"
                    var3.config = nil
                    var3.error = error
                end
                table.insert(tbl5.results, var3)
            end
            return tbl5
        end)
    end

    local function runBulkGamePassMutation(tbl4, func1: (...any) -> (...any))
        if #tbl4 == 0 then
            return func1(tbl3), nil
        end
        local var3, var4 = captureMutationToken()
        if var3 == nil then
            return Promise.reject(var4), nil
        end

        return func1((bulkFetchOptions(var3))):andThen(function(arg1)
            if isTokenCurrent(var3) then
                return arg1
            end
            local tbl5 = {
                errors = arg1.errors,
                results = {}
            }

            for _, result in arg1.results do
                local var5 = table.clone(result)
                if result.status ~= "failed" then
                    var5.status = "unverified"
                    var5.reason = "session_changed"
                    var5.config = nil
                    var5.error = error
                end
                table.insert(tbl5.results, var5)
            end
            return tbl5
        end), var3
    end
    local tbl4 = ({})
    local tbl5 = ({})

    local singleEntityResolver = createSingleEntityResolver(function(num2: number)
        return fetchMonetizationOptions.getManagedPricing(num2, tbl3)
    end, {
        resolver = {
            replaceItems = true,
            logError = function(arg1)
                logError("managed_pricing", arg1)
            end
        }
    })

    local singleEntityResolver2 = createSingleEntityResolver(function(num2: number)
        return fetchMonetizationOptions.listShops(num2, tbl3)
    end, {
        resolver = {
            replaceItems = true,
            logError = function(arg1)
                logError("shops", arg1)
            end
        }
    })
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        logError = function(arg1)
            logError("permission", arg1)
        end,
        fetchFn = function(str1: string, _)
            local var3 = tbl4[str1]
            assert(var3 ~= nil, "Permission context must be set before fetching")
            return fetchMonetizationOptions.getMonetizationPermission(var3.universeId, var3.creatorType, var3.creatorTargetId, tbl3)
        end
    })

    local function permissionKey(universeId: number, creatorType, creatorTargetId: number?): string -- Luacid: Inlined by compiler; 2 call sites recovered
        local str1 = `{universeId}:{creatorType}:{creatorTargetId or 0}`
        tbl4[str1] = {
            universeId = universeId,
            creatorType = creatorType,
            creatorTargetId = creatorTargetId
        }
        return str1
    end

    local function acceptManagedPricing(num2: number) -- Luacid: Inlined by compiler; 1 call site recovered
        return fetchMonetizationOptions.acceptManagedPricing(num2, tbl3):andThen(function<T>(arg1: T): T
            singleEntityResolver.update(num2, { status = "Accepted" })
            return arg1
        end)
    end

    local function readBackShops(num2: number, arg1, tbl6)
        if tbl6 ~= nil and (tbl5[num2] ~= tbl6 or not isShopQueueCurrent(tbl6)) then
            return Promise.reject({ kind = "unverified", error = "Shop write session changed" })
        end
        return fetchMonetizationOptions.listShops(num2, tbl3):andThen(function(arg2)
            if tbl6 ~= nil and (tbl5[num2] ~= tbl6 or not isShopQueueCurrent(tbl6)) then
                return Promise.reject({ kind = "unverified", error = "Shop write was reset" })
            end
            singleEntityResolver2.update(num2, arg2)
            return arg2
        end):catch(function(error2)
            if tbl6 ~= nil and (tbl5[num2] ~= tbl6 or not isShopQueueCurrent(tbl6)) then
                return Promise.reject({ kind = "unverified", error = error2 })
            end

            logError("shops_readback", error2)
            if tbl6 == nil or not tbl6.overlapped then
                return arg1
            end

            if tbl5[num2] == tbl6 then
                singleEntityResolver2.cache.markItemsAsFailed({ tostring(num2) })
            end
            return Promise.reject({ kind = "unverified", error = error2 })
        end)
    end

    local function performShopGlobalIcon(num2: number, isEnabled: boolean, tbl6)
        if tbl5[num2] ~= tbl6 or not isShopQueueCurrent(tbl6) then
            return Promise.reject({ kind = "unverified", error = "Shop write was reset" })
        end
        local var3 = singleEntityResolver2.get(num2).data(false)
        local shops = if var3 == nil then nil else var3.shops
        local shop = if shops == nil then nil else shops[1]

        if shop == nil then
            return fetchMonetizationOptions.createShop(num2, isEnabled, tbl3):andThen(function(arg1)
                local tbl7 = {
                    shops = { (updateEntryPoint({ shopId = arg1.shopId, entryPoints = {} }, isEnabled)) }
                }

                if tbl5[num2] ~= tbl6 or not isShopQueueCurrent(tbl6) then
                    return Promise.reject({ kind = "unverified", error = "Shop write was reset" })
                end
                singleEntityResolver2.update(num2, tbl7)
                return readBackShops(num2, tbl7, tbl6)
            end, function(error2)
                if tbl5[num2] ~= tbl6 or not isShopQueueCurrent(tbl6) then
                    return Promise.reject({ kind = "unverified", error = error2 })
                end
                return Promise.reject(error2)
            end)
        end

        local var4 = assert(var3, "Shop data must exist before an optimistic update")
        local var1 = table.clone(var4.shops or {})
        var1[1] = updateEntryPoint(shop, isEnabled)
        local tbl7 = { shops = var1 }

        singleEntityResolver2.update(num2, tbl7)

        return fetchMonetizationOptions.setShopGlobalIcon(shop.shopId, isEnabled, tbl3):andThen(function()
            if not isShopQueueCurrent(tbl6) then
                return Promise.reject({ kind = "unverified", error = "Shop write session changed" })
            end
            return readBackShops(num2, tbl7, tbl6)
        end, function(error2)
            if tbl5[num2] ~= tbl6 or not isShopQueueCurrent(tbl6) then
                return Promise.reject({ kind = "unverified", error = error2 })
            end
            singleEntityResolver2.update(num2, var4)
            return Promise.reject(error2)
        end)
    end

    local function refreshGamePassInventory(num2: number, tbl6, arg1, tbl7)
        if #tbl6 == 0 then
            return arg1
        end
        return arg1:andThen(function(arg2)
            if tbl7 == nil or not isTokenCurrent(tbl7) then
                return arg2
            end
            local bool2 = false
            for _, result in arg2.results do
                if result.status ~= "failed" then
                    bool2 = true
                    break
                end
            end

            if not bool2 then
                return arg2
            end

            local var3 = (if tbl2.getGamePassConfigStore ~= nil then tbl2.getGamePassConfigStore else getGamePassConfigStore)()
            if FFlagBuildExperienceMonetizationManageKinds then
                var3.refetchGamePasses(num2)
            else
                var3.clear()
                var3.fetchGamePasses(num2)
            end
            return arg2
        end)
    end

    return {
        getManagedPricing = singleEntityResolver.get,
        fetchManagedPricing = singleEntityResolver.fetch,
        getAndFetchManagedPricing = singleEntityResolver.getAndFetch,
        getShops = singleEntityResolver2.get,
        fetchShops = singleEntityResolver2.fetch,
        getAndFetchShops = singleEntityResolver2.getAndFetch,
        getAndFetchPermission = function(universeId: number, creatorType, creatorTargetId: number?)
            return dataResolver.getAndFetchItem((permissionKey(universeId, creatorType, creatorTargetId)))
        end,
        fetchPermission = function(universeId: number, creatorType, creatorTargetId: number?)
            return dataResolver.fetchItem((permissionKey(universeId, creatorType, creatorTargetId)))
        end,
        acceptManagedPricing = acceptManagedPricing,
        ensureManagedPricingAccepted = function(num2: number)
            return fetchMonetizationOptions.getManagedPricing(num2, tbl3):andThen(function(arg1)
                singleEntityResolver.update(num2, arg1)
                if arg1.status == "Accepted" then
                    return true
                elseif arg1.status == "Disabled" then
                    return Promise.reject("Managed pricing is not available for this experience.")
                end

                return acceptManagedPricing(num2):andThen(function(): boolean
                    return true
                end)
            end)
        end,
        updateDeveloperProductsManagedPricing = function(arg1, arg2, arg3)
            return fetchMonetizationOptions.updateDeveloperProductsManagedPricing(arg1, arg2, arg3, tbl3)
        end,
        updateGamePassesManagedPricing = function(arg1, arg2, arg3)
            return refreshGamePassInventory(arg1, arg2, runBulkGamePassMutation(arg2, function(arg4)
                return fetchMonetizationOptions.updateGamePassesManagedPricing(arg1, arg2, arg3, arg4)
            end))
        end,
        updateGamePassesArchived = function(arg1, arg2, arg3)
            return refreshGamePassInventory(arg1, arg2, runBulkGamePassMutation(arg2, function(arg4)
                return fetchMonetizationOptions.updateGamePassesArchived(arg1, arg2, arg3, arg4)
            end))
        end,
        setShopGlobalIcon = function(num2: number, isEnabled: boolean)
            local var3 = tbl5[num2]

            if var3 ~= nil and not isShopQueueCurrent(var3) then
                tbl5[num2] = nil
            end
            local tbl6 = tbl5[num2]
            if tbl6 == nil then
                tbl6 = {
                    tail = Promise.resolve(),
                    pending = 0,
                    overlapped = false,
                    generation = num1,
                    userId = getLocalPlayerUserId()
                }
                tbl5[num2] = tbl6
            end
            if tbl6.pending > 0 then
                tbl6.overlapped = true
            end
            local pending = tbl6.pending + 1
            tbl6.pending = pending
            local var5 = tbl6.tail:andThen(function()
                return performShopGlobalIcon(num2, isEnabled, tbl6)
            end)
            local tail = var5:andThen(function()
                local var6 = tbl6
                var6.pending -= 1
                if tbl6.pending == 0 and tbl5[num2] == tbl6 then
                    tbl5[num2] = nil
                end
            end, function()
                local var6 = tbl6
                var6.pending -= 1
                if tbl6.pending == 0 and tbl5[num2] == tbl6 then
                    tbl5[num2] = nil
                end
            end)

            tbl6.tail = tail

            return var5
        end,
        clear = function()
            singleEntityResolver.clear()
            singleEntityResolver2.clear()
            dataResolver.clear()
            table.clear(tbl4)
            table.clear(tbl5)
        end,
        dispose = function()
            bool1 = true
            num1 += 1
            var2()
            singleEntityResolver.dispose()
            singleEntityResolver2.dispose()
            dataResolver.dispose()
            table.clear(tbl4)
            table.clear(tbl5)
        end
    }
end
return createMonetizationOptionsStore
