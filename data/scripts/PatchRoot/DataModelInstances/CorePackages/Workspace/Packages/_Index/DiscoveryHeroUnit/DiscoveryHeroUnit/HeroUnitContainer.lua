-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryHeroUnit = script:FindFirstAncestor("DiscoveryHeroUnit")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local DiscoveryHeroUnitParent = DiscoveryHeroUnit.Parent
local ArgCheck = require(DiscoveryHeroUnitParent.ArgCheck)
local Cryo = require(DiscoveryHeroUnitParent.Cryo)
local Foundation = require(DiscoveryHeroUnitParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Image = Foundation.Image
local React = require(DiscoveryHeroUnitParent.React)
local Responsive = require(DiscoveryHeroUnitParent.Responsive)

local HeroImages = require(DiscoveryHeroUnit.HeroImages)
local HeroNarrowLayout = require(DiscoveryHeroUnit.HeroUnitTypes).HeroNarrowLayout

local CollectionViews = require(DiscoveryHeroUnitParent.CollectionViews)
local CollectionHeader = CollectionViews.CollectionHeader
local maybeForceDarkTheme = CollectionViews.maybeForceDarkTheme

local SharedFlags = require(DiscoveryHeroUnitParent.SharedFlags)
local FFlagLuaAppEnableHeroUnitV2 = SharedFlags.FFlagLuaAppEnableHeroUnitV2
local FFlagLuaAppHomePageFirstImageLoadObserver = SharedFlags.FFlagLuaAppHomePageFirstImageLoadObserver

local tbl1 = { Compact = 0.5625, Square = 1, Tall = 1.25 }

local tbl2 = {
    Color3 = Color3.new(1, 1, 1),
    Transparency = 0
}

local function scaleSizeForPlatform(num1: number, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return num1 * arg1.Stroke.Standard
end

local function useHeroConfiguration(tbl3, arg1)
    local var1 = Responsive.useResponsive({ { Key = "Small", maxWidth = 413 }, { Key = "Medium", maxWidth = 600 } })

    local var2 = nil
    local var3 = nil
    local var4, var5, bool1, var6, var7, num1

    if var1 == "Small" or var1 == "Medium" then
        local var8 = tbl3.narrowLayout or HeroNarrowLayout.Compact
        var2 = tbl1[var8] or tbl1[HeroNarrowLayout.Compact]

        if var1 == "Small" then
            var4 = arg1.Typography.HeadingMedium
        else
            var4 = arg1.Typography.HeadingLarge
        end

        var5 = arg1.Typography.BodyMedium
        bool1 = tbl3.titleImage == nil and var8 == HeroNarrowLayout.Compact or tbl3.subtitle == nil
        var6 = arg1.Padding.Large
        var7 = arg1.Gap.Large
        if FFlagLuaAppEnableHeroUnitV2 then
            if tbl3.titleImageAspectRatio == 1 then
                num1 = 0.26
            else
                num1 = 0.16
            end
        else
            num1 = 0.25
        end
    else
        var3 = scaleSizeForPlatform(336, arg1)
        var4 = arg1.Typography.DisplaySmall
        var5 = arg1.Typography.BodyLarge
        bool1 = tbl3.subtitle == nil
        var6 = arg1.Padding.XLarge
        var7 = arg1.Gap.XXLarge
        if not FFlagLuaAppEnableHeroUnitV2 or tbl3.titleImageAspectRatio == 1 then
            num1 = 0.3
        else
            num1 = 0.2
        end
    end

    local num2, num3

    if tbl3.gradient == nil or tbl3.gradient.degree == 270 then
        num2 = 1
        num3 = 0.5
    elseif tbl3.gradient.degree == 0 then
        num2 = 0.5
        num3 = 1
    else
        num2 = 1
        num3 = 0.5
    end

    return Cryo.Dictionary.join({
        cornerRadius = arg1.Radius.Medium,
        titleTypography = var4,
        subtitleTypography = var5,
        aspectRatio = var2,
        backgroundImageFrameHeight = var3,
        hideSubtitle = bool1,
        foregroundOverflow = var7,
        backgroundOverflow = scaleSizeForPlatform(50, arg1),
        foregroundAspectRatio = 1,
        gradientWidthPercent = num2,
        gradientHeightPercent = num3,
        contentPadding = var6,
        enableBackgroundAnimation = not UserGameSettings.ReducedMotion,
        enableForegroundAnimation = not UserGameSettings.ReducedMotion,
        sideMargin = 0,
        titleImageAspectRatio = 3,
        titleImageHeightPercentage = num1,
        minCardHeight = scaleSizeForPlatform(262, arg1)
    }, tbl3)
end

return React.memo(function(tbl3) -- name: HeroUnitContainer
    local var1, var2 = React.useBinding(0)
    local ref = React.useCallback(function(arg1)
        if arg1 then
            var2(arg1.AbsoluteSize.X)
        end
    end, {})

    local tokens = useTokens()

    local var5 = useHeroConfiguration(tbl3, tokens)
    local yOffset = if var5.backgroundImageFrameHeight and var5.foregroundOverflow then var5.backgroundImageFrameHeight + var5.foregroundOverflow else var5.backgroundImageFrameHeight

    if FFlagLuaAppEnableHeroUnitV2 then
        assert(var5.minCardHeight ~= nil, "minCardHeight is required")
        assert(var5.titleImageAspectRatio ~= nil, "titleImageAspectRatio is required")
    end

    local var6 = React.useCallback(function()
        if not tbl3.titleImage then
            ArgCheck.assert(false, "The path should never be called")
            return React.createElement(React.Fragment)
        end

        return React.createElement(Image, {
            Image = tbl3.titleImage,
            Size = var1:map(function(xOffset: number): UDim2
                local var6 = yOffset
                if var5.aspectRatio then
                    var6 = math.max(var5.minCardHeight, xOffset * var5.aspectRatio + var5.foregroundOverflow)
                end
                return UDim2.new(0, xOffset, 0, var6 * var5.titleImageHeightPercentage)
            end),
            aspectRatio = var5.titleImageAspectRatio,
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            ZIndex = 0,
            tag = if FFlagLuaAppHomePageFirstImageLoadObserver then "observed-image" else nil
        })
    end, {
        var1,
        yOffset,
        tbl3.titleImage,
        var5.titleImageAspectRatio,
        var5.minCardHeight,
        var5.aspectRatio,
        var5.foregroundOverflow,
        var5.titleImageHeightPercentage
    })

    local headerComponent = tbl3.headerComponent

    if not headerComponent then
        local createElement = React.createElement
        local var7 = CollectionHeader
        local tbl4 = {
            LayoutOrder = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            title = 0,
            AnchorPoint = 0,
            subtitle = 0,
            hideButton = true,
            titleColor = 0,
            subtitleColor = 0,
            titleTypography = 0,
            subtitleTypography = 0,
            forceUpdatedHeader = true,
            Position = 0
        }

        if FFlagLuaAppEnableHeroUnitV2 or not tbl3.titleImage then
            var6 = tbl3.title
        end

        tbl4.title = var6

        tbl4.AnchorPoint = Vector2.new(0, 0.5)
        tbl4.subtitle = if var5.hideSubtitle then nil else tbl3.subtitle

        tbl4.titleColor = tbl2
        tbl4.subtitleColor = tbl2
        tbl4.titleTypography = var5.titleTypography
        tbl4.subtitleTypography = var5.subtitleTypography

        tbl4.Position = UDim2.new(0, 0, 0.5, 0)
        headerComponent = createElement(var7, tbl4)
    end

    local createElement = React.createElement
    local str1 = "TextButton"

    local tbl4 = {
        ref = ref,
        [React.Change.AbsoluteSize] = ref,
        Position = UDim2.new(0, var5.sideMargin, 0, 0),
        Size = if var5.aspectRatio then var1:map(function(num1: number)
            return UDim2.new(1, -2 * var5.sideMargin, 0, math.max(var5.minCardHeight, num1 * var5.aspectRatio + var5.foregroundOverflow))
        end) else UDim2.new(1, -2 * var5.sideMargin, 0, yOffset),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        [React.Event.Activated] = tbl3.onActivated,
        SelectionOrder = tbl3.SelectionOrder,
        [React.Tag] = if tbl3.testId then `data-testid={tbl3.testId}` else nil
    }

    local tbl5 = {
        HeroBackground = tbl3.backgroundComponent
            or React.createElement(HeroImages, {
                ZIndex = 0,
                Size = UDim2.new(1, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(0, 0, 1, 0),
                verticalScrollingFrameRef = tbl3.verticalScrollingFrameRef,
                foregroundImage = tbl3.foregroundImage,
                backgroundImage = tbl3.backgroundImage,
                foregroundAspectRatio = var5.foregroundAspectRatio,
                foregroundOverflow = var5.foregroundOverflow,
                backgroundOverflow = var5.backgroundOverflow,
                cornerRadius = var5.cornerRadius,
                enableBackgroundAnimation = var5.enableBackgroundAnimation and not UserGameSettings.ReducedMotion,
                enableForegroundAnimation = var5.enableForegroundAnimation and not UserGameSettings.ReducedMotion,
                gradient = var5.gradient,
                gradientHeightPercent = var5.gradientHeightPercent,
                gradientWidthPercent = var5.gradientWidthPercent,
                tokens = tokens
            }),
        HeroForeground = maybeForceDarkTheme(
            React.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, -var5.foregroundOverflow),
                Position = UDim2.new(0, 0, 0, var5.foregroundOverflow),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = 2
            }, {
                UIPadding = React.createElement("UIPadding", {
                    PaddingLeft = UDim.new(0, var5.contentPadding),
                    PaddingRight = UDim.new(0, var5.contentPadding),
                    PaddingTop = UDim.new(0, var5.contentPadding),
                    PaddingBottom = UDim.new(0, var5.contentPadding)
                }),
                HeroLogo = if FFlagLuaAppEnableHeroUnitV2 and tbl3.titleImage then React.createElement(Image, {
                    Image = tbl3.titleImage,
                    Size = var1:map(function(xOffset: number): UDim2
                        local var7 = yOffset or 0
                        if var5.aspectRatio then
                            var7 = math.max(var5.minCardHeight, xOffset * var5.aspectRatio + var5.foregroundOverflow)
                        end

                        return UDim2.new(0, xOffset, 0, var7 * var5.titleImageHeightPercentage)
                    end),
                    aspectRatio = var5.titleImageAspectRatio,
                    Position = UDim2.new(1, 0, 0, 0),
                    AnchorPoint = Vector2.new(1, 0)
                }) else nil,
                HeroHeaderFrame = React.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Position = UDim2.new(0, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                }, { HeroHeader = headerComponent }),
                HeroBottomRowFrame = React.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Position = UDim2.new(0, 0, 1, 0),
                    AnchorPoint = Vector2.new(0, 1),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                }, {
                    HeroBottomRow = tbl3.bottomRowComponent
                }),
                HeroOverlay = tbl3.overlayComponent
            }),
            true
        )
    }

    return createElement(str1, tbl4, tbl5)
end)
