-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactSceneUnderstanding = script:FindFirstAncestor("ReactSceneUnderstanding")

local _SceneUnderstanding = require(ReactSceneUnderstanding.Parent.SceneUnderstanding)

local SceneAnalysisContext = require(ReactSceneUnderstanding.SceneAnalysisContext)
local useSourceAssets = require(ReactSceneUnderstanding.useSourceAssets)

local function useAssetsInView(viewportQueryOptions)
    local var1 = SceneAnalysisContext.use()

    return useSourceAssets({ viewportQueryOptions = viewportQueryOptions or var1.viewportQueryOptions }).assetsInView
end

return useAssetsInView
