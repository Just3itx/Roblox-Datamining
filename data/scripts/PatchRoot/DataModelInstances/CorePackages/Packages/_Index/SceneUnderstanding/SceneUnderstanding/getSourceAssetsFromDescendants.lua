-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local isSourceAsset = require(SceneUnderstanding.isSourceAsset)
local findSourceAssetsFromDescendant = require(SceneUnderstanding.findSourceAssetsFromDescendant)

local function getSourceAssetsFromDescendants(tbl1)
    local sourceAssetsFromDescendants = {}

    for _, value in tbl1 do
        if isSourceAsset(value) then
            table.insert(sourceAssetsFromDescendants, value)
        end

        for _, value2 in findSourceAssetsFromDescendant(value) do
            if not table.find(sourceAssetsFromDescendants, value2) then
                table.insert(sourceAssetsFromDescendants, value2)
            end
        end
    end

    return sourceAssetsFromDescendants
end

return getSourceAssetsFromDescendants
