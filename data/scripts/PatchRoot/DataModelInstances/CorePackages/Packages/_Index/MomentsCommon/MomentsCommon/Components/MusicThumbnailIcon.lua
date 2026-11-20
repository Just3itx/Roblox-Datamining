-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local getRbxThumb = Foundation.Utility.getRbxThumb

local useImageLoadingState = require(MomentsCommon.Hooks.useImageLoadingState)

local MusicThumbnailIconSize = require(MomentsCommon.Enums.MusicThumbnailIconSize)

local tbl1 = {
    [MusicThumbnailIconSize.Small] = 24,
    [MusicThumbnailIconSize.Large] = 40
}

local tbl2 = {
    [MusicThumbnailIconSize.Small] = 2,
    [MusicThumbnailIconSize.Large] = 4
}

return function(tbl3)
    local image = getRbxThumb(Foundation.Enums.ThumbnailType.Asset, tbl3.assetId)
    local var1 = useImageLoadingState(image)
    local var2 = tbl1[tbl3.size]

    if not var1 then
        return React.createElement(Skeleton, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            LayoutOrder = 1,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(var2, var2)
        })
    end

    return React.createElement(Image, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        cornerRadius = UDim.new(0, tbl2[tbl3.size]),
        Image = image,
        LayoutOrder = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromOffset(var2, var2)
    })
end
