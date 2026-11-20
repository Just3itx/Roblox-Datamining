-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)

local boundsScale = game:DefineFastInt("UGCValidateFacialBoundsScale", 120) / 100
local getExpectedPartSize = require(scriptParentParent.util.getExpectedPartSize)
local _Types = require(scriptParentParent.util.Types)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)

local getEngineFeatureEngineUGCValidateMinMaxMeshSizeAcrossAllFacs = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidateMinMaxMeshSizeAcrossAllFacs)

local function validateFacialBounds(arg1, arg2)
    local isServer = arg2.isServer

    local var1, var2 = pcallDeferred(function(): boolean
        local expectedPartSize = getExpectedPartSize(arg1, arg2)

        local var1, editableMesh = getEditableMeshFromContext(arg1, "MeshId", arg2)
        if not var1 then
            error("Failed to retrieve MeshContent")
        end
        return UGCValidationService:ValidateEditableMeshFacialBounds(editableMesh, boundsScale, expectedPartSize)
    end, arg2)

    if not var1 then
        local str1 = string.format("Failed to load mesh data for '%s'. Make sure the mesh exists and try again.", arg1:GetFullName())
        if isServer ~= nil and isServer then
            error(str1)
        end
        return false, { str1 }
    elseif not var2 then
        return false, { string.format("DynamicHead (%s) when emoting surpasses the expected bounding box", arg1:GetFullName()) }
    else
        return true
    end
end

local function validateDynamicHeadData(arg1, arg2)
    local now = tick()

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    if not getEngineFeatureEngineUGCValidateMinMaxMeshSizeAcrossAllFacs() then
        failureReasonsAccumulator:updateReasons(validateFacialBounds(arg1, arg2))
    end

    Analytics.recordScriptTime(script.Name, now, arg2)
    return failureReasonsAccumulator:getFinalResults()
end

return validateDynamicHeadData
