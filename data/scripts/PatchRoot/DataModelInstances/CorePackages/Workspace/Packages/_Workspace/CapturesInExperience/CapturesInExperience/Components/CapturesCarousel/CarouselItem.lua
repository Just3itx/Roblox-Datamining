-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local AppCommonLib = require(scriptParentParentParentParent.AppCommonLib)
local CapturesCommon = require(scriptParentParentParentParent.CapturesCommon)
local React = require(scriptParentParentParentParent.React)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local memoize = AppCommonLib.memoize

local useScreenSize = RobloxAppHooks.useScreenSize
local useStyle = UIBlox.Core.Style.useStyle

local CaptureType = require(scriptParentParentParent.Enums.CaptureType)
local getContentFromObject = CapturesCommon.Utils.getContentFromObject
local getCaptureSize = require(scriptParentParentParent.Utils.getCaptureSize)
local MediaPlayer = CapturesCommon.Components.MediaPlayer
local _Types = require(scriptParentParentParent.Types)

local FFlagUseMediaPlayerInCarousel = require(scriptParentParentParentParent.SharedFlags).FFlagUseMediaPlayerInCarousel
local FFlagUseRbxstorageInGallery = require(scriptParentParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

local var1 = memoize(function(vector2: Vector2, vector2_2: Vector2): Vector2
    local var1 = vector2.X / vector2.Y

    local vector22X = vector2_2.X
    local y = math.floor(vector22X / var1)

    if vector2_2.Y < y then
        y = vector2_2.Y
        vector22X = math.floor(y * var1)
    end

    return Vector2.new(vector22X, y)
end)

local function getDeleteTransitionSize(num1: number): UDim2 -- Luacid: Inlined by compiler; 1 call site recovered
    return UDim2.fromScale(num1, num1)
end

local function getDeleteTransitionTransparency(arg1)
    return if UserGameSettings.ReducedMotion then arg1 else 1
end

local function getCapturesItemSize(arg1)
    if UserGameSettings.ReducedMotion then
        return UDim2.fromScale(1, 1)
    end

    return (getDeleteTransitionSize(arg1))
end

local function getFullScreenSize(arg1, arg2): UDim2 -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = arg1.X / arg1.Y

    local yOffset = arg2.X / var2
    if yOffset <= arg2.Y then
        return UDim2.fromOffset(arg2.X, yOffset)
    end
    local xOffset = arg2.Y * var2
    return UDim2.fromOffset(xOffset, arg2.Y)
end

return function(tbl1)
    local var2 = useStyle()

    local itemSize = tbl1.itemSize
    local absoluteXPosition, var4 = React.useBinding(0)
    local var5, var6 = React.useState(Vector2.new(0, 0))
    local var7 = useScreenSize()
    local videoRef = React.useRef(nil)
    local var9 = React.useRef(nil)
    local var10, var11 = React.useState(false)

    local imagePadding = tbl1.imagePadding
    local itemIndex = tbl1.itemIndex

    local var12 = React.useCallback(function(arg1)
        var4(arg1.AbsolutePosition.X)
    end, { var4 })

    React.useEffect(function()
        return function()
            if var9.current then
                var9.current.Video = ""
            end
        end
    end, {})

    React.useEffect(function()
        if FFlagEnableCapturesGalleryRetrievalCoreScript then
            if tbl1.capture.CaptureType == Enum.CaptureType.Screenshot then
                var6(itemSize)
            end

            return
        end

        if tbl1.capture.type == CaptureType.Video then
            return
        end

        task.spawn(function()
            local captureSize = getCaptureSize(tbl1.capture.contentId)
            if captureSize then
                var6(captureSize)
                return
            end

            var6(itemSize)
        end)
    end, { itemSize, tbl1.capture })

    local onLoaded = React.useCallback(function(current)
        var9.current = current
        local resolution = current.Resolution
        var6(Vector2.new(resolution.X, resolution.Y))
    end, {})

    local var14 = React.useCallback(function(num1: number): (number, number)
        local var14 = itemSize.X / 2
        local var15 = var7.X / 2
        local var16 = num1 + var14

        local num2 = math.abs(var15 - var16)
        local num3 = if num2 < 25 then 0 else num2 - 25

        return math.sign(var15 - var16), math.min(1, num3 / (itemSize.X - 25))
    end, { itemSize, itemIndex, var7 })

    local var15 = React.useCallback(function(num1: number): UDim2
        local _, var15 = var14(num1)
        local var16 = var1(var5, itemSize)
        if var15 == 0 then
            return UDim2.fromOffset(var16.X, var16.Y)
        end

        local var17 = 1 - var15 * (1 - tbl1.unfocusedSizeMultiplier)

        local var18 = var16.Y * var17
        local var19 = var16.X * var17

        local yOffset = math.floor(var18)
        local xOffset = math.floor(var19)

        return UDim2.fromOffset(xOffset, yOffset)
    end, {
        var5,
        itemSize,
        tbl1.unfocusedSizeMultiplier,
        var14
    })
    local var16 = React.useCallback(function(num1: number): UDim2
        local var16, var17 = var14(num1)
        if var17 == 0 then
            return UDim2.fromScale(0.5, 0.5)
        end

        local offset = var15(num1).X.Offset
        local var18 = (itemSize.X / 2 - imagePadding - offset / 2) * var17

        return UDim2.new(0.5, var18 * var16, 0.5, 0)
    end, {
        var5,
        imagePadding,
        itemSize,
        var7,
        var14,
        var15
    })
    local overlayTransparency = var2.Theme.Overlay.Transparency

    local var17 = React.useCallback(function(num1: number)
        local _, var17 = var14(num1)
        return 1 - (1 - overlayTransparency) * var17
    end, { overlayTransparency, var14 })

    local var18 = React.useCallback(function(arg1)
        local absoluteXPosition = arg1.absoluteXPosition
        local fadeOutBinding = arg1.fadeOutBinding

        if UserGameSettings.ReducedMotion and fadeOutBinding then
            return 1
        end

        if not fadeOutBinding then
            return var17(absoluteXPosition)
        end

        return math.min(var17(absoluteXPosition), fadeOutBinding)
    end, { var17 })

    local onExpandCallback = React.useCallback(function()
        if tbl1.onExpandCallback then
            tbl1.onExpandCallback(tbl1.itemIndex)
        end
        var11(not var10)
    end, { var10, tbl1.onExpandCallback, tbl1.itemIndex })

    local onMuteCallback = React.useCallback(function()
        if tbl1.onMuteCallback then
            tbl1.onMuteCallback()
        end
    end, { tbl1.onMuteCallback })

    local renderOnFailed = React.useCallback(function()
        return (React.createElement("Frame", { Size = UDim2.fromScale(1, 1) }))
    end, {})

    local bool1 = if FFlagEnableCapturesGalleryRetrievalCoreScript then tbl1.capture.CaptureType == Enum.CaptureType.Screenshot else tbl1.capture.type == CaptureType.Screenshot
    local bool2 = if FFlagEnableCapturesGalleryRetrievalCoreScript then tbl1.capture.CaptureType == Enum.CaptureType.Video else tbl1.capture.type == CaptureType.Video
    local var22 = if FFlagEnableCapturesGalleryRetrievalCoreScript then getContentFromObject(tbl1.capture) else tbl1.capture.contentId
    local var23 = if FFlagEnableCapturesGalleryRetrievalCoreScript then tbl1.capture else tbl1.capture.videoCapture
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        [React.Change.AbsolutePosition] = var12
    }
    local tbl3 = {
        FullScreenOffset = React.createElement("UIPadding", { PaddingTop = UDim.new(0, if var10 then 16 else 0) }),
        CaptureContainer = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = if var10 then UDim2.fromScale(0.5, 0.5) else absoluteXPosition:map(var16),
        Size = if var10 then getFullScreenSize(var5, var7) else absoluteXPosition:map(var15)
    }

    local tbl5 = {
        CaptureImage = 0,
        CaptureVideo = 0,
        Overlay = 0,
        TransitionOverlay = 0,
        FullScreenBackground = 0
    }
    local var24

    if bool1 then
        local createElement3 = React.createElement
        local str3 = "ImageLabel"
        local tbl6 = {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = var2.Theme.BackgroundContrast.Color,
            BackgroundTransparency = if FFlagEnableCapturesGalleryRetrievalCoreScript then 0 else 1,
            BorderSizePixel = 0,
            Image = if FFlagEnableCapturesGalleryRetrievalCoreScript then nil else var22,
            ImageContent = 0,
            Position = 0,
            ScaleType = 0,
            Size = 0,
            Visible = 0,
            ZIndex = 1
        }

        if not FFlagEnableCapturesGalleryRetrievalCoreScript then
            var22 = nil
        end

        tbl6.ImageContent = var22
        tbl6.Position = UDim2.fromScale(0.5, 0.5)
        tbl6.ScaleType = if FFlagEnableCapturesGalleryRetrievalCoreScript then Enum.ScaleType.Fit else Enum.ScaleType.Crop

        tbl6.Size = if tbl1.fadeOutBinding then tbl1.fadeOutBinding:map(getCapturesItemSize) else UDim2.fromScale(1, 1)

        tbl6.Visible = var5 ~= Vector2.new(0, 0)
        var24 = createElement3(str3, tbl6)
    else
        var24 = nil
    end

    tbl5.CaptureImage = var24
    local var25

    if bool2 then
        if FFlagUseMediaPlayerInCarousel then
            local createElement3 = React.createElement
            local var26 = MediaPlayer

            local tbl6 = {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = var2.Theme.BackgroundContrast.Color,
                BackgroundTransparency = if FFlagEnableCapturesGalleryRetrievalCoreScript then 0 else 1,
                BorderSizePixel = 0,
                isOverlayDisabled = not tbl1.isSelected or tbl1.isDisabled,
                isTimeHidden = var7.X > var7.Y and var5.Y > var5.X and not var10,
                Looped = true,
                onExpandCallback = onExpandCallback,
                onMuteCallback = onMuteCallback,
                onLoaded = onLoaded,
                Playing = tbl1.isSelected and absoluteXPosition:map(function(arg1): boolean
                    local _, var27 = var14(arg1)
                    return var27 < 0.5
                end),
                Position = UDim2.fromScale(0.5, 0.5),
                renderOnFailed = renderOnFailed,
                Size = if tbl1.fadeOutBinding then tbl1.fadeOutBinding:map(getCapturesItemSize) else UDim2.fromScale(1, 1),
                VideoContent = getContentFromObject(var23),
                videoRef = videoRef,
                ZIndex = if var10 then 5 else 1
            }

            var25 = createElement3(var26, tbl6)
        else
            local createElement3 = React.createElement
            local str3 = "VideoFrame"

            local tbl6 = {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Playing = absoluteXPosition:map(function(arg1): boolean
                    local _, var26 = var14(arg1)
                    return var26 < 0.5
                end),
                Position = UDim2.fromScale(0.5, 0.5),
                Looped = true,
                Size = if tbl1.fadeOutBinding then tbl1.fadeOutBinding:map(getCapturesItemSize) else UDim2.fromScale(1, 1),
                Video = if FFlagUseRbxstorageInGallery then nil else tbl1.capture.contentId,
                VideoContent = if FFlagUseRbxstorageInGallery then getContentFromObject(tbl1.capture.videoCapture) else nil,
                Volume = 0,
                ZIndex = 1,
                [React.Event.Loaded] = onLoaded
            }

            var25 = createElement3(str3, tbl6)
        end
    else
        var25 = nil
    end

    tbl5.CaptureVideo = var25

    tbl5.Overlay = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = var2.Theme.Overlay.Color,
        BackgroundTransparency = React.joinBindings({ absoluteXPosition = absoluteXPosition, fadeOutBinding = tbl1.fadeOutBinding }):map(var18),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = if tbl1.fadeOutBinding then tbl1.fadeOutBinding:map(getCapturesItemSize) else UDim2.fromScale(1, 1),
        ZIndex = 2
    })

    tbl5.TransitionOverlay = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = var2.Theme.BackgroundContrast.Color,
        BackgroundTransparency = if tbl1.transitionBinding then tbl1.transitionBinding:map(getDeleteTransitionTransparency) else 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        ZIndex = 3
    })
    local element

    if FFlagUseMediaPlayerInCarousel and var10 then
        element = React.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = var2.Theme.BackgroundContrast.Color,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(var7.X, var7.Y),
            ZIndex = 4
        })
    else
        element = nil
    end

    tbl5.FullScreenBackground = element
    tbl3.CaptureContainer = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end
