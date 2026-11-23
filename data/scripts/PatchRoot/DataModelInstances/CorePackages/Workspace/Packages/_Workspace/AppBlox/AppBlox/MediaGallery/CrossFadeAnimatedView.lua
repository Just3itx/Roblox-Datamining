-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Cryo = require(AppBloxParent.Cryo)
local React = require(AppBloxParent.React)
local ReactOtter = require(AppBloxParent.ReactOtter)

local useStyle = require(AppBloxParent.UIBlox).Core.Style.useStyle

local _MediaGalleryTypes = require(script.Parent.MediaGalleryTypes)

local tbl1 = {
    zIndex = 1,
    overlayTransparency = 0.5,
    animationConfig = {
        dampingRatio = 1,
        frequency = 20 / 3
    }
}

local function CrossFadeAnimatedView(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local itemsLen = #var1.items
    local var2 = useStyle()

    local var3 = React.useCallback(function()
        if var1.crossAnim.isCrossFade then
            var1.crossAnim.setCrossFade(false)
            var1.crossAnim.setCurrentIndex(var1.crossAnim.nextIndex)
        end
    end, {
        var1.crossAnim.isCrossFade,
        var1.crossAnim.nextIndex,
        var1.crossAnim.setCrossFade,
        var1.crossAnim.setCurrentIndex
    })

    local imageTransparency, var5 = ReactOtter.useAnimatedBinding(0, var3)
    React.useEffect(function()
        if itemsLen < 2 then
            return
        end

        if var1.crossAnim.isCrossFade then
            var5(ReactOtter.spring(1, var1.animationConfig))
        else
            var5((ReactOtter.instant(0)))
        end
    end, { var1.crossAnim.isCrossFade, var1.crossAnim.nextIndex, var1.animationConfig })

    local createElement = React.createElement
    local str1 = "ImageLabel"
    local tbl3 = {
        Size = UDim2.fromScale(1, 1),
        ZIndex = var1.zIndex,
        Image = var1.items[var1.crossAnim.currentIndex].imageId,
        ScaleType = Enum.ScaleType.Crop,
        BackgroundTransparency = 1,
        ImageTransparency = imageTransparency
    }
    local tbl4 = { NextImage = 0, Overlay = 0 }
    local element

    if itemsLen >= 2 then
        element = React.createElement("ImageLabel", {
            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(1, 1),
            Image = var1.items[var1.crossAnim.nextIndex].imageId,
            ScaleType = Enum.ScaleType.Crop,
            BackgroundTransparency = 1,
            ImageTransparency = imageTransparency:map(function(arg1): number
                return 1 - arg1
            end)
        })
    else
        element = nil
    end

    tbl4.NextImage = element

    tbl4.Overlay = React.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = var1.overlayTransparency,
        BackgroundColor3 = var2.Theme.Overlay.Color
    })
    return createElement(str1, tbl3, tbl4)
end

return CrossFadeAnimatedView
