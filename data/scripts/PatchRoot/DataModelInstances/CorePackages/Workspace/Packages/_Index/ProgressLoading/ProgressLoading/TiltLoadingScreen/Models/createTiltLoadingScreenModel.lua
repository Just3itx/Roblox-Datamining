-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreen = script:FindFirstAncestor("TiltLoadingScreen")
local TiltLoadingScreenParent = TiltLoadingScreen.Parent
local TiltLoadingScreenParentParent = TiltLoadingScreenParent.Parent

local Signals = require(TiltLoadingScreenParentParent.Signals)
local Http = require(TiltLoadingScreenParentParent.Http)
local DataHydration = require(TiltLoadingScreenParentParent.DataHydration)
local QueueExperimentation = require(TiltLoadingScreenParentParent.SocialExperiments).QueueExperimentation
local CachedPolicyService = require(TiltLoadingScreenParentParent.CachedPolicyService)

local MarketplaceGetMarketplaceAssetStore = require(TiltLoadingScreenParentParent.DataHydration.MarketplaceGetMarketplaceAssetStore)
local LoadingScreenTelemetry = require(TiltLoadingScreenParent.LoadingScreenTelemetry)
local SharedFlags = require(TiltLoadingScreenParentParent.SharedFlags)
local Constants = require(TiltLoadingScreen.Constants)

