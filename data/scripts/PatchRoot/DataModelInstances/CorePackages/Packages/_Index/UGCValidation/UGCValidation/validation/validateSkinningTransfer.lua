-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local ConstantsInterface = require(scriptParentParent.ConstantsInterface)
local Constants = require(scriptParentParent.Constants)

local _Types = require(scriptParentParent.util.Types)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)

local getFFlagUGCValidationEyebrowEyelashSupport = require(scriptParentParent.flags.getFFlagUGCValidationEyebrowEyelashSupport)

local function validateSkinningTransfer(arg1, arg2)
    local assetTypeEnum = arg2.assetTypeEnum

    local var1, var2 = pcallDeferred(function()
        local var1, editableMesh = getEditableMeshFromContext(arg1, "MeshId", arg2)
        if not var1 then
            error("Failed to retrieve MeshContent")
        end
        return UGCValidationService:GetEditableMeshSkinningTransferJointsInfo(editableMesh)
    end, arg2)

    if not var1 then
        Analytics.reportFailure(Analytics.ErrorType.validateSkinningTransfer_FailedToExecute, nil, arg2)
        return false, { string.format(
                "Failed to execute skinning transfer check for '%s'. Make sure the mesh exists and try again.",
                arg1:GetFullName()
            ) }
    end

    local bool1 = next(var2) ~= nil
    if bool1 then
        local tbl1 = {}
        for value in var2 do
            table.insert(tbl1, value)
        end
        local str1 = table.concat(tbl1, ", ")

        if ConstantsInterface.isBodyPart(assetTypeEnum) then
            Analytics.reportFailure(Analytics.ErrorType.validateSkinningTransfer_BodyPartsWithSpecialJoints, nil, arg2)

            return false, { string.format(
                    "Invalid joints [%s] found in body mesh '%s'. Please remove the joints and try again.",
                    str1,
                    arg1:GetFullName()
                ) }
        end

        local wrapLayer = arg1:FindFirstChildOfClass("WrapLayer")
        assert(wrapLayer, "MeshPart isn't a body part, so it must be an accessory with a WrapLayer")
        if wrapLayer.AutoSkin ~= Enum.WrapLayerAutoSkin.EnabledOverride then
            Analytics.reportFailure(Analytics.ErrorType.validateSkinningTransfer_SkinningTransferOverride, nil, arg2)

            return false, { string.format(
                    "Skinning Transfer joints [%s] found in '%s'. WrapLayer.AutoSkin must be set to EnabledOverride when joints are present.",
                    str1,
                    arg1:GetFullName()
                ) }
        end
    end

    if getFFlagUGCValidationEyebrowEyelashSupport() and not bool1 and Constants.SkinningTransferRequiredTypes[assetTypeEnum] then
        Analytics.reportFailure(Analytics.ErrorType.validateSkinningTransfer_RequiredAssetTypes, nil, arg2)

        return false, { string.format(
                "No Skinning Transfer joints found in '%s'. Accessories of type %s are required to use Skinning Transfer with RBX_Leader and RBX_Follower joints.",
                arg1:GetFullName(),
                assetTypeEnum.Name
            ) }
    end

    for value, value2 in var2 do
        if not value2 then
            Analytics.reportFailure(Analytics.ErrorType.validateSkinningTransfer_Weights, nil, arg2)
            return false, { string.format(
                    "Vert(s) in mesh '%s' are only partially weighted to joint %s. Vert(s) must be fully weighted to this joint.",
                    arg1:GetFullName(),
                    value
                ) }
        end
    end

    return true
end

return validateSkinningTransfer
