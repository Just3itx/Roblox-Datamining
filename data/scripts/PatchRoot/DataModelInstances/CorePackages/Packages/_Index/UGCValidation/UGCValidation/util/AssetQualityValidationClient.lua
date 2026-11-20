-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local createUGCBodyPartFolders = require(scriptParentParent.util.createUGCBodyPartFolders)
local fixUpPreValidation = require(scriptParentParent.util.fixUpPreValidation)

local HttpService = game:GetService("HttpService")

local module = {}

function module.getAssetQualityService(): AssetQualityService
    return game:GetService("AssetQualityService")
end

function module.buildSettings(arg1)
    local options = {
        ConsumerName = arg1.source
    }
    if arg1.intendedBundleType then
        options.IntendedBundleTypeId = tostring(arg1.intendedBundleType.Value)
    end
    if arg1.validateSingleAssetsInBundle then
        options.ValidateSingleAssetsInBundle = "true"
    end
    if arg1.backendConfigs then
        options.LegacyValidationConfigs = HttpService:JSONEncode({
            allowedCreators = arg1.backendConfigs.restrictedUserIds,
            universeId = arg1.backendConfigs.universeId,
            isUserInTrustedCreatorProgram = arg1.backendConfigs.isUserInTrustedCreatorProgram,
            isEmissiveAllowed = arg1.backendConfigs.isEmissiveAllowed
        })
    end

    local tbl2 = {
        postQualitySteps = { "validation" },
        options = options
    }
    if arg1.mode then
        tbl2.mode = arg1.mode
    end
    return tbl2
end

function module.createSingleAssetInput(arg1, assetType)
    local success, result = pcall(fixUpPreValidation, arg1)
    if not success then
        error(result, 0)
    end

    local model = Instance.new("Model")
    model.Name = arg1.Name
    result.Parent = model
    return { model = model, assetType = assetType }
end

function module.createBodyInputs(arg1, arg2, str1: string)
    local var1 = fixUpPreValidation(arg1)
    local bodyInputs = {}
    local success, result = pcall(function()
        for assetType, value2 in (createUGCBodyPartFolders(var1, arg2, str1, true)) do
            local model = Instance.new("Model")
            for _, value3 in value2 do
                value3.Parent = model
            end
            table.insert(bodyInputs, { model = model, assetType = assetType })
        end
    end)
    var1:Destroy()
    if not success then
        for _, bodyInput in bodyInputs do
            bodyInput.model:Destroy()
        end
        error(result, 0)
    end
    return bodyInputs
end

function module.fetch(tbl1, arg1)
    local assetQualityService = module.getAssetQualityService()
    local tbl2 = {}
    local tbl3 = {}
    for _, value in tbl1 do
        table.insert(tbl2, value.model)
        table.insert(tbl3, value.assetType.Value)
    end

    local success, result = pcall(function()
        local assetQualityValidationRawFromModelsAsyncResult = assetQualityService:FetchAssetQualityValidationRawFromModelsAsync(tbl2, tbl3, module.buildSettings(arg1))

        if typeof(assetQualityValidationRawFromModelsAsyncResult) == "table"
            and typeof(assetQualityValidationRawFromModelsAsyncResult.error) == "string"
        then
            local taskId = if typeof(assetQualityValidationRawFromModelsAsyncResult.taskId) == "string" then assetQualityValidationRawFromModelsAsyncResult.taskId else nil
            error(
                if taskId then `{assetQualityValidationRawFromModelsAsyncResult.error} (taskId: {taskId})` else assetQualityValidationRawFromModelsAsyncResult.error,
                0
            )
        end

        local validationRawJson = if typeof(assetQualityValidationRawFromModelsAsyncResult) == "table" then assetQualityValidationRawFromModelsAsyncResult.validationRawJson else nil

        if typeof(validationRawJson) ~= "string" then
            error("AssetQualityService returned no validationRawJson", 0)
        end
        local success, result = pcall(HttpService.JSONDecode, HttpService, validationRawJson)
        if not success or typeof(result) ~= "table" then
            error("Failed to decode validationRawJson from AssetQualityService", 0)
        end
        return result
    end)

    for _, value in tbl1 do
        value.model:Destroy()
    end
    if not success then
        error(result, 0)
    end

    local bool1 = #tbl1 == 1 or arg1.validateSingleAssetsInBundle == true
    local result2 = {}
    for value, validationData in result do
        table.insert(
            result2,
            {
                validationData = validationData,
                assetType = if bool1 and tbl1[value] then tbl1[value].assetType else nil
            }
        )
    end

    return result2
end

return module
