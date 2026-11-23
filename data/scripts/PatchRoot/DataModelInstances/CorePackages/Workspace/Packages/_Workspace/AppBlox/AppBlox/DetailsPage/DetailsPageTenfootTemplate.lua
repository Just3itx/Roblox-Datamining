-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBlox = script:FindFirstAncestor("AppBlox")
local AppBloxParent = AppBlox.Parent
local Cryo = require(AppBloxParent.Cryo)
local AnimatedFlatList = require(AppBloxParent.VirtualizedList).AnimatedFlatList

local DetailsPageHeader = require(script.Parent.DetailsPageHeader)
local getPlatformConfig = require(script.Parent.getPlatformConfig)
local useDetailsPageRenderItems = require(script.Parent.Hooks.useDetailsPageRenderItems)
local useAnimateFullscreen = require(script.Parent.Hooks.useAnimateFullscreen)
local DetailsPageRenderItem = require(script.Parent.DetailsPageRenderItem)
local Display = require(AppBloxParent.Display)
local useSignalState = require(AppBloxParent.SignalsReact).useSignalState
local FullscreenFrame = require(AppBlox.FullscreenFrame)
local Signal = require(AppBloxParent.AppCommonLib).Signal

local UIBlox = require(AppBloxParent.UIBlox)
local Overlay = UIBlox.App.Dialog.Overlay
local LoadableImage = UIBlox.App.Loading.LoadableImage

local _RobloxAppEnums = require(AppBloxParent.RobloxAppEnums)

local _ReactOtter = require(AppBloxParent.ReactOtter)

local _Types = require(script.Parent.Types)

local React = require(AppBloxParent.React)

local FFlagLuaAppEdpConsoleMediaGalleryVideo = require(AppBloxParent.SharedFlags).FFlagLuaAppEdpConsoleMediaGalleryVideo

local tbl1 = {
    animationConfig = { dampingRatio = 1, frequency = 3 },
    itemPadding = 36,
    safeAreaSize = Vector2.new(96, 144),
    trailingWhitespace = 3000
}

