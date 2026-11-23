-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBlox = script:FindFirstAncestor("AppBlox")
local AppBloxParent = AppBlox.Parent
local UIBlox = require(AppBloxParent.UIBlox)

local Cryo = require(AppBloxParent.Cryo)
local React = require(AppBloxParent.React)
local Roact = require(AppBloxParent.Roact)
local t = require(AppBloxParent.t)
local useTokens = require(AppBloxParent.Foundation).Hooks.useTokens

local withStyle = UIBlox.Core.Style.withStyle
local LoadableImage = UIBlox.App.Loading.LoadableImage

local Images = UIBlox.App.ImageSet.Images
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local getIconSize = UIBlox.App.ImageSet.getIconSize
local getIconSizeUDim2 = UIBlox.App.ImageSet.getIconSizeUDim2
local VerticalScrollView = UIBlox.App.Container.VerticalScrollView
local ActionBar = UIBlox.App.Button.ActionBar
local StickyActionBar = require(script.Parent.Parent.StickyActionBar)
local DeviceType = require(AppBloxParent.RobloxAppEnums).DeviceType
local useLastInputMode = require(AppBloxParent.FocusNavigationUtils).useLastInputMode
local Signal = require(AppBloxParent.AppCommonLib).Signal

local getPlatformConfig = require(script.Parent.getPlatformConfig)
local DetailsPageHeader = require(script.Parent.DetailsPageHeader)
local DetailsPageBody = require(script.Parent.DetailsPageBody)
local validateDetailsPageComponentList = require(script.Parent.validateDetailsPageComponentList)
local useAnimateScrollViewToSelection = require(AppBlox.useAnimateScrollViewToSelection)
local getTestId = require(AppBloxParent.RoactUtils).getTestId

local FFlagLuaAppFixDetailsPageThumbnailRenderInPhone = require(AppBloxParent.SharedFlags).FFlagLuaAppFixDetailsPageThumbnailRenderInPhone
local FFlagLuaAppFixSDPLayout = require(AppBloxParent.SharedFlags).FFlagLuaAppFixSDPLayout
local FFlagLuaAppAddTestIdsForArrow = require(AppBloxParent.SharedFlags).FFlagLuaAppAddTestIdsForArrow
local FFlagLuaAppEdpConsoleMediaGalleryVideo = require(AppBloxParent.SharedFlags).FFlagLuaAppEdpConsoleMediaGalleryVideo

local var1 = Roact.PureComponent:extend("DetailsPageTemplate")

local function applyTokenScaling(num1: number, foundationTokens) -- Luacid: Inlined by compiler; 7 call sites recovered
    return num1 * foundationTokens.Stroke.Standard
end

local strictInterface = t.strictInterface
local tbl1 = {
    foundationTokens = t.table,
    thumbnailImageUrl = t.optional(t.string),
    thumbnailHeight = t.optional(t.number),
    thumbnailAspectRatio = t.optional(t.Vector2),
    thumbnailShadowHeight = if FFlagLuaAppFixDetailsPageThumbnailRenderInPhone then t.optional(t.number) else nil,
    titleText = t.optional(t.string),
    subTitleText = t.optional(t.string),
    actionBarLabelText = t.optional(t.string),
    renderInfoContent = t.optional(t.callback),
    renderCustomHeader = t.optional(t.callback),
    actionBarProps = t.optional(t.table),
    actionBarWidth = t.optional(t.number),
    actionBarHeight = t.optional(t.number),
    renderActionBarLabelImpressionsDetector = t.optional(t.callback),
    componentList = t.optional(validateDetailsPageComponentList),
    dualPanelBreakpoint = t.optional(t.number),
    sideMargin = t.optional(t.number),
    bodyClipsDescendants = t.optional(t.boolean),
    maxContentWidth = t.optional(t.number),
    startingOffsetPosition = t.optional(t.number),
    headerBarBackgroundHeight = t.optional(t.number),
    onClose = t.callback,
    bannerPlaceholderGradient = t.optional(t.table),
    bannerImageUrl = t.optional(t.string),
    isFullscreen = t.optional(t.boolean),
    renderFullscreenContent = t.optional(t.callback),
    deviceType = t.optional(t.string),
    isMobile = t.optional(t.boolean),
    tokens = t.optional(t.table),
    containerRef = t.optional(t.union(t.table, t.callback)),
    backgroundFrameSize = t.optional(t.UDim2),
    scrollingFrameRef = t.optional(t.table),
    disableScrollingForFocusNav = t.optional(t.boolean),
    gradientHeight = t.optional(t.number),
    backgroundImageTransparency = t.optional(t.number),
    disableBackgroundAspectRatio = t.optional(t.boolean),
    bodyContainerSafeAreaSize = if FFlagLuaAppFixSDPLayout then t.optional(t.UDim2) else nil,
    backgroundImageSize = if FFlagLuaAppFixSDPLayout then t.optional(t.UDim2) else nil,
    headerPadding = if FFlagLuaAppFixSDPLayout then t.optional(t.number) else nil,
    disableStickyActionBar = t.optional(t.boolean),
    hideCloseButton = t.optional(t.boolean),
    backgroundContentOverride = if FFlagLuaAppEdpConsoleMediaGalleryVideo then t.optional(t.table) else nil
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    deviceType = DeviceType.Desktop,
    isFullscreen = false
}

