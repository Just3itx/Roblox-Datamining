-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")

local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local ReactOtter = require(MomentsParent.ReactOtter)
local Foundation = require(MomentsParent.Foundation)

local FFlagMomentsImageWithSkeletonRetry = require(Moments.Flags.FFlagMomentsImageWithSkeletonRetry)

local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local View = Foundation.View

local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local tbl1 = { frequency = 3, dampingRatio = 1 }

local function getCornerRadius(circle, arg1): UDim -- Luacid: Inlined by compiler; 1 call site recovered
    if circle == Radius.Circle then
        return UDim.new(1, 0)
    end
    return UDim.new(0, arg1.Radius[circle])
end

return React.memo(function(tbl2) -- name: ImageWithSkeleton
    local var1 = useTokens()
    local radius = tbl2.radius or Radius.Medium
    local image = tbl2.Image
    local bool1 = not (image == nil) and image ~= ""
    local var3, var4 = React.useState(bool1)

    local var5, var6 = ReactOtter.useAnimatedBinding(0, function()
        if image ~= nil and ContentProvider:GetAssetFetchStatus(image) == Enum.AssetFetchStatus.Success then
            var4(false)
        end
    end)

    React.useEffect(function()
        var4(bool1)

        if not bool1 or image == nil or image == "" then
            var6((ReactOtter.instant(0)))
            return
        end

        local isCurrent = true
        local function fadeInImage() -- Luacid: Inlined by compiler; 3 call sites recovered
            if isCurrent then
                var6((ReactOtter.spring(1, tbl1)))
            end
        end

        if ContentProvider:GetAssetFetchStatus(image) == Enum.AssetFetchStatus.Success then
            fadeInImage()

            return function()
                isCurrent = false
            end
        end

        var6((ReactOtter.instant(0)))

        if FFlagMomentsImageWithSkeletonRetry then
            local preloadImageWithRetry = require(script.Parent.preloadImageWithRetry)
            task.spawn(preloadImageWithRetry, image, {
                isCurrent = function()
                    return isCurrent
                end,
                onSuccess = fadeInImage,
                onGiveUp = function()
                    var4(false)
                end
            })
            return function()
                isCurrent = false
            end
        end

        task.spawn(function()
            pcall(function()
                ContentProvider:PreloadAsync({ image }, function(arg1, assetFetchStatus)
                    if arg1 == image and assetFetchStatus == Enum.AssetFetchStatus.Success then
                        fadeInImage()
                    end
                end)
            end)

            if ContentProvider:GetAssetFetchStatus(image) == Enum.AssetFetchStatus.Success then
                fadeInImage()
            end
        end)

        return function()
            isCurrent = false
        end
    end, { image, bool1 })

    local imageStyle = tbl2.imageStyle

    local var2 = if bool1 and imageStyle ~= nil then React.joinBindings({ imageStyle, var5 }):map(function(tbl3)
        local var7 = tbl3[1]
        local var8 = tbl3[2]
        return {
            Color3 = var7.Color3,
            Transparency = 1 - (1 - var7.Transparency) * var8
        }
    end) elseif bool1 then var5:map(function(num1: number)
        return {
            Color3 = Color3.new(1, 1, 1),
            Transparency = 1 - num1
        }
    end) else imageStyle

    if imageStyle ~= nil then
        var5 = React.joinBindings({ var5, imageStyle }):map(function(tbl3)
            local var8 = tbl3[1]
            local var9 = tbl3[2]
            return 1 - (1 - var8) * (1 - (var9.Transparency or 0))
        end)
    end

    local createElement = React.createElement
    local var8 = View
    local tbl3 = {
        LayoutOrder = tbl2.LayoutOrder,
        Size = tbl2.Size
    }
    local createElement2 = React.createElement
    local var9 = Image
    local tbl4 = {
        tag = "size-full",
        Image = image,
        backgroundStyle = tbl2.backgroundStyle,
        imageStyle = var2,
        cornerRadius = 0,
        ScaleType = 0
    }
    local uDim = getCornerRadius(radius, var1)
    local tbl5 = { Image = 0, SkeletonOverlay = 0 }
    tbl4.cornerRadius = uDim
    tbl4.ScaleType = tbl2.ScaleType or Enum.ScaleType.Crop
    tbl5.Image = createElement2(var9, tbl4)

    tbl5.SkeletonOverlay = if bool1 and var3 then React.createElement(
        View,
        { tag = "size-full", ZIndex = 2, GroupTransparency = var5 },
        {
            Shimmer = React.createElement(Skeleton, { radius = radius, Size = UDim2.fromScale(1, 1) })
        }
    ) else nil
    return createElement(var8, tbl3, tbl5)
end)
