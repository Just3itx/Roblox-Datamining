-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local ConsolidatedAssets = require(scriptParent.Generated.ConsolidatedAssets)
local ContentProvider = game:GetService("ContentProvider")

local function preloadAsset(str1: string)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Image = ConsolidatedAssets[str1].assetId

    task.spawn(function()
        ContentProvider:PreloadAsync({ imageLabel })
        imageLabel:Destroy()
    end)
end

return preloadAsset
