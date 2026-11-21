-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryHeroUnit = script:FindFirstAncestor("DiscoveryHeroUnit")

local DiscoveryHeroUnitParent = DiscoveryHeroUnit.Parent
local React = require(DiscoveryHeroUnitParent.React)
local _Foundation = require(DiscoveryHeroUnitParent.Foundation)
local ArgCheck = require(DiscoveryHeroUnitParent.ArgCheck)

local FFlagLuaAppHomePageFirstImageLoadObserver = require(DiscoveryHeroUnitParent.SharedFlags).FFlagLuaAppHomePageFirstImageLoadObserver

local ParallaxUtils = require(DiscoveryHeroUnit.ParallaxUtils)
local useNormalizedVerticalProgress = ParallaxUtils.useNormalizedVerticalProgress
local getYPositionOffsetForMotion = ParallaxUtils.getYPositionOffsetForMotion
local getNormalizedTopPosition = ParallaxUtils.getNormalizedTopPosition
local _HeroUnitTypes = require(DiscoveryHeroUnit.HeroUnitTypes)

local function calculateModifiedNormalizedPosition(normalizedPosition: number, current: number?, num1: number?): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if normalizedPosition < 0 and num1 and num1 > 0 then
        return math.clamp(normalizedPosition / num1, -1, 0)
    end

    if current == nil or current <= 0 or current >= 1 then
        return normalizedPosition
    end

    return math.clamp(normalizedPosition / current, 0, 1)
end

