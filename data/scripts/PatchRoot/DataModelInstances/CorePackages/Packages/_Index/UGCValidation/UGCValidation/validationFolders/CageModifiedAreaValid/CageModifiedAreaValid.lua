-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local WrapTargetCageUVReferenceValues = require(scriptParentParentParent.WrapTargetCageUVReferenceValues)
local CollisionTestUtil = require(scriptParentParentParent.util.CollisionTestUtil)
local StringUtil = require(scriptParentParentParent.util.StringUtil)

local num1 = game:DefineFastInt("UGCValidateExcludedUVModifyRequirements", 14)
local num2 = game:DefineFastInt("UGCValidatePartUVModifyRequirements", 45)
local num3 = game:DefineFastInt("UGCValidateRenderMeshInsideModifiedArea", 70)

local var1 = tonumber((game:DefineFastString("UGCValidateModifiedAreaPaddingModifier", "1.1")))

local module = {}

local tbl1 = {
    [Enum.AssetType.LeftShoeAccessory] = {
        allowedParts = { LeftFoot = true, LeftLowerLeg = true, LeftUpperLeg = true },
        mainParts = { LeftFoot = true }
    },
    [Enum.AssetType.RightShoeAccessory] = {
        allowedParts = { RightFoot = true, RightLowerLeg = true, RightUpperLeg = true },
        mainParts = { RightFoot = true }
    }
}

module.categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING }

module.requiredData = { ValidationEnums.SharedDataMember.innerCagesData, ValidationEnums.SharedDataMember.outerCagesData, ValidationEnums.SharedDataMember.renderMeshesData }

module.conditionalData = {}

module.expectedFailures = {}

local function gatherUVs(tbl2)
    local result = {}
    for value in tbl2 do
        local var2 = WrapTargetCageUVReferenceValues[value]

        for _, value2 in assert(var2, "Body area not found in UV reference values") do
            table.insert(result, value2)
        end
    end
    return result
end

local function lazyGetUVsExcludedForAssetType(tbl2)
    if not tbl2.uVsDisallowedForAssetType then
        local tbl3 = ({})
        for value in WrapTargetCageUVReferenceValues do
            if not tbl2.allowedParts[value] then
                tbl3[value] = true
            end
        end

        tbl2.uVsDisallowedForAssetType = gatherUVs(tbl3)
    end
    return tbl2.uVsDisallowedForAssetType
end

local function lazyGetUVsForAssetType(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if not tbl2.uVsForAssetType then
        tbl2.uVsForAssetType = gatherUVs(tbl2.allowedParts)
    end
    return tbl2.uVsForAssetType
end

local function lazyGetMainUVsForAssetType(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if not tbl2.mainUVsForAssetType then
        tbl2.mainUVsForAssetType = gatherUVs(tbl2.mainParts)
    end
    return tbl2.mainUVsForAssetType
end

function module.run(arg1, arg2)
    local assetType = arg2.uploadEnum.assetType

    local var2 = tbl1[assetType]
    if not var2 then
        return
    end

    local handle = arg2.innerCagesData.Handle
    local handle2 = arg2.outerCagesData.Handle
    if not (handle and handle2) then
        return
    end

    local origin = handle.origin
    local origin2 = handle2.origin

    local uVsDisallowedForAssetType = lazyGetUVsExcludedForAssetType(var2)
    if #uVsDisallowedForAssetType > 0 then
        local var3, var4, var5 = UGCValidationService:CalculateEditableMeshNumModifiedCageUVsInSet(
            uVsDisallowedForAssetType,
            handle.editable,
            origin,
            handle2.editable,
            origin2
        )

        assert(
            var3 == #uVsDisallowedForAssetType,
            "all the UVs in allExcludedUVsForBodyArea sent in to CalculateEditableMeshNumModifiedCageUVsInSet should be unique"
        )

        if var4 ~= 0 then
            local var6 = var5 / var4 * 100
            if num1 < var6 then
                local cageUvTooManyExcludedModified = ErrorSourceStrings.Keys.CageUV_TooManyExcludedModified
                local tbl2 = {
                    modifiedPercent = tostring(math.floor(var6)),
                    assetTypeName = assetType.Name,
                    maxPercent = tostring(num1),
                    allowedArea = StringUtil.keysToString(var2.allowedParts, "/")
                }
                arg1:fail(cageUvTooManyExcludedModified, tbl2)
            end
        end
    end

    local mainUVsForAssetType = lazyGetMainUVsForAssetType(var2)

    if #mainUVsForAssetType > 0 then
        local var3, _, var4 = UGCValidationService:CalculateEditableMeshNumModifiedCageUVsInSet(
            mainUVsForAssetType,
            handle.editable,
            origin,
            handle2.editable,
            origin2
        )

        assert(
            var3 == #mainUVsForAssetType,
            "all the UVs in allUVsForBodyArea sent in to CalculateEditableMeshNumModifiedCageUVsInSet should be unique"
        )

        local var5 = var4 / var3 * 100
        if var5 < num2 then
            local cageUvTooFewMainModified = ErrorSourceStrings.Keys.CageUV_TooFewMainModified
            local tbl2 = {
                assetTypeName = assetType.Name,
                requiredPercent = tostring(num2),
                mainArea = StringUtil.keysToString(var2.mainParts, "/"),
                currentPercent = tostring(math.floor(var5))
            }
            arg1:fail(cageUvTooFewMainModified, tbl2)
        end
    end

    local uVsForAssetType = lazyGetUVsForAssetType(var2)

    if not (#uVsForAssetType > 0) then
        return
    end

    local handle3 = arg2.renderMeshesData.Handle
    if not handle3 then
        return
    end

    local var3, var4 = UGCValidationService:CalculateEditableMeshModifiedCageBoundingBox(
        uVsForAssetType,
        handle.editable,
        origin,
        handle2.editable,
        origin2
    )

    local editableMeshVerts = UGCValidationService:GetEditableMeshVerts(handle3.editable)
    if not editableMeshVerts or #editableMeshVerts == 0 then
        arg1:fail(ErrorSourceStrings.Keys.CageUV_RenderMeshBoundsCheckFailed)
        return
    end

    local var5 = var4 * var1

    local num4 = 0
    for _, editableMeshVert in editableMeshVerts do
        if CollisionTestUtil.pointInAxisAlignedBounds(editableMeshVert, var3, var5) then
            num4 += 1
        end
    end

    local num5 = num4 / #editableMeshVerts * 100
    if not (num5 < num3) then
        return
    end

    local allowedArea = StringUtil.keysToString(var2.allowedParts, "/")
    local cageUvRenderMeshOutsideModifiedArea = ErrorSourceStrings.Keys.CageUV_RenderMeshOutsideModifiedArea
    local tbl2 = {
        currentPercent = tostring(math.floor(num5)),
        allowedArea = allowedArea,
        requiredPercent = tostring(num3)
    }
    arg1:fail(cageUvRenderMeshOutsideModifiedArea, tbl2)
end

return module
