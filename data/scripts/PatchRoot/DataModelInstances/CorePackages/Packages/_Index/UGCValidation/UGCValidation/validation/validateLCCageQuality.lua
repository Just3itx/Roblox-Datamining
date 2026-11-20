-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local getCageMeshInfos = require(scriptParentParent.validation.getCageMeshInfos)

local getFStringLCCageQualityDocumentationLink = require(scriptParentParent.flags.getFStringLCCageQualityDocumentationLink)
local validateLCCagingRelevancy = require(scriptParentParent.validation.validateLCCagingRelevancy)
local validateRenderMeshInsideOuterCageMesh = require(scriptParentParent.validation.validateRenderMeshInsideOuterCageMesh)

local _Types = require(scriptParentParent.util.Types)

local function validateLCCageQuality(arg1, arg2, arg3)
    local bool1 = true
    local tbl1 = {}
    local wrapLayer = arg1:FindFirstChild("Handle"):FindFirstChildOfClass("WrapLayer")
    assert(wrapLayer, "calling validateInstanceTree() means we would not get this far if there was no WrapLayer")

    local var1, var2, var3 = getCageMeshInfos(arg1, arg3)
    if not var1 or var3 == nil then
        return false, var2
    end

    local var4, var5 = unpack({ var3[1], var3[2] })

    local var6, var7 = validateLCCagingRelevancy(var4, var5, arg2, wrapLayer.ReferenceOrigin.Position, wrapLayer.CageOrigin.Position, arg3)

    if not var6 and var7 ~= nil then
        bool1 = false
        for _, value in var7 do
            table.insert(tbl1, value)
        end
    end

    local var8, var9 = validateRenderMeshInsideOuterCageMesh(wrapLayer, var5, arg2, arg3)
    if not var8 then
        table.insert(tbl1, table.concat(var9, "\n"))
        bool1 = false
    end

    if bool1 then
        return true
    end

    if getFStringLCCageQualityDocumentationLink() ~= "" then
        table.insert(tbl1, string.format("[Caging best practices](%s)", getFStringLCCageQualityDocumentationLink()))
    end

    return false, tbl1
end

return validateLCCageQuality
