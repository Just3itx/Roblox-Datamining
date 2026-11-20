-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)

local calculateMinMax = require(scriptParentParent.util.calculateMinMax)

local function getVerts(arg1, isServer: boolean?, arg2)
    local var1, var2 = pcallDeferred(function()
        return UGCValidationService:GetEditableMeshVerts(arg1.editableMesh)
    end, arg2)

    if var1 then
        return true, nil, var2
    end

    local var3 = "Failed to read mesh: " .. arg1.fullName
    if isServer then
        error(var3)
    end
    return false, { var3 }
end

local function getBoundsInfo(arg1, scale: vector?)
    local var1 = nil
    local var2 = nil

    for _, value in pairs(arg1) do
        if scale then
            value *= scale
        end

        var1, var2 = calculateMinMax(var1, var2, value, value)
    end
    return var1, var2
end

local function getMeshMinMax(arg1, arg2)
    local isServer = arg2.isServer
    local var1, var2, var3 = getVerts(arg1, isServer, arg2)
    if not var1 then
        return var1, var2
    end

    if not var3 or #var3 == 0 then
        return false, { "Mesh: " .. arg1.fullName .. " contains no verts" }
    end

    local var4, var5 = getBoundsInfo(var3, arg1.scale)
    return true, nil, var4, var5
end

return getMeshMinMax
