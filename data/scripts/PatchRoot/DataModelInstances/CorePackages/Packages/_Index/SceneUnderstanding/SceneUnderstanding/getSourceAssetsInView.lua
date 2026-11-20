-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local queryViewport = require(SceneUnderstanding.queryViewport)
local findSourceAssetsFromDescendant = require(SceneUnderstanding.findSourceAssetsFromDescendant)
local getSourceAssetsFromDescendants = require(SceneUnderstanding.getSourceAssetsFromDescendants)
local isSourceAsset = require(SceneUnderstanding.isSourceAsset)
local _ViewportQueryOptions = require(SceneUnderstanding.options.ViewportQueryOptions)

local function getSourceAssetsInView(arg1, arg2)
    local var1 = queryViewport(arg1, function(arg3)
        return isSourceAsset(arg3) or #findSourceAssetsFromDescendant(arg3) > 0
    end, arg2)

    return getSourceAssetsFromDescendants(var1)
end

return getSourceAssetsInView
