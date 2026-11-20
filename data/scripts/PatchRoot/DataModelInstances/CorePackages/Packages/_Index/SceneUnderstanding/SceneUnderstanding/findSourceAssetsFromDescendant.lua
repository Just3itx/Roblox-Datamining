-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local isSourceAsset = require(SceneUnderstanding.isSourceAsset)

local function findSourceAssetsFromDescendant(arg1)
    local parent = arg1.Parent
    local sourceAssetsFromDescendant = {}

    while parent do
        if isSourceAsset(parent) then
            table.insert(sourceAssetsFromDescendant, parent)
        end
        parent = parent.Parent
    end

    return sourceAssetsFromDescendant
end

return findSourceAssetsFromDescendant
