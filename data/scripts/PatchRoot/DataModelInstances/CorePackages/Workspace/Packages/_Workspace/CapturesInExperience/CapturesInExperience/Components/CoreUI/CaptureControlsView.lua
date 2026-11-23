-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CaptureService = game:GetService("CaptureService")

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local Foundation = require(scriptParentParentParentParent.Foundation)
local IXPServiceWrapper = require(scriptParentParentParentParent.IXPServiceWrapper).IXPServiceWrapper
local Localization = require(scriptParentParentParentParent.Localization)
local SocialStopwatch = require(scriptParentParentParentParent.SocialStopwatch)

local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local Image = Foundation.Image
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local Tooltip = Foundation.Tooltip
local View = Foundation.View

local GalleryButtonContent = require(scriptParentParentParent.Components.CoreUI.GalleryButtonContent)
local VideoCaptureControl = require(scriptParentParentParent.Components.CoreUI.VideoCaptureControl)
local VoiceChatIndicator = require(scriptParentParentParent.Components.CoreUI.VoiceChatIndicator)

local CapturesContext = require(scriptParentParentParent.Context.CapturesContext)
local CapturesPolicy = require(scriptParentParentParent.App.CapturesPolicy)
local CarouselOpened = require(scriptParentParentParent.Actions.CarouselOpened)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local GetLatestCaptureStore = require(scriptParentParentParent.Stores.GetLatestCaptureStore)
local TakeCapture = require(scriptParentParentParent.Thunks.TakeCapture)

local findCaptureIndex = require(scriptParentParentParent.Utils.findCaptureIndex)

local SnapDirection = require(scriptParentParentParent.Enums.SnapDirection)

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useCallback = React.useCallback
local useCaptureControlsController = require(scriptParentParentParent.Hooks.useCaptureControlsController)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useLocalization = Localization.Hooks.useLocalization
local usePlayShutterSound = require(scriptParentParentParent.Hooks.usePlayShutterSound)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useLatestCapture = require(scriptParentParentParent.Hooks.useLatestCapture)
local useSystemMenuDetection = require(scriptParentParentParent.Hooks.useSystemMenuDetection)
local useTokens = Foundation.Hooks.useTokens
local useTopbarInset = require(scriptParentParentParent.Hooks.useTopbarInset)

local bool1 = game:DefineFastFlag("DebugOverrideCaptureControlsVideoGuacPolicy", false)
local FStringSocialCaptureIXPLayer = require(scriptParentParentParentParent.SharedFlags).FStringSocialCaptureIXPLayer
local FFlagCapturesControlsUseBuilderIcons = require(scriptParentParentParent.Flags.FFlagCapturesControlsUseBuilderIcons)
local FFlagCapturesControlsGalleryButton = require(scriptParentParentParent.Flags.FFlagCapturesControlsGalleryButton)

local name = if FFlagCapturesControlsUseBuilderIcons then IconName.FrameCameraCenter else "icons/controls/screenCapture"
local Large = if FFlagCapturesControlsUseBuilderIcons then IconSize.Large else nil
local tbl1 = {
    [SnapDirection.Bottom] = PopoverSide.Top,
    [SnapDirection.Left] = PopoverSide.Right,
    [SnapDirection.Right] = PopoverSide.Left,
    [SnapDirection.Top] = PopoverSide.Bottom
}

