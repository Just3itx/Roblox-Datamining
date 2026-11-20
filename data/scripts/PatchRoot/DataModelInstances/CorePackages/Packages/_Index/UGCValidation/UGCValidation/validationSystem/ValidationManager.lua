-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:20:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local ValidationEnums = require(scriptParentParent.validationSystem.ValidationEnums)
local ValidationModuleLoader = require(scriptParentParent.validationSystem.ValidationModuleLoader)
local Constants = require(scriptParentParent.Constants)
local ValidationTestWrapper = require(scriptParentParent.validationSystem.ValidationTestWrapper)
local FetchAllDesiredData = require(scriptParentParent.validationSystem.dataFetchModules.FetchAllDesiredData)
local FetchContentIds = require(scriptParentParent.validationSystem.dataFetchModules.FetchContentIds)
local getUploadCategory = require(scriptParentParent.util.getUploadCategory)
local RecreateSceneFromEditables = require(scriptParentParent.util.RecreateSceneFromEditables)
local stripMeshFromGltf = require(scriptParentParent.util.stripMeshFromGltf)
local ErrorSourceStrings = require(scriptParentParent.validationSystem.ErrorSourceStrings)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local resetPhysicsData = require(scriptParentParent.util.resetPhysicsData)
local getFFlagDebugAllowHRDUploadOnBundleBackend = require(scriptParentParent.flags.getFFlagDebugAllowHRDUploadOnBundleBackend)

local getEngineFeatureEngineUGCValidateInstanceTreesEquivalent = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidateInstanceTreesEquivalent)
local getFFlagUGCValidationAllowFullVaas = require(scriptParentParent.flags.getFFlagUGCValidationAllowFullVaas)
local getFFlagUGCValidateAQSRequiresOnlySummary = require(scriptParentParent.flags.getFFlagUGCValidateAQSRequiresOnlySummary)
local getFFlagDebugUGCDisableAssetQualityChecks = require(scriptParentParent.flags.getFFlagDebugUGCDisableAssetQualityChecks)

local getEngineFeatureEngineDebugUGCValidationViaLocalRCC = require(scriptParentParent.flags.getEngineFeatureEngineDebugUGCValidationViaLocalRCC)

local getEngineFeatureEngineUGCValidateEmoteAnimationExport = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidateEmoteAnimationExport)

local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")
local RunService = game:GetService("RunService")
local AssetQualityService = game:GetService("AssetQualityService")

game:DefineFastInt("FullValidationTelemetryThrottleHundrethsPercent", 10000)
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local config = {
    eventName = "UgcFullValidationFinished",
    backends = { "EventIngest" },
    throttlingPercentage = game:GetFastInt("FullValidationTelemetryThrottleHundrethsPercent"),
    lastUpdated = { 26, 9, 4 },
    description = "Report result of ugc validation suite",
    links = "https://create.roblox.com/docs/art/validation-errors"
}

local getFFlagDebugUGCValidationPrintNewStructureResults = require(scriptParentParent.flags.getFFlagDebugUGCValidationPrintNewStructureResults)

local getFIntUGCValidationFetchQualityMaxRetry = require(scriptParentParent.flags.getFIntUGCValidationFetchQualityMaxRetry)

local getEngineFeatureEngineAssetQualityV2SummaryFromUrl = require(scriptParentParent.flags.getEngineFeatureEngineAssetQualityV2SummaryFromUrl)
local getFIntUGCValidationFetchQualityRetryDelayMs = require(scriptParentParent.flags.getFIntUGCValidationFetchQualityRetryDelayMs)

local module = {}
local tbl1 = { Publish = true, Backend = true, Internal = true }

local tbl2 = { InExpServer = true, InExpClient = true }

local tbl3 = {
    Toolbox = ValidationEnums.ConsumerEnv.Studio,
    AutoSetup = ValidationEnums.ConsumerEnv.Studio,
    Publish = ValidationEnums.ConsumerEnv.Backend,
    Backend = ValidationEnums.ConsumerEnv.Backend,
    Internal = ValidationEnums.ConsumerEnv.Backend,
    InExpServer = ValidationEnums.ConsumerEnv.IEC,
    InExpClient = ValidationEnums.ConsumerEnv.IEC
}

