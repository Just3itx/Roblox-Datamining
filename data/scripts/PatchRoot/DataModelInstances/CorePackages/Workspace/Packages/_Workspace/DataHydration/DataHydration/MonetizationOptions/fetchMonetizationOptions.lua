-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)
local Http = require(DataHydrationParent.Http)
local StatusCodes = Http.StatusCodes
local Promise = require(DataHydrationParent.Promise)
local t = require(DataHydrationParent.t)
local UrlBuilder = require(DataHydrationParent.UrlBuilder)
local creatorApiHttp = require(DataHydration.creatorApiHttp)
local _MonetizationOptionsTypes = require(script.Parent.MonetizationOptionsTypes)
local fetchGamePassConfig = require(DataHydration.GamePassConfig.fetchGamePassConfig)
local _GamePassConfigTypes = require(DataHydration.GamePassConfig.GamePassConfigTypes)

local var1 = t.interface({ status = t.union(t.literal("Disabled"), t.literal("Pending"), t.literal("Accepted")) })

local error = t.interface({
    errorCode = t.optional(t.string),
    errorMessage = t.optional(t.string),
    field = t.optional(t.string),
    hint = t.optional(t.string)
})
local var3 = t.interface({ productId = t.integer, error = error })

local var4 = t.interface({ errors = t.array(var3) })

local var5 = t.interface({ gamePassId = t.integer, error = error })

local var6 = t.interface({ errors = t.array(var5) })

local var7 = t.interface({ name = t.string, isEnabled = t.boolean })

local var8 = t.interface({ shopId = t.integer, entryPoints = t.array(var7) })

local var9 = t.interface({ shopId = t.integer, status = t.union(t.literal("Draft"), t.literal("Active")) })

local var10 = t.interface({ shops = t.array(var8) })

local var11 = t.interface({ createdCategories = t.array(t.table) })

local var12 = t.interface({ monetizeExperience = t.boolean })

local var13 = t.interface(
    {
        status = t.union(t.literal("Invalid"), t.literal("NotMigrated"), t.literal("Migrating"), t.literal("Migrated"))
    }
)
local var14 = t.interface({ permissions = t.optional(t.map(t.string, t.boolean)) })

local function validateResponse<T>(str1: string, func1: (...any) -> (...any), arg1: T): T -- Luacid: unused: defined but never referenced
    local var15, var16 = func1(arg1)
    assert(var15, `Invalid {str1} response: {tostring(var16)}`)
    return arg1
end

local function decodeManagedPricingResponse<T>(arg1: T): T
    local var15, var16 = var1(arg1)
    assert(var15, `Invalid Managed Pricing response: {tostring(var16)}`)
    return arg1
end

local function decodeBulkDeveloperProductUpdateResponse<T>(arg1: T): T
    local var15, var16 = var4(arg1)
    assert(var15, `Invalid bulk developer product update response: {tostring(var16)}`)
    return arg1
end

local function decodeBulkGamePassUpdateResponse(tbl1, arg1)
    local var15, var16 = var6(arg1)
    assert(var15, `Invalid bulk Game Pass update response: {tostring(var16)}`)

    local tbl2 = {}
    for _, error in arg1.errors do
        assert(tbl1[error.gamePassId], "Bulk Game Pass update error has an unexpected ID")
        assert(not tbl2[error.gamePassId], "Bulk Game Pass update error has a duplicate ID")
        tbl2[error.gamePassId] = true
    end
    return arg1
end

local function decodeCreatedShop<T>(arg1: T): T
    local var15, var16 = var9(arg1)
    assert(var15, `Invalid created Shop response: {tostring(var16)}`)
    return arg1
end

local function decodeShopListResponse<T>(arg1: T): T
    local var15, var16 = var10(arg1)
    assert(var15, `Invalid Shop list response: {tostring(var16)}`)
    return arg1
end

local function decodeUniversePermissionResponse(arg1)
    local var15, var16 = var12(arg1)
    assert(var15, `Invalid universe permission response: {tostring(var16)}`)

    return {
        canMonetize = arg1.monetizeExperience
    }
end

local function decodeGroupMigrationResponse<T>(arg1: T): T
    local var15, var16 = var13(arg1)
    assert(var15, `Invalid group migration response: {tostring(var16)}`)
    return arg1
end

