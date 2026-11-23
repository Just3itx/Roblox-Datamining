-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local FoundationCloudAssets = require(AppChatParent.FoundationCloudAssets)
local Assets = FoundationCloudAssets.Assets
local preloadAsset = FoundationCloudAssets.preloadAsset
local var1 = require(AppChat.Logger):new("loadFoundationCloudAsset")

local function loadFoundationCloudAsset(str1: string)
    preloadAsset(str1)
    local asset = Assets[str1]
    if asset then
        return asset.assetId, asset.size
    end

    var1:error("FoundationCloudAsset not found: %s", str1)
    return "", { X = 0, Y = 0 }
end

return loadFoundationCloudAsset
