-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TiltLoadingScreen = script:FindFirstAncestor("TiltLoadingScreen")
local TiltLoadingScreenParentParent = TiltLoadingScreen.Parent.Parent

local React = require(TiltLoadingScreenParentParent.React)
local Foundation = require(TiltLoadingScreenParentParent.Foundation)
local View = Foundation.View
local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local useTokens = Foundation.Hooks.useTokens

local Constants = require(TiltLoadingScreen.Constants)
local FFlagLoadingScreenMilestones = require(TiltLoadingScreenParentParent.SharedFlags).FFlagLoadingScreenMilestones
local TILT_DEGREES = Constants.KEYART.TILT_DEGREES

local _Types = require(TiltLoadingScreen.Types)

local tbl1 = {
    rotation = React.createBinding(TILT_DEGREES),
    sizeScale = React.createBinding(1),
    coverTransparency = React.createBinding(1)
}
local tbl2 = {
    rotation = React.createBinding(-TILT_DEGREES),
    sizeScale = React.createBinding(1),
    groupTransparency = React.createBinding(0)
}

return React.memo(function(arg1) -- name: TiltKeyart
    local var1 = useTokens()
    local var2, var3 = React.useState(false)
    local var4 = arg1.keyart or tbl1
    local var5 = arg1.frame or tbl2

    local var6 = var1.Size.Size_2400 * 2
    local var7 = var6 / (math.cos(math.rad(TILT_DEGREES)) + math.sin(math.rad(TILT_DEGREES)))

    local onLoaded = React.useCallback(function(assetFetchStatus)
        if assetFetchStatus == Enum.AssetFetchStatus.Success then
            var3(true)
        end
    end, {})

    if FFlagLoadingScreenMilestones then
        React.useEffect(function()
            local onThumbnailLoaded = arg1.onThumbnailLoaded
            if not onThumbnailLoaded then
                return
            end

            if var2 and arg1.thumbnailUrl ~= "" then
                onThumbnailLoaded(arg1.thumbnailUrl)
            end
            return function()
                onThumbnailLoaded(nil)
            end
        end, { var2, arg1.thumbnailUrl, arg1.onThumbnailLoaded })
    end

    local createElement = React.createElement
    local var9 = View
    local tbl3 = {
        Size = UDim2.fromOffset(var6, var6),
        testId = "tilt-keyart"
    }
    local tbl4 = {
        Square = React.createElement(View, {
            tag = "position-center-center anchor-center-center stroke-standard stroke-system-neutral",
            testId = "tilt-keyart-frame",
            Size = var5.sizeScale:map(function(arg2): UDim2
                return UDim2.fromOffset(var7 * arg2, var7 * arg2)
            end),
            Rotation = var5.rotation,
            GroupTransparency = var5.groupTransparency,
            Visible = var5.groupTransparency:map(function(arg2): boolean
                return arg2 < 1
            end),
            ZIndex = 1
        }),
        Keyart = React.createElement(View, {
            tag = "position-center-center anchor-center-center",
            testId = "tilt-keyart-card",
            Size = var4.sizeScale:map(function(arg2): UDim2
                return UDim2.fromOffset(var7 * arg2, var7 * arg2)
            end),
            Rotation = var4.rotation,
            ZIndex = 2
        }, {
            ThumbnailSkeleton = if var2 then nil else React.createElement(Skeleton, { tag = "size-full", ZIndex = 1, testId = "tilt-keyart-skeleton" }),
            Thumbnail = if arg1.thumbnailUrl == "" then nil else React.createElement(Image, {
                tag = "size-full radius-small",
                Image = arg1.thumbnailUrl,
                ScaleType = Enum.ScaleType.Crop,
                ImageTransparency = if var2 then 0 else 1,
                onLoaded = onLoaded,
                ZIndex = 2,
                testId = "tilt-keyart-thumbnail"
            }),
            RevealCover = React.createElement(View, {
                tag = "size-full",
                backgroundStyle = var4.coverTransparency:map(function(transparency)
                    return {
                        Color3 = var1.Color.Extended.Black.Black_100.Color3,
                        Transparency = transparency
                    }
                end),
                ZIndex = 3
            })
        })
    }

    return createElement(var9, tbl3, tbl4)
end)
