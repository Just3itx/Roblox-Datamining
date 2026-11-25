-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local Cryo = require(SduiSharedUtilitiesParent.Cryo)
local Signals = require(SduiSharedUtilitiesParent.Signals)
local SduiCoreSystem = require(SduiSharedUtilitiesParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local Promise = require(SduiSharedUtilitiesParent.Promise)
local _HttpClient = require(SduiSharedUtilitiesParent.HttpClient)
local DataHydration = require(SduiSharedUtilitiesParent.DataHydration)
local createDataCache = DataHydration.createDataCache
local createDataResolver = DataHydration.createDataResolver
local getLocalPlayerUserId = DataHydration.DataHydrationUtils.getLocalPlayerUserId

local SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)
local SduiRequestConcurrencyPolicy = SduiIntegrationTypes.SduiRequestConcurrencyPolicy
local SduiRequestStatus = SduiIntegrationTypes.SduiRequestStatus
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local SduiProtobufResponseHelpers = require(SduiSharedUtilities.SduiProtobufResponseHelpers)
local makeProtoResponseDecoder = SduiProtobufResponseHelpers.makeProtoResponseDecoder
local makeProtobufJsonResponseDecoder = SduiProtobufResponseHelpers.makeProtobufJsonResponseDecoder
local SduiResponseType = SduiIntegrationTypes.SduiResponseType
local handleSduiApiResponse = require(SduiSharedUtilities.handleSduiApiResponse)
local SduiPageAnalytics = require(SduiSharedUtilities.SduiPageAnalytics)
local SduiApiStorePostConfig = require(SduiSharedUtilities.SduiApiStorePostConfig)
local _SduiApiRequestConfig = require(SduiSharedUtilities.SduiApiRequestConfig)
local createSduiStreamingResponseHandler = require(SduiSharedUtilities.createSduiStreamingResponseHandler)
local SduiRetryPolicy = require(SduiSharedUtilities.SduiRetryPolicy)
local sendSduiHttpRequest = require(SduiSharedUtilities.sendSduiHttpRequest)
local FFlagSduiAllowNoConfigsBuilt = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiAllowNoConfigsBuilt
local FFlagSduiAlwaysCacheWithIdentifier = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiAlwaysCacheWithIdentifier
local FFlagSduiDismissPromptAction = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiDismissPromptAction
local FFlagPromptsEdpOpenReplaceOnFetch = require(SduiSharedUtilitiesParent.SharedFlags).FFlagPromptsEdpOpenReplaceOnFetch
local FFlagSduiApiStoreUpdateInputData = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiApiStoreUpdateInputData

local FFlagAppChatConversationTrustedFriendUpsellBanner = require(SduiSharedUtilitiesParent.SharedFlags).FFlagAppChatConversationTrustedFriendUpsellBanner
local FFlagSduiRequestCounters = require(SduiSharedUtilities.Flags.FFlagSduiRequestCounters)
local FFlagSduiFreshInputDataSignalOnRebuild = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiFreshInputDataSignalOnRebuild
local FFlagLuaAppEnableSduiHomePage = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppEnableSduiHomePage

local FFlagSduiStreamingRefreshReplacesInputData = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiStreamingRefreshReplacesInputData
local FFlagLuaAppSduiSearchAutocomplete = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppSduiSearchAutocomplete
local FFlagLuaAppEnableSduiApiStoreInFlightFix = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppEnableSduiApiStoreInFlightFix
local FFlagDataHydrationAccountReset = require(SduiSharedUtilitiesParent.SharedFlags).FFlagDataHydrationAccountReset

local FFlagHomePageRefetchOnDataHydrationAccountReset = require(SduiSharedUtilitiesParent.SharedFlags).FFlagHomePageRefetchOnDataHydrationAccountReset
local FFlagSduiReleaseSearchResultsPageState = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiReleaseSearchResultsPageState

local priority = game:DefineFastInt("SduiPageRequestPriority", 1)

local resolveSduiCacheEntry = require(SduiSharedUtilities.resolveSduiCacheEntry)
local accumulateSduiCacheSubEntries = require(SduiSharedUtilities.accumulateSduiCacheSubEntries)

