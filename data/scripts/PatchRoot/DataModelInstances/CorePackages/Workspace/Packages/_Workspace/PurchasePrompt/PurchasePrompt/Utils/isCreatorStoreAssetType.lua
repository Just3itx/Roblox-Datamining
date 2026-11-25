-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _scriptParentParent = script.Parent.Parent

function isCreatorStoreAssetType(str1: string)
    if str1 == nil or type(str1) ~= "string" then
        return false
    end

    for _, value in {
        "Model",
        "Plugin",
        "Audio",
        "Decal",
        "FontFamily",
        "MeshPart",
        "Video"
    } do
        if str1 == value then
            return true
        end
    end

    return false
end

return isCreatorStoreAssetType
