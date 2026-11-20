-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Promise = require(scriptParentParent.Parent.Promise)

local _BundlesMetadata = require(scriptParentParent.util.BundlesMetadata)
local _Types = require(scriptParentParent.util.Types)
local createEditableInstancesForContext = require(scriptParentParent.util.createEditableInstancesForContext)
local destroyEditableInstances = require(scriptParentParent.util.destroyEditableInstances)
local _createUGCBodyPartFolders = require(scriptParentParent.util.createUGCBodyPartFolders)
local fixUpPreValidation = require(scriptParentParent.util.fixUpPreValidation)

local validateInternal = require(scriptParentParent.validation.validateInternal)
local validateShoes = require(scriptParentParent.validation.validateShoes)
local _validateBundleReadyForUpload = require(scriptParentParent.validation.validateBundleReadyForUpload)

local bool1 = game:DefineFastFlag("ValidateFullShoesBundleStudio", false)
local LegacyValidationAdapter = require(scriptParentParent.util.LegacyValidationAdapter)
local HttpService = game:GetService("HttpService")

local function validateShoesBundleReadyForUpload(arg1, arg2, arg3, func1: ((...any) -> (...any))?, allowEditableInstances: boolean?, bypassFlags)
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
    local leftShoeAccessory = arg1:FindFirstChild("LeftShoeAccessory")
    local rightShoeAccessory = arg1:FindFirstChild("RightShoeAccessory")

    if not (leftShoeAccessory and leftShoeAccessory:IsA("Accessory") and rightShoeAccessory and rightShoeAccessory:IsA("Accessory")) then
        return Promise.resolve({
            errors = {{
                assetType = nil,
                error = {
                    type = "message",
                    message = "Shoes must of type 'Accessory' and names must be 'LeftShoeAccessory' and 'RightShoeAccessory'"
                }
            }},
            pieces = {}
        })
    end
    local tbl1 = {
        [Enum.AssetType.LeftShoeAccessory] = { fixUpPreValidation(leftShoeAccessory) },
        [Enum.AssetType.RightShoeAccessory] = { fixUpPreValidation(rightShoeAccessory) }
    }

    local tbl2 = ({})

    local errors = {}
    local pieces = {}

    for k, settings in arg2[arg3].allowedAssetTypeSettings do
        local assetType = assert(Enum.AssetType[k], "Asset type name doesn't map to an enum item")

        if not settings.isEligibleForUpload then
            continue
        end

        local var3 = tbl1[assetType]
        local instance = var3 and var3[1]

        tbl2[assetType] = {
            assetType = assetType,
            instance = instance,
            settings = settings,
            status = if instance == nil then "finished" else "pending"
        }

        if instance ~= nil then
            continue
        end

        table.insert(errors, { assetType = assetType, error = { type = "notFound" } })
    end

    table.insert(pieces, tbl2[Enum.AssetType.LeftShoeAccessory])
    table.insert(pieces, tbl2[Enum.AssetType.RightShoeAccessory])

    local tbl5 = { errors = errors, pieces = pieces }

    var1(tbl5)

    local str1 = HttpService:GenerateGUID()

    return Promise.each(pieces, function(arg4, num1: number)
        if arg4.status == "finished" then
            return
        end

        assert(arg4.instance ~= nil, "Unfinished piece doesn't have an instance")

        local instances = { arg4.instance }
        local tbl7 = {
            instances = instances,
            assetTypeEnum = arg4.assetType,
            allowEditableInstances = allowEditableInstances,
            bypassFlags = bypassFlags
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

        tbl5 = table.clone(tbl5)
        tbl5.errors = table.clone(tbl5.errors)

        if not var4 then
            assert(var3 ~= nil, "Failure without errors")
            for _, message in var3 do
                table.insert(tbl5.errors, { assetType = arg4.assetType, error = { type = "message", message = message } })
            end
        end

        tbl5.pieces = table.clone(tbl5.pieces)
        tbl5.pieces[num1].status = "finished"

        var1(tbl5)
    end):andThen(function()
        if bool1 then
            local function createFullBodyData(pieces)
                local fullBodyData = {}
                for _, value in pieces do
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

            local fullBodyData = createFullBodyData(tbl5.pieces)

            local tbl6 = {
                fullBodyData = fullBodyData,
                isServer = false,
                allowEditableInstances = allowEditableInstances,
                bypassFlags = bypassFlags
            }

            local tbl7 = {}
            for _, value in fullBodyData do
                for _, value2 in value.allSelectedInstances do
                    table.insert(tbl7, value2)
                end
            end

            local var2, var3 = createEditableInstancesForContext.processAll(tbl7, allowEditableInstances)
            local var4

            if var2 then
                tbl6.editableMeshes = var3.editableMeshes
                tbl6.editableImages = var3.editableImages

                local var5, var6 = validateShoes(tbl6)
                var4, var3 = LegacyValidationAdapter.studioRFUBundleValidation(fullBodyData, Enum.BundleType.Shoes, tbl6, str1, var5, var6)

                destroyEditableInstances(tbl6.editableMeshes, tbl6.editableImages)
            else
                var4 = false
            end

            if not var4 then
                tbl5 = table.clone(tbl5)
                tbl5.errors = table.clone(tbl5.errors)

                assert(var3 and #var3 > 0, "There should always be a reason for failure")
                for _, message in var3 do
                    table.insert(tbl5.errors, { assetType = nil, error = { type = "message", message = message } })
                end
            end
        end

        var1(tbl5)
    end):andThen(function()
        return tbl5
    end)
end

return validateShoesBundleReadyForUpload