local function DetailsPageTenfootTemplate(tbl2)
    local tbl3 = tbl1
    if tbl2.tokens then
        tbl3 = Cryo.Dictionary.join(tbl3, tbl2.tokens)
    end

    local showGradient, var2 = React.useState(true)

    local var3 = React.useMemo(function()
        return getPlatformConfig(tbl2.deviceType)
    end, { tbl2.deviceType })

    local ref = React.useRef(nil)
    local var5, var6 = React.useState(Vector2.new(0, 0))
    local var7 = React.useCallback(function(arg1)
        var6(arg1.AbsoluteSize)
    end, {})
    React.useEffect(function()
        if ref.current then
            var6(ref.current.AbsoluteSize)
        end
    end, {})

    local thumbnailHeight = if tbl2.thumbnailHeight then tbl2.thumbnailHeight else var3.thumbnailHeight
    local headerBarBackgroundHeight = if tbl2.headerBarBackgroundHeight ~= nil then tbl2.headerBarBackgroundHeight else var3.headerBarBackgroundHeight
    local sideMargin = if tbl2.sideMargin then tbl2.sideMargin else var3.sideMargin

    local scrollViewPositionChangedSignal = React.useMemo(function()
        return Signal.new()
    end, {})

    local isFullscreen = not (tbl2.isFullscreen == nil) and tbl2.isFullscreen
    local renderFullscreenContent = tbl2.renderFullscreenContent

    local var9, groupTransparency = useAnimateFullscreen(isFullscreen, renderFullscreenContent, tbl3.animationConfig)

    local var11 = React.useMemo(function()
        return React.createElement(DetailsPageHeader, {
            thumbnailImageUrl = tbl2.thumbnailImageUrl,
            thumbnailAspectRatio = tbl2.thumbnailAspectRatio,
            thumbnailHeight = thumbnailHeight,
            titleText = tbl2.titleText,
            subTitleText = tbl2.subTitleText,
            actionBarLabelText = tbl2.actionBarLabelText,
            renderActionBarLabelImpressionsDetector = tbl2.renderActionBarLabelImpressionsDetector,
            scrollViewPositionChangedSignal = scrollViewPositionChangedSignal,
            renderInfoContent = tbl2.renderInfoContent,
            actionBarProps = tbl2.actionBarProps,
            sideMargin = sideMargin,
            headerBarBackgroundHeight = headerBarBackgroundHeight,
            deviceType = tbl2.deviceType,
            thumbnailShadowHeight = tbl3.thumbnailShadowHeight,
            gradientHeight = tbl3.headerGradientHeight,
            actionBarHeight = tbl3.actionBarHeight,
            actionBarWidth = tbl2.actionBarWidth or tbl3.actionBarWidth,
            itemPadding = tbl3.thumbnailMargin,
            bottomMargin = tbl3.headerBottomMargin
        })
    end, {
        tbl2.thumbnailImageUrl,
        tbl2.thumbnailAspectRatio,
        thumbnailHeight,
        tbl2.titleText,
        tbl2.subTitleText,
        tbl2.actionBarLabelText,
        tbl2.renderInfoContent,
        tbl2.actionBarProps,
        sideMargin,
        headerBarBackgroundHeight,
        tbl2.deviceType,
        tbl3.thumbnailShadowHeight,
        tbl3.headerGradientHeight,
        tbl3.thumbnailMargin,
        tbl3.headerBottomMargin,
        tbl3.actionBarHeight,
        tbl3.actionBarWidth,
        tbl2.actionBarWidth,
        tbl2.renderActionBarLabelImpressionsDetector,
        scrollViewPositionChangedSignal
    })

    local var12 = useDetailsPageRenderItems(tbl2.componentList, var11, var5, tbl3.safeAreaSize)

    local renderItem = React.useCallback(function(arg1)
        return React.createElement(
            DetailsPageRenderItem,
            {
                item = arg1.item,
                itemPadding = tbl3.itemPadding,
                safeArea = tbl3.safeAreaSize
            }
        )
    end, { tbl3.itemPadding, tbl3.safeAreaSize })

    local itemSeparatorComponent = React.useCallback(function()
        return React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, tbl3.itemPadding),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }
        )
    end, { tbl3.itemPadding })

    local onSelectedIndexChanged = React.useCallback(function(arg1)
        scrollViewPositionChangedSignal:fire()
        if var12[arg1].showCornerGradient == false then
            var2(false)
            return
        end
        var2(true)
    end, { var12, scrollViewPositionChangedSignal })

    local var16 = useSignalState(Display.GetDisplayStore().getDeviceSafePadding)

    local createElement = React.createElement
    local var17 = FullscreenFrame
    local tbl4 = {
        [React.Change.AbsoluteSize] = var7,
        BackgroundTransparency = 1,
        ref = ref
    }
    local tbl5 = { BackgroundImage = 0, Overlay = 0, Content = 0, Fullscreen = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl6 = {
        ZIndex = 1,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }
    local tbl7 = {
        BackgroundImage = if FFlagLuaAppEdpConsoleMediaGalleryVideo then nil else React.createElement(LoadableImage, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, 0),
            Image = tbl2.bannerImageUrl,
            ScaleType = Enum.ScaleType.Crop
        }),
        BackgroundContent = 0
    }
    local var18

    if FFlagLuaAppEdpConsoleMediaGalleryVideo then
        if tbl2.backgroundContentOverride then
            var18 = tbl2.backgroundContentOverride
        else
            var18 = React.createElement(LoadableImage, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.new(1, 0, 1, 0),
                Image = tbl2.bannerImageUrl,
                ScaleType = Enum.ScaleType.Crop
            })
        end
    else
        var18 = nil
    end

    tbl7.BackgroundContent = var18
    tbl5.BackgroundImage = createElement2(str1, tbl6, tbl7)

    tbl5.Overlay = React.createElement(Overlay, { ZIndex = 2, showGradient = showGradient, gradientDirection = "topRight" })

    tbl5.Content = React.createElement(AnimatedFlatList, {
        onSelectedIndexChanged = onSelectedIndexChanged,
        animated = true,
        initialNumToRender = #var12,
        data = var12,
        renderItem = renderItem,
        ItemSeparatorComponent = itemSeparatorComponent,
        ListFooterComponent = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, tbl3.trailingWhitespace),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }
        ),
        ListHeaderComponent = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, tbl3.safeAreaSize.Y),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }
        ),
        viewOffset = tbl3.safeAreaSize.Y,
        contentContainerStyle = { BackgroundTransparency = 1 },
        style = {
            Position = UDim2.fromOffset(0, -var16.top),
            Size = UDim2.new(1, 0, 1, var16.top + var16.bottom),
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            ScrollingEnabled = true,
            Selectable = false,
            VerticalScrollBarInset = Enum.ScrollBarInset.None,
            ZIndex = 3
        },
        animationConfig = tbl3.animationConfig,
        UNSTABLE_forceSiblingLayoutUpdate = true,
        overrideAutomaticCanvasSize = false,
        isSequentiallySelectable = true
    })

    tbl5.Fullscreen = React.createElement(
        "CanvasGroup",
        {
            Size = UDim2.fromScale(1, 1),
            GroupTransparency = groupTransparency,
            BorderSizePixel = 0,
            ZIndex = 4
        },
        {
            FullscreenContent = if var9 then renderFullscreenContent() else nil
        }
    )
    return createElement(var17, tbl4, tbl5)
end

return DetailsPageTenfootTemplate