local function getHeaderPaddingHeight(arg1, num1: number): number -- Luacid: unused: defined but never referenced
    local platformConfig = getPlatformConfig(arg1.deviceType)

    return num1 - (if arg1.headerBarBackgroundHeight then arg1.headerBarBackgroundHeight else applyTokenScaling(platformConfig.headerBarBackgroundHeight, arg1.foundationTokens))
end

function var1.init(arg1)
    arg1.containerRef = Roact.createRef()
    arg1.scrollingFrameRef = arg1.props.scrollingFrameRef
    arg1.scrolled = false
    arg1.scrollViewPositionChangedSignal = Signal.new()
    arg1.state = {
        showStickyActionTopBar = false,
        backgroundHeight = 500,
        containerSize = Vector2.new(500, 500),
        backgroundComponentPosition = 250
    }

    function arg1.onContainerSizeChange(arg2)
        arg1:setState({ containerSize = arg2.AbsoluteSize })
    end

    function arg1.onBackgroundComponentFrameSizeChange(arg2)
        arg1:setState(function(_, arg3)
            local absoluteSizeY = arg2.AbsoluteSize.Y
            local platformConfig = getPlatformConfig(arg3.deviceType)

            return {
                backgroundHeight = absoluteSizeY,
                backgroundComponentPosition = math.max(
                    0,
                    absoluteSizeY - (if arg3.headerBarBackgroundHeight then arg3.headerBarBackgroundHeight else applyTokenScaling(platformConfig.headerBarBackgroundHeight, arg3.foundationTokens))
                ) / 2
            }
        end)
    end

    function arg1.canvasPositionChange(arg2)
        arg1.scrollViewPositionChangedSignal:fire()
        arg1.scrolled = true
        arg1:setState(function(arg3, arg4)
            local backgroundHeight = arg3.backgroundHeight
            local platformConfig = getPlatformConfig(arg4.deviceType)

            local var2 = backgroundHeight - (if arg4.headerBarBackgroundHeight then arg4.headerBarBackgroundHeight else applyTokenScaling(platformConfig.headerBarBackgroundHeight, arg4.foundationTokens))

            local backgroundComponentPosition = math.max(0, var2 - arg2.CanvasPosition.Y) / 2

            if var2 < arg2.CanvasPosition.Y then
                if arg3.showStickyActionTopBar == false
                    and arg1.props.deviceType ~= DeviceType.Phone
                    and not arg1.props.disableStickyActionBar
                then
                    return { showStickyActionTopBar = true }
                end

                return nil
            end

            if arg3.showStickyActionTopBar == true then
                return {
                    showStickyActionTopBar = false,
                    backgroundComponentPosition = backgroundComponentPosition
                }
            end

            return { backgroundComponentPosition = backgroundComponentPosition }
        end)
    end
end

