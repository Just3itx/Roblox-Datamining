-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.util.Types)
local getMeshInfo = require(scriptParentParent.util.getMeshInfo)
local getMeshMinMax = require(scriptParentParent.util.getMeshMinMax)
local getExpectedPartSize = require(scriptParentParent.util.getExpectedPartSize)

local function getRenderMeshScale(arg1, arg2)
    local var1, var2, var3 = getMeshInfo(arg1, Constants.MESH_CONTENT_TYPE.RENDER_MESH, arg2)

    if not var1 then
        return var1, var2
    end

    local var4, var5, var6, var7 = getMeshMinMax(var3, arg2)
    if not var4 then
        return var4, var5
    end
    local var8 = var7 - var6
    return true, nil, getExpectedPartSize(arg1, arg2) / var8
end

return getRenderMeshScale