local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local ExperienceService = game:GetService("ExperienceService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local FFlagEnableLuaAppsFollowUserId = SharedFlags.FFlagEnableLuaAppsFollowUserId

local createDataCache = DataHydration.createDataCache
local createDataResolver = DataHydration.createDataResolver
local engineFeature = game:GetEngineFeature("QueuePositionEnabled")
local var1 = game:GetEngineFeature("ExperienceServiceFollowUserIdEnabled") and FFlagEnableLuaAppsFollowUserId

local engineFeature2 = game:GetEngineFeature("PlaceJoinStateEnabled")

local var2 = Http.NetworkLayers.requestInternalWrapper(HttpService)

local function defaultFetchUniverseId(num1: number)
    local str1 = string.format("%suniverses/v1/places/%d/universe", Http.Url.APIS_URL, num1)
    local var3, var4 = var2(str1, "GET"):await()
    return if var3 and var4 and var4.responseBody then var4.responseBody.universeId else nil
end

local function defaultFetchProductInfo(assetId: number)
    return (MarketplaceService:GetProductInfoAsync(assetId))
end

local function defaultFetchPlayerLocalizationChoice(universeId: string)
    return var2(
        string.format("%sv1/user-localization-settings/player-choice/%s", Http.Url.GAME_INTERNATIONALIZATION_URL, universeId),
        "GET"
    ):andThen(
        function(arg1)
            if not (arg1 and arg1.responseBody) then
                error({
                    responseCode = arg1 and arg1.responseCode,
                    errorType = "PlayerLocalizationChoiceResponseError",
                    errorMessage = if arg1 then "Missing response body" else "No response",
                    customFields = { universeId = universeId }
                })
            end

            local responseBody = arg1.responseBody
            if responseBody.IsPlayerChoiceEnabled == nil then
                error({
                    responseCode = arg1.responseCode,
                    errorType = "PlayerLocalizationChoiceMissingKey",
                    errorMessage = "Missing IsPlayerChoiceEnabled in response body",
                    customFields = { universeId = universeId, responseBody = responseBody }
                })
            end
            return responseBody
        end
    )
end

local function getQueueTreatment() -- Luacid: Inlined by compiler; 1 call site recovered
    if not engineFeature2 then
        return nil
    end

    if QueueExperimentation.getIsAutoJoinNewServerEnabled() then
        return Constants.AUTO_JOIN_TREATMENT
    end

    if QueueExperimentation.getIsJoinNewServerButtonEnabled() then
        return Constants.JOIN_NEW_SERVER_TREATMENT
    end

    return nil
end

local function createTiltLoadingScreenModel(num1: number, tbl1, num2: number?)
    local var3 = if tbl1 and tbl1.dataModel then tbl1.dataModel else game
    local var4 = if tbl1 and tbl1.experienceService then tbl1.experienceService else ExperienceService
    local var5 = if tbl1 and tbl1.guiService then tbl1.guiService else GuiService
    local var6 = tbl1 and tbl1.fetchUniverseId or defaultFetchUniverseId
    local var7 = tbl1 and tbl1.fetchProductInfo or defaultFetchProductInfo
    local var8 = tbl1 and tbl1.fetchIsSubjectToChinaPolicies or function()
        return CachedPolicyService:IsSubjectToChinaPolicies()
    end
    local var9 = tbl1 and tbl1.fetchPlayerLocalizationChoice or defaultFetchPlayerLocalizationChoice
    local function readServerStatusText(): string -- Luacid: Inlined by compiler; 2 call sites recovered
        if not var5.GetUiMessage then
            return ""
        end
        local success, result = pcall(var5.GetUiMessage, var5)
        return if success and type(result) == "string" then result else ""
    end
    local var10 = MarketplaceGetMarketplaceAssetStore(false)
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        logError = function(arg1)
            if type(arg1) == "table" then
                LoadingScreenTelemetry.countPlayerLocalizationChoiceFailed(
                    {
                        responseCode = arg1.responseCode,
                        errorType = arg1.errorType
                    }
                )
                return
            end

            LoadingScreenTelemetry.countPlayerLocalizationChoiceFailed({ errorType = "PlayerLocalizationChoiceFetchError" })
        end,
        fetchFn = function(str1: string)
            return var9(str1)
        end
    })

    if num2 == nil and not (num1 > 0) then
        num1 = var3.PlaceId
    end

    local var11, var12 = Signals.createSignal(if num1 > 0 then num1 else 0)
    local var13 = if num2 == nil then var3.GameId else num2
    local getUniverseId, var15 = Signals.createSignal(if var13 > 0 then var13 else 0)
    local queueTreatment = if num2 == nil then getQueueTreatment() else nil
    local signal = Signals.createSignal(queueTreatment)
    local getJoinState, var17 = Signals.createSignal("")
    local getQueuePosition, var19 = Signals.createSignal(nil)

    local getServerStatusText, var21 = Signals.createSignal(if num2 ~= nil then "" else readServerStatusText())
    local getFollowUserId, var23 = Signals.createSignal(0)
    local getIsSubjectToChinaPolicies, var25 = Signals.createSignal(false)
    local getAssetInfo = Signals.createComputed(function(arg1)
        local var26 = var11(arg1)
        if var26 <= 0 then
            return nil
        end
        local var27 = var10.getMarketplaceAssetInfo(tostring(var26)).data(arg1)

        if not var27 then
            return nil
        end

        return {
            name = var27.name,
            creatorName = var27.creatorName,
            creatorHasVerifiedBadge = var27.creatorHasVerifiedBadge
        }
    end)

    local bool1 = false
    local getIsAutoTranslated = Signals.createComputed(function(arg1)
        local var26 = getUniverseId(arg1)
        if not (var26 <= 0) then
            local var27 = dataResolver.getAndFetchItem(tostring(var26)).data(arg1)
            return if var27 then var27.IsPlayerChoiceEnabled else nil
        end

        if not bool1 then
            bool1 = true
            LoadingScreenTelemetry.countAutoTranslateZeroUniverseId()
        end
        return nil
    end)

    local bool2 = false
    local bool3 = false
    local var26 = nil
    local var27 = nil
    local var28 = nil
    local var29 = nil
    local var30 = nil
    local var31 = nil
    local var32 = nil
    local var33 = nil
    local bool4 = false
    local bool5 = false

    local function cancel(thread1: thread?) -- Luacid: Inlined by compiler; 12 call sites recovered
        if thread1 and coroutine.status(thread1) ~= "dead" then
            task.cancel(thread1)
        end
    end

    local function disconnect(arg1) -- Luacid: Inlined by compiler; 19 call sites recovered
        if arg1 then
            arg1:Disconnect()
        end
        return nil
    end

    local function readFollowUserId(): number -- Luacid: Inlined by compiler; 1 call site recovered
        if not (var1 and var4.GetFollowUserId) then
            return 0
        end
        local success, result = pcall(var4.GetFollowUserId, var4)
        return if success and type(result) == "number" then result else 0
    end

    local function readExposureFollowUserId(): number -- Luacid: Inlined by compiler; 3 call sites recovered
        if not var4.GetFollowUserId then
            return 0
        end
        local success, result = pcall(var4.GetFollowUserId, var4)
        return if success and type(result) == "number" then result else 0
    end

    local function readQueuePosition() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not (engineFeature and var4.GetQueuePosition) then
            return nil
        end
        local success, result = pcall(var4.GetQueuePosition, var4)
        return if success and type(result) == "number" then result else nil
    end

    local function updateQueuePosition() -- Luacid: Inlined by compiler; 1 call site recovered
        var19((readQueuePosition()))
    end

    local function logQueueExposureIfNeeded(queuedState: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if bool4
            or queuedState ~= Constants.QUEUED_STATE
            or var11(false) <= 0
            or readExposureFollowUserId() <= 0
            or not QueueExperimentation.isInExperiment()
        then
            return
        end
        bool4 = true
        QueueExperimentation.logExposure()
    end

    local function updateJoinState(queuedState: string?) -- Luacid: Inlined by compiler; 1 call site recovered
        if type(queuedState) ~= "string" then
            return
        end
        var17(queuedState)
        if queuedState ~= Constants.QUEUED_STATE then
            var19(nil)
        end

        logQueueExposureIfNeeded(queuedState)
    end

    local function resolveUniverseId(num3: number) -- Luacid: unused: defined but never referenced
        if bool3 or num3 <= 0 or getUniverseId(false) > 0 then
            return
        end
        var15(num3)
        var27 = disconnect(var27)
    end

    local function watchUniverseId()
        var27 = disconnect(var27)
        if bool3 or getUniverseId(false) > 0 then
            return
        end
        var27 = var3:GetPropertyChangedSignal("GameId"):Connect(function()
            local gameId = var3.GameId

            if bool3 or gameId <= 0 then
                return
            end

            if getUniverseId(false) > 0 then
                return
            end
            var15(gameId)
            var27 = disconnect(var27)
        end)
        local gameId = var3.GameId

        if bool3 or gameId <= 0 then
            return
        end

        if getUniverseId(false) > 0 then
            return
        end
        var15(gameId)
        var27 = disconnect(var27)
    end

    local function fetchUniverseIdForPlace(num3: number) -- Luacid: unused: defined but never referenced
        if getUniverseId(false) > 0 then
            return
        end

        cancel(var32)

        var32 = task.defer(function()
            local success, result = pcall(var6, num3)

            if bool3 or num3 ~= var11(false) or not success or type(result) ~= "number" or bool3 or result <= 0 then
                return
            end

            if getUniverseId(false) > 0 then
                return
            end
            var15(result)
            var27 = disconnect(var27)
        end)
    end

    local function fetchGameDataForPlace(num3: number) -- Luacid: Inlined by compiler; 6 call sites recovered
        cancel(var31)

        var31 = task.defer(function()
            local success, getGameProductInfo = pcall(var7, num3)
            if not success then
                print(string.format("LoadingScreen:GetGameProductInfo: %s", tostring(getGameProductInfo)))
                return
            end

            if bool3 or num3 ~= var11(false) then
                return
            end

            local creator = getGameProductInfo.Creator
            var10.updateMarketplaceAssetInfo(tostring(num3), {
                name = getGameProductInfo.Name or "",
                creatorName = creator and creator.Name or "",
                creatorHasVerifiedBadge = if creator then creator.HasVerifiedBadge == true else false
            })
        end)
    end

    local function resolveChinaPolicy() -- Luacid: Inlined by compiler; 2 call sites recovered
        cancel(var33)

        var33 = task.defer(function()
            local success, result = pcall(var8)
            if not bool3 and success and type(result) == "boolean" then
                var25(result)
            end
        end)
    end

    local function beginRequests(num3: number) -- Luacid: unused: defined but never referenced
        if num3 <= 0 then
            return
        end

        fetchGameDataForPlace(num3)

        if getUniverseId(false) > 0 then
            return
        end

        cancel(var32)

        var32 = task.defer(function()
            local success, result = pcall(var6, num3)

            if bool3 or num3 ~= var11(false) or not success or type(result) ~= "number" or bool3 or result <= 0 then
                return
            end

            if getUniverseId(false) > 0 then
                return
            end
            var15(result)
            var27 = disconnect(var27)
        end)
    end

    local function resolvePlaceId(num3: number) -- Luacid: unused: defined but never referenced
        if bool3 or num3 <= 0 or var11(false) == num3 then
            return
        end

        var12(num3)
        var26 = disconnect(var26)

        if num3 <= 0 then
            return
        end

        fetchGameDataForPlace(num3)

        if getUniverseId(false) > 0 then
            return
        end

        cancel(var32)

        var32 = task.defer(function()
            local success, result = pcall(var6, num3)

            if bool3 or num3 ~= var11(false) or not success or type(result) ~= "number" or bool3 or result <= 0 then
                return
            end

            if getUniverseId(false) > 0 then
                return
            end
            var15(result)
            var27 = disconnect(var27)
        end)
    end

    return {
        getAssetInfo = getAssetInfo,
        getFollowUserId = getFollowUserId,
        getIsAutoTranslated = getIsAutoTranslated,
        getIsSubjectToChinaPolicies = getIsSubjectToChinaPolicies,
        getJoinState = getJoinState,
        getQueuePosition = getQueuePosition,
        getQueueTreatment = signal,
        getServerStatusText = getServerStatusText,
        getUniverseId = getUniverseId,
        launchExperience = function()
            local placeId = var11(false)
            if placeId > 0 and var4.LaunchExperience then
                var4:LaunchExperience({ placeId = placeId })
            end
        end,
        logQueuedStateButtonClick = function(buttonName: string, timeElapsedMs: number?)
            if not queueTreatment then
                return
            end
            LoadingScreenTelemetry.logQueuedStateButtonClick({
                buttonName = buttonName,
                joinTargetUserId = if var1 then getFollowUserId(false) else nil,
                placeId = var11(false),
                positionInQueue = if engineFeature then getQueuePosition(false) else nil,
                timeElapsedMs = timeElapsedMs,
                universeId = getUniverseId(false)
            })
        end,
        showConnectionHealth = function()
            if var5.ShowStatsBasedOnInputString then
                bool5 = true
                var5:ShowStatsBasedOnInputString("ConnectionHealth")
            end
        end,
        start = function()
            if bool2 or bool3 then
                return
            end
            bool2 = true
            if num2 ~= nil then
                resolveChinaPolicy()
                local var34 = var11(false)

                if var34 <= 0 then
                    return
                end

                fetchGameDataForPlace(var34)

                if getUniverseId(false) > 0 then
                    return
                end

                cancel(var32)

                var32 = task.defer(function()
                    local success, result = pcall(var6, var34)

                    if bool3 or var34 ~= var11(false) or not success or type(result) ~= "number" or bool3 or result <= 0 then
                        return
                    end

                    if getUniverseId(false) > 0 then
                        return
                    end
                    var15(result)
                    var27 = disconnect(var27)
                end)

                return
            end
            if var11(false) <= 0 then
                var26 = var3:GetPropertyChangedSignal("PlaceId"):Connect(function()
                    local placeId = var3.PlaceId

                    if bool3 or placeId <= 0 then
                        return
                    end

                    if var11(false) == placeId then
                        return
                    end

                    var12(placeId)
                    var26 = disconnect(var26)

                    if placeId <= 0 then
                        return
                    end

                    fetchGameDataForPlace(placeId)

                    if getUniverseId(false) > 0 then
                        return
                    end

                    cancel(var32)

                    var32 = task.defer(function()
                        local success, result = pcall(var6, placeId)

                        if bool3 or placeId ~= var11(false) or not success or type(result) ~= "number" or bool3 or result <= 0 then
                            return
                        end

                        if getUniverseId(false) > 0 then
                            return
                        end
                        var15(result)
                        var27 = disconnect(var27)
                    end)
                end)
            end

            watchUniverseId()
            resolveChinaPolicy()
            var23((readFollowUserId()))
            if var5.UiMessageChanged then
                var30 = var5.UiMessageChanged:Connect(function(msgType: Enum.UiMessageType, newUiMessage: string)
                    if msgType == Enum.UiMessageType.UiMessageInfo and type(newUiMessage) == "string" then
                        var21(newUiMessage)
                    end
                end)
            end
            var21((readServerStatusText()))
            if QueueExperimentation.isInExperiment() then
                if var4.GetPlaceJoinState then
                    local success, result = pcall(var4.GetPlaceJoinState, var4)
                    if success then
                        updateJoinState(result)
                    end
                end

                if var4.PlaceJoinStateChanged then
                    var28 = var4.PlaceJoinStateChanged:Connect(updateJoinState)
                end
                if engineFeature and var4.QueuePositionChanged then
                    var29 = var4.QueuePositionChanged:Connect(updateQueuePosition)
                end
                if engineFeature then
                    updateQueuePosition()
                end
            end

            if not (var11(false) <= 0) then
                local var34 = var11(false)

                if var34 <= 0 then
                    return
                end

                fetchGameDataForPlace(var34)

                if getUniverseId(false) > 0 then
                    return
                end

                cancel(var32)

                var32 = task.defer(function()
                    local success, result = pcall(var6, var34)

                    if bool3 or var34 ~= var11(false) or not success or type(result) ~= "number" or bool3 or result <= 0 then
                        return
                    end

                    if getUniverseId(false) > 0 then
                        return
                    end
                    var15(result)
                    var27 = disconnect(var27)
                end)

                return
            end

            local placeId = var3.PlaceId

            if bool3 or placeId <= 0 then
                return
            end

            if var11(false) == placeId then
                return
            end

            var12(placeId)
            var26 = disconnect(var26)

            if placeId <= 0 then
                return
            end

            fetchGameDataForPlace(placeId)

            if getUniverseId(false) > 0 then
                return
            end

            cancel(var32)

            var32 = task.defer(function()
                local success, result = pcall(var6, placeId)

                if bool3 or placeId ~= var11(false) or not success or type(result) ~= "number" or bool3 or result <= 0 then
                    return
                end

                if getUniverseId(false) > 0 then
                    return
                end
                var15(result)
                var27 = disconnect(var27)
            end)
        end,
        destroy = function()
            if bool3 then
                return
            end
            bool3 = true
            var26 = disconnect(var26)
            var27 = disconnect(var27)
            var28 = disconnect(var28)
            var29 = disconnect(var29)
            var30 = disconnect(var30)
            cancel(var31)
            cancel(var32)
            cancel(var33)
            dataResolver.clear()
            cache.clear()
            dataResolver.dispose()
            if not bool5 or not var5.CloseStatsBasedOnInputString then
                return
            end

            local connection = nil
            connection = UserInputService.InputBegan:Connect(function()
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
                var5:CloseStatsBasedOnInputString("ConnectionHealth")
            end)
        end
    }
end

return createTiltLoadingScreenModel
