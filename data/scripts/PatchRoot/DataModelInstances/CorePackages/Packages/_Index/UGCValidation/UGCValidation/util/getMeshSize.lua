-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local function getMeshSize(arg1): Vector3
    local editableMeshVerts = UGCValidationService:GetEditableMeshVerts(arg1.editableMesh)

    local huge = math.huge
    local huge2 = -math.huge
    local huge3 = math.huge
    local huge4 = -math.huge
    local huge5 = math.huge
    local huge6 = -math.huge

    for i = 1, #editableMeshVerts do
        local editableMeshVert = editableMeshVerts[i]
        huge = math.min(huge, editableMeshVert.X)
        huge3 = math.min(huge3, editableMeshVert.Y)
        huge5 = math.min(huge5, editableMeshVert.Z)
        huge2 = math.max(huge2, editableMeshVert.X)
        huge4 = math.max(huge4, editableMeshVert.Y)
        huge6 = math.max(huge6, editableMeshVert.Z)
    end

    return Vector3.new(huge2 - huge, huge4 - huge3, huge6 - huge5)
end

return getMeshSize