local function computeNormalizedHeroUnitHeight(current, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if current == nil then
        return nil
    end
    local absoluteWindowSizeY = current.AbsoluteWindowSize.Y
    return if absoluteWindowSizeY <= 0 then nil else num1 / absoluteWindowSizeY
end

return React.memo(function(tbl1) -- name: HeroImages
    ArgCheck.assert(tbl1.foregroundAspectRatio > 0, "HeroImages: foregroundAspectRatio must be > 0")

    local ref = React.useRef(nil)

    local var2 = React.useRef(nil)
    local frameSize, var4 = React.useBinding(Vector2.new(0, 0))

    React.useEffect(function()
        if ref and ref.current then
            var4(ref.current.AbsoluteSize)
        end
    end, {})

    local var5 = React.useCallback(function(arg1)
        if arg1 then
            var2.current = getNormalizedTopPosition(tbl1.verticalScrollingFrameRef.current, arg1)
            var4(arg1.AbsoluteSize)
        end
    end, { tbl1.verticalScrollingFrameRef })

    local normalizedPosition = useNormalizedVerticalProgress(tbl1.verticalScrollingFrameRef, ref)

    local imageSize, var8 = React.useBinding(Vector2.new(0, 0))
    local var9 = React.useCallback(function(num1: number, num2: number, num3: number, num4: number, num5: number): Vector2
        ArgCheck.assert(num4 > 0)
        ArgCheck.assert(num5 > 0)

        local y = num1 - num2 + num3 * 2
        local x = num4 / num5 * y
        return Vector2.new(x, y)
    end, {})

    local var10 = if tbl1.foregroundAspectRatio == 1 then tbl1.foregroundOverflow + tbl1.tokens.Padding.Small else tbl1.foregroundOverflow - tbl1.tokens.Padding.Small
    local var11 = tbl1.backgroundOverflow * 2
    local backgroundOverflow = tbl1.backgroundOverflow

    local yOffset = -tbl1.foregroundOverflow * (if tbl1.gradientHeightPercent then if tbl1.gradientHeightPercent > 0 then tbl1.gradientHeightPercent else 1 else 1) + (if tbl1.gradientHeightPercent >= 0.9 then 1 else 0)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        [React.Change.AbsoluteSize] = var5,
        ref = ref,
        BackgroundTransparency = 1,
        Size = tbl1.Size,
        ZIndex = tbl1.ZIndex,
        Position = tbl1.Position,
        AnchorPoint = tbl1.AnchorPoint,
        LayoutOrder = tbl1.LayoutOrder,
        ClipsDescendants = true
    }
    local tbl3 = { BackgroundImage = 0, ForegroundImage = 0, HeroGradientFrame = 0 }
    local createElement2 = React.createElement
    local str2 = "ImageLabel"

    local tbl4 = {
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.new(1, 0, 1, -tbl1.foregroundOverflow),
        Position = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 0,
        BackgroundColor3 = tbl1.tokens.Color.Surface.Surface_100.Color3,
        ZIndex = 0,
        Image = tbl1.backgroundImage,
        ScaleType = Enum.ScaleType.Crop,
        [React.Tag] = if FFlagLuaAppHomePageFirstImageLoadObserver then "observed-image data-testid=--hero-unit-background-image" else "data-testid=--hero-unit-background-image",
        ImageRectOffset = if tbl1.enableBackgroundAnimation then React.joinBindings({ normalizedPosition = normalizedPosition, imageSize = imageSize, frameSize = frameSize }):map(
            function(tbl4): Vector2
                if var2.current == nil then
                    var2.current = getNormalizedTopPosition(tbl1.verticalScrollingFrameRef.current, ref.current)
                end

                local var12 = computeNormalizedHeroUnitHeight(tbl1.verticalScrollingFrameRef.current, tbl4.frameSize.Y)

                local modifiedNormalizedPosition = calculateModifiedNormalizedPosition(tbl4.normalizedPosition, var2.current, var12)

                local yPositionOffsetForMotion = getYPositionOffsetForMotion(modifiedNormalizedPosition, 0, var11, backgroundOverflow)
                local imageSize = tbl4.imageSize
                if not (imageSize.X > 0 and imageSize.Y > 0 and ref and ref.current) then
                    return Vector2.new(0, 0)
                end

                local frameSize = tbl4.frameSize
                local var13 = var9(frameSize.Y, tbl1.foregroundOverflow, tbl1.backgroundOverflow, imageSize.X, imageSize.Y)

                return Vector2.new((1 - frameSize.X / var13.X) * imageSize.X * 0.5, yPositionOffsetForMotion * (imageSize.Y / var13.Y))
            end
        ) else nil,
        ImageRectSize = if tbl1.enableBackgroundAnimation then React.joinBindings({ imageSize = imageSize, frameSize = frameSize }):map(function(tbl4): Vector2
            local imageSize = tbl4.imageSize
            if not (imageSize.X > 0 and imageSize.Y > 0 and ref and ref.current) then
                return Vector2.new(0, 0)
            end

            local frameSize = tbl4.frameSize
            local var12 = var9(frameSize.Y, tbl1.foregroundOverflow, tbl1.backgroundOverflow, imageSize.X, imageSize.Y)

            local x = frameSize.X / var12.X * imageSize.X
            local y = imageSize.Y - tbl1.backgroundOverflow * 2 / var12.Y * imageSize.Y
            return Vector2.new(x, y)
        end) else nil
    }

    tbl4[React.Change.ContentImageSize] = function(arg1)
        if arg1 then
            var8(arg1.ContentImageSize)
        end
    end

    tbl3.BackgroundImage = createElement2(
        str2,
        tbl4,
        {
            CornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) })
        }
    )

    tbl3.ForegroundImage = React.createElement("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.new(
            1,
            -tbl1.foregroundOverflow,
            1 / tbl1.foregroundAspectRatio,
            -tbl1.foregroundOverflow / tbl1.foregroundAspectRatio
        ),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Position = if tbl1.enableForegroundAnimation then React.joinBindings({ normalizedPosition = normalizedPosition, frameSize = frameSize }):map(function(tbl5): UDim2
            if var2.current == nil then
                var2.current = getNormalizedTopPosition(tbl1.verticalScrollingFrameRef.current, ref.current)
            end

            local var12 = computeNormalizedHeroUnitHeight(tbl1.verticalScrollingFrameRef.current, tbl5.frameSize.Y)

            local modifiedNormalizedPosition = calculateModifiedNormalizedPosition(tbl5.normalizedPosition, var2.current, var12)

            local frameSizeY = tbl5.frameSize.Y
            local var13 = -((frameSizeY - tbl1.foregroundOverflow) / tbl1.foregroundAspectRatio - frameSizeY)

            if tbl1.foregroundAspectRatio == 1 then
                var13 -= tbl1.tokens.Size.Size_1500
            end

            local yPositionOffsetForMotion = getYPositionOffsetForMotion(modifiedNormalizedPosition, var13, var10, 0)

            return UDim2.new(0.5, 0, 0, yPositionOffsetForMotion)
        end) else UDim2.new(0.5, 0, 0, 0),
        Image = tbl1.foregroundImage,
        ZIndex = 1,
        BackgroundTransparency = 1,
        [React.Tag] = if FFlagLuaAppHomePageFirstImageLoadObserver then "observed-image data-testid=--hero-unit-foreground-image" else "data-testid=--hero-unit-foreground-image"
    })

    local element

    if tbl1.gradient then
        element = React.createElement("Frame", {
            ZIndex = 2,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, 1),
            Size = UDim2.new(tbl1.gradientWidthPercent, 0, tbl1.gradientHeightPercent, yOffset),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0,
            BorderSizePixel = 0
        }, {
            HeroGradient = React.createElement("UIGradient", {
                Rotation = tbl1.gradient.degree,
                Transparency = NumberSequence.new(
                    { NumberSequenceKeypoint.new(0, tbl1.gradient.startOpacity), NumberSequenceKeypoint.new(1, tbl1.gradient.endOpacity) }
                ),
                Color = ColorSequence.new(
                    { ColorSequenceKeypoint.new(0, tbl1.gradient.startColor), ColorSequenceKeypoint.new(1, tbl1.gradient.endColor) }
                )
            }),
            CornerRadius = React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) })
        })
            or nil
    else
        element = nil
    end

    tbl3.HeroGradientFrame = element
    return createElement(str1, tbl2, tbl3)
end)
