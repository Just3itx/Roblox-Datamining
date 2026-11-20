-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Promise = require(scriptParentParent.Parent.Promise)

local ConstantsInterface = require(scriptParentParent.ConstantsInterface)

local _BundlesMetadata = require(scriptParentParent.util.BundlesMetadata)
local _Types = require(scriptParentParent.util.Types)
local createEditableInstancesForContext = require(scriptParentParent.util.createEditableInstancesForContext)
local destroyEditableInstances = require(scriptParentParent.util.destroyEditableInstances)
local createUGCBodyPartFolders = require(scriptParentParent.util.createUGCBodyPartFolders)
local fixUpPreValidation = require(scriptParentParent.util.fixUpPreValidation)
local validateInternal = require(scriptParentParent.validation.validateInternal)
local validateFullBody = require(scriptParentParent.validation.validateFullBody)

local LegacyValidationAdapter = require(scriptParentParent.util.LegacyValidationAdapter)
local HttpService = game:GetService("HttpService")

local tbl1 = {
    Enum.AssetType.DynamicHead,
    Enum.AssetType.Torso,
    Enum.AssetType.LeftArm,
    Enum.AssetType.RightArm,
    Enum.AssetType.LeftLeg,
    Enum.AssetType.RightLeg,
    Enum.AssetType.HairAccessory,
    Enum.AssetType.EyebrowAccessory,
    Enum.AssetType.EyelashAccessory
}

local function validateBundleReadyForUpload(arg1, arg2, arg3, func1: ((...any) -> (...any))?, allowEditableInstances: boolean?, bypassFlags)
    local var1 = func1 or function() end
    assert(var1 ~= nil, "Luau")

    if not arg1:IsA("Model") then
        return Promise.resolve({
            errors = {{
                assetType = nil,
                error = { type = "message", message = "Invalid root instance, must be a model" }
            }},
            pieces = {}
        })
    end
    arg1 = fixUpPreValidation(arg1)

    local uGcBodyPartFolders = createUGCBodyPartFolders(arg1, arg2, arg3, false)

    local errors = {}
    local pieces = {}

    for k, settings in arg2[arg3].allowedAssetTypeSettings do
        local assetType = assert(Enum.AssetType[k], "Asset type name doesn't map to an enum item")

        if not settings.isEligibleForUpload then
            continue
        end

        assert(
            settings.minimumQuantity == 0 or settings.minimumQuantity == 1,
            "Invalid minimum quantity, createUGCBodyParts folder is a dictionary and will only ever give one."
        )

        assert(
            settings.maximumQuantity == 0 or settings.maximumQuantity == 1,
            "Invalid maximum quantity, createUGCBodyParts folder is a dictionary and will only ever give one."
        )

        local uGcBodyPartFolder = uGcBodyPartFolders[assetType]
        local instance = uGcBodyPartFolder and uGcBodyPartFolder[1]

        if settings.minimumQuantity == 0 and instance == nil then
            continue
        end

        table.insert(pieces, {
            assetType = assetType,
            instance = instance,
            settings = settings,
            status = if instance == nil then "finished" else "pending"
        })

        if instance ~= nil then
            continue
        end

        table.insert(errors, { assetType = assetType, error = { type = "notFound" } })
    end

    table.sort(pieces, function(arg4, arg5): boolean
        return (table.find(tbl1, arg4.assetType) or math.huge) < (table.find(tbl1, arg5.assetType) or math.huge)
    end)

    local tbl4 = { errors = errors, pieces = pieces }

    var1(tbl4)
    local str1 = HttpService:GenerateGUID()

    return Promise.each(pieces, function(tbl5, num1: number)
        if tbl5.status == "finished" then
            return
        end

        assert(tbl5.instance ~= nil, "Unfinished piece doesn't have an instnace")

        local instances = { tbl5.instance }
        local tbl7 = {
            instances = instances,
            assetTypeEnum = tbl5.assetType,
            allowUnreviewedAssets = false,
            isServer = false,
            isAsync = false,
            allowEditableInstances = allowEditableInstances,
            bypassFlags = bypassFlags,
            validateMeshPartAccessories = true,
            requireAllFolders = false
        }

        local var2, var3 = createEditableInstancesForContext.processAll(instances, allowEditableInstances)
        local var4

        if var2 then
            tbl7.editableMeshes = var3.editableMeshes
            tbl7.editableImages = var3.editableImages

            local var5, var6 = validateInternal(tbl7)
            var4, var3 = LegacyValidationAdapter.studioRFUAssetValidation(tbl7, str1, var5, var6)

            destroyEditableInstances(tbl7.editableMeshes, tbl7.editableImages)
        else
            var4 = false
        end

        tbl4 = table.clone(tbl4)
        tbl4.errors = table.clone(tbl4.errors)

        if not var4 then
            assert(var3 ~= nil, "Failure without errors")
            for _, message in var3 do
                table.insert(tbl4.errors, { assetType = tbl5.assetType, error = { type = "message", message = message } })
            end
        end

        tbl4.pieces = table.clone(tbl4.pieces)
        tbl4.pieces[num1].status = "finished"

        var1(tbl4)
    end):andThen(function()
        if arg3 ~= "Body" then
            return
        end

        local function createFullBodyData(pieces)
            local fullBodyData = {}
            for _, value in pieces do
                if not ConstantsInterface.isBodyPart(value.assetType) then
                    continue
                end

                table.insert(
                    fullBodyData,
                    {
                        assetTypeEnum = value.assetType,
                        allSelectedInstances = value.instance and { value.instance } or {}
                    }
                )
            end
            return fullBodyData
        end

        local fullBodyData = createFullBodyData(tbl4.pieces)

        local tbl5 = {
            fullBodyData = fullBodyData,
            isServer = false,
            allowEditableInstances = allowEditableInstances,
            bypassFlags = bypassFlags,
            validateMeshPartAccessories = false,
            requireAllFolders = false
        }

        local tbl6 = {}
        for _, value in fullBodyData do
            for _, value2 in value.allSelectedInstances do
                table.insert(tbl6, value2)
            end
        end

        local var2, var3 = createEditableInstancesForContext.processAll(tbl6, allowEditableInstances)
        local var4

        if var2 then
            tbl5.editableMeshes = var3.editableMeshes
            tbl5.editableImages = var3.editableImages

            local var5, var6 = validateFullBody(tbl5)
            var4, var3 = LegacyValidationAdapter.studioRFUBundleValidation(fullBodyData, Enum.BundleType.BodyParts, tbl5, str1, var5, var6)

            destroyEditableInstances(tbl5.editableMeshes, tbl5.editableImages)
        else
            var4 = false
        end

        if not var4 then
            tbl4 = table.clone(tbl4)
            tbl4.errors = table.clone(tbl4.errors)

            assert(var3 and #var3 > 0, "There should always be a reason for failure")
            for _, message in var3 do
                table.insert(tbl4.errors, { assetType = nil, error = { type = "message", message = message } })
            end
        end

        var1(tbl4)
    end):andThen(function()
        return tbl4
    end)
end

return validateBundleReadyForUpload