return (CapturesPolicy.connect(function(arg1)
    return {
        hasVideoCaptureCapability = arg1.hasVideoCaptureCapability() and CaptureService:CanCaptureVideo() or bool1
    }
end)(function(tbl2)
    local var2 = useAnalytics()
    local var3 = useDispatch()
    local var4 = useLocalization({
        captureScreenshot = "Feature.Captures.Title.CaptureScreenshotTooltip",
        gallery = if FFlagCapturesControlsGalleryButton then "Feature.Captures.Title.Gallery" else nil
    })
    local var5 = useTokens()
    local openGallery = if FFlagCapturesControlsGalleryButton then React.useContext(CapturesContext).openGallery else nil
    local var6 = if FFlagCapturesControlsGalleryButton then useSystemMenuDetection() else false
    local latestCapture = if FFlagCapturesControlsGalleryButton then useLatestCapture() else nil

    local var8 = if FFlagCapturesControlsGalleryButton then useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Captures
    end) else nil

    local var9 = useTopbarInset()

    local var10 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsActive
    end)

    local var11 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].IsVideoCaptureActive.status
    end)

    useEffect(function()
        if var10 then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringSocialCaptureIXPLayer)
        end
    end, { var10 })

    local var12 = usePlayShutterSound()

    local var13 = React.useMemo(function(): Vector2
        return Vector2.new(var9.Min.X - var5.Padding.Small, var9.Height - var5.Padding.XSmall - var5.Padding.XXSmall)
    end, { var9, var5 })

    local var14 = useCaptureControlsController(var10, var13)

    local dragContainerRef = var14.dragContainerRef
    local dragDetectorRef = var14.dragDetectorRef
    local dragItemAnchorPointBinding = var14.dragItemAnchorPointBinding
    local dragItemPositionBinding = var14.dragItemPositionBinding
    local dragItemRef = var14.dragItemRef
    local isItemHorizontal = var14.isItemHorizontal
    local screenshotButtonRef = var14.screenshotButtonRef
    local snapDirection = var14.snapDirection

    useEffect(function()
        if var10 then
            var2.fireEvent(EventNames.CapturesEntrypointViewed)
        end
    end, { var10 })

    local onActivated = useCallback(function()
        if not SocialStopwatch.Stopwatch.get(SocialStopwatch.Events.CaptureTaken) then
            SocialStopwatch.Stopwatch.start(SocialStopwatch.Events.CaptureTaken)
        end

        var2.fireEvent(EventNames.CapturesEntrypointActivated)

        var12()
        var3(TakeCapture())
    end, { var12 })

    local var1 = if FFlagCapturesControlsGalleryButton then useCallback(function()
        local var16 = GetLatestCaptureStore(false).getLatestCaptureFilePath(false)

        if not openGallery() or latestCapture == nil or var8 == nil then
            return
        end

        local captureIndex = findCaptureIndex(var8, latestCapture, var16)
        if captureIndex then
            var2.fireEvent(EventNames.CapturesCarouselOpened)
            var3(CarouselOpened(captureIndex))
        end
    end, {
        openGallery,
        latestCapture,
        var8,
        var2.fireEvent,
        var3
    }) else nil

    local galleryButtonContent = if FFlagCapturesControlsGalleryButton then React.createElement(GalleryButtonContent, { latestCapture = latestCapture }) else nil
    local createElement = React.createElement
    local var17 = View
    local tbl3 = {
        Position = UDim2.fromOffset(0, -var9.Height),
        Size = UDim2.new(1, 0, 1, var9.Height),
        tag = "padding-x-large padding-y-medium",
        ZIndex = Constants.ZIndex.Entrypoint
    }
    local tbl4 = { PaddedContainer = 0 }
    local createElement2 = React.createElement
    local var18 = View
    local tbl5 = {
        ref = dragContainerRef,
        tag = "anchor-center-center position-center-center size-full"
    }
    local tbl6 = { CaptureControls = 0 }
    local var19

    if var10 then
        local createElement3 = React.createElement
        local var20 = View

        local tbl7 = {
            AnchorPoint = dragItemAnchorPointBinding:map(function(arg1): Vector2
                return Vector2.new(arg1.x, arg1.y)
            end),
            onActivated = function() end,
            Position = dragItemPositionBinding:map(function(arg1): UDim2
                return UDim2.fromOffset(arg1.xOffset, arg1.yOffset)
            end),
            ref = dragItemRef,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            tag = {
                ["row auto-x padding-x-small padding-y-xsmall size-0-1100"] = isItemHorizontal,
                ["col auto-y padding-y-small padding-x-xsmall size-1100-0"] = not isItemHorizontal,
                ["align-x-center align-y-center bg-over-media-0 flex-evenly radius-circle"] = true
            }
        }

        local tbl8 = {
            DragDetector = React.createElement("UIDragDetector", {
                DragStyle = Enum.UIDragDetectorDragStyle.Scriptable,
                BoundingUI = dragContainerRef,
                ref = dragDetectorRef,
                ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset
            }),
            VideoCaptureControl = if tbl2.hasVideoCaptureCapability then React.createElement(VideoCaptureControl, { layoutOrder = 1, popoverSide = tbl1[snapDirection] }) else nil,
            ScreenshotCTA = 0,
            GalleryCTA = 0,
            VoiceChatIndicator = 0,
            DragAffordance = 0
        }
        local element2

        if var11 then
            element2 = nil
        else
            element2 = React.createElement(View, {
                LayoutOrder = 2,
                tag = {
                    ["size-1200-1200"] = true,
                    ["anchor-center-center auto-xy clip position-center-center radius-circle"] = true
                },
                onActivated = onActivated,
                ref = screenshotButtonRef
            }, {
                ScreenshotIconWithTooltip = React.createElement(
                    Tooltip,
                    {
                        align = PopoverAlign.Center,
                        side = tbl1[snapDirection],
                        title = var4.captureScreenshot
                    },
                    React.createElement(View, { tag = "size-1200-1200" }, { React.createElement(Icon, {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            name = name,
                            size = Large,
                            style = var5.Color.Content.Emphasis
                        }) })
                )
            })
        end

        tbl8.ScreenshotCTA = element2
        local element3

        if FFlagCapturesControlsGalleryButton and openGallery and not var11 then
            element3 = React.createElement(View, {
                LayoutOrder = 3,
                tag = "position-center-center anchor-center-center size-1200-1200 auto-xy radius-circle clip",
                testId = "--social-captures-controls-gallery-button",
                onActivated = var1
            }, {
                GalleryButtonContent = galleryButtonContent,
                GalleryTooltip = if var6 then nil else React.createElement(
                    Tooltip,
                    {
                        align = PopoverAlign.Center,
                        side = tbl1[snapDirection],
                        title = var4.gallery
                    },
                    React.createElement(View, { tag = "size-1200-1200" })
                )
            })
        else
            element3 = nil
        end

        tbl8.GalleryCTA = element3

        tbl8.VoiceChatIndicator = if var11 then React.createElement(
            VoiceChatIndicator,
            {
                layoutOrder = if FFlagCapturesControlsGalleryButton then 4 else 3,
                popoverSide = tbl1[snapDirection]
            }
        ) else nil

        local createElement4 = React.createElement
        local var21 = View
        local tbl9 = {
            LayoutOrder = if FFlagCapturesControlsGalleryButton then 5 else 4,
            tag = "anchor-center-center auto-xy padding-xxsmall position-center-center"
        }
        local tbl10 = { DragAffordanceIcon = 0 }
        local element4

        if FFlagCapturesControlsUseBuilderIcons then
            element4 = React.createElement(Icon, {
                name = IconName.SixDotsTwoColumnGrid,
                Rotation = if isItemHorizontal then 0 else 90,
                style = var5.Color.Content.Muted,
                tag = "position-center-center anchor-center-center"
            })
        else
            element4 = React.createElement(Image, {
                Image = "component_assets/dragger_small",
                Rotation = if isItemHorizontal then 90 else 0,
                tag = "anchor-center-center content-muted position-center-center size-600-400"
            })
        end

        tbl10.DragAffordanceIcon = element4
        tbl8.DragAffordance = createElement4(var21, tbl9, tbl10)
        var19 = createElement3(var20, tbl7, tbl8)
    else
        var19 = nil
    end

    tbl6.CaptureControls = var19
    tbl4.PaddedContainer = createElement2(var18, tbl5, tbl6)
    return createElement(var17, tbl3, tbl4)
end))
