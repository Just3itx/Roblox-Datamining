-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local ContextActionService = game:GetService("ContextActionService")
local LocalizationService = game:GetService("LocalizationService")

local AppCommonLib = require(scriptParentParentParentParent.AppCommonLib)
local IXPServiceWrapper = require(scriptParentParentParentParent.IXPServiceWrapper).IXPServiceWrapper
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local RobloxAppHooks = require(scriptParentParentParentParent.RobloxAppHooks)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local Images = UIBlox.App.ImageSet.Images
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Signal = AppCommonLib.Signal
local useStyle = UIBlox.Core.Style.useStyle

local useCallback = React.useCallback
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local useRef = React.useRef
local useScreenSize = RobloxAppHooks.useScreenSize
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useState = React.useState

local CapturesCarousel = require(scriptParentParentParent.Components.CapturesCarousel.CapturesCarousel)
local CapturesToastType = require(scriptParentParentParent.Enums.CapturesToastType)
local CarouselClosed = require(scriptParentParentParent.Actions.CarouselClosed)
local CarouselCTAContainer = require(scriptParentParentParent.Components.CapturesCarousel.CarouselCTAContainer)
local Constants = require(scriptParentParentParent.Constants)
local DeleteCapture = require(scriptParentParentParent.Thunks.DeleteCapture)
local DeleteWarningModal = require(scriptParentParentParent.Components.Common.DeleteWarningModal)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local getTimestampFromCapture = require(scriptParentParentParent.Utils.getTimestampFromCapture)
local PermissionModal = require(scriptParentParentParent.Components.Common.PermissionModal)
local ToastContainer = require(scriptParentParentParent.Components.Common.ToastContainer)
local ToastTriggered = require(scriptParentParentParent.Actions.ToastTriggered)
local _Types = require(scriptParentParentParent.Types)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

local FFlagUseMediaPlayerInCarousel = require(scriptParentParentParentParent.SharedFlags).FFlagUseMediaPlayerInCarousel
local FStringSocialCaptureTakenIXPLayer = require(scriptParentParentParentParent.SharedFlags).FStringSocialCaptureTakenIXPLayer

local uDim2 = UDim2.fromOffset(32, 32)

local function getTitle(arg1): string
    local timestampFromCapture = getTimestampFromCapture(arg1)
    if not timestampFromCapture then
        return ""
    end

    assert(typeof(timestampFromCapture) == "number", "Expected timestamp to be a number")
    local dateTime = DateTime.fromUnixTimestampMillis(timestampFromCapture)

    local robloxLocaleId = LocalizationService.RobloxLocaleId
    return `{dateTime:FormatLocalTime("L", robloxLocaleId)} {dateTime:FormatLocalTime("LT", robloxLocaleId)}`
end