local function shouldApplyResponse(arg1, func1: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (func1 == nil or func1()) and (arg1.isResponseCurrent == nil or arg1.isResponseCurrent())
end

local function checkAndReportStaleResponse(arg1, arg2, str1: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    if arg1.isCurrentRequest(arg2.accountPlayerId, arg2.accountGeneration) then
        return false
    end
    local str2 = if arg2.enableStreaming then "streaming" else "buffered"
    SduiPageAnalytics.sendStaleResponseDiscarded(arg2.surfaceKey, str2, str1)
    return true
end

local function getSduiRequestEndpointForCounters(url: string?): string
    if url == nil or url == "" then
        return "unknown"
    end

    local var1 = string.gsub(url, "^%a[%w+.%-]*://", "")
    local var2 = string.match(var1, "^[^?#]*")
    if var2 == nil or var2 == "" then
        return "unknown"
    end

    local var3, var4 = string.match(var2, "^([^/]*)(.*)$")
    local tbl1 = {}
    for value in string.gmatch(var4, "[^/]+") do
        table.insert(tbl1, if string.match(value, "^%d+$") ~= nil then "{id}" else value)
    end

    return `{var3}/{table.concat(tbl1, "/")}`
end

local function createSduiApiStore(tbl1)
    local cache = createDataCache(nil, nil, FFlagDataHydrationAccountReset and { observeLocalUser = false } or nil)

    local tbl2 = ({})
    local tbl3 = FFlagLuaAppEnableSduiHomePage and {} or nil
    local tbl4 = ({})

    local tbl5 = ({})

    local function completeActiveRequest(str1: string, bool1: boolean, arg1, arg2, bool2: boolean?)
        local var1 = tbl5[str1]
        if var1 then
            tbl5[str1] = nil
            if bool1 then
                var1.resolve(arg1)
            else
                var1.reject(arg1)
            end
        end

        if not bool1 or bool2 == false then
            return
        end

        local var2 = tbl2[str1]
        if var2 and var2.onSuccess then
            var2.onSuccess(arg1, arg2)
        end
    end

    local function isInFlight(str1: string): boolean
        if tbl5[str1] ~= nil then
            return true
        end
        if not FFlagSduiReleaseSearchResultsPageState then
            return tbl4[str1] == true
        end

        local var1 = tbl4[str1]
        return not (var1 == nil) and not var1.released
    end

    local tbl6 = ({})
    local dataResolver = nil

    local function getInputDataSignals(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local tbl7 = tbl6[str1]
        if tbl7 == nil then
            local get, set = Signals.createSignal(nil)
            tbl7 = { get = get, set = set }

            tbl6[str1] = tbl7
        end
        return tbl7
    end

    local tbl7 = FFlagSduiReleaseSearchResultsPageState and {} or nil

    local function registerInputDataSignalKey(str1: string, str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local var1 = tbl7
        if var1 == nil then
            return
        end
        local tbl8 = var1[str1]
        if tbl8 == nil then
            tbl8 = {}
            var1[str1] = tbl8
        end
        tbl8[str2] = true
    end

    local function createGetInputDataSignalsForRequest(configKey: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        return function(str1: string)
            if FFlagSduiReleaseSearchResultsPageState then
                registerInputDataSignalKey(configKey, str1)
            end

            return (getInputDataSignals(str1))
        end
    end

    local tbl8 = ({})

    local function getInputDataSignalsGeneration(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        local tbl9 = tbl8[str1]
        if tbl9 == nil then
            local get, set = Signals.createSignal(0)
            tbl9 = { get = get, set = set }

            tbl8[str1] = tbl9
        end
        return tbl9
    end

    local function bumpInputDataSignalsGeneration(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        getInputDataSignalsGeneration(str1).set(function(num2: number): number
            return num2 + 1
        end)
    end

    local function setInputDataSignals(str1: string, str2: string, tbl9)
        tbl6[str2] = tbl9
        if FFlagSduiReleaseSearchResultsPageState then
            registerInputDataSignalKey(str1, str2)
        end

        bumpInputDataSignalsGeneration(str2)

        if str2 ~= str1 then
            bumpInputDataSignalsGeneration(str1)
        end
    end

    local var1 = nil

    local function fetchFunction(configKey: string, arg1, requestConfig, func1: ((...any) -> (...any))?)
        local var2 = FFlagLuaAppEnableSduiHomePage and requestConfig ~= nil
        if not (FFlagLuaAppEnableSduiHomePage and var2) then
            requestConfig = tbl2[configKey]
        end

        if not requestConfig then
            return Promise.reject("No request config for key", configKey)
        end

        local var3 = nil
        if FFlagSduiReleaseSearchResultsPageState and not var2 then
            var3 = { released = false }
            tbl4[configKey] = var3
        end

        local func2 = completeActiveRequest
        if FFlagLuaAppEnableSduiHomePage then
            func2 = var2 and function(_, arg3, arg4, arg5)
                if arg3 and requestConfig.onSuccess then
                    requestConfig.onSuccess(arg4, arg5)
                end
            end or func2
        end

        local url = requestConfig.url
        local str1 = if FFlagSduiRequestCounters then getSduiRequestEndpointForCounters(url) else ""
        local loadTimer = requestConfig.loadTimer

        loadTimer.logUiRequestSent()

        local bool1 = requestConfig.responseType == SduiResponseType.ProtobufJson

        local postConfig = requestConfig.postConfig

        local method = if postConfig then "POST" else "GET"
        local enableStreaming = requestConfig.enableStreaming
        local decodeResponse = if bool1 then makeProtobufJsonResponseDecoder(requestConfig.apiProto) else makeProtoResponseDecoder(requestConfig.apiProto)
        local enableInputDataMerge = if FFlagSduiStreamingRefreshReplacesInputData then requestConfig.enableInputDataMerge else nil

        local function processSduiResponse(response)
            local paginateResponse = requestConfig.isPaginated and arg1.data(false) ~= nil
            local var4 = if FFlagLuaAppEnableSduiHomePage or FFlagSduiStreamingRefreshReplacesInputData then if enableInputDataMerge ~= nil then enableInputDataMerge else enableStreaming or requestConfig.enableInputDataMerge or nil else nil
            local var7, var8 = handleSduiApiResponse({
                response = response,
                loadTimer = loadTimer,
                surfaceKey = requestConfig.surfaceKey,
                configCacheKey = requestConfig.configKey,
                decodeResponse = decodeResponse,
                parseHydrationDataFromResponse = SduiProtobufResponseHelpers.parseHydrationDataFromResponse,
                parseTemplateEntriesFromResponse = requestConfig.parseTemplateEntriesFromResponse or SduiProtobufResponseHelpers.parseTemplateEntriesFromResponse,
                parsePageEntriesFromResponse = requestConfig.parsePageEntriesFromResponse or SduiProtobufResponseHelpers.parsePageEntriesFromResponse,
                parseLocalizedLiteralsFromResponse = requestConfig.parseLocalizedLiteralsFromResponse or SduiProtobufResponseHelpers.parseLocalizedLiteralsFromResponse,
                getInputDataSignalsForRequest = if FFlagSduiReleaseSearchResultsPageState then createGetInputDataSignalsForRequest(configKey) else getInputDataSignals,
                setInputDataSignalsForRequest = if FFlagSduiFreshInputDataSignalOnRebuild then setInputDataSignals else nil,
                enableStreamingMerge = enableStreaming,
                enableInputDataMerge = var4,
                paginateResponse = paginateResponse,
                buildNextPageUrl = requestConfig.buildNextPageUrl,
                buildNextPagePostBody = requestConfig.buildNextPagePostBody,
                allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then requestConfig.allowNoConfigsBuilt else nil,
                mergeStrategy = requestConfig.mergeStrategy,
                cacheSingleEntryWithIdentifier = if FFlagLuaAppEnableSduiHomePage then requestConfig.cacheSingleEntryWithIdentifier else nil,
                enableTemplateCache = requestConfig.enableTemplateCache
            })
            if FFlagSduiStreamingRefreshReplacesInputData then
                enableInputDataMerge = nil
            end
            return var7, var8
        end

        local function func3(arg3)
            local recoverFromError = requestConfig.recoverFromError
            if recoverFromError == nil then
                return nil
            end

            local var5 = arg1.data(false)
            if type(var5) == "table" and next(var5) ~= nil then
                return var5
            end

            local function reportUnusable(message: string) -- Luacid: Inlined by compiler; 3 call sites recovered
                SduiLogger.reportError(
                    SduiErrors.SduiErrorType.FailedToApplyFallbackResponse,
                    {
                        message = message,
                        name = requestConfig.surfaceKey
                    },
                    requestConfig.surfaceKey
                )
            end
            local success, result = pcall(recoverFromError.getDecodedResponse, arg3)
            if not success then
                reportUnusable(`recovery errored: {SduiParseHelpers.stringifyValue(result)}`)
                return nil
            end
            if result == nil then
                return nil
            end

            local success2, result2 = pcall(var1, {
                surfaceKey = requestConfig.surfaceKey,
                configKey = configKey,
                decodedResponse = result,
                loadTimer = loadTimer,
                apiProto = requestConfig.apiProto,
                requestConfig = requestConfig
            })
            if not success2 then
                reportUnusable(`recovery errored: {SduiParseHelpers.stringifyValue(result2)}`)
                return nil
            end

            local var6 = arg1.data(false)
            if type(var6) ~= "table" or next(var6) == nil then
                reportUnusable("recovery built no configs")
                return nil
            end

            loadTimer.updateRequestStatus(SduiRequestStatus.LoadedFromCache)
            if recoverFromError.onApplied ~= nil then
                recoverFromError.onApplied()
            end
            return var6
        end

        local var5 = nil

        local sduiStreamingResponseHandler = if enableStreaming then createSduiStreamingResponseHandler({
            configKey = configKey,
            loadTimer = loadTimer,
            processFrame = function(str3: string)
                if FFlagSduiReleaseSearchResultsPageState and var3 and var3.released then
                    return true, nil
                end

                if FFlagHomePageRefetchOnDataHydrationAccountReset
                    and checkAndReportStaleResponse(dataResolver, requestConfig, "streamFrame")
                then
                    return true, arg1.data(false)
                end

                if (FFlagLuaAppEnableSduiHomePage or FFlagLuaAppSduiSearchAutocomplete) and not shouldApplyResponse(requestConfig, func1) then
                    return true, arg1.data(false)
                end
                local success, result, result2 = pcall(processSduiResponse, { statusCode = 200, responseBody = buffer.fromstring(str3), stats = {} })

                if not success then
                    return false, result
                end

                var5 = result2
                local var6 = accumulateSduiCacheSubEntries(result, arg1.data(false))
                cache.updateItems({ [configKey] = var6 })
                return true, var6
            end
        }) else nil

        local function createRequestPromise(func4: (...any) -> (...any))
            return Promise.new(function(arg3, arg4, callback)
                local var6 = arg3
                local var7 = arg3
                local statusCode = nil
                local httpError = nil
                if FFlagSduiRequestCounters then
                    local var8 = arg3
                    local var9 = arg4
                    arg3 = function(arg5)
                        SduiPageAnalytics.sendRequestOutcomeCounter(requestConfig.surfaceKey, str1, "success", statusCode, httpError)

                        return var8(arg5)
                    end
                    arg4 = function(arg5)
                        SduiPageAnalytics.sendRequestOutcomeCounter(requestConfig.surfaceKey, str1, "failure", statusCode, httpError)

                        return var9(arg5)
                    end
                end

                local function func5(arg5, arg6)
                    local var8 = func3(arg5)
                    if var8 ~= nil then
                        if FFlagSduiRequestCounters then
                            SduiPageAnalytics.sendRequestOutcomeCounter(requestConfig.surfaceKey, str1, "failure", statusCode, httpError)
                        end

                        var7(var8)
                        return (if FFlagLuaAppEnableSduiHomePage then func2 else completeActiveRequest)(configKey, false, arg5)
                    end

                    (if FFlagLuaAppEnableSduiHomePage then func2 else completeActiveRequest)(configKey, false, arg5)

                    local var9 = arg4

                    if arg6 ~= nil then
                        arg5 = arg6
                    end

                    return var9(arg5)
                end

                local var8 = func4(function(arg5, arg6)
                    if FFlagHomePageRefetchOnDataHydrationAccountReset and checkAndReportStaleResponse(dataResolver, requestConfig, "response") then
                        return var6(nil)
                    end
                    if FFlagSduiReleaseSearchResultsPageState and var3 and var3.released then
                        return var6(nil)
                    end

                    loadTimer.logUiResponseReceived()

                    if not (FFlagLuaAppEnableSduiHomePage and var2) then
                        if FFlagSduiReleaseSearchResultsPageState then
                            if var3 and tbl4[configKey] == var3 then
                                tbl4[configKey] = nil
                            end
                        else
                            tbl4[configKey] = false
                        end
                    end

                    SduiPageAnalytics.sendPageStatusEvent(requestConfig.surfaceKey, arg6.statusCode, arg6.httpError)

                    if FFlagSduiRequestCounters then
                        statusCode = arg6.statusCode
                        httpError = arg6.httpError
                    end

                    if not arg5 then
                        if not (FFlagLuaAppEnableSduiHomePage or FFlagLuaAppSduiSearchAutocomplete) or shouldApplyResponse(requestConfig, func1) then
                            return func5(arg6)
                        end

                        if (FFlagLuaAppEnableSduiApiStoreInFlightFix or FFlagLuaAppSduiSearchAutocomplete) and not var2 then
                            local str3 = configKey
                            local var8 = tbl5[str3]
                            if var8 then
                                tbl5[str3] = nil

                                var8.resolve(nil)
                            end
                        end

                        return arg3(nil)
                    end

                    local statusCode2 = arg6.statusCode
                    local httpError2 = arg6.httpError
                    local var8 = if statusCode2 then tonumber(statusCode2) else nil
                    local bool2 = arg6.wasTransportFailure == true

                    if var8 and var8 >= 400 or httpError2 and httpError2 ~= Enum.HttpError.OK or bool2 then
                        loadTimer.updateRequestStatus(SduiRequestStatus.FailedToLoad)

                        if not (FFlagLuaAppEnableSduiHomePage or FFlagLuaAppSduiSearchAutocomplete) or shouldApplyResponse(requestConfig, func1) then
                            return func5(arg6)
                        end

                        if (FFlagLuaAppEnableSduiApiStoreInFlightFix or FFlagLuaAppSduiSearchAutocomplete) and not var2 then
                            local str3 = configKey
                            local var9 = tbl5[str3]
                            if var9 then
                                tbl5[str3] = nil

                                var9.resolve(nil)
                            end
                        end

                        return arg3(nil)
                    end

                    loadTimer.updateRequestStatus(SduiRequestStatus.LoadedFromNetwork)

                    if (FFlagLuaAppEnableSduiHomePage or FFlagLuaAppSduiSearchAutocomplete) and not shouldApplyResponse(requestConfig, func1) then
                        if (FFlagLuaAppEnableSduiApiStoreInFlightFix or FFlagLuaAppSduiSearchAutocomplete) and not var2 then
                            local str3 = configKey
                            local var9 = tbl5[str3]
                            if var9 then
                                tbl5[str3] = nil

                                var9.resolve(nil)
                            end
                        end

                        return arg3(nil)
                    end

                    local responseBody = arg6.responseBody

                    SduiPageAnalytics.sendPagePayloadSizeEvent(requestConfig.surfaceKey, responseBody)

                    if sduiStreamingResponseHandler then
                        local var9 = sduiStreamingResponseHandler.finalize(responseBody)
                        if var9.ok then
                            (if FFlagLuaAppEnableSduiHomePage then func2 else completeActiveRequest)(configKey, true, var9.value, var5)

                            return arg3(var9.value)
                        end
                        local message = SduiParseHelpers.stringifyValue(var9.value)
                        SduiLogger.reportError(
                            SduiErrors.SduiErrorType.FailedToFetchPage,
                            {
                                message = message,
                                name = requestConfig.surfaceKey
                            },
                            requestConfig.surfaceKey
                        )
                        loadTimer.updateRequestStatus(SduiRequestStatus.FailedToLoad)
                        return func5(var9.value)
                    end

                    local success, result, result2 = pcall(processSduiResponse, arg6)

                    if not success then
                        local var9 = SduiParseHelpers.stringifyValue(result)

                        SduiLogger.reportError(
                            SduiErrors.SduiErrorType.FailedToFetchPage,
                            {
                                message = `handleSduiApiResponse not successful for {url} err {var9}`,
                                name = requestConfig.surfaceKey
                            },
                            requestConfig.surfaceKey
                        )
                        return func5(result, arg1)
                    end

                    local tbl9 = ({})

                    if FFlagPromptsEdpOpenReplaceOnFetch and requestConfig.replaceOnFetch then
                        local var9 = arg1.data(false)
                        for value, value2 in result do
                            tbl9[value] = value2
                        end
                        if var9 then
                            for value in var9 do
                                if result[value] == nil then
                                    tbl9[value] = Cryo.None
                                end
                            end
                        end
                    elseif next(result) then
                        local var9 = arg1.data(false)
                        for value, value2 in result do
                            local var10 = var9 and var9[value]
                            if var10 then
                                value2 = Cryo.Dictionary.join(var10, value2)
                            end

                            tbl9[value] = value2
                        end
                    elseif requestConfig.clearOnEmptyResponse and requestConfig.configKey then
                        tbl9[requestConfig.configKey] = {}
                    end

                    (if FFlagLuaAppEnableSduiHomePage then func2 else completeActiveRequest)(configKey, true, tbl9, result2)

                    return arg3(tbl9)
                end)

                if var8 ~= nil then
                    callback(var8)
                end
            end)
        end

        local body = if postConfig then SduiApiStorePostConfig.getBodyFromPostConfig(postConfig) else nil
        local contentType = if postConfig then SduiApiStorePostConfig.getContentTypeHeaderFromPostConfig(postConfig) else nil
        local var6 = SduiRetryPolicy.resolve(requestConfig.retry)
        if FFlagSduiRequestCounters and var6 ~= nil then
            local onRetry = var6.onRetry
            var6 = Cryo.Dictionary.join(var6, {
                onRetry = function(num2: number)
                    if onRetry ~= nil then
                        onRetry(num2)
                    end
                    SduiPageAnalytics.sendRequestRetryCounter(requestConfig.surfaceKey, str1, num2)
                end
            })
        end

        local requestDeadlineSec = if tbl1 and tbl1.requestDeadlineSec then tbl1.requestDeadlineSec else SduiRetryPolicy.getRequestDeadlineSec()
        local tbl9 = {
            url = url,
            method = method,
            body = body,
            contentType = contentType,
            accept = if bool1 then "application/json" else "application/x-protobuf",
            analyticsKey = requestConfig.surfaceKey,
            priority = priority,
            retry = var6,
            deadlineSec = requestDeadlineSec,
            network = if tbl1 then tbl1.network or nil else nil,
            delivery = sduiStreamingResponseHandler and {
                mode = "streaming",
                onMessage = sduiStreamingResponseHandler.handleChunk
            }
                or { mode = "buffered" }
        }

        return createRequestPromise(function(callback)
            local var7 = sendSduiHttpRequest(tbl9)
            var7:andThen(function(arg3)
                callback(true, arg3)
            end, function(arg3)
                if typeof(arg3) == "table" and (arg3.statusCode ~= nil or arg3.httpError ~= nil) then
                    callback(true, arg3)
                    return
                end
                callback(false, arg3)
            end)

            return function()
                var7:cancel()
            end
        end)
    end

    dataResolver = createDataResolver({
        cache = cache,
        fetchFn = fetchFunction,
        queueProcessDelaySec = 0,
        supportsMultiGet = false,
        requestTimeoutSec = SduiRetryPolicy.getFetchTimeoutSec(),
        onBeforeClear = FFlagHomePageRefetchOnDataHydrationAccountReset and function()
            local tbl9 = tbl5
            tbl5 = {}
            tbl4 = {}
            tbl2 = {}
            if tbl3 ~= nil then
                tbl3 = {}
            end

            tbl6 = {}
            if FFlagSduiReleaseSearchResultsPageState then
                tbl7 = {}
            end
            for _, value in tbl9 do
                value.resolve(nil)
            end
        end or nil
    })

    local function fetchIfNeeded(arg1, bool1: boolean?)
        if arg1.responseType == nil then
            arg1.responseType = SduiResponseType.Protobuf
        end

        local configKey = arg1.configKey or arg1.url
        local var3 = FFlagLuaAppEnableSduiHomePage and arg1.concurrencyPolicy == SduiRequestConcurrencyPolicy.LatestWins
        arg1.configKey = configKey
        arg1.loadTimer.logUiRequestQueued()
        if FFlagHomePageRefetchOnDataHydrationAccountReset then
            arg1.accountGeneration = dataResolver.getAccountGeneration(false)
            arg1.accountPlayerId = getLocalPlayerUserId()
        end

        if FFlagLuaAppEnableSduiHomePage and var3 then
            local var4 = arg1.concurrencyKey or configKey
            local var5 = tbl3
            local var6 = (var5[var4] or 0) + 1
            var5[var4] = var6

            return fetchFunction(configKey, dataResolver.getCachedItem(configKey), arg1, function(): boolean
                return var5[var4] == var6
            end):andThen(function(nil1: nil)
                if FFlagHomePageRefetchOnDataHydrationAccountReset
                    and nil1 ~= nil
                    and checkAndReportStaleResponse(dataResolver, arg1, "cacheCommit")
                then
                    return nil
                end

                if nil1 ~= nil and not arg1.enableInputDataMerge then
                    cache.updateItems({ [configKey] = nil1 })
                end
                return nil1
            end)
        end

        tbl2[configKey] = arg1

        local _, var4 = dataResolver.getAndFetchItem(configKey, bool1 and function(): boolean
            return true
        end or nil, arg1.staleTimeSec)

        if not var4 then
            return Promise.resolve()
        end

        if not tbl5[configKey] then
            local var5 = nil
            local var6 = nil
            local promise = Promise.new(function(arg2, arg3)
                var5 = arg2
                var6 = arg3
            end)
            promise:catch(function(_) end)
            tbl5[configKey] = { promise = promise, resolve = var5, reject = var6 }
        end

        return tbl5[configKey].promise
    end

    local function getInputData(str1: string, str2: string?, arg1)
        local var2 = if str2 and str2 ~= "" then `{str1}_{str2}` else nil

        if FFlagSduiFreshInputDataSignalOnRebuild and arg1 then
            getInputDataSignalsGeneration(var2 or str1).get(arg1)
        end
        local var3 = resolveSduiCacheEntry(tbl6, str1, var2)
        if var3 == nil then
            return nil
        end
        local get = var3.get

        if arg1 == nil then
            arg1 = false
        end

        return get(arg1)
    end

    local function forEachInputData(str1: string, func1: (...any) -> (...any))
        local var2 = dataResolver.getCachedItem(str1).data(false)
        if var2 == nil then
            return
        end
        for value in var2 do
            local var3 = tbl6[value]
            local var4 = if var3 then var3.get(false) else nil

            if var4 ~= nil and func1(value, var4) then
                return
            end
        end
    end

    local function setInputDataField(str1: string, str2: string, str3: string, arg1): boolean
        local var2 = dataResolver.getCachedItem(str1).data(false)
        local var3 = tbl6[str2]
        if var2 == nil or var2[str2] == nil or var3 == nil then
            return false
        end
        local var4 = var3.get(false)
        local var5 = if var4 then var4[str3] else nil

        if var5 == nil or arg1 == nil or typeof(arg1) ~= typeof(var5) then
            return false
        end

        local var6 = table.clone(var4)
        var6[str3] = arg1
        var3.set(var6)
        return true
    end

    local function getRootConfig(str1: string, arg1, str2: string?)
        local var2 = dataResolver.getCachedItem(str1).data(arg1)
        local var3 = if FFlagSduiAlwaysCacheWithIdentifier then resolveSduiCacheEntry(var2, str1, str2) else var2 and var2[str2 or str1]
        return if var3 then var3.config else nil
    end

    local function getTitle(str1: string, arg1, str2: string?)
        local var2 = dataResolver.getCachedItem(str1).data(arg1)
        local var3 = if FFlagSduiAlwaysCacheWithIdentifier then resolveSduiCacheEntry(var2, str1, str2) else var2 and var2[str2 or str1]
        return if var3 and var3.title ~= "" then var3.title else nil
    end

    local function getDataUpdatedTimestamp(str1: string, arg1, str2: string?)
        local var2 = dataResolver.getCachedItem(str1).data(arg1)
        local var3 = if FFlagSduiAlwaysCacheWithIdentifier then resolveSduiCacheEntry(var2, str1, str2) else var2 and var2[str2 or str1]
        return if var3 then var3.dataUpdatedTimestamp else nil
    end

    local function getEntrySurfacing(str1: string, str2: string?, arg1)
        local var2 = dataResolver.getCachedItem(str1).data(arg1)
        local var3 = if FFlagSduiAlwaysCacheWithIdentifier then resolveSduiCacheEntry(var2, str1, str2) else var2 and var2[str2 or str1]
        return if var3 then var3.surfacing else nil
    end

    local function loadMoreFromApi(tbl9)
        local var2 = tbl2[tbl9.configKey]
        if not var2 then
            SduiLogger.reportError(
                SduiErrors.SduiErrorType.FailedToPaginateRequest,
                {
                    message = `No requestData for {tbl9.configKey}`
                },
                "unknown"
            )
            return Promise.resolve()
        end

        local var3 = dataResolver.getCachedItem(tbl9.configKey).data(false)
        local var4 = if FFlagSduiAlwaysCacheWithIdentifier then resolveSduiCacheEntry(var3, tbl9.configKey, tbl9.identifier) else var3 and var3[tbl9.identifier or tbl9.configKey]

        if not var4 then
            SduiLogger.reportError(
                SduiErrors.SduiErrorType.FailedToPaginateRequest,
                {
                    message = `No entry data for {tbl9.configKey}`,
                    name = var2.surfaceKey
                },
                var2.surfaceKey
            )
            return Promise.resolve()
        end

        local nextPageUrl = var4.nextPageUrl
        if not nextPageUrl or nextPageUrl == "" then
            return Promise.resolve()
        end
        local tbl10 = {
            url = nextPageUrl,
            loadTimer = tbl9.loadTimer,
            isPaginated = true
        }

        if var2.postConfig and var4.nextPagePostBody then
            tbl10.postConfig = Cryo.Dictionary.join(var2.postConfig, { body = var4.nextPagePostBody })
        end
        return fetchIfNeeded(Cryo.Dictionary.join(var2, tbl10), true)
    end

    local function refreshFromApi(tbl9)
        local var2 = tbl2[tbl9.configKey]
        if not var2 then
            SduiLogger.reportError(
                SduiErrors.SduiErrorType.FailedToFetchPage,
                {
                    message = `No requestData for refresh: {tbl9.configKey}`
                },
                "unknown"
            )
            return Promise.resolve()
        end
        if var2.refresh then
            return var2.refresh(tbl9.loadTimer)
        end

        local tbl10 = {
            url = (if var2.buildRefreshUrl then var2.buildRefreshUrl() else nil) or var2.url,
            loadTimer = tbl9.loadTimer,
            isPaginated = Cryo.None
        }
        if FFlagSduiStreamingRefreshReplacesInputData and not var2.enableInputDataMerge then
            tbl10.enableInputDataMerge = false
        end
        if var2.postConfig then
            local body = if var2.buildRefreshPostBody then var2.buildRefreshPostBody() else nil

            if body then
                tbl10.postConfig = Cryo.Dictionary.join(var2.postConfig, { body = body })
            end
        end
        return fetchIfNeeded(Cryo.Dictionary.join(var2, tbl10), true)
    end

    var1 = function(tbl9)
        local configKey = tbl9.configKey
        local loadTimer = tbl9.loadTimer

        if tbl9.requestConfig ~= nil then
            tbl2[configKey] = tbl9.requestConfig
        else
            loadTimer.logUiRequestQueued()
            tbl2[configKey] = {
                url = `inline://{configKey}`,
                surfaceKey = tbl9.surfaceKey,
                configKey = configKey,
                loadTimer = loadTimer,
                apiProto = tbl9.apiProto,
                responseType = SduiResponseType.Protobuf
            }
        end

        local requestConfig = tbl9.requestConfig
        local var2 = dataResolver.getCachedItem(configKey).data(false)

        local success, result = pcall(function()
            return handleSduiApiResponse({
                response = {
                    statusCode = 200,
                    responseBody = tbl9.decodedResponse,
                    stats = {}
                },
                loadTimer = loadTimer,
                surfaceKey = tbl9.surfaceKey,
                configCacheKey = configKey,
                decodeResponse = function<T>(arg1: T): T
                    return arg1
                end,
                parseHydrationDataFromResponse = SduiProtobufResponseHelpers.parseHydrationDataFromResponse,
                parseTemplateEntriesFromResponse = if requestConfig ~= nil then requestConfig.parseTemplateEntriesFromResponse or SduiProtobufResponseHelpers.parseTemplateEntriesFromResponse else SduiProtobufResponseHelpers.parseTemplateEntriesFromResponse,
                parsePageEntriesFromResponse = if requestConfig ~= nil then requestConfig.parsePageEntriesFromResponse or SduiProtobufResponseHelpers.parsePageEntriesFromResponse else SduiProtobufResponseHelpers.parsePageEntriesFromResponse,
                parseLocalizedLiteralsFromResponse = if requestConfig ~= nil then requestConfig.parseLocalizedLiteralsFromResponse or SduiProtobufResponseHelpers.parseLocalizedLiteralsFromResponse else SduiProtobufResponseHelpers.parseLocalizedLiteralsFromResponse,
                getInputDataSignalsForRequest = if FFlagSduiReleaseSearchResultsPageState then createGetInputDataSignalsForRequest(configKey) else getInputDataSignals,
                setInputDataSignalsForRequest = if FFlagSduiFreshInputDataSignalOnRebuild then setInputDataSignals else nil,
                paginateResponse = false,
                allowNoConfigsBuilt = if requestConfig == nil or not FFlagSduiAllowNoConfigsBuilt then nil else requestConfig.allowNoConfigsBuilt,
                mergeStrategy = if requestConfig == nil then nil else requestConfig.mergeStrategy,
                enableTemplateCache = if requestConfig == nil then nil else requestConfig.enableTemplateCache,
                cacheSingleEntryWithIdentifier = true
            })
        end)

        if not success then
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToFetchPage, {
                message = `seedFromDecodedResponse failed for {configKey}: {SduiParseHelpers.stringifyValue(result)}`,
                name = tbl9.surfaceKey
            }, tbl9.surfaceKey)
            error(result)
        end

        if FFlagAppChatConversationTrustedFriendUpsellBanner and tbl9.replace then
            cache.replaceItems({ [configKey] = result })
            return
        end
        local var3 = accumulateSduiCacheSubEntries(result, var2)
        cache.updateItems({ [configKey] = var3 })
    end

    local function dismissEntry(title: string)
        local result = {}
        if typeof(title) ~= "string" or title == "" then
            return result
        end

        for value in tbl2 do
            local var2 = dataResolver.getCachedItem(value).data(false)
            if not var2 then
                continue
            end

            local bool1 = false
            local tbl9 = ({})
            for value2, value3 in var2 do
                if value3 and value3.category ~= nil and value3.title == title then
                    bool1 = true
                else
                    tbl9[value2] = value3
                end
            end

            if bool1 then
                cache.replaceItems({ [value] = tbl9 })
                table.insert(result, value)
            end
        end

        return result
    end

    local function clearConfigEntries(str1: string)
        if typeof(str1) ~= "string" or str1 == "" then
            return
        end

        cache.replaceItems({ [str1] = {} })
    end

    local function releaseConfigKey(str1: string)
        if str1 == "" then
            return
        end
        local var2 = tbl7
        local var3 = if var2 then var2[str1] else nil

        if var3 ~= nil then
            for value in var3 do
                tbl6[value] = nil
                tbl8[value] = nil
            end
        end
        if var2 ~= nil then
            var2[str1] = nil
        end

        tbl2[str1] = nil
        local var4 = tbl4[str1]
        if var4 then
            var4.released = true
            tbl4[str1] = nil
        end
        local var5 = tbl5[str1]
        tbl5[str1] = nil
        if var5 then
            var5.resolve(nil)
        end

        dataResolver.releaseItem(str1)
    end

    local tbl9 = {
        fetchIfNeeded = fetchIfNeeded,
        releaseConfigKey = 0,
        isInFlight = 0,
        clearConfigEntries = 0,
        dismissEntry = 0,
        seedFromDecodedResponse = 0,
        getData = 0,
        getInputData = 0,
        forEachInputData = 0,
        setInputDataField = 0,
        getRootConfig = 0,
        getTitle = 0,
        getDataUpdatedTimestamp = 0,
        getAccountGeneration = 0,
        getEntrySurfacing = 0,
        loadMoreFromApi = 0,
        refreshFromApi = 0
    }

    if not FFlagSduiReleaseSearchResultsPageState then
        releaseConfigKey = nil
    end

    tbl9.releaseConfigKey = releaseConfigKey
    tbl9.isInFlight = isInFlight
    if not FFlagAppChatConversationTrustedFriendUpsellBanner then
        clearConfigEntries = nil
    end

    tbl9.clearConfigEntries = clearConfigEntries

    if not FFlagSduiDismissPromptAction then
        dismissEntry = nil
    end

    tbl9.dismissEntry = dismissEntry
    tbl9.seedFromDecodedResponse = var1
    tbl9.getData = dataResolver.getCachedItem
    tbl9.getInputData = getInputData
    if not FFlagSduiApiStoreUpdateInputData then
        forEachInputData = nil
    end

    tbl9.forEachInputData = forEachInputData
    if not FFlagSduiApiStoreUpdateInputData then
        setInputDataField = nil
    end

    tbl9.setInputDataField = setInputDataField
    tbl9.getRootConfig = getRootConfig
    tbl9.getTitle = getTitle
    tbl9.getDataUpdatedTimestamp = getDataUpdatedTimestamp
    tbl9.getAccountGeneration = if FFlagHomePageRefetchOnDataHydrationAccountReset then dataResolver.getAccountGeneration else nil

    tbl9.getEntrySurfacing = getEntrySurfacing
    tbl9.loadMoreFromApi = loadMoreFromApi
    tbl9.refreshFromApi = refreshFromApi
    return tbl9
end

return createSduiApiStore
