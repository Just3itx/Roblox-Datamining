-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:30:47Z
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
local incompleteListCode = require(script.Parent.incompleteListCode)

local fetchGamePassConfig = require(script.Parent.fetchGamePassConfig)
local isManagedPricingEnabled = require(script.Parent.isManagedPricingEnabled)
local _GamePassConfigTypes = require(script.Parent.GamePassConfigTypes)

local var1 = table.freeze({ errorMessage = "The local user changed while the Game Pass request was running" })

local function createGamePassConfigStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local getLocalPlayerUserId = tbl2.getLocalPlayerUserId or DataHydrationUtils.getLocalPlayerUserId
    local observeLocalPlayerUserId = tbl2.observeLocalPlayerUserId or DataHydrationUtils.observeLocalPlayerUserId

    local bool1 = false
    local num1 = 0

    local singleEntityResolver = createSingleEntityResolver(function(num2: number) -- name: fetchGamePasses
        local var2 = fetchGamePassConfig.list(num2, tbl3)
        if not FFlagDataHydrationPreserveIncompleteCatalogResults then
            return var2
        end
        return var2:catch(function(arg1)
            if typeof(arg1) ~= "table" or arg1.code ~= incompleteListCode then
                return Promise.reject(arg1)
            end

            return {
                gamePasses = arg1.gamePasses,
                nextPageToken = arg1.nextPageToken,
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

    local function verificationError(gamePass, str1: string, cause) -- Luacid: Inlined by compiler; 1 call site recovered
        return {
            outcome = "unverified",
            errorMessage = (if gamePass ~= nil then `Game pass {gamePass.gamePassId} could not be verified: {str1}. ` else `The Game Pass request could not be verified: {str1}. `)
                .. "Inspect the existing game pass before retrying. Do not create another game pass.",
            gamePass = gamePass,
            cause = cause
        }
    end

    local function failedError(gamePassId: number?, errorMessage: string, cause)
        return {
            outcome = "failed",
            errorMessage = `The Game Pass request was rejected: {errorMessage}.`,
            gamePass = gamePassId ~= nil and { gamePassId = gamePassId } or nil,
            cause = cause
        }
    end

    local function captureMutationToken(gamePassId: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
        local userId = getLocalPlayerUserId()
        if userId ~= nil then
            return { generation = num1, userId = userId }, nil
        end

        return nil, {
            outcome = "failed",
            errorMessage = "The Game Pass request was rejected: a signed-in local user is required.",
            gamePass = gamePassId ~= nil and { gamePassId = gamePassId } or nil,
            cause = nil
        }
    end
    local function currentTokenError(tbl4) -- Luacid: Inlined by compiler; 6 call sites recovered
        return if bool1 or tbl4.generation ~= num1 or tbl4.userId ~= getLocalPlayerUserId() then var1 else nil
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

    local function mutationResult(arg1, gamePassId: number?) -- Luacid: unused: defined but never referenced
        return arg1:catch(function(cause)
            if typeof(cause) == "table"
                and cause.responseCode ~= nil
                and cause.responseCode >= StatusCodes.BAD_REQUEST
                and cause.responseCode < StatusCodes.INTERNAL_SERVER_ERROR
                and cause.responseCode ~= StatusCodes.REQUEST_TIMEOUT
            then
                return Promise.reject((failedError(gamePassId, cause.errorMessage or "the service rejected the write", cause)))
            end

            local reject = Promise.reject

            local gamePass = gamePassId ~= nil and { gamePassId = gamePassId } or nil
            return reject({
                outcome = "unverified",
                errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the write outcome is unknown. " else `Game pass {gamePass.gamePassId} could not be verified: the write outcome is unknown. `)
                    .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                gamePass = gamePass,
                cause = cause
            })
        end)
    end

    local function runMutation(tbl4, gamePassId: number?, func1: (...any) -> (...any))
        local var3 = currentTokenError(tbl4)

        if var3 ~= nil then
            return Promise.reject((failedError(gamePassId, var3.errorMessage, var3)))
        end

        return func1():catch(function(cause)
            if typeof(cause) == "table"
                and cause.responseCode ~= nil
                and cause.responseCode >= StatusCodes.BAD_REQUEST
                and cause.responseCode < StatusCodes.INTERNAL_SERVER_ERROR
                and cause.responseCode ~= StatusCodes.REQUEST_TIMEOUT
            then
                return Promise.reject((failedError(gamePassId, cause.errorMessage or "the service rejected the write", cause)))
            end

            local reject = Promise.reject

            local gamePass = gamePassId ~= nil and { gamePassId = gamePassId } or nil
            return reject({
                outcome = "unverified",
                errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the write outcome is unknown. " else `Game pass {gamePass.gamePassId} could not be verified: the write outcome is unknown. `)
                    .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                gamePass = gamePass,
                cause = cause
            })
        end):andThen(function(gamePass)
            local cause = currentTokenError(tbl4)
            if cause == nil then
                return gamePass
            end

            if typeof(gamePass) ~= "table" or typeof(gamePass.gamePassId) ~= "number" then
                gamePass = gamePassId ~= nil and { gamePassId = gamePassId } or nil
            end

            return Promise.reject({
                outcome = "unverified",
                errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the local user changed after the write. " else `Game pass {gamePass.gamePassId} could not be verified: the local user changed after the write. `)
                    .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                gamePass = gamePass,
                cause = cause
            })
        end)
    end
    local function tokenBoundGet(tbl4, num2: number, gamePassId: number)
        local var3 = currentTokenError(tbl4)

        if var3 ~= nil then
            return Promise.reject(var3)
        end
        return fetchGamePassConfig.get(num2, gamePassId, tbl3):andThen(function(arg1)
            local var4 = currentTokenError(tbl4)
            if var4 ~= nil then
                return (Promise.reject(var4))
            end

            return arg1
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

    local function readBackMutation(tbl4, num2: number, gamePassId: number, iconAssetId: number?, iconAssetId2: number?, isForSale: boolean?, arg1, bool2: boolean?)
        return tokenBoundGet(tbl4, num2, gamePassId):andThen(function(gamePass)
            if iconAssetId ~= nil and gamePass.iconAssetId ~= iconAssetId then
                return Promise.reject({
                    outcome = "unverified",
                    errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the stored icon did not match the returned icon. " else `Game pass {gamePass.gamePassId} could not be verified: the stored icon did not match the returned icon. `)
                        .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                    gamePass = gamePass,
                    cause = nil
                })
            end
            if iconAssetId2 ~= nil and (gamePass.iconAssetId == nil or gamePass.iconAssetId <= 0 or gamePass.iconAssetId == iconAssetId2) then
                return Promise.reject({
                    outcome = "unverified",
                    errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the replacement image is not visible yet. " else `Game pass {gamePass.gamePassId} could not be verified: the replacement image is not visible yet. `)
                        .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                    gamePass = gamePass,
                    cause = nil
                })
            end

            if isForSale ~= nil and gamePass.isForSale ~= isForSale then
                return Promise.reject({
                    outcome = "unverified",
                    errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the sale state does not match the requested state. " else `Game pass {gamePass.gamePassId} could not be verified: the sale state does not match the requested state. `)
                        .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                    gamePass = gamePass,
                    cause = nil
                })
            end

            if arg1 ~= nil then
                for _, value in { "name", "description" } do
                    if not bool2 and arg1[value] ~= nil and gamePass[value] ~= arg1[value] then
                        return Promise.reject(verificationError(gamePass, `the stored {value} does not match the request`, nil))
                    end
                end

                if arg1.isManagedPricingEnabled ~= nil and isManagedPricingEnabled(gamePass) ~= arg1.isManagedPricingEnabled then
                    return Promise.reject({
                        outcome = "unverified",
                        errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the stored isManagedPricingEnabled does not match the request. " else `Game pass {gamePass.gamePassId} could not be verified: the stored isManagedPricingEnabled does not match the request. `)
                            .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                        gamePass = gamePass,
                        cause = nil
                    })
                end

                local priceInformation = gamePass.priceInformation

                if arg1.priceInRobux ~= nil and (priceInformation == nil or priceInformation.defaultPriceInRobux ~= arg1.priceInRobux) then
                    return Promise.reject({
                        outcome = "unverified",
                        errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the stored price does not match the request. " else `Game pass {gamePass.gamePassId} could not be verified: the stored price does not match the request. `)
                            .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                        gamePass = gamePass,
                        cause = nil
                    })
                end
            end

            return gamePass
        end, function(cause)
            if cause == var1 or currentTokenError(tbl4) ~= nil then
                local reject = Promise.reject
                local gamePass = { gamePassId = gamePassId }
                return reject({
                    outcome = "unverified",
                    errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the local user changed during readback. " else `Game pass {gamePass.gamePassId} could not be verified: the local user changed during readback. `)
                        .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                    gamePass = gamePass,
                    cause = cause
                })
            end
            local reject = Promise.reject
            local gamePass = { gamePassId = gamePassId }
            return reject({
                outcome = "unverified",
                errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the readback failed. " else `Game pass {gamePass.gamePassId} could not be verified: the readback failed. `)
                    .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                gamePass = gamePass,
                cause = cause
            })
        end)
    end

    local function update(num2: number, gamePassId: number, arg1, arg2)
        local var3, var4 = captureMutationToken(gamePassId)

        if var3 == nil then
            return Promise.reject(var4)
        end
        local function mutate(iconAssetId: number?)
            return runMutation(var3, gamePassId, function()
                return fetchGamePassConfig.update(num2, gamePassId, arg1, tbl3)
            end):andThen(function()
                return readBackMutation(
                    var3,
                    num2,
                    gamePassId,
                    nil,
                    iconAssetId,
                    arg1.isForSale,
                    arg1,
                    not (arg2 == nil) and arg2.acceptModeratedText == true
                )
            end)
        end

        local var5 = if arg1.imageFile ~= nil then tokenBoundGet(var3, num2, gamePassId):andThen(function(gamePass)
            if gamePass.iconAssetId ~= nil then
                return mutate(gamePass.iconAssetId)
            end

            return Promise.reject(
                {
                    outcome = "failed",
                    errorMessage = "The existing icon could not be read. No update was sent.",
                    gamePass = gamePass
                }
            )
        end, function(cause)
            if cause == var1 or currentTokenError(var3) ~= nil then
                return Promise.reject((failedError(gamePassId, var1.errorMessage, cause)))
            end
            return Promise.reject(
                (failedError(gamePassId, cause.errorMessage or "the existing Game Pass could not be read before the update", cause))
            )
        end) else mutate(nil)

        return reconcileMutation(num2, var5)
    end

    return {
        getGamePasses = singleEntityResolver.get,
        fetchGamePasses = singleEntityResolver.fetch,
        refetchGamePasses = singleEntityResolver.refetch,
        getAndFetchGamePasses = singleEntityResolver.getAndFetch,
        getAccountResetGeneration = singleEntityResolver.getAccountResetGeneration,
        list = function(num2: number)
            return fetchGamePassConfig.list(num2, tbl3)
        end,
        get = function(num2: number, num3: number)
            return fetchGamePassConfig.get(num2, num3, tbl3)
        end,
        batchGet = function(num2: number, tbl4)
            if #tbl4 == 0 then
                return Promise.resolve({ gamePasses = {} })
            end
            return fetchGamePassConfig.batchGet(num2, tbl4, tbl3)
        end,
        create = function(num2: number, arg1)
            local userId = getLocalPlayerUserId()
            local tbl4, var3

            if userId == nil then
                tbl4 = nil
                var3 = {
                    outcome = "failed",
                    errorMessage = "The Game Pass request was rejected: a signed-in local user is required.",
                    gamePass = nil,
                    cause = nil
                }
            else
                tbl4 = { generation = num1, userId = userId }
                var3 = nil
            end

            if tbl4 == nil then
                return Promise.reject(var3)
            end
            local var4 = runMutation(tbl4, nil, function()
                return fetchGamePassConfig.create(num2, arg1, tbl3)
            end):andThen(function(arg2)
                if arg1.imageFile == nil or arg2.iconAssetId ~= nil and not (arg2.iconAssetId <= 0) then
                    return readBackMutation(
                        tbl4,
                        num2,
                        arg2.gamePassId,
                        if arg1.imageFile == nil then nil else arg2.iconAssetId,
                        nil,
                        not (arg1.isForSale == nil) and arg1.isForSale,
                        arg1
                    )
                end

                local reject = Promise.reject

                local gamePass = {
                    gamePassId = arg2.gamePassId
                }
                return reject({
                    outcome = "unverified",
                    errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the API did not return an uploaded image asset ID. " else `Game pass {gamePass.gamePassId} could not be verified: the API did not return an uploaded image asset ID. `)
                        .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                    gamePass = gamePass,
                    cause = nil
                })
            end)
            return reconcileMutation(num2, var4)
        end,
        update = update,
        activate = function(num2: number, gamePassId: number)
            return update(num2, gamePassId, { isForSale = true })
        end,
        deactivate = function(num2: number, gamePassId: number)
            return update(num2, gamePassId, { isForSale = false })
        end,
        setArchived = function(num2: number, gamePassId: number, isArchived: boolean)
            local var3, var4 = captureMutationToken(gamePassId)

            if var3 == nil then
                return Promise.reject(var4)
            end
            local var5 = runMutation(var3, gamePassId, function()
                return fetchGamePassConfig.setArchived(num2, gamePassId, isArchived, tbl3)
            end):andThen(function()
                return readBackMutation(var3, num2, gamePassId):andThen(function(gamePass)
                    if gamePass.isArchived == nil then
                        return Promise.reject({
                            outcome = "unverified",
                            errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: archiving is not available for this account yet. " else `Game pass {gamePass.gamePassId} could not be verified: archiving is not available for this account yet. `)
                                .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                            gamePass = gamePass,
                            cause = nil
                        })
                    elseif gamePass.isArchived ~= isArchived then
                        return Promise.reject({
                            outcome = "unverified",
                            errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the archive state is unchanged. " else `Game pass {gamePass.gamePassId} could not be verified: the archive state is unchanged. `)
                                .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                            gamePass = gamePass,
                            cause = nil
                        })
                    elseif isArchived and gamePass.isForSale ~= false then
                        return Promise.reject({
                            outcome = "unverified",
                            errorMessage = (if gamePass == nil then "The Game Pass request could not be verified: the archived pass was not taken off sale. " else `Game pass {gamePass.gamePassId} could not be verified: the archived pass was not taken off sale. `)
                                .. "Inspect the existing game pass before retrying. Do not create another game pass.",
                            gamePass = gamePass,
                            cause = nil
                        })
                    end

                    return gamePass
                end)
            end)
            return reconcileMutation(num2, var5)
        end,
        getSalesLimit = function(num2: number)
            return fetchGamePassConfig.getSalesLimit(num2, tbl3)
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
return createGamePassConfigStore