local AssetQualityFetchStatus = ValidationEnums.AssetQualityFetchStatus
local tbl4

if getEngineFeatureEngineDebugUGCValidationViaLocalRCC() then
    tbl4 = {}
    tbl4[ValidationEnums.ValidationModule.DescendantIdsAllowed] = true
    tbl4[ValidationEnums.ValidationModule.DescendantIdsPublished] = true
else
    tbl4 = nil
end

local function initRunVariables(str1: string, consumerConfig)
    local tbl5 = {}
    local tbl6 = ({})
    local tbl7 = ({})
    local skipModules = consumerConfig.skipModules

    for name, value2 in ValidationModuleLoader.allModules do
        if skipModules[name]
            or getFFlagDebugUGCDisableAssetQualityChecks() and consumerConfig.skipAssetQualityChecks and value2.isAssetQualityModule
        then
            continue
        end

        local categories = value2.categories

        if not (table.find(categories, str1) and (value2.fflag() or value2.shadowFlag())) then
            continue
        end

        local isShadow = value2.shadowFlag() and not value2.fflag()
        for _, value3 in value2.requiredData do
            tbl7[value3] = true
        end

        for _, value3 in value2.conditionalData do
            tbl7[value3] = true
        end

        local isAssetQualityModule = value2.isAssetQualityModule

        if isAssetQualityModule then
            table.insert(tbl5, name)
        end

        local prereqs = ({})
        for _, prereqTest in value2.prereqTests do
            prereqs[prereqTest] = true
        end

        tbl6[name] = {
            name = name,
            prereqs = prereqs,
            postreqs = {},
            isQuality = isAssetQualityModule,
            isShadow = isShadow
        }
    end

    if getFFlagUGCValidateAQSRequiresOnlySummary() and #tbl5 > 0 and consumerConfig.aqFetchStage == "scene" then
        for _, value in RecreateSceneFromEditables.requiredData do
            tbl7[value] = true
        end
    end

    for value, value2 in tbl6 do
        for k, _ in value2.prereqs do
            if tbl6[k] == nil then
                error(string.format("%s is needed for %s to run, but is not an included test", k, value))
            end

            table.insert(tbl6[k].postreqs, value)
        end
    end

    return tbl5, tbl6, tbl7
end

