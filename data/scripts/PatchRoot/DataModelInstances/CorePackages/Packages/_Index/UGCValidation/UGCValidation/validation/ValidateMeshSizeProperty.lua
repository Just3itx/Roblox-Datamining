-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)

local Analytics = require(scriptParentParent.Analytics)

local util = scriptParentParent.util
local floatEquals = require(scriptParentParent.util.floatEquals)
local _Types = require(util.Types)
local pcallDeferred = require(util.pcallDeferred)
local getMeshSize = require(util.getMeshSize)
local getEditableMeshFromContext = require(util.getEditableMeshFromContext)
local FailureReasonsAccumulator = require(util.FailureReasonsAccumulator)

local module = {}

local function reportFailure(str1: string, str2: string, arg1, bool1: boolean): (boolean, {string})
    if bool1 and arg1.isServer ~= nil and arg1.isServer then
        error(str1)
    end

    Analytics.reportFailure(str2, nil, arg1)
    return false, { str1 }
end

local function vector3Equals(meshSize: vector, vec1: vector) -- Luacid: Inlined by compiler; 1 call site recovered
    return floatEquals(meshSize.X, vec1.X, 0.00001)
        and floatEquals(meshSize.Y, vec1.Y, 0.00001)
        and floatEquals(meshSize.Z, vec1.Z, 0.00001)
end

local function calculateMeshSize(arg1, arg2)
    local tbl1 = {
        fullName = arg1:GetFullName(),
        fieldName = "MeshId",
        contentId = arg1.MeshId,
        context = arg1.Name
    }

    local var1, editableMesh = getEditableMeshFromContext(arg1, "MeshId", arg2)
    if not var1 then
        return reportFailure(
            string.format("Mesh for '%s' failed to load. Make sure the mesh exists and try again.", arg1.Name),
            Analytics.ErrorType.validateMeshSizeProperty_FailedToLoadMesh,
            arg2,
            false
        )
    end

    tbl1.editableMesh = editableMesh

    local var3, var4 = pcallDeferred(function()
        return getMeshSize(tbl1)
    end, arg2)

    if not var3 then
        return reportFailure(
            string.format("Mesh for '%s' failed to load. Make sure the mesh exists and try again.", arg1.Name),
            Analytics.ErrorType.validateMeshSizeProperty_FailedToLoadMesh,
            arg2,
            true
        )
    end
    return true, nil, var4
end

local function validateInternal(arg1, arg2)
    local now = tick()

    local var1, var2, var3 = calculateMeshSize(arg1, arg2)
    if not (var1 and var3) then
        return var1, var2
    end

    if not vector3Equals(arg1.MeshSize, var3) then
        return reportFailure(
            string.format("Calculated mesh size for %s does not match MeshSize property value", arg1.Name),
            Analytics.ErrorType.validateMeshSizeProperty_Mismatch,
            arg2,
            false
        )
    end

    Analytics.recordScriptTime(script.Name, now, arg2)
    return true
end

function module.validateSingleMeshPart(arg1, arg2)
    if arg2.allowEditableInstances then
        return true
    end
    return validateInternal(arg1, arg2)
end

function module.validateBodyAsset(arg1, arg2)
    local now = tick()

    if arg2.allowEditableInstances then
        return true
    end

    local assetTypeEnum = arg2.assetTypeEnum

    if Enum.AssetType.DynamicHead == assetTypeEnum then
        local var1, var2 = validateInternal(arg1, arg2)
        Analytics.recordScriptTime(script.Name, now, arg2)
        return var1, var2
    end

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    for k in Constants.ASSET_TYPE_INFO[assetTypeEnum].subParts do
        local var1 = arg1:FindFirstChild(k)
        assert(var1)

        failureReasonsAccumulator:updateReasons(validateInternal(var1, arg2))
    end

    Analytics.recordScriptTime(script.Name, now, arg2)
    return failureReasonsAccumulator:getFinalResults()
end

return module
