-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local UGCValidationService = game:GetService("UGCValidationService")
local Analytics = require(scriptParentParent.Analytics)

local util = scriptParentParent.util
local Constants = require(scriptParentParent.Constants)
local _Types = require(util.Types)
local pcallDeferred = require(util.pcallDeferred)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)

local getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning)
local getFFlagUGCValidationEnableR15plusSkinning = require(scriptParentParent.flags.getFFlagUGCValidationEnableR15plusSkinning)

local module = {}

function module.validateMeshPart(arg1, arg2)
    if getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning() and getFFlagUGCValidationEnableR15plusSkinning() then
        error(
            "ValidateMeshPartOnlySkinnedToR15 is deprecated. Use RigidSkinnedToSchema / LCSkinnedToSchema / BodySkinnedToSchema instead."
        )
    end

    local var1, editableMesh = getEditableMeshFromContext(arg1, "MeshId", arg2)

    if not var1 then
        Analytics.reportFailure(Analytics.ErrorType.validateBodyPartVertsSkinnedToR15_FailedToFetchSkinning, nil, arg2)

        return false, { `Could not get editable mesh data for {arg1}. Please retry later or make a bug report.` }
    end

    local var2, var3 = pcallDeferred(function()
        return { UGCValidationService:GetSkinnedJointNamesFromEditableMesh(editableMesh) }
    end, arg2)

    if not var2 then
        Analytics.reportFailure(Analytics.ErrorType.validateBodyPartVertsSkinnedToR15_FailedToFetchSkinning, nil, arg2)

        return false, { `Could not get skinning data for {arg1}. Please retry later or make a bug report.` }
    end

    for _, value in var3 do
        if Constants.R15_STANDARD_JOINT_NAMES[value] == nil then
            Analytics.reportFailure(Analytics.ErrorType.validateBodyPartVertsSkinnedToR15_BodyIsSkinnedToFakeJoints, nil, arg2)

            return false, { `{arg1} is skinned to a non-standard joint {value}. This part may only be skinned to standard R15 joints.` }
        end
    end

    return true
end

function module.validateBodyParts(arg1, arg2)
    if getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning() and getFFlagUGCValidationEnableR15plusSkinning() then
        error(
            "ValidateMeshPartOnlySkinnedToR15 is deprecated. Use RigidSkinnedToSchema / LCSkinnedToSchema / BodySkinnedToSchema instead."
        )
    end

    for _, value in Constants.R15_BODY_PARTS do
        local var1 = arg1:FindFirstChild(value)

        if not var1 then
            continue
        end

        local var2, var3 = module.validateMeshPart(var1, arg2)
        if not var2 then
            return var2, var3
        end
    end

    return true
end

return module