return function(_)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3 = useStyle()

    local var4 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Captures
    end)

    local var5 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Carousel.IsOpen
    end)

    local var6 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Carousel.SelectedCaptureIndex
    end)

    local var7 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Carousel.IsDeleteWarningModalOpen
    end)

    local var8 = useRef(Signal.new())
    local isDisabled, var10 = useState(false)
    local visible, var12 = useState(false)
    local var13 = useScreenSize()

    useEffectOnce(function()
        IXPServiceWrapper:LogUserLayerExposure(FStringSocialCaptureTakenIXPLayer)
    end, var5)

    useEffect(function()
        var2(ToastTriggered(CapturesToastType.None))
    end, { var5 })

    local var14 = useCallback(function()
        var10(false)
        var1.fireEvent(EventNames.CapturesCarouselClosed)
        var2(CarouselClosed())
    end, {})

    local var15 = useCallback(function()
        var10(false)
        var1.fireEvent(EventNames.CapturesCarouselClosedByKeyboard)
        var2(CarouselClosed())
    end, {})

    local openPermissionModal = useCallback(function()
        var12(true)
    end, {})

    local closeModal = useCallback(function()
        var12(false)
    end, {})

    local deleteItem = useCallback(function()
        var10(true)

        local var18 = var4[var6]
        var8.current:fire(function()
            var2(DeleteCapture(var18))
            var10(false)
        end)
    end, { var4, var6 })

    useEffect(function()
        if not var5 or var7 then
            return
        end

        ContextActionService:BindCoreAction("CapturesCarouselCloseShortcutAction", function(_, userInputState)
            if userInputState == Enum.UserInputState.End then
                var15()
            end
        end, false, Enum.KeyCode.Escape)

        return function()
            ContextActionService:UnbindCoreAction("CapturesCarouselCloseShortcutAction")
        end
    end, { var5, var7, var15 })

    if not var5 then
        return nil
    end

    local maxHeight = var13.Y - 32 - 40 - 8 - 16 - 16

    local var20 = var4[var6]
    local title = getTitle(var20)

    local createElement = React.createElement
    local tbl1 = {
        Active = true,
        BackgroundColor3 = var3.Theme.BackgroundContrast.Color,
        BackgroundTransparency = var3.Theme.BackgroundContrast.Transparency,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromScale(1, 1)
    }
    local tbl2 = {
        CarouselContainer = 0,
        DeleteWarningModal = 0,
        PermissionModal = 0,
        ToastsFrame = 0
    }
    local createElement2 = React.createElement
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        Padding = React.createElement("UIPadding", { PaddingBottom = UDim.new(0, 16), PaddingTop = UDim.new(0, 8) }),
        TitleFrame = 0,
        CapturesCarousel = 0,
        CTAContainer = 0
    }

    local createElement3 = React.createElement
    local tbl5 = {
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 32),
        ZIndex = if FFlagUseMediaPlayerInCarousel then 1 else 2
    }
    local tbl6 = {
        CloseButton = React.createElement(ImageSetButton, {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Image = Images["icons/navigation/close"],
            ImageColor3 = var3.Theme.IconEmphasis.Color,
            ImageTransparency = var3.Theme.IconEmphasis.Transparency,
            Position = UDim2.new(0, 42, 0.5, 0),
            Size = uDim2,
            [React.Event.Activated] = var14
        }),
        DropShadow = React.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var3.Tokens.Typography.TitleLarge.Font),
            LayoutOrder = 1,
            Position = UDim2.new(0.5, 0, 0.5, 2),
            Size = UDim2.fromScale(0, 1),
            Text = title,
            TextColor3 = var3.Theme.DropShadow.Color,
            TextSize = var3.Font.BaseSize * var3.Font.Header2.RelativeSize,
            TextTransparency = var3.Theme.DropShadow.Transparency,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 1
        }, {
            UIStroke = React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = var3.Theme.DropShadow.Color,
                LineJoinMode = Enum.LineJoinMode.Round,
                Thickness = 1,
                Transparency = var3.Theme.DropShadow.Transparency
            })
        }),
        Title = React.createElement("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var3.Tokens.Typography.TitleLarge.Font),
            LayoutOrder = 1,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0, 1),
            Text = title,
            TextColor3 = var3.Theme.TextEmphasis.Color,
            TextSize = var3.Font.BaseSize * var3.Font.Header2.RelativeSize,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            ZIndex = 2
        })
    }
    tbl4.TitleFrame = createElement3("Frame", tbl5, tbl6)

    tbl4.CapturesCarousel = React.createElement(CapturesCarousel, {
        deleteItemSignal = var8.current,
        isDisabled = isDisabled,
        LayoutOrder = 2,
        maxHeight = maxHeight,
        ZIndex = if FFlagUseMediaPlayerInCarousel then 2 else 1
    })

    tbl4.CTAContainer = React.createElement(CarouselCTAContainer, {
        deleteItem = deleteItem,
        height = 40,
        isDisabled = isDisabled or var7,
        LayoutOrder = 3,
        openPermissionModal = openPermissionModal,
        ZIndex = if FFlagUseMediaPlayerInCarousel then 1 else 2
    })
    tbl2.CarouselContainer = createElement2("Frame", tbl3, tbl4)

    tbl2.DeleteWarningModal = React.createElement(DeleteWarningModal, { deleteItem = deleteItem, zIndex = 3 })

    tbl2.PermissionModal = React.createElement(PermissionModal, { closeModal = closeModal, visible = visible, zIndex = 3 })

    tbl2.ToastsFrame = React.createElement(
        "Frame",
        {
            Active = false,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ZIndex = Constants.ZIndex.Toasts
        },
        {
            ToastContainer = React.createElement(ToastContainer)
        }
    )
    return createElement("Frame", tbl1, tbl2)
end
