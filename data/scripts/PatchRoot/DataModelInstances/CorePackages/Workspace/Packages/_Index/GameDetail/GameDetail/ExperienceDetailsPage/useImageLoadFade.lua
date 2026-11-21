-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local ReactOtter = require(GameDetailParent.ReactOtter)

local tbl1 = { frequency = 3, dampingRatio = 1 }

local function useImageLoadFade()
    local skeletonVisible, var2 = React.useState(true)

    local overlayTransparency, var4 = ReactOtter.useAnimatedBinding(0, function()
        var2(false)
    end)

    return {
        onLoaded = React.useCallback(function(assetFetchStatus)
            if assetFetchStatus == Enum.AssetFetchStatus.Success then
                var4((ReactOtter.spring(1, tbl1)))
            end
        end, {}),
        skeletonVisible = skeletonVisible,
        overlayTransparency = overlayTransparency
    }
end

return useImageLoadFade
