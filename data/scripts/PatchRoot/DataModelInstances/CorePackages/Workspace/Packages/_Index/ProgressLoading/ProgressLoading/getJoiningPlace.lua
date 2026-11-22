-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")

local EngineFeatureEnableDeferredAssetManagerService = require(ProgressLoading.Flags.EngineFeatureEnableDeferredAssetManagerService)
local DeferredAssetManagerService = if EngineFeatureEnableDeferredAssetManagerService then game:GetService("DeferredAssetManagerService") else nil

return {
    getJoiningPlaceId = function(): number
        return if EngineFeatureEnableDeferredAssetManagerService and DeferredAssetManagerService then DeferredAssetManagerService.JoiningPlaceId or 0 else 0
    end,
    getJoiningUniverseId = function(): number
        return if EngineFeatureEnableDeferredAssetManagerService and DeferredAssetManagerService then DeferredAssetManagerService.JoiningUniverseId or 0 else 0
    end
}
