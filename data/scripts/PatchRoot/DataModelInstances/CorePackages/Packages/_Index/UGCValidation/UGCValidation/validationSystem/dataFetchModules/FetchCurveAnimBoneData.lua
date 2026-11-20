-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local CurveAnimBoneHierarchyUtils = require(scriptParentParentParent.util.CurveAnimBoneHierarchyUtils)

local module = {}

function module.getData(tbl1)
    if not tbl1 then
        return nil
    end
    if typeof(tbl1) ~= "table" or #tbl1 == 0 then
        return nil
    end

    local bool1 = false
    for _, value in tbl1 do
        for _, descendant in value:GetDescendants() do
            if descendant:IsA("Folder") and CurveAnimBoneHierarchyUtils.isBoneFolderName(descendant.Name) then
                bool1 = true
                break
            end
        end

        if bool1 then
            break
        end
    end

    return if bool1 then { hasBones = true } else nil
end

return module
