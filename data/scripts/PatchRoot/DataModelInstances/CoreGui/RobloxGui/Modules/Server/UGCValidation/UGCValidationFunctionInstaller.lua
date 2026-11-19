-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UGCValidationService = game:GetService("UGCValidationService")
local UGCValidation = require(CorePackages.Packages.UGCValidation)

local engineFeature = game:GetEngineFeature("UGCValidationWithContextEntrypointFeature")
local bool1 = game:DefineFastFlag("UGCValidateMigrateSchemaProperties2", false)
local bool2 = game:DefineFastFlag("UGCValidateForwardIECRestrictedUserIds", false)

local function UGCValidationFunction(arg1)
    local instances = arg1.instances
    local assetType = arg1.assetType
    local isServer = arg1.isServer
    local fullBodyData = arg1.fullBodyData
    local allowUnreviewedAssets = arg1.allowUnreviewedAssets
    local restrictedUserIds = arg1.restrictedUserIds
    local token = arg1.token
    local universeId = arg1.universeId
    local requireAllFolders = arg1.requireAllFolders

    local bypassFlags = { skipSnapshot = true, skipPhysicsDataReset = true, skipValidateHSR = true }
    local var1, var2

    if engineFeature then
        local tbl2 = {
            instances = instances,
            assetTypeEnum = assetType,
            isServer = isServer,
            allowUnreviewedAssets = allowUnreviewedAssets,
            restrictedUserIds = restrictedUserIds,
            token = token,
            universeId = universeId,
            allowEditableInstances = true,
            shouldYield = true,
            validateMeshPartAccessories = true,
            requireAllFolders = requireAllFolders,
            bypassFlags = bypassFlags
        }

        local tbl3 = {
            fullBodyData = fullBodyData,
            isServer = isServer,
            allowEditableInstances = true,
            bypassFlags = bypassFlags,
            shouldYield = true,
            requireAllFolders = requireAllFolders,
            validateMeshPartAccessories = false
        }

        if fullBodyData then
            var1, var2 = UGCValidation.validateFullBodyWithContext(tbl3)
        else
            var1, var2 = UGCValidation.validateWithContext(tbl2)
        end
    elseif fullBodyData then
        var1, var2 = UGCValidation.validateFullBody(fullBodyData, isServer, true, bypassFlags, true, requireAllFolders)
    else
        var1, var2 = UGCValidation.validate(
            instances,
            assetType,
            isServer,
            allowUnreviewedAssets,
            restrictedUserIds,
            token,
            universeId,
            true,
            bypassFlags,
            true,
            true,
            requireAllFolders
        )
    end

    local tbl2 = {
        source = if isServer then "InExpServer" else "InExpClient",
        enforceR15FolderStructure = requireAllFolders or false,
        skipAssetQualityChecks = UGCValidation.shouldSkipAssetQualityChecks and UGCValidation.shouldSkipAssetQualityChecks() or nil,
        iecConfigs = 0
    }
    local tbl3

    if bool1 then
        tbl3 = { token = token, universeId = universeId, restrictedUserIds = 0 }
        if not bool2 then
            restrictedUserIds = nil
        end

        tbl3.restrictedUserIds = restrictedUserIds
    else
        tbl3 = nil
    end

    tbl2.iecConfigs = tbl3
    local var3 = if fullBodyData then UGCValidation.ValidateFinalizedBundle(fullBodyData, Enum.BundleType.BodyParts, tbl2) else UGCValidation.ValidateAsset(instances, assetType, tbl2)
    local var4, var5 = UGCValidation.combineResultsIntoLegacy(var1, var2, var3)

    if not var4 then
        return false, var5
    end

    return true, { "Success" }
end

local function Install()
    UGCValidationService:RegisterUGCValidationFunction(UGCValidationFunction)
end

return Install