function var1.render(arg1)
    local bool1 = arg1.props.deviceType == DeviceType.Phone
    local platformConfig = getPlatformConfig(arg1.props.deviceType)
    local thumbnailHeight = if arg1.props.thumbnailHeight then arg1.props.thumbnailHeight else applyTokenScaling(platformConfig.thumbnailHeight, arg1.props.foundationTokens)
    local headerBarBackgroundHeight = if arg1.props.headerBarBackgroundHeight then arg1.props.headerBarBackgroundHeight else applyTokenScaling(platformConfig.headerBarBackgroundHeight, arg1.props.foundationTokens)
    local sideMargin = if arg1.props.sideMargin then arg1.props.sideMargin else platformConfig.sideMargin
    local dualPanelBreakpoint = if arg1.props.dualPanelBreakpoint then arg1.props.dualPanelBreakpoint else platformConfig.dualPanelBreakpoint
    local headerPadding = FFlagLuaAppFixSDPLayout and arg1.props.headerPadding

    if not headerPadding then
        local props = arg1.props
        local backgroundHeight = arg1.state.backgroundHeight
        local platformConfig2 = getPlatformConfig(props.deviceType)

        headerPadding = backgroundHeight - (if props.headerBarBackgroundHeight then props.headerBarBackgroundHeight else applyTokenScaling(platformConfig2.headerBarBackgroundHeight, props.foundationTokens))
    end

    local backgroundComponentPosition = arg1.state.backgroundComponentPosition
    local containerSize = arg1.state.containerSize

    local isFullscreen = arg1.props.isFullscreen
    local renderFullscreenContent = arg1.props.renderFullscreenContent
    local bool2 = not (bool1 or not isFullscreen) and not not renderFullscreenContent

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local bool3 = arg1.props.bannerImageUrl == nil
        local var3 = arg1.props.bannerPlaceholderGradient
            or {
                Rotation = 90,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, theme.BackgroundMuted.Color), ColorSequenceKeypoint.new(1, theme.BackgroundUIDefault.Color) })
            }

        local yOffset2 = bool1 and (getIconSize(IconSize.Large) + 22) / 2 or headerBarBackgroundHeight / 2

        local actionBarProps = bool1 and arg1.props.actionBarProps

        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl2 = {
            Text = "",
            Selectable = false,
            AutoButtonColor = false,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = theme.BackgroundDefault.Color,
            BackgroundTransparency = theme.BackgroundDefault.Transparency,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            [Roact.Ref] = if arg1.props.containerRef then arg1.props.containerRef else arg1.containerRef,
            [Roact.Change.AbsoluteSize] = arg1.onContainerSizeChange
        }
        local tbl3 = {
            CloseButtonFrame = 0,
            BackgroundDetailsFrame = 0,
            StickyActionBarFrame = 0,
            ContentScrollingFrame = 0,
            FullscreenFrame = 0,
            MobileActionBarFrame = 0
        }
        local element

        if arg1.props.hideCloseButton then
            element = nil
        else
            element = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = getIconSizeUDim2(IconSize.Large),
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 22, 0, yOffset2),
                ZIndex = 2,
                [React.Tag] = if FFlagLuaAppAddTestIdsForArrow then getTestId("details-close-button") else nil
            }, {
                CloseButton = Roact.createElement(IconButton, {
                    size = UDim2.fromScale(1, 1),
                    icon = bool2 and Images["icons/navigation/pushBack"] or Images["icons/navigation/close"],
                    iconColor3 = arg2.Theme.UIEmphasis.Color,
                    iconSize = IconSize.Medium,
                    onActivated = arg1.props.onClose,
                    showBackground = arg1.state.showStickyActionTopBar == false,
                    backgroundColor = arg2.Theme.BackgroundUIDefault
                })
            })
        end

        tbl3.CloseButtonFrame = element

        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl4 = {
            BackgroundColor3 = theme.BackgroundMuted.Color,
            BackgroundTransparency = theme.BackgroundMuted.Transparency,
            Size = if arg1.props.backgroundFrameSize then arg1.props.backgroundFrameSize else UDim2.fromScale(1, 1),
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0),
            [Roact.Change.AbsoluteSize] = arg1.onBackgroundComponentFrameSizeChange
        }
        local tbl5 = {
            GradientPlaceholder = bool3 and Roact.createElement("UIGradient", var3) or nil,
            UIAspectRatioConstraint = if bool3 or arg1.props.disableBackgroundAspectRatio then nil else Roact.createElement("UIAspectRatioConstraint", { AspectRatio = 16 / 9 }),
            BackgroundImage = 0
        }
        local element2

        if bool3 == false then
            element2 = Roact.createElement(LoadableImage, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0, backgroundComponentPosition),
                Size = FFlagLuaAppFixSDPLayout and arg1.props.backgroundImageSize or UDim2.new(0, containerSize.x, 1, 0),
                Image = arg1.props.bannerImageUrl,
                ScaleType = Enum.ScaleType.Crop,
                BackgroundTransparency = arg1.props.backgroundImageTransparency
            })
                or nil
        else
            element2 = nil
        end

        tbl5.BackgroundImage = element2
        tbl3.BackgroundDetailsFrame = createElement2(str2, tbl4, tbl5)
        local element3

        if arg1.state.showStickyActionTopBar or bool2 and not arg1.props.disableStickyActionBar then
            element3 = Roact.createElement("TextButton", {
                Text = "",
                AutoButtonColor = false,
                Size = UDim2.new(1, 0, 0, headerBarBackgroundHeight),
                BackgroundColor3 = theme.BackgroundUIDefault.Color,
                BackgroundTransparency = theme.BackgroundUIDefault.Transparency,
                BorderSizePixel = 0
            }, {
                StickyActionBar = Roact.createElement(StickyActionBar, {
                    actionBarProps = arg1.props.actionBarProps,
                    actionBarWidth = arg1.props.actionBarWidth,
                    infoProps = {
                        icon = arg1.props.thumbnailImageUrl,
                        title = arg1.props.titleText
                    }
                })
            })
                or nil
        else
            element3 = nil
        end

        tbl3.StickyActionBarFrame = element3

        local createElement3 = Roact.createElement
        local var4 = VerticalScrollView
        local tbl6 = {
            size = UDim2.fromScale(1, 1),
            canvasSizeY = UDim.new(1, 0),
            useAutomaticCanvasSize = true,
            scrollingEnabled = not (arg1.props.disableScrollingForFocusNav or bool2),
            [Roact.Change.CanvasPosition] = arg1.canvasPositionChange,
            scrollingFrameRef = arg1.scrollingFrameRef,
            isGamepadFocusable = false,
            selectable = false
        }
        local tbl7 = {
            Layout = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }
            ),
            Padding = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, headerPadding), BackgroundTransparency = 1, LayoutOrder = 1 }),
            MainView = 0,
            MobileActionViewPadding = 0
        }

        local createElement4 = Roact.createElement
        local str3 = "Frame"
        local tbl8 = {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            AutomaticSize = Enum.AutomaticSize.Y
        }
        local tbl9 = {
            Layout = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical
                }
            ),
            HeaderContainer = 0,
            BodyContainer = 0
        }
        local createElement5 = Roact.createElement
        local str4 = "Frame"
        local tbl10 = {
            Size = UDim2.new(1, 0, 0, headerBarBackgroundHeight),
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }

        local tbl11 = {
            DetailsPageHeader = Roact.createElement(DetailsPageHeader, {
                thumbnailImageUrl = arg1.props.thumbnailImageUrl,
                thumbnailAspectRatio = arg1.props.thumbnailAspectRatio,
                thumbnailHeight = thumbnailHeight,
                thumbnailShadowHeight = if FFlagLuaAppFixDetailsPageThumbnailRenderInPhone then arg1.props.thumbnailShadowHeight else nil,
                titleText = arg1.props.titleText,
                subTitleText = arg1.props.subTitleText,
                actionBarLabelText = arg1.props.actionBarLabelText,
                renderInfoContent = arg1.props.renderInfoContent,
                renderCustomHeader = arg1.props.renderCustomHeader,
                actionBarProps = if arg1.state.showStickyActionTopBar or not arg1.props.disableStickyActionBar and bool2 then nil else arg1.props.actionBarProps,
                actionBarWidth = arg1.props.actionBarWidth,
                actionBarHeight = arg1.props.actionBarHeight,
                headerBarBackgroundHeight = headerBarBackgroundHeight,
                sideMargin = sideMargin,
                maxContentWidth = arg1.props.maxContentWidth,
                deviceType = arg1.props.deviceType,
                gradientHeight = arg1.props.gradientHeight,
                renderActionBarLabelImpressionsDetector = arg1.props.renderActionBarLabelImpressionsDetector,
                scrollViewPositionChangedSignal = arg1.scrollViewPositionChangedSignal
            })
        }
        tbl9.HeaderContainer = createElement5(str4, tbl10, tbl11)

        local createElement6 = Roact.createElement
        local str5 = "Frame"
        local tbl12 = {
            Size = UDim2.fromScale(1, 0),
            LayoutOrder = 2,
            BackgroundColor3 = theme.BackgroundDefault.Color,
            BackgroundTransparency = theme.BackgroundDefault.Transparency,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y
        }
        local tbl13 = { BodyContainerSafeArea = 0 }
        local createElement7 = Roact.createElement
        local str6 = "Frame"
        local tbl14 = {
            Size = FFlagLuaAppFixSDPLayout and arg1.props.bodyContainerSafeAreaSize
                or UDim2.fromOffset(math.min(containerSize.x, containerSize.y * (16 / 9)), 0),
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        }
        tbl13.BodyContainerSafeArea = createElement7(str6, tbl14, {
            DetailsPageBody = Roact.createElement(DetailsPageBody, {
                titleText = arg1.props.titleText,
                subTitleText = arg1.props.subTitleText,
                renderInfoContent = arg1.props.renderInfoContent,
                bodyClipsDescendants = arg1.props.bodyClipsDescendants,
                componentList = arg1.props.componentList,
                dualPanelBreakpoint = dualPanelBreakpoint,
                sideMargin = sideMargin,
                maxContentWidth = arg1.props.maxContentWidth,
                deviceType = arg1.props.deviceType,
                showPageDetails = bool1 and arg1.props.renderCustomHeader == nil,
                bottomPadding = 100
            })
        })
        tbl9.BodyContainer = createElement6(str5, tbl12, tbl13)
        tbl7.MainView = createElement4(str3, tbl8, tbl9)

        tbl7.MobileActionViewPadding = actionBarProps
            and Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 72), BackgroundTransparency = 1, LayoutOrder = 3 })
        tbl3.ContentScrollingFrame = createElement3(var4, tbl6, tbl7)

        tbl3.FullscreenFrame = bool2
            and Roact.createElement("TextButton", {
                Size = UDim2.new(1, 0, 1, -headerBarBackgroundHeight),
                Position = UDim2.fromOffset(0, headerBarBackgroundHeight),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ClipsDescendants = true,
                ZIndex = 2
            }, {
                FullscreenContent = renderFullscreenContent()
            })
            or nil

        tbl3.MobileActionBarFrame = actionBarProps
            and Roact.createElement("TextButton", {
                Text = "",
                AutoButtonColor = false,
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.fromScale(0, 1),
                Size = UDim2.new(1, 0, 0, 72),
                BackgroundColor3 = theme.BackgroundDefault.Color,
                BackgroundTransparency = theme.BackgroundDefault.Transparency,
                BorderSizePixel = 0,
                ZIndex = 3
            }, {
                GradientBar = Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundColor3 = theme.BackgroundDefault.Color,
                    AnchorPoint = Vector2.new(0, 1),
                    BorderSizePixel = 0,
                    LayoutOrder = 1
                }, {
                    Gradient = Roact.createElement("UIGradient", {
                        Rotation = 270,
                        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(1, 0.9999) })
                    })
                }),
                ActionBar = Roact.createElement(ActionBar, { button = arg1.props.actionBarProps.button, icons = arg1.props.actionBarProps.icons })
            })
        return createElement(str1, tbl2, tbl3)
    end)
