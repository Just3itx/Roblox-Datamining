-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local useAssetFetchStatus = require(MomentsCommonParent.RoactUtils).Hooks.useAssetFetchStatus

local function useImageLoadingState(str1: string?): boolean
    return useAssetFetchStatus(str1) == Enum.AssetFetchStatus.Success
end

return useImageLoadingState