local function fetchQualityResults(arg1, desiredQualityChecks)
    if not AssetQualityService then
        arg1.aqsFetchMetrics.fetchStatus = AssetQualityFetchStatus.assetQualityFetchFailure
        arg1.aqsFetchMetrics.fetchFailureReason = "Not enabled"
        return
    end

    local result = nil
    local gltfData = nil
    local uploadModel = nil
    local success

    if arg1.consumerConfig.aqFetchStage ~= "scene" then
        if arg1.consumerConfig.aqFetchStage == "gltf" then
            gltfData = arg1.consumerConfig.aqFetchData
        end

        success = true
    else
        success, result = pcall(function()
            if getFFlagUGCValidateAQSRequiresOnlySummary() then
                for _, value in RecreateSceneFromEditables.requiredData do
                    if arg1[value] == FetchAllDesiredData.DATA_FETCH_FAILURE then
                        error(`Missing scene data: {value}`)
                    end
                end
            end
            uploadModel = RecreateSceneFromEditables.createModelForGltfExport(arg1)
            gltfData = AssetQualityService:GenerateAssetQualityGltfFromInstanceAsync(uploadModel)
        end)

        if getEngineFeatureEngineUGCValidateEmoteAnimationExport()
            and success
            and gltfData
            and arg1.uploadCategory == ValidationEnums.UploadCategory.EMOTE_ANIMATION
        then
            local success2, result2 = pcall(stripMeshFromGltf, gltfData)
            if success2 then
                gltfData = result2
            end
        end
    end

    if success then
        local fIntUgcValidationFetchQualityRetryDelayMs = getFIntUGCValidationFetchQualityRetryDelayMs()
        for fetchAttemptCount = 1, 1 + getFIntUGCValidationFetchQualityMaxRetry() do
            if fetchAttemptCount > 1 and fIntUgcValidationFetchQualityRetryDelayMs > 0 then
                task.wait(fIntUgcValidationFetchQualityRetryDelayMs / 1000)
            end
            success, result = pcall(function()
                arg1.aqsFetchMetrics.fetchAttemptCount = fetchAttemptCount
                local startTime = os.clock()
                local var1

                if arg1.consumerConfig.aqFetchStage == "jobId" then
                    local jobId = if getEngineFeatureEngineAssetQualityV2SummaryFromUrl() then arg1.consumerConfig.aqJobId else arg1.consumerConfig.aqFetchData

                    if getFFlagUGCValidationAllowFullVaas() and jobId ~= nil and jobId ~= "" then
                        var1 = AssetQualityService:FetchAssetQualitySummaryFromJobIdV2Async(jobId, desiredQualityChecks)
                    else
                        var1 = AssetQualityService:FetchAssetQualitySummaryFromJobIdAsync(jobId, desiredQualityChecks)
                    end
                elseif arg1.consumerConfig.aqFetchStage == "summaryUrl" then
                    var1 = AssetQualityService:FetchAssetQualitySummaryFromUrlAsync(
                        arg1.consumerConfig.aqSummaryUrl,
                        arg1.consumerConfig.aqJobId,
                        desiredQualityChecks
                    )
                else
                    var1 = AssetQualityService:FetchAssetQualitySummaryFromGltfAsync(gltfData, desiredQualityChecks)
                end
                local fetchTimeMs = 1000 * (os.clock() - startTime)
                arg1.aqsFetchMetrics.visualizationUrl = var1.visualizationUrl
                arg1.aqsFetchMetrics.fetchTimeMs = fetchTimeMs
                arg1.aqsFetchMetrics.aqJobId = var1.aqJobId
                arg1.aqsSummaryData = HttpService:JSONDecode(var1.rawJson)
            end)

            if success then
                break
            end
        end
    end

    if success then
        arg1.aqsFetchMetrics.fetchStatus = AssetQualityFetchStatus.assetQualityFetchSuccess
        if getFFlagDebugUGCValidationPrintNewStructureResults() then
            print(
                string.format(
                    "AQS fetch success: aqJobId=%s attempts=%d fetchTimeMs=%d",
                    arg1.aqsFetchMetrics.aqJobId or "",
                    arg1.aqsFetchMetrics.fetchAttemptCount or 0,
                    arg1.aqsFetchMetrics.fetchTimeMs or 0
                )
            )
            print(arg1.aqsSummaryData)
        end
    else
        arg1.aqsFetchMetrics.fetchFailureReason = result
        arg1.aqsSummaryData = FetchAllDesiredData.DATA_FETCH_FAILURE
        arg1.aqsFetchMetrics.fetchStatus = AssetQualityFetchStatus.assetQualityFetchFailure
        if getFFlagDebugUGCValidationPrintNewStructureResults() then
            print("AQS fetch failure:", result)
        end
    end

    if uploadModel then
        uploadModel:Destroy()
    end
end

local function getNextLayer(tbl5, bool1: boolean)
    local nextLayer = {}

    for value, value2 in tbl5 do
        if next(value2.prereqs) == nil and (bool1 or not value2.isQuality) then
            table.insert(nextLayer, value)
        end
    end

    return nextLayer
end