end

function var1.didMount(arg1)
    if arg1.containerRef.current then
        arg1.onContainerSizeChange(arg1.containerRef.current)
    end
end

function var1.didUpdate(arg1)
    local platformConfig = getPlatformConfig(arg1.props.deviceType)

    if arg1.scrolled ~= false or not arg1.scrollingFrameRef.current then
        return
    end

    local startingOffsetPosition = if arg1.props.startingOffsetPosition then arg1.props.startingOffsetPosition else platformConfig.startingOffsetPosition
    local num1 = 0
    local props = arg1.props
    local backgroundHeight = arg1.state.backgroundHeight
    local platformConfig2 = getPlatformConfig(props.deviceType)

    local y = math.max(
        num1,
        backgroundHeight - (if props.headerBarBackgroundHeight then props.headerBarBackgroundHeight else applyTokenScaling(platformConfig2.headerBarBackgroundHeight, props.foundationTokens)) - startingOffsetPosition
    )
    arg1.scrollingFrameRef.current.CanvasPosition = Vector2.new(0, y)
end

return function(arg1)
    local scrollingFrameRef = React.useRef(nil)
    useAnimateScrollViewToSelection(scrollingFrameRef, 0.4)
    local foundationTokens = useTokens()
    local disableScrollingForFocusNav = useLastInputMode() ~= "Cursor"
    return React.createElement(
        var1,
        Cryo.Dictionary.join(arg1, {
            foundationTokens = foundationTokens,
            scrollingFrameRef = scrollingFrameRef,
            disableScrollingForFocusNav = disableScrollingForFocusNav
        })
    )
end
