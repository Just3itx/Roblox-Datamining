-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local FetchEditables = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchEditables)
local FetchCurveAnimations = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchCurveAnimations)
local FetchCurveAnimComputedFrames = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchCurveAnimComputedFrames)
local FetchContentIds = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchContentIds)
local FetchHSRAssets = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchHSRAssets)
local FetchCurveAnimBoneData = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchCurveAnimBoneData)
local FetchFullBodyPartsMetrics = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchFullBodyPartsMetrics)
local _Types = require(scriptParentParentParent.util.Types)
local SharedDataMember = ValidationEnums.SharedDataMember

local getFFlagUGCValidationAllowFullVaas = require(scriptParentParentParent.flags.getFFlagUGCValidationAllowFullVaas)
local getFFlagUGCValidateHeadAboveTorso = require(scriptParentParentParent.flags.getFFlagUGCValidateHeadAboveTorso)
local resetPhysicsData = require(scriptParentParentParent.util.resetPhysicsData)

local tbl1 = {
    SharedDataMember.renderMeshesData,
    SharedDataMember.innerCagesData,
    SharedDataMember.outerCagesData,
    SharedDataMember.meshTextures
}

local module = {
    DATA_FETCH_FAILURE = {}
}
function module.storeDesiredData(arg1, tbl2)
    local rootInstance = arg1.rootInstance
    local preloadedEditableMeshes = arg1.consumerConfig.preloadedEditableMeshes or {}
    local preloadedEditableImages = arg1.consumerConfig.preloadedEditableImages or {}

    if not getFFlagUGCValidationAllowFullVaas() and arg1.consumerConfig.consumerEnv ~= ValidationEnums.ConsumerEnv.IEC then
        local isServer = arg1.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.Backend
        pcall(resetPhysicsData, { rootInstance }, { isServer = isServer, bypassFlags = {} })
    end

    local bool1 = arg1.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC
    for _, value in tbl1 do
        if not tbl2[value] then
            continue
        end

        local success, result = pcall(function()
            return (FetchEditables.getDatas(rootInstance, value, bool1, preloadedEditableMeshes, preloadedEditableImages))
        end)

        if success and result then
            arg1[value] = result
        else
            arg1[value] = module.DATA_FETCH_FAILURE
        end
    end

    local var1

    if tbl2[SharedDataMember.curveAnimations] then
        local var2
        var2, var1 = FetchCurveAnimations.getData(rootInstance, arg1.consumerConfig)
        arg1.curveAnimations = var2 or module.DATA_FETCH_FAILURE
    else
        var1 = nil
    end

    if tbl2[SharedDataMember.curveAnimComputedFrames] then
        if arg1.curveAnimations and arg1.curveAnimations ~= module.DATA_FETCH_FAILURE then
            arg1.curveAnimComputedFrames = FetchCurveAnimComputedFrames.getData(arg1.curveAnimations, var1) or module.DATA_FETCH_FAILURE
        else
            arg1.curveAnimComputedFrames = module.DATA_FETCH_FAILURE
        end
    end

    if tbl2[SharedDataMember.contentIds] then
        arg1.contentIds = FetchContentIds.getData(arg1)
    end

    if tbl2[SharedDataMember.hsrAssets] then
        arg1.hsrAssets = FetchHSRAssets.getData(rootInstance, arg1.consumerConfig) or module.DATA_FETCH_FAILURE
    end

    if tbl2[SharedDataMember.curveAnimBoneData] then
        local data = FetchCurveAnimBoneData.getData(arg1[SharedDataMember.curveAnimations])
        arg1[SharedDataMember.curveAnimBoneData] = data
    end

    if not getFFlagUGCValidateHeadAboveTorso() or not tbl2[SharedDataMember.fullBodyPartsMetrics] then
        return
    end
    if arg1.uploadCategory ~= ValidationEnums.UploadCategory.FULL_BODY
        or not arg1.renderMeshesData
        or arg1.renderMeshesData == module.DATA_FETCH_FAILURE
    then
        arg1.fullBodyPartsMetrics = {}
        return
    end

    local success, result = pcall(FetchFullBodyPartsMetrics.getData, arg1)
    if success and result then
        arg1.fullBodyPartsMetrics = result
        return
    end
    arg1.fullBodyPartsMetrics = {}
end

return module