local function decodeGroupPermissionResponse(arg1)
    local var15, var16 = var14(arg1)
    assert(var15, `Invalid group permission response: {tostring(var16)}`)

    return {
        canMonetize = not (arg1.permissions == nil) and arg1.permissions.canMonetize == true
    }
end

local function decodeBatchUpdateShopItemsResponse<T>(arg1: T): T
    local var15, var16 = var11(arg1)
    assert(var15, `Invalid Shop item update response: {tostring(var16)}`)
    return arg1
end

local function decodeEmptyResponse(_)
    return nil
end

local function transportOptions(tbl1)
    local tbl2 = tbl1 or {}
    return {
        network = tbl2.network,
        readNetwork = tbl2.readNetwork,
        mutatingNetwork = tbl2.mutatingNetwork,
        baseUrl = tbl2.baseUrl,
        retryReads = false
    }
end

local function resolveBase(tbl1) -- Luacid: Inlined by compiler; 8 call sites recovered
    return creatorApiHttp.baseUrl((transportOptions(tbl1)))
end

local function get(str1: string, str2: string, tbl1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    return creatorApiHttp.get(transportOptions(tbl1), str1, str2, func1)
end

local function mutate(str1: string, str2: string, arg1, str3: string, tbl1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl2 = transportOptions(tbl1)
    return creatorApiHttp.json(creatorApiHttp.mutatingNetwork(tbl2), str1, str2, arg1, str3, creatorApiHttp.jsonDecoder(func1))
end

local module = {}

function module.getManagedPricing(num1: number, tbl1)
    local var15 = resolveBase(tbl1)

    return get(
        ("%s/price-configuration-api/v1/universes/%d/managed-pricing"):format(var15, num1),
        "monetization-options.managed-pricing.get",
        tbl1,
        decodeManagedPricingResponse
    )
end

function module.acceptManagedPricing(num1: number, tbl1)
    local var15 = resolveBase(tbl1)

    return mutate(
        "POST",
        ("%s/price-configuration-api/v1/universes/%d/managed-pricing:accept"):format(var15, num1),
        nil,
        "monetization-options.managed-pricing.accept",
        tbl1,
        decodeEmptyResponse
    )
end

function module.updateDeveloperProductsManagedPricing(num1: number, tbl1, isManagedPricingEnabled: boolean, tbl2)
    local var15 = resolveBase(tbl2)

    local errors = {}
    local num2 = 1

    local function updateNextBatch()
        local developerProductUpdates = {}
        local num3 = num2
        local num4 = num2 + 30 - 1
        local num5 = #tbl1

        for i = num3, math.min(num4, num5) do
            table.insert(
                developerProductUpdates,
                {
                    productId = tbl1[i],
                    changedProperties = { isManagedPricingEnabled = isManagedPricingEnabled }
                }
            )
        end

        if #developerProductUpdates == 0 then
            return Promise.resolve({ errors = errors })
        end
        num2 += #developerProductUpdates

        return mutate(
            "PATCH",
            ("%s/developer-products/v1/universes/%d/developer-products"):format(var15, num1),
            { developerProductUpdates = developerProductUpdates },
            "monetization-options.managed-pricing.update-products",
            tbl2,
            decodeBulkDeveloperProductUpdateResponse
        ):andThen(
            function(arg1)
                for _, value in arg1.errors or {} do
                    table.insert(errors, value)
                end
                return updateNextBatch()
            end
        )
    end

    return updateNextBatch()
end

local function bulkUpdateGamePasses(num1: number, tbl1, str1: string, changedProperties, func1: (...any) -> (...any), str2: string, tbl2)
    local baseUrl = resolveBase(tbl2)

    local var16 = table.clone(tbl1)
    local tbl3 = {
        baseUrl = baseUrl,
        network = creatorApiHttp.readNetwork((transportOptions(tbl2)))
    }
    local errors = {}
    local results = {}
    local num2 = 1
    local var2 = table.freeze({ errorMessage = "The local user changed while the bulk Game Pass request was running" })

    local function isRequestCurrent() -- Luacid: Inlined by compiler; 4 call sites recovered
        return tbl2 == nil or tbl2.isRequestCurrent == nil or tbl2.isRequestCurrent()
    end
    local function appendSessionChanged(tbl6, tbl7)
        for _, gamePassId in tbl6 do
            local var18 = if tbl7 == nil then nil else tbl7[gamePassId]
            local tbl8 = results
            local tbl9 = if var18 ~= nil then {
                gamePassId = gamePassId,
                status = "failed",
                reason = "service_error",
                error = var18.error
            } else {
                gamePassId = gamePassId,
                status = "unverified",
                reason = "session_changed",
                error = var2
            }
            table.insert(tbl8, tbl9)
        end
    end

    local function updateNextBatch()
        if not isRequestCurrent() then
            local tbl6 = {}
            for i = num2, #var16 do
                table.insert(tbl6, var16[i])
            end
            num2 = #var16 + 1
            appendSessionChanged(tbl6)
            return Promise.resolve({ errors = errors, results = results })
        end
        local gamePassUpdates = {}
        local tbl7 = {}
        local num3 = num2
        local num4 = num2 + 30 - 1
        local num5 = #var16

        for i = num3, math.min(num4, num5) do
            local var18 = var16[i]
            table.insert(tbl7, var18)
            local tbl8 = {
                gamePassId = var16[i],
                changedPropertyNames = { str1 },
                changedProperties = changedProperties
            }
            table.insert(gamePassUpdates, tbl8)
        end

        if #gamePassUpdates == 0 then
            return Promise.resolve({ errors = errors, results = results })
        end
        num2 += #gamePassUpdates
        local tbl8 = {}
        for _, value in gamePassUpdates do
            tbl8[value.gamePassId] = true
        end
        local function readBack(tbl9, mutationError)
            local tbl10 = {}
            local tbl11 = {}
            if tbl9 ~= nil then
                for _, error in tbl9.errors do
                    table.insert(errors, error)
                    tbl10[error.gamePassId] = error
                end
            end
            for _, value in gamePassUpdates do
                if tbl10[value.gamePassId] == nil then
                    table.insert(tbl11, value.gamePassId)
                end
            end

            if not isRequestCurrent() then
                appendSessionChanged(tbl7, tbl10)
                return updateNextBatch()
            end
            return fetchGamePassConfig.batchGet(num1, tbl11, tbl3):andThen(function(arg1)
                if not isRequestCurrent() then
                    appendSessionChanged(tbl7, tbl10)
                    return updateNextBatch()
                end
                local tbl12 = {}
                for _, value in arg1.gamePasses do
                    tbl12[value.gamePassId] = value
                end
                for _, value in gamePassUpdates do
                    local gamePassId = value.gamePassId
                    local var18 = tbl10[gamePassId]
                    local config = tbl12[gamePassId]
                    if var18 ~= nil then
                        table.insert(results, { gamePassId = gamePassId, status = "failed", reason = "service_error", error = var18.error })
                    elseif config == nil then
                        table.insert(
                            results,
                            {
                                gamePassId = gamePassId,
                                status = "unverified",
                                reason = "readback_failed",
                                mutationError = mutationError
                            }
                        )
                    else
                        local var20 = func1(config)
                        table.insert(results, {
                            gamePassId = gamePassId,
                            status = if var20 then "confirmed" else "unverified",
                            reason = if var20 then nil else "readback_mismatch",
                            config = config,
                            mutationError = mutationError
                        })
                    end
                end
                return updateNextBatch()
            end, function(error2)
                if not isRequestCurrent() then
                    appendSessionChanged(tbl7, tbl10)
                    return updateNextBatch()
                end
                for _, value in gamePassUpdates do
                    local var18 = tbl10[value.gamePassId]

                    local tbl12 = results
                    local tbl13 = if var18 ~= nil then {
                        gamePassId = value.gamePassId,
                        status = "failed",
                        reason = "service_error",
                        error = var18.error
                    } else {
                        gamePassId = value.gamePassId,
                        status = "unverified",
                        reason = "readback_failed",
                        error = error2,
                        mutationError = mutationError
                    }
                    table.insert(tbl12, tbl13)
                end

                return updateNextBatch()
            end)
        end

        return mutate(
            "POST",
            ("%s/game-passes/v1/game-passes/universes/%d/bulk-update"):format(baseUrl, num1),
            { gamePassUpdates = gamePassUpdates },
            str2,
            tbl2,
            function(arg1)
                return (decodeBulkGamePassUpdateResponse(tbl8, arg1))
            end
        ):andThen(
            function(tbl9)
                return readBack(tbl9, nil)
            end,
            function(error2)
                local responseCode = if typeof(error2) == "table" then error2.responseCode else nil

                if responseCode == nil
                    or not (StatusCodes.BAD_REQUEST <= responseCode)
                    or not (responseCode < StatusCodes.INTERNAL_SERVER_ERROR)
                    or responseCode == StatusCodes.REQUEST_TIMEOUT
                then
                    return readBack(nil, error2)
                end

                local bool1 = responseCode == StatusCodes.UNAUTHORIZED
                    or responseCode == StatusCodes.FORBIDDEN
                    or responseCode == StatusCodes.TOO_MANY_REQUESTS
                local var18 = bool1 and #var16 or num2 - 1
                for i = num2 - #gamePassUpdates, var18 do
                    table.insert(results, { gamePassId = var16[i], status = "failed", reason = "service_error", error = error2 })
                end

                if bool1 then
                    return { errors = errors, results = results }
                end
                return updateNextBatch()
            end
        )
    end

    return updateNextBatch()
end

function module.updateGamePassesManagedPricing(num1: number, tbl1, managedPricing: boolean, tbl2)
    return bulkUpdateGamePasses(num1, tbl1, "ManagedPricing", { ManagedPricing = managedPricing }, function(arg1): boolean
        return arg1.isManagedPricingEnabled == managedPricing
    end, "monetization-options.managed-pricing.update-game-passes", tbl2)
end

function module.updateGamePassesArchived(num1: number, tbl1, archived: boolean, tbl2)
    return bulkUpdateGamePasses(num1, tbl1, "Archived", { Archived = archived }, function(arg1): boolean
        return arg1.isArchived == archived and (not archived or arg1.isForSale == false)
    end, "monetization-options.archive.update-game-passes", tbl2)
end

function module.listShops(num1: number, tbl1)
    local var15 = resolveBase(tbl1)

    local var16 = UrlBuilder.UrlBuilder.addQueryString(
        ("%s/shops-api/v1/shops"):format(var15),
        {
            ["scope.type"] = "Universe",
            ["scope.scopeId"] = tostring(num1)
        }
    )
    return get(var16, "monetization-options.shops.list", tbl1, decodeShopListResponse)
end

function module.createShop(num1: number, isEnabled: boolean, tbl1)
    local var15 = resolveBase(tbl1)

    return mutate(
        "POST",
        ("%s/shops-api/v1/shops"):format(var15),
        {
            scope = {
                type = "Universe",
                scopeId = tostring(num1)
            },
            entryPoints = {{ name = "InExperienceGlobalIconEnabled", isEnabled = isEnabled }}
        },
        "monetization-options.shops.create",
        tbl1,
        decodeCreatedShop
    )
end

function module.setShopGlobalIcon(num1: number, isEnabled: boolean, tbl1)
    local var15 = resolveBase(tbl1)

    return mutate(
        "PATCH",
        ("%s/shops-api/v1/shops/%d/items"):format(var15, num1),
        {
            changedEntryPoints = {{ name = "InExperienceGlobalIconEnabled", isEnabled = isEnabled }}
        },
        "monetization-options.shops.update-global-icon",
        tbl1,
        decodeBatchUpdateShopItemsResponse
    )
end

function module.getMonetizationPermission(num1: number, str1: string, num2: number?, tbl1)
    local var15 = resolveBase(tbl1)

    if str1 ~= "Group" or num2 == nil then
        return get(
            ("%s/orgs/v2/universes/%d/permissions/resolved"):format(var15, num1),
            "monetization-options.permission.universe",
            tbl1,
            decodeUniversePermissionResponse
        )
    end

    local var16 = tbl1 and tbl1.groupsBaseUrl or Http.Url.GROUPS_URL
    local function getLegacyPermission()
        return get(
            ("%s/orgs/v2/universes/%d/permissions/resolved"):format(var15, num1),
            "monetization-options.permission.universe",
            tbl1,
            decodeUniversePermissionResponse
        )
    end

    return get(
        ("%sv1/groups/%d/migration"):format(var16, num2),
        "monetization-options.permission.group-migration",
        tbl1,
        decodeGroupMigrationResponse
    ):catch(
        function(arg1)
            if type(arg1) == "table" and arg1.responseCode == 409 then
                return { status = "NotMigrated" }
            end
            return Promise.reject(arg1)
        end
    ):andThen(
        function(arg1)
            if arg1.status ~= "Migrated" then
                return getLegacyPermission()
            end
            return get(
                ("%sv2/groups/%d/universes/%d/permissions/resolved"):format(var16, num2, num1),
                "monetization-options.permission.group",
                tbl1,
                decodeGroupPermissionResponse
            )
        end
    )
end
return module