local function populateRelevantSourceStrings(tbl5: {aqJobId: string, failureMap: number, numFailures: number, numWarnings: number, pass: boolean, ranIntoInternalError: boolean, relevantSourceStrings: number, states: number, telemetryBundleId: number, validationJobId: any, warningMap: number})
    local function capture(failureStringKey: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl6 = failureStringKey:split(".")
        local str1 = tbl6[#tbl6]
        local var1 = ErrorSourceStrings.Values[str1]
        if var1 then
            tbl5.relevantSourceStrings[failureStringKey] = var1
        end
    end

    for _, value in tbl5.failureMap do
        for _, value2 in value do
            capture(value2.failureStringKey)
        end
    end
    for _, value in tbl5.warningMap do
        for _, value2 in value do
            capture(value2.failureStringKey)
        end
    end
end

local function getDebugLabel(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local uploadEnum = arg1.uploadEnum

    if uploadEnum.assetType then
        return uploadEnum.assetType.Name
    end

    if uploadEnum.bundleType then
        return uploadEnum.bundleType.Name
    end

    return "?"
end

local function reportFullResult(tbl5: {aqJobId: string, failureMap: number, numFailures: number, numWarnings: number, pass: boolean, ranIntoInternalError: boolean, relevantSourceStrings: number, states: number, telemetryBundleId: number, validationJobId: any, warningMap: number}, arg1, durationMs: number)
    local bool1 = arg1.aqsFetchMetrics.fetchStatus ~= AssetQualityFetchStatus.assetQualityFetchNA
    local customFields = {
        validationJobId = arg1.jobId,
        bundleJobId = arg1.consumerConfig.telemetryBundleId,
        rootInstanceId = arg1.consumerConfig.telemetryRootId,
        studioSid = RbxAnalyticsService:GetSessionId(),
        clientId = RbxAnalyticsService:GetClientId(),
        placeId = game.PlaceId,
        validationSource = arg1.consumerConfig.source,
        assetType = arg1.uploadEnum.assetType and arg1.uploadEnum.assetType.Value or 0,
        bundleType = arg1.uploadEnum.bundleType and arg1.uploadEnum.bundleType.Value or 0,
        numFailures = tbl5.numFailures,
        passed = tbl5.pass,
        durationMs = durationMs,
        uploadCategory = arg1.uploadCategory,
        aqFetchStatus = arg1.aqsFetchMetrics.fetchStatus,
        aqFetchAttemptCount = bool1 and arg1.aqsFetchMetrics.fetchAttemptCount or 0,
        aqFetchTimeMs = bool1 and arg1.aqsFetchMetrics.fetchTimeMs or 0,
        aqFetchFailureReason = bool1 and arg1.aqsFetchMetrics.fetchFailureReason or "",
        aqJobId = arg1.aqsFetchMetrics.aqJobId or ""
    }

    if getFFlagUGCValidationAllowFullVaas() then
        customFields.isVaas = arg1.consumerConfig.isVaaS or false
        customFields.aqFetchStage = arg1.consumerConfig.aqFetchStage
    end

    TelemetryService:LogEvent(config, { customFields = customFields })

    if not getFFlagDebugUGCValidationPrintNewStructureResults() then
        return
    end

    print(
        string.format(
            "==== %s Validation end ==== pass=%s numFailures=%d numWarnings=%d durationMs=%d",
            getDebugLabel(arg1),
            tostring(tbl5.pass),
            tbl5.numFailures,
            tbl5.numWarnings,
            durationMs
        )
    )

    for value, value2 in tbl5.failureMap do
        for _, value3 in value2 do
            print(
                string.format(
                    "  FAIL %s: %s @ %s",
                    value,
                    value3.failureStringKey,
                    if value3.instancePath == "" then "<root>" else value3.instancePath
                )
            )
        end
    end
    print(tbl5)
end

local function updateResultData(tbl5: {aqJobId: string, failureMap: number, numFailures: number, numWarnings: number, pass: boolean, ranIntoInternalError: boolean, relevantSourceStrings: number, states: number, telemetryBundleId: number, validationJobId: any, warningMap: number}, tbl6, arg1, _: string, enforceShadowValidations: boolean)
    local validationEnum = arg1.validationEnum
    if enforceShadowValidations or not tbl6[validationEnum].isShadow then
        tbl5.states[validationEnum] = arg1.status

        if arg1.status ~= ValidationEnums.Status.PASS then
            tbl5.pass = false
            tbl5.numFailures += math.max(1, #arg1.failures)
        end

        if #arg1.failures > 0 then
            tbl5.failureMap[validationEnum] = arg1.failures
        end

        if #arg1.warnings > 0 then
            tbl5.warningMap[validationEnum] = arg1.warnings
            tbl5.numWarnings += #arg1.warnings
        end

        if arg1.status == ValidationEnums.Status.ERROR then
            tbl5.ranIntoInternalError = true
        end
    end

    for _, postreq in tbl6[validationEnum].postreqs do
        tbl6[postreq].prereqs[validationEnum] = nil
    end

    tbl6[validationEnum] = nil
end

local function createConsumerConfigWithDefaults(arg1)
    local var1 = table.clone(arg1)

    if var1.enforceR15FolderStructure == nil then
        var1.enforceR15FolderStructure = true
    end
    if var1.enforceShadowValidations == nil then
        var1.enforceShadowValidations = false
    end

    var1.telemetryBundleId = var1.telemetryBundleId or ""
    var1.telemetryRootId = var1.telemetryRootId or ""
    var1.preloadedEditableMeshes = var1.preloadedEditableMeshes or {}
    var1.preloadedEditableImages = var1.preloadedEditableImages or {}
    var1.preloadedHsrAssets = var1.preloadedHsrAssets or {}
    var1.preloadedCurveAnimations = var1.preloadedCurveAnimations or {}
    var1.skipModules = var1.skipModules or {}
    if tbl4 then
        var1.skipModules = table.clone(var1.skipModules)
        for value in tbl4 do
            var1.skipModules[value] = true
        end
    end
    var1.skipAssetQualityChecks = var1.skipAssetQualityChecks or false
    var1.skipPhysicsDataReset = var1.skipPhysicsDataReset or false
    var1.isVaaS = var1.isVaaS or false

    var1.consumerEnv = tbl3[var1.source]
    local bool1 = var1.consumerEnv ~= nil
    local source = var1.source
    assert(bool1, `unknown consumer source: {tostring(source)}`)

    if getFFlagUGCValidationAllowFullVaas() and var1.isVaaS then
        var1.validationEnv = ValidationEnums.ValidationEnv.Backend
    else
        var1.validationEnv = var1.consumerEnv
    end

    var1.backendConfigs = var1.backendConfigs or {}
    var1.iecConfigs = var1.iecConfigs or {}

    var1.aqFetchStage = var1.aqFetchStage or "scene"
    var1.aqFetchData = var1.aqFetchData or ""
    local aqFetchData = var1.aqFetchData
    if getEngineFeatureEngineAssetQualityV2SummaryFromUrl() then
        var1.aqJobId = var1.aqJobId or ""
        var1.aqSummaryUrl = var1.aqSummaryUrl or ""
        if var1.aqFetchStage == "jobId" then
            aqFetchData = var1.aqJobId
        elseif var1.aqFetchStage == "summaryUrl" then
            aqFetchData = var1.aqSummaryUrl
        end
    else
        assert(var1.aqFetchStage ~= "summaryUrl", "aqFetchStage \"summaryUrl\" requires EngineAssetQualityV2SummaryFromUrl")
    end

    assert(
        var1.aqFetchStage == "scene" == (aqFetchData == ""),
        `aqFetchData/aqJobId/aqSummaryUrl (per stage) must be non-empty iff aqFetchStage is not "scene" (got stage="{var1.aqFetchStage}")`
    )

    return var1
end

local function runValidationOnRootInstance(arg1)
    local startTime = os.clock()

    local rootInstance = arg1.rootInstance
    local assetType = arg1.uploadEnum.assetType
    local bundleType = arg1.uploadEnum.bundleType
    local consumerConfig = arg1.consumerConfig

    if getFFlagDebugUGCValidationPrintNewStructureResults() then
        print(
            string.format(
                "==== %s Validation begin ==== jobId=%s source=%s",
                getDebugLabel(arg1),
                arg1.jobId,
                arg1.consumerConfig.source
            )
        )
    end

    local tbl5 = {
        validationJobId = arg1.jobId,
        telemetryBundleId = if getFFlagUGCValidationAllowFullVaas() then consumerConfig.telemetryBundleId else nil,
        pass = true,
        numFailures = 0,
        numWarnings = 0,
        states = {},
        ranIntoInternalError = false,
        failureMap = {},
        warningMap = {},
        relevantSourceStrings = {},
        aqJobId = ""
    }

    local uploadCategory = getUploadCategory(rootInstance, assetType, bundleType)

    local desiredQualityChecks, tbl6, tbl7 = initRunVariables(uploadCategory, consumerConfig)
    arg1.uploadCategory = uploadCategory
    arg1.aqsFetchMetrics = {
        fetchStatus = AssetQualityFetchStatus.assetQualityFetchNA,
        aqJobId = if getEngineFeatureEngineAssetQualityV2SummaryFromUrl() then consumerConfig.aqJobId elseif consumerConfig.aqFetchStage == "jobId" then consumerConfig.aqFetchData else nil
    }

    local var1 = ValidationTestWrapper(ValidationEnums.ValidationModule.ExpectedRootSchema, arg1, tbl5.states)
    updateResultData(tbl5, tbl6, var1, arg1.jobId, consumerConfig.enforceShadowValidations)
    if tbl5.states[ValidationEnums.ValidationModule.ExpectedRootSchema] ~= ValidationEnums.Status.PASS then
        populateRelevantSourceStrings(tbl5)
        tbl5.aqJobId = arg1.aqsFetchMetrics.aqJobId or ""
        reportFullResult(tbl5, arg1, -1)
        return tbl5
    end

    local descendantIdsPublished = ValidationEnums.ValidationModule.DescendantIdsPublished
    if tbl6[descendantIdsPublished] then
        arg1.contentIds = FetchContentIds.getData(arg1)
        local var2 = ValidationTestWrapper(descendantIdsPublished, arg1, tbl5.states)
        updateResultData(tbl5, tbl6, var2, arg1.jobId, consumerConfig.enforceShadowValidations)
        local var3 = tbl5.states[descendantIdsPublished]
        if var3 ~= nil and var3 ~= ValidationEnums.Status.PASS then
            populateRelevantSourceStrings(tbl5)
            tbl5.aqJobId = arg1.aqsFetchMetrics.aqJobId or ""
            reportFullResult(tbl5, arg1, 1000 * (os.clock() - startTime))
            return tbl5
        end
    end

    if getFFlagUGCValidationAllowFullVaas() and arg1.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.Backend then
        local bypassFlags = {
            skipPhysicsDataReset = arg1.consumerConfig.skipPhysicsDataReset
        }
        resetPhysicsData({ arg1.rootInstance }, { isServer = true, bypassFlags = bypassFlags })
    end

    local var2 = tbl1[consumerConfig.source] or consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend

    FetchAllDesiredData.storeDesiredData(arg1, tbl7)
    if #desiredQualityChecks > 0 then
        arg1.aqsFetchMetrics.fetchStatus = AssetQualityFetchStatus.assetQualityFetchInProgress
        if var2 then
            RunService:Run()
            fetchQualityResults(arg1, desiredQualityChecks)
            RunService:Pause()
        else
            task.spawn(fetchQualityResults, arg1, desiredQualityChecks)
        end
    end

    while next(tbl6) ~= nil do
        local bool1 = arg1.aqsFetchMetrics.fetchStatus == AssetQualityFetchStatus.assetQualityFetchInProgress
        local nextLayer = getNextLayer(tbl6, not bool1)

        if #nextLayer == 0 and not bool1 then
            error("Impossible to complete all layers")
        end

        for _, value in nextLayer do
            local var3 = ValidationTestWrapper(value, arg1, tbl5.states)
            updateResultData(tbl5, tbl6, var3, arg1.jobId, consumerConfig.enforceShadowValidations)

            if tbl2[consumerConfig.source] and not var2 then
                task.wait()
            end
        end

        if bool1 and not var2 then
            task.wait()
        end
    end

    populateRelevantSourceStrings(tbl5)
    tbl5.aqJobId = arg1.aqsFetchMetrics.aqJobId or ""
    reportFullResult(tbl5, arg1, 1000 * (os.clock() - startTime))
    return tbl5
end

local function getRootInstance(tbl5) -- Luacid: Inlined by compiler; 3 call sites recovered
    if #tbl5 == 0 then
        return nil
    end

    for _, value in tbl5 do
        if value.Name == Constants.FOLDER_NAMES.R15ArtistIntent then
            return value
        end
    end

    return tbl5[1]
end

local function findFolderByName(allSelectedInstances, name: string, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in allSelectedInstances do
        if value.Name == name then
            return value
        end
    end

    return if bool1 then allSelectedInstances[1] else nil
end

local function synthesizeRootFromFolders(entrypointInput, name: string, bool1: boolean): Folder
    local folder = Instance.new("Folder")
    for _, value in entrypointInput do
        local folderByName = findFolderByName(value.allSelectedInstances, name, bool1)
        if folderByName == nil then
            continue
        end

        if folderByName:IsA("Folder") or folderByName:IsA("Model") then
            for _, child in folderByName:GetChildren() do
                child:Clone().Parent = folder
            end
        else
            folderByName:Clone().Parent = folder
        end
    end

    return folder
end

function module.ValidateAsset(entrypointInput, assetType, arg1)
    local tbl5 = {
        jobId = HttpService:GenerateGUID(),
        entrypointInput = entrypointInput,
        rootInstance = getRootInstance(entrypointInput),
        r15LegacyDuplicateRoot = 0,
        uploadEnum = 0,
        consumerConfig = 0,
        hsrAssets = 0
    }
    local var1, var2

    if getEngineFeatureEngineUGCValidateInstanceTreesEquivalent() then
        local r15Fixed = Constants.FOLDER_NAMES.R15Fixed
        var1 = false

        for _, value in entrypointInput do
            if value.Name == r15Fixed then
                var2 = value
                var1 = true
                break
            end
        end
    else
        var1 = false
    end

    if not var1 then
        var2 = nil
    end

    tbl5.r15LegacyDuplicateRoot = var2

    tbl5.uploadEnum = { assetType = assetType }

    tbl5.consumerConfig = createConsumerConfigWithDefaults(arg1)
    tbl5.hsrAssets = {}

    return (runValidationOnRootInstance(tbl5))
end

function module.ValidateFinalizedBundle(entrypointInput, bundleType, arg1)
    if getFFlagDebugAllowHRDUploadOnBundleBackend() then
        R15plusUtils.setIsBackendBundleUpload(arg1.source == "Publish" or arg1.source == "Backend")
    end

    local var1 = nil
    local var2

    if bundleType == Enum.BundleType.Animations then
        var2 = Instance.new("Model")
        for _, value in entrypointInput do
            local rootInstance = getRootInstance(value.allSelectedInstances)
            if rootInstance ~= nil then
                rootInstance:Clone().Parent = var2
            end
        end
    elseif getEngineFeatureEngineUGCValidateInstanceTreesEquivalent() then
        var2 = synthesizeRootFromFolders(entrypointInput, Constants.FOLDER_NAMES.R15ArtistIntent, true)
        var1 = synthesizeRootFromFolders(entrypointInput, Constants.FOLDER_NAMES.R15Fixed, true)
    else
        var2 = Instance.new("Folder")
        for _, value in entrypointInput do
            local rootInstance = getRootInstance(value.allSelectedInstances)
            if rootInstance == nil then
                continue
            end

            if rootInstance:IsA("Folder") or rootInstance:IsA("Model") then
                for _, child in rootInstance:GetChildren() do
                    child:Clone().Parent = var2
                end
            else
                rootInstance:Clone().Parent = var2
            end
        end
    end

    local tbl5 = {
        jobId = HttpService:GenerateGUID(),
        entrypointInput = entrypointInput,
        rootInstance = var2,
        r15LegacyDuplicateRoot = var1,
        uploadEnum = { bundleType = bundleType },
        consumerConfig = createConsumerConfigWithDefaults(arg1),
        hsrAssets = {}
    }

    local tbl6 = runValidationOnRootInstance(tbl5)

    if getFFlagDebugAllowHRDUploadOnBundleBackend() then
        R15plusUtils.setIsBackendBundleUpload(false)
    end

    return tbl6
end

return module
