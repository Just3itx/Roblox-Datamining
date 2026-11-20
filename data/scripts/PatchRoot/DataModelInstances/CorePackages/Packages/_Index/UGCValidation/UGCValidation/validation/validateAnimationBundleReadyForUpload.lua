-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Promise = require(scriptParentParent.Parent.Promise)

local Constants = require(scriptParentParent.Constants)
local _BundlesMetadata = require(scriptParentParent.util.BundlesMetadata)
local _Types = require(scriptParentParent.util.Types)
local ErrorSourceStrings = require(scriptParentParent.validationSystem.ErrorSourceStrings)
local createEditableInstancesForContext = require(scriptParentParent.util.createEditableInstancesForContext)
local destroyEditableInstances = require(scriptParentParent.util.destroyEditableInstances)

local _validateBundleReadyForUpload = require(scriptParentParent.validation.validateBundleReadyForUpload)

local LegacyValidationAdapter = require(scriptParentParent.util.LegacyValidationAdapter)
local HttpService = game:GetService("HttpService")

local function hasExactStringValueNames(arg1, stringValueNames)
    local tbl1 = ({})
    for _, value in stringValueNames do
        tbl1[value] = true
    end

    local tbl2 = {}
    for _, child in arg1:GetChildren() do
        if not child:IsA("StringValue") then
            continue
        end

        if not tbl1[child.Name] or tbl2[child.Name] then
            return false
        end
        tbl2[child.Name] = true
    end

    for _, value in stringValueNames do
        if not tbl2[value] then
            return false
        end
    end

    return true
end

local function validateAnimationBundleReadyForUpload(arg1, arg2, str1: string, func1: ((...any) -> (...any))?, allowEditableInstances: boolean?, bypassFlags)
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
    local tbl1 = ({})
    if Constants.ANIMATION_ASSET_INFO then
        local tbl2 = {}
        local tbl3 = {}

        local tbl4 = ({})

        for value, value2 in Constants.ANIMATION_ASSET_INFO do
            local bool1 = false
            for _, child in arg1:GetChildren() do
                local var2 = child.Name == "R15Anim" and child:IsA("Folder") and hasExactStringValueNames(child, value2.stringValueNames)

                if tbl4[child] or not var2 then
                    continue
                end

                tbl1[value] = { child }
                tbl4[child] = true
                bool1 = true
                break
            end

            if not bool1 then
                table.insert(tbl3, value.Name)
            end
        end

        for _, child in arg1:GetChildren() do
            if not tbl4[child] and child.Name ~= "R15Anim" then
                table.insert(tbl2, child.Name)
            end
        end

        if #tbl3 > 0 then
            local tbl5 = {
                errors = {{
                    assetType = nil,
                    error = {
                        type = "message",
                        message = string.gsub(
                            ErrorSourceStrings.Values.AnimationPack_InvalidR15AnimChildren,
                            "{missingAnimationTypes}",
                            table.concat(tbl3, ", ")
                        )
                    }
                }},
                pieces = {}
            }
            return Promise.resolve(tbl5)
        end

        if #tbl2 > 0 then
            local tbl5 = {
                errors = {{
                    assetType = nil,
                    error = {
                        type = "message",
                        message = string.gsub(
                            ErrorSourceStrings.Values.AnimationPack_UnexpectedBundleChildren,
                            "{unexpectedNames}",
                            table.concat(tbl2, ", ")
                        )
                    }
                }},
                pieces = {}
            }
            return Promise.resolve(tbl5)
        end
    end

    local tbl2 = ({})

    local errors = {}
    local pieces = {}

    for k, settings in arg2[str1].allowedAssetTypeSettings do
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

    if Constants.ANIMATION_ASSET_INFO then
        for value, _ in Constants.ANIMATION_ASSET_INFO do
            if tbl2[value] then
                table.insert(pieces, tbl2[value])
            end
        end
    end

    local tbl5 = { errors = errors, pieces = pieces }

    var1(tbl5)

    local str2 = HttpService:GenerateGUID()

    return Promise.each(pieces, function(arg3, num1: number)
        if arg3.status == "finished" then
            return
        end

        assert(arg3.instance ~= nil, "Unfinished piece doesn't have an instance")

        local instances = { arg3.instance }
        local tbl7 = {
            instances = instances,
            assetTypeEnum = arg3.assetType,
            allowEditableInstances = allowEditableInstances,
            bypassFlags = bypassFlags
        }

        local var2, var3 = createEditableInstancesForContext.processAll(instances, allowEditableInstances)
        local var4

        if var2 then
            tbl7.editableMeshes = var3.editableMeshes
            tbl7.editableImages = var3.editableImages

            var4, var3 = LegacyValidationAdapter.studioRFUAssetValidation(tbl7, str2, true, nil)

            destroyEditableInstances(tbl7.editableMeshes, tbl7.editableImages)
        else
            var4 = false
        end

        tbl5 = table.clone(tbl5)
        tbl5.errors = table.clone(tbl5.errors)

        if not var4 then
            assert(var3 ~= nil, "Failure without errors")
            for _, message in var3 do
                table.insert(tbl5.errors, { assetType = arg3.assetType, error = { type = "message", message = message } })
            end
        end

        tbl5.pieces = table.clone(tbl5.pieces)
        tbl5.pieces[num1].status = "finished"

        var1(tbl5)
    end):andThen(function()
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

            var4, var3 = LegacyValidationAdapter.studioRFUBundleValidation(fullBodyData, Enum.BundleType.Animations, tbl6, str2, true, nil)

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

        var1(tbl5)
    end):andThen(function()
        return tbl5
    end)
end

return validateAnimationBundleReadyForUpload
