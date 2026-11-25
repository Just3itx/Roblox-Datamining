-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local Signals = require(SduiSharedUtilitiesParent.Signals)
local SduiCoreSystem = require(SduiSharedUtilitiesParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local addSduiErrorContextFields = SduiCoreSystem.addSduiErrorContextFields
local SduiLogger = SduiCoreSystem.SduiLogger
local SduiUsageRecorder = SduiCoreSystem.SduiUsageRecorder
local recordTemplateUsage = SduiCoreSystem.recordTemplateUsage
local getSduiTemplateStore = require(SduiSharedUtilities.getSduiTemplateStore)
local SduiProtobufResponseHelpers = require(SduiSharedUtilities.SduiProtobufResponseHelpers)
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local SduiRequestStatus = require(SduiSharedUtilities.SduiIntegrationTypes).SduiRequestStatus
local SduiInputDataMerge = require(SduiSharedUtilities.SduiInputDataMerge)
local processClientHints = require(SduiSharedUtilities.processClientHints)
local getSduiClientBindingBuilder = SduiCoreSystem.getSduiClientBindingBuilder
local createBuilderConfig = SduiCoreSystem.createBuilderConfig
local getSduiDataBinder = SduiCoreSystem.getSduiDataBinder

local FFlagSduiErrorPaths = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiErrorPaths
local FFlagSduiAllowNoConfigsBuilt = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiAllowNoConfigsBuilt
local FFlagSduiAlwaysCacheWithIdentifier = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiAlwaysCacheWithIdentifier
local FFlagEnableSduiV2HomepagePrompts = require(SduiSharedUtilitiesParent.SharedFlags).FFlagEnableSduiV2HomepagePrompts

local FFlagEnableHomepagePromptsForModalsAndBanners = require(SduiSharedUtilitiesParent.SharedFlags).FFlagEnableHomepagePromptsForModalsAndBanners
local FFlagPromptsHandlerEnabled = require(SduiSharedUtilitiesParent.SharedFlags).FFlagPromptsHandlerEnabled
local FFlagLuaAppEnableSduiHomePage = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppEnableSduiHomePage

local FFlagSduiStreamingRefreshReplacesInputData = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiStreamingRefreshReplacesInputData
local FFlagSduiFreshInputDataSignalOnRebuild = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiFreshInputDataSignalOnRebuild
local FFlagSduiSharedLocalizedLiterals = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiSharedLocalizedLiterals
local FFlagLuaAppSduiHomePageSupport = require(SduiSharedUtilitiesParent.SharedFlags).FFlagLuaAppSduiHomePageSupport

local Cryo = require(SduiSharedUtilitiesParent.Cryo)

local function mergeTables(tbl1, tbl2)
    for value, value2 in tbl2 do
        if typeof(value2) == "table" then
            if tbl1[value] == nil then
                tbl1[value] = {}
            end

            if #value2 > 0 then
                for _, value3 in value2 do
                    table.insert(tbl1[value], value3)
                end
            else
                mergeTables(tbl1[value], value2)
            end
        else
            tbl1[value] = value2
        end
    end
end

local function getLocalizedLiteral(str1: string)
    return getSduiTemplateStore().getLocalizedLiterals()[str1]
end

local function handleSduiApiResponse(tbl1)
    local response = tbl1.response
    local decodeResponse = tbl1.decodeResponse
    local parsePageEntriesFromResponse = tbl1.parsePageEntriesFromResponse
    local parseHydrationDataFromResponse = tbl1.parseHydrationDataFromResponse
    local parseTemplateEntriesFromResponse = tbl1.parseTemplateEntriesFromResponse
    local parseLocalizedLiteralsFromResponse = tbl1.parseLocalizedLiteralsFromResponse
    local getInputDataSignalsForRequest = tbl1.getInputDataSignalsForRequest
    local setInputDataSignalsForRequest = tbl1.setInputDataSignalsForRequest
    local loadTimer = tbl1.loadTimer
    local surfaceKey = tbl1.surfaceKey
    local var1 = tbl1.configCacheKey or tbl1.surfaceKey
    local enableTemplateCache = tbl1.enableTemplateCache
    local paginateResponse = tbl1.paginateResponse
    local buildNextPageUrl = tbl1.buildNextPageUrl
    local buildNextPagePostBody = tbl1.buildNextPagePostBody
    local allowNoConfigsBuilt = if FFlagSduiAllowNoConfigsBuilt then tbl1.allowNoConfigsBuilt else nil
    local mergeStrategy = tbl1.mergeStrategy

    local enableInputDataMerge = (FFlagLuaAppEnableSduiHomePage or FFlagSduiStreamingRefreshReplacesInputData) and tbl1.enableInputDataMerge
    assert(var1, "configCacheKey must exist")

    loadTimer.logNetRequestStats(response.stats or {})

    loadTimer.logResponseDecodeBegin()
    local success, result = pcall(function()
        return (decodeResponse(response.responseBody))
    end)
    loadTimer.logResponseDecodeEnd()

    if not success then
        loadTimer.updateRequestStatus(SduiRequestStatus.FailedToLoad)

        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToDecodeResponse, { name = var1, message = result }, surfaceKey)

        error("Failed to decode")
    end

    loadTimer.logResponseDataUpdateBegin()

    if parseHydrationDataFromResponse then
        local success2, result2 = pcall(function()
            local var2 = parseHydrationDataFromResponse(result)
            if var2 ~= nil then
                getSduiDataBinder().updateDataStores(var2)
            end
        end)
        if not success2 then
            SduiLogger.reportError(
                SduiErrors.SduiErrorType.FailedToUpdateDataStores,
                { name = var1, message = result2 },
                surfaceKey
            )
        end
    end

    local tbl2 = {}
    local var2 = nil
    if parseTemplateEntriesFromResponse then
        local success2, result2 = pcall(function()
            local var3, var4, var5 = parseTemplateEntriesFromResponse(result, if FFlagSduiErrorPaths then true else enableTemplateCache)
            tbl2 = var4

            if FFlagSduiErrorPaths and not enableTemplateCache then
                var2 = var5
            end

            getSduiTemplateStore().addTemplates(var3)

            if enableTemplateCache then
                getSduiTemplateStore().recordSurfaceTemplates(surfaceKey, var5)
            end

            if not var3 then
                return
            end

            for _, value in var3 do
                pcall(recordTemplateUsage, surfaceKey, value)
            end
            SduiUsageRecorder.scheduleFlush()
        end)

        if not success2 then
            SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToAddTemplates, { name = var1, message = result2 }, surfaceKey)
        end
    end

    local function getTemplateIdForRCT(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        if enableTemplateCache then
            return getSduiTemplateStore().getCachedRobloxComponentToTemplateId(surfaceKey)[str1]
        end

        return var2 and var2[str1]
    end

    local function createErrorContextForRCT(rctPath: string?, arg1)
        local var3

        if arg1 then
            if rctPath then
                var3 = `{surfaceKey}.{rctPath}`
            else
                var3 = surfaceKey
            end

            local identifier = arg1.identifier
            if identifier and identifier ~= "" then
                var3 = `{var3}[{identifier}]`
            end
        else
            var3 = nil
        end

        return {
            fullName = var3,
            rctPath = rctPath,
            templateId = if rctPath then getTemplateIdForRCT(rctPath) else nil
        }
    end

    loadTimer.logResponseDataUpdateEnd()

    loadTimer.logSduiTreeBuildBegin()

    local pageEntries = not parsePageEntriesFromResponse and {} or parsePageEntriesFromResponse(result)
    local var4 = if parseLocalizedLiteralsFromResponse then parseLocalizedLiteralsFromResponse(result) else SduiProtobufResponseHelpers.parseLocalizedLiteralsFromResponse(result)

    if FFlagSduiSharedLocalizedLiterals and var4 then
        getSduiTemplateStore().addLocalizedLiterals(var4)
    end

    local function resolveTemplateForRobloxComponent(name: string, arg1)
        local var5 = tbl2[name]
        if var5 == nil then
            var5 = getSduiTemplateStore().getTemplateForRobloxComponent(surfaceKey, name)
        end

        if var5 == nil then
            local tbl3 = {
                name = name,
                message = `Backend omitted template for {name} but it could not be resolved from the surface cache + template store`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl3, (createErrorContextForRCT(name, arg1)))
            end
            SduiLogger.reportError(SduiErrors.SduiErrorType.MissingCachedTemplate, tbl3, surfaceKey)
        end

        return var5
    end

    local tbl3 = ({})

    local var5 = nil
    local bool1 = #pageEntries > 1
    local identifier, var6, componentInputData, tbl4, var7, enableStreamingMerge

    for _, value in pageEntries do
        do
            local num1 = 1

            if num1 == 1 then
                identifier = value.identifier
                if (bool1 or FFlagSduiAlwaysCacheWithIdentifier or tbl1.cacheSingleEntryWithIdentifier) and identifier and identifier ~= "" then
                    var6 = `{var1}_{identifier}`
                else
                    var6 = var1
                end
                componentInputData = value.componentInputData
                tbl4 = getInputDataSignalsForRequest(var6)
                var7 = tbl4.get(false)
                enableStreamingMerge = tbl1.enableStreamingMerge

                if paginateResponse then
                    num1 = 3
                else
                    num1 = 2
                end
            end

            if num1 == 2 then
                if if FFlagLuaAppEnableSduiHomePage then enableInputDataMerge elseif FFlagSduiStreamingRefreshReplacesInputData then enableInputDataMerge else enableStreamingMerge then
                    num1 = 3
                else
                    num1 = 4
                end
            end

            if num1 == 3 then
                if var7 then
                    num1 = 5
                else
                    num1 = 4
                end
            end

            if num1 == 4 then
                if FFlagSduiFreshInputDataSignalOnRebuild and setInputDataSignalsForRequest then
                    local get, set = Signals.createSignal(nil)
                    tbl4 = { get = get, set = set }
                end
                tbl4.set(componentInputData)
                num1 = 6
            end

            if num1 == 5 then
                if componentInputData then
                    local var8 = SduiInputDataMerge.merge(tbl4.get(false), componentInputData, mergeStrategy)
                    tbl4.set(var8)
                end

                num1 = 6
            end

            if num1 == 6 then
                if not paginateResponse then
                    if FFlagLuaAppEnableSduiHomePage or FFlagSduiStreamingRefreshReplacesInputData then
                        enableStreamingMerge = enableInputDataMerge
                    end

                    var7 = enableStreamingMerge and var7
                end

                if not var7 then
                    local robloxComponentType = value.robloxComponentType
                    if not robloxComponentType then
                        local tbl5 = {
                            name = var1,
                            message = "Page entry missing robloxComponentType"
                        }

                        if FFlagSduiErrorPaths then
                            local var8 = addSduiErrorContextFields
                            local var9

                            if value then
                                local identifier2 = value.identifier
                                if identifier2 and identifier2 ~= "" then
                                    var9 = `{surfaceKey}[{identifier2}]`
                                else
                                    var9 = surfaceKey
                                end
                            else
                                var9 = nil
                            end

                            var8(tbl5, { fullName = var9, rctPath = nil, templateId = nil })
                        end
                        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToAddTemplates, tbl5, surfaceKey)
                        continue
                    end

                    local var8 = if enableTemplateCache then resolveTemplateForRobloxComponent(robloxComponentType, if FFlagSduiErrorPaths then value else nil) else tbl2[robloxComponentType]
                    local var9 = var8

                    if not var9 then
                        if enableTemplateCache then
                            continue
                        end

                        local tbl5 = {
                            name = robloxComponentType,
                            message = `Missing template for robloxComponentType {robloxComponentType}`
                        }
                        if FFlagSduiErrorPaths then
                            addSduiErrorContextFields(tbl5, (createErrorContextForRCT(robloxComponentType, value)))
                        end

                        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToMapRobloxComponentToTemplate, tbl5, surfaceKey)
                        continue
                    end

                    local success2, result2 = pcall(function()
                        local builderConfig = createBuilderConfig({
                            appPage = surfaceKey,
                            debugName = var1,
                            getTemplateForRobloxComponent = function(rctPath)
                                if enableTemplateCache then
                                    return (resolveTemplateForRobloxComponent(rctPath))
                                end

                                return tbl2[rctPath]
                            end,
                            getTemplateIdForRCT = if FFlagSduiErrorPaths then getTemplateIdForRCT else nil,
                            localizedLiterals = if FFlagSduiSharedLocalizedLiterals then nil else var4,
                            getLocalizedLiteral = if FFlagSduiSharedLocalizedLiterals then getLocalizedLiteral else nil,
                            configKey = var1
                        })
                        return (getSduiClientBindingBuilder().buildConfigForComponent(
                            var9,
                            if FFlagLuaAppSduiHomePageSupport and value.componentInputDataGetter then value.componentInputDataGetter else tbl4.get,
                            builderConfig,
                            nil,
                            nil,
                            nil,
                            nil,
                            if FFlagSduiErrorPaths then robloxComponentType else nil,
                            if FFlagSduiErrorPaths then identifier else nil
                        ))
                    end)
                    if success2 then
                        if FFlagSduiFreshInputDataSignalOnRebuild and setInputDataSignalsForRequest then
                            var5 = var5 == nil and {} or var5

                            var5[var6] = tbl4
                        end
                        if tbl3[var6] then
                            local tbl5 = {
                                name = robloxComponentType,
                                message = `Existing config found for cacheKey {var6}. Need to specify identifer in page entry for multiple configs`
                            }
                            if FFlagSduiErrorPaths then
                                addSduiErrorContextFields(tbl5, result2 and result2.errorContext)
                            end
                            SduiLogger.reportError(SduiErrors.SduiErrorType.DuplicateOrMissingIdentifier, tbl5, surfaceKey)
                        end

                        local tbl5 = {
                            config = result2,
                            dataUpdatedTimestamp = os.clock(),
                            identifier = if FFlagEnableSduiV2HomepagePrompts then identifier elseif FFlagPromptsHandlerEnabled then identifier else nil,
                            robloxComponentType = if FFlagEnableSduiV2HomepagePrompts then robloxComponentType elseif FFlagPromptsHandlerEnabled then robloxComponentType else nil,
                            category = if FFlagEnableHomepagePromptsForModalsAndBanners or FFlagPromptsHandlerEnabled then value.category else nil,
                            surfacing = value.surfacing
                        }
                        tbl3[var6] = tbl5
                    else
                        local tbl5 = {
                            name = robloxComponentType,
                            message = `{result2}`
                        }
                        if FFlagSduiErrorPaths then
                            addSduiErrorContextFields(tbl5, (createErrorContextForRCT(robloxComponentType, value)))
                        end
                        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToBuildClientBindingConfig, tbl5, surfaceKey)
                    end

                    if value.title and tbl3[var6] then
                        tbl3[var6].title = value.title
                    end
                end

                tbl3[var6] = tbl3[var6] or {}
                if buildNextPageUrl then
                    tbl3[var6].nextPageUrl = buildNextPageUrl(result) or ""
                else
                    tbl3[var6].nextPageUrl = ""
                end
                if not buildNextPagePostBody then
                    continue
                end

                local nextPagePostBody = buildNextPagePostBody(result)
                tbl3[var6].nextPagePostBody = nextPagePostBody or Cryo.None
            end
        end
    end
    if FFlagSduiFreshInputDataSignalOnRebuild and setInputDataSignalsForRequest and var5 then
        for value, value2 in var5 do
            setInputDataSignalsForRequest(var1, value, value2)
        end
    end

    if not (next(tbl3) or paginateResponse or FFlagSduiAllowNoConfigsBuilt and allowNoConfigsBuilt) then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.NoComponentConfigsBuilt,
            {
                name = var1,
                message = `No configs built when handling proto response for {var1}`
            },
            surfaceKey
        )
    end

    loadTimer.logSduiTreeBuildEnd()

    local function getTemplateForRobloxComponent(rctPath: string)
        if enableTemplateCache then
            return (resolveTemplateForRobloxComponent(rctPath))
        end

        return tbl2[rctPath]
    end

    local function getKnownTemplates()
        local knownTemplates = {}
        for _, value in tbl2 do
            table.insert(knownTemplates, value)
        end
        if enableTemplateCache then
            local sduiTemplateStore = getSduiTemplateStore()
            for _, value in sduiTemplateStore.getCachedRobloxComponentToTemplateId(surfaceKey) do
                local template = sduiTemplateStore.getTemplate(value)
                if template ~= nil then
                    table.insert(knownTemplates, template)
                end
            end
        end
        return knownTemplates
    end

    loadTimer.logSduiClientHintsBegin()
    local success2, result2 = pcall(function()
        processClientHints({
            pageEntries = pageEntries,
            getTemplateForRobloxComponent = getTemplateForRobloxComponent,
            getKnownTemplates = getKnownTemplates
        })
    end)
    loadTimer.logSduiClientHintsEnd()
    if not success2 then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.FailedToProcessClientHints,
            { name = var1, message = result2 },
            surfaceKey
        )
    end
    return tbl3, result
end

return handleSduiApiResponse
