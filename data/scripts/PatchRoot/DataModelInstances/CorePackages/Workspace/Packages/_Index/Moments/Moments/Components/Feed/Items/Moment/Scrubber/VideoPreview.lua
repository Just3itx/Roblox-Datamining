-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)

local getColorStyleWithTransparency = require(Moments.Utils.getColorStyleWithTransparency)
local _useVideoScrubPreview = require(script.Parent.useVideoScrubPreview)

local Skeleton = Foundation.Skeleton
local View = Foundation.View
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: VideoPreview
    local var1 = useTokens()
    local preview = tbl1.preview

    local groupTransparency = tbl1.animationRatio:map(function(num1: number): number
        return 1 - num1
    end)

    local var3 = groupTransparency:map(function(num1: number)
        return getColorStyleWithTransparency(var1.Color.Shift.Shift_400, num1).Transparency or 0
    end)

    local var4, var5 = React.useState(preview.isLoading)
    local var2, var7 = ReactOtter.useAnimatedBinding(0, function()
        var5(false)
    end)

    React.useEffect(function()
        if not preview.isLoading then
            var7(ReactOtter.ease(1, { duration = 0.1, easingStyle = Enum.EasingStyle.Quad }))
        end
    end, { preview.isLoading })

    local imageTransparency = var2:map(function(num1: number): number
        return 1 - num1
    end)

    return React.createElement(View, {
        tag = "size-2800 radius-medium bg-shift-200",
        aspectRatio = {
            AspectRatio = 0.5625,
            AspectType = Enum.AspectType.FitWithinMaxSize,
            DominantAxis = Enum.DominantAxis.Width
        },
        stroke = {
            Color = var1.Color.Shift.Shift_400.Color3,
            Transparency = var3,
            Thickness = var1.Stroke.Thick
        },
        GroupTransparency = groupTransparency,
        LayoutOrder = tbl1.LayoutOrder
    }, {
        FrameA = React.createElement("ImageLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ImageTransparency = imageTransparency,
            ScaleType = Enum.ScaleType.Crop,
            ImageContent = preview.contentA,
            ZIndex = preview.frontIsA:map(function(bool1: boolean): number
                return if bool1 then 2 else 1
            end),
            ref = preview.imageARef
        }),
        FrameB = React.createElement("ImageLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ImageTransparency = imageTransparency,
            ScaleType = Enum.ScaleType.Crop,
            ImageContent = preview.contentB,
            ZIndex = preview.frontIsA:map(function(bool1: boolean): number
                return if bool1 then 1 else 2
            end),
            ref = preview.imageBRef
        }),
        SkeletonOverlay = if var4 then React.createElement(
            View,
            { tag = "size-full", ZIndex = 3, GroupTransparency = var2 },
            {
                Shimmer = React.createElement(Skeleton, { radius = Radius.Medium, Size = UDim2.fromScale(1, 1) })
            }
        ) else nil
    })
end)
