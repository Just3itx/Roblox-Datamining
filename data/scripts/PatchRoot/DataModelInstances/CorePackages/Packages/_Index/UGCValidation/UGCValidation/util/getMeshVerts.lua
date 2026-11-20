-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)

local function getVerts(arg1, arg2)
    local isServer = arg2.isServer

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

return getVerts
