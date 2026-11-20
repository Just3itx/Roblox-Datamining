-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)
local getMeshSize = require(scriptParentParent.util.getMeshSize)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)

return function(arg1, arg2, bool1: boolean?)
    if not (arg2.bypassFlags and arg2.bypassFlags.skipPhysicsDataReset) then
        return if bool1 then arg1.MeshSize else arg1.Size
    end

    if not arg2.partSizes then
        arg2.partSizes = {}
    end

    if arg2.partSizes[arg1] then
        return arg2.partSizes[arg1]
    end

    local tbl1 = {
        fullName = arg1:GetFullName(),
        fieldName = "MeshId",
        contentId = arg1.MeshId,
        context = arg1.Name
    }

    local var1, editableMesh = getEditableMeshFromContext(arg1, "MeshId", arg2)
    if not var1 then
        return if bool1 then arg1.MeshSize else arg1.Size
    end

    tbl1.editableMesh = editableMesh

    if arg2.editableMeshes[arg1].MeshId.created then
        return if bool1 then arg1.MeshSize else arg1.Size
    end

    local var3, var4 = pcallDeferred(function()
        return getMeshSize(tbl1)
    end, arg2)

    if not var3 then
        return if bool1 then arg1.MeshSize else arg1.Size
    end

    arg2.partSizes[arg1] = var4
    return var4
end
