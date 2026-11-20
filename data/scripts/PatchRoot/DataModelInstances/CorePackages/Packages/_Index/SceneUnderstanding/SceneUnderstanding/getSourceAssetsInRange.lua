-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local findSourceAssetsFromDescendant = require(SceneUnderstanding.findSourceAssetsFromDescendant)
local getSourceAssetsFromDescendants = require(SceneUnderstanding.getSourceAssetsFromDescendants)
local isSourceAsset = require(SceneUnderstanding.isSourceAsset)
local RangeQueryOptions = require(SceneUnderstanding.options.RangeQueryOptions)

local function getSourceAssetsInRange(vec1: vector, arg1)
    local tbl1 = {}
    local rangeQueryOptions = RangeQueryOptions.new(arg1)

    for _, value in workspace:GetPartBoundsInRadius(vec1, rangeQueryOptions.maxDistance) do
        if isSourceAsset(value) or #findSourceAssetsFromDescendant(value) > 0 then
            table.insert(tbl1, value)
        end
    end

    return getSourceAssetsFromDescendants(tbl1)
end

return getSourceAssetsInRange
