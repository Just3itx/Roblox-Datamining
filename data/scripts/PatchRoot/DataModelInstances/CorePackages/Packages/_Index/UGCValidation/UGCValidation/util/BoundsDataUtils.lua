-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)

local calculateMinMax = require(scriptParentParent.util.calculateMinMax)

local module = {}

function module.combineBounds(arg1, arg2)
    local result = {}

    local minMeshCorner, maxMeshCorner = calculateMinMax(arg1.minMeshCorner, arg1.maxMeshCorner, arg2.minMeshCorner, arg2.maxMeshCorner)
    result.minMeshCorner = minMeshCorner
    result.maxMeshCorner = maxMeshCorner

    local minRigAttachment, maxRigAttachment = calculateMinMax(arg1.minRigAttachment, arg1.maxRigAttachment, arg2.minRigAttachment, arg2.maxRigAttachment)
    result.minRigAttachment = minRigAttachment
    result.maxRigAttachment = maxRigAttachment

    module.setOverallBounds(result)
    return result
end

function module.expandMeshBounds(arg1, vec1: vector)
    local minMeshCorner, maxMeshCorner = calculateMinMax(arg1.minMeshCorner, arg1.maxMeshCorner, vec1, vec1)
    arg1.minMeshCorner = minMeshCorner
    arg1.maxMeshCorner = maxMeshCorner
end

function module.expandRigAttachmentBounds(arg1, vec1: vector)
    local minRigAttachment, maxRigAttachment = calculateMinMax(arg1.minRigAttachment, arg1.maxRigAttachment, vec1, vec1)
    arg1.minRigAttachment = minRigAttachment
    arg1.maxRigAttachment = maxRigAttachment
end

function module.setOverallBounds(arg1)
    local minOverall, maxOverall = calculateMinMax(arg1.minMeshCorner, arg1.maxMeshCorner, arg1.minRigAttachment, arg1.maxRigAttachment)
    arg1.minOverall = minOverall
    arg1.maxOverall = maxOverall
end

function module.calculateBoundsCenters(arg1)
    local var1 = if arg1.minMeshCorner and arg1.maxMeshCorner then (arg1.minMeshCorner + arg1.maxMeshCorner) / 2 else nil
    local var2 = if arg1.minRigAttachment and arg1.maxRigAttachment then (arg1.minRigAttachment + arg1.maxRigAttachment) / 2 else nil

    if arg1.minOverall and arg1.maxOverall then
        return var1, var2, (arg1.minOverall + arg1.maxOverall) / 2
    end

    return var1, var2, nil
end

function module.calculateBoundsDimensions(arg1)
    local var1 = if arg1.minMeshCorner and arg1.maxMeshCorner then arg1.maxMeshCorner - arg1.minMeshCorner else nil
    local var2 = if arg1.minRigAttachment and arg1.maxRigAttachment then arg1.maxRigAttachment - arg1.minRigAttachment else nil

    if arg1.minOverall and arg1.maxOverall then
        return var1, var2, arg1.maxOverall - arg1.minOverall
    end

    return var1, var2, nil
end

return module
