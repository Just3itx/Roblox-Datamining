-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)

local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

local function SceneOutfitPoster(tbl1)
    local var1 = useTokens()
    local uri = tbl1.content.Uri
    local var2, var3 = React.useState(nil)
    local bool1 = not (uri == nil) and var2 == uri

    local onLoaded = React.useCallback(function(assetFetchStatus)
        if assetFetchStatus == Enum.AssetFetchStatus.Success then
            var3(uri)
        end
    end, { uri })

    return React.createElement(Image, {
        Image = uri,
        ScaleType = Enum.ScaleType.Crop,
        ZIndex = tbl1.zIndex,
        cornerRadius = if tbl1.cornerRadius == nil then nil else UDim.new(0, tbl1.cornerRadius),
        tag = "size-full",
        backgroundStyle = {
            Color3 = var1.Color.Surface.Surface_100.Color3,
            Transparency = if bool1 then 0 else 1
        },
        onLoaded = onLoaded
    })
end

return SceneOutfitPoster
