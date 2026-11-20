-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local _GuiService = game:GetService("GuiService")

local Signals = require(CorePackages.Packages.Signals)
local Display = require(CorePackages.Workspace.Packages.Display)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagAddUILessMode = SharedFlags.FFlagAddUILessMode
local FIntAddUILessModeVariant = SharedFlags.FIntAddUILessModeVariant

local Roact = require(CorePackages.Packages.Roact)
local React = require(CorePackages.Packages.React)

local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Cryo = require(CorePackages.Packages.Cryo)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Core.Style.withStyle
local Interactable = UIBlox.Core.Control.Interactable
local ControlState = UIBlox.Core.Control.Enum.ControlState
local Images = UIBlox.App.ImageSet.Images
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local _CursorKind = UIBlox.App.SelectionImage.CursorKind
local ReactOtter = require(CorePackages.Packages.ReactOtter)

local Foundation = require(CorePackages.Packages.Foundation)
local withCursor = Foundation.Hooks.withCursor
local SkinToneCircle = Foundation.Enums.CursorType.SkinToneCircle

local _scriptParentParentParent = script.Parent.Parent.Parent

local FlashingDot = require(script.Parent.FlashingDot)
local FlashingDotV2 = require(script.Parent.FlashingDotV2)
local GetFFlagFlashingDotUseAsyncInit = require(CoreGui.RobloxGui.Modules.Flags.GetFFlagFlashingDotUseAsyncInit)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local isNewTiltIconEnabled = require(CoreGui.RobloxGui.Modules.isNewTiltIconEnabled)
local Constants = require(script.Parent.Parent.Parent.Constants)

local var2 = Roact.PureComponent:extend("IconButton")

local component_assetsCircle_17 = Images["component_assets/circle_17"]

local strictInterface = t.strictInterface
local tbl1 = {
    icon = t.union(t.string, t.table),
    iconSize = t.union(t.number, t.UDim2, t.table),
    enableFlashingDot = t.optional(t.boolean),
    useIconScaleAnimation = t.optional(t.boolean),
    onActivated = t.callback,
    onHover = t.optional(t.callback),
    onHoverEnd = t.optional(t.callback),
    backgroundTransparency = t.optional(t.number),
    backgroundColor3 = t.optional(t.Color3),
    backgroundCornerRadius = t.optional(t.UDim),
    forwardRef = t.optional(t.any),
    onSelectionChanged = if var1 and FFlagEnableConsoleExpControls then t.optional(t.callback) else nil,
    nextSelectionRightRef = if var1 and FFlagEnableConsoleExpControls then t.optional(t.any) else nil,
    modal = if FFlagAddUILessMode and FIntAddUILessModeVariant == 2 then t.optional(t.boolean) else nil,
    [Roact.Change.AbsoluteSize] = t.optional(t.callback),
    [Roact.Change.AbsolutePosition] = t.optional(t.callback)
}
var2.validateProps = strictInterface(tbl1)

function AnimatedScaleIcon(arg1)
    local var3, var4 = ReactOtter.useAnimatedBinding(arg1.iconSize)

    React.useEffect(function()
        var4(ReactOtter.spring(arg1.iconSize, { dampingRatio = 1, frequency = 20 / 7 }))

        return function() end
    end, { arg1.iconSize })

    return Roact.createElement(ImageSetLabel, {
        Size = var3:map(function(num1: number): UDim2
            return UDim2.fromOffset(num1, num1)
        end),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Image = arg1.icon,
        ImageColor3 = arg1.style.Theme.IconEmphasis.Color,
        ImageTransparency = arg1.style.Theme.IconEmphasis.Transparency,
        ZIndex = 1
    })
end

function var2.init(arg1)
    arg1:setState({ controlState = ControlState.Default })

    function arg1.controlStateUpdated(hover, controlState)
        if arg1.props.onHover and controlState == ControlState.Hover then
            arg1.props.onHover()
        elseif arg1.props.onHoverEnd and hover == ControlState.Hover and controlState ~= ControlState.Hover then
            arg1.props.onHoverEnd()
        end
        arg1:setState({ controlState = controlState })
    end

    arg1.disposeUiScaleEffect = Signals.createEffect(function(arg2)
        local displayStore = Display.GetDisplayStore(arg2)
        arg1:setState({ UiScale = displayStore.getUIScale(arg2) })
    end)
end

function var2.render(arg1)
    if var1 then
        return withCursor(function(arg2)
            return arg1:renderWithCursor(arg2)
        end)
    end
    return withSelectionCursorProvider(function(arg2)
        return arg1:renderWithCursor(arg2)
    end)
end

function var2.renderWithCursor(arg1, arg2)
    local backgroundColor3 = not isNewTiltIconEnabled() and arg1.props.backgroundColor3
    local var3 = Constants.TopBarButtonHeight * arg1.state.UiScale
    return withStyle(function(style)
        local tbl2 = {
            Color = Color3.new(1, 1, 1),
            Transparency = 1
        }

        if arg1.state.controlState == ControlState.Pressed then
            tbl2 = style.Theme.BackgroundOnPress
        elseif arg1.state.controlState == ControlState.Hover then
            tbl2 = style.Theme.BackgroundOnHover
        end

        local createElement = Roact.createElement
        local var4 = Interactable
        local tbl3 = {
            onStateChanged = arg1.controlStateUpdated,
            ZIndex = 1,
            Modal = if FFlagAddUILessMode and FIntAddUILessModeVariant == 2 then arg1.props.modal else nil,
            BackgroundTransparency = if isNewTiltIconEnabled() then style.Theme.BackgroundUIContrast.Transparency * style.Settings.PreferredTransparency else 1,
            Position = UDim2.fromScale(0, if isNewTiltIconEnabled() then 0.5 else 1),
            AnchorPoint = Vector2.new(0, if isNewTiltIconEnabled() then 0.5 else 1),
            Size = UDim2.fromOffset(var3, var3),
            Image = if isNewTiltIconEnabled() then nil else "rbxasset://textures/ui/TopBar/iconBase.png",
            BackgroundColor3 = style.Theme.BackgroundUIContrast.Color,
            SelectionImageObject = if isNewTiltIconEnabled() then arg2.getCursor(SkinToneCircle) else nil,
            NextSelectionRight = if var1 and FFlagEnableConsoleExpControls then arg1.props.nextSelectionRightRef else nil,
            [Roact.Event.Activated] = arg1.props.onActivated,
            [Roact.Event.SelectionChanged] = if var1 and FFlagEnableConsoleExpControls then arg1.props.onSelectionChanged else nil,
            [Roact.Ref] = arg1.props.forwardRef
        }
        local tbl4 = {
            UICorner = isNewTiltIconEnabled() and Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }) or nil,
            BackgroundFrame = 0,
            Icon = 0,
            ScalingIcon = 0,
            FlashingDot = 0,
            StateOverlayRound = 0,
            StateOverlay = 0
        }
        local element

        if backgroundColor3 then
            element = Roact.createElement("Frame", {
                Size = arg1.props.iconSize,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BorderSizePixel = 0,
                BackgroundTransparency = arg1.props.backgroundTransparency,
                BackgroundColor3 = arg1.props.backgroundColor3,
                ZIndex = 0
            }, {
                UICorner = if arg1.props.backgroundCornerRadius then Roact.createElement("UICorner", { CornerRadius = arg1.props.backgroundCornerRadius }) else nil
            })
        else
            element = nil
        end

        tbl4.BackgroundFrame = element

        local bool1 = not arg1.props.useIconScaleAnimation

        if bool1 then
            bool1 = Roact.createElement(ImageSetLabel, {
                Size = if typeof(arg1.props.iconSize) ~= "number" then arg1.props.iconSize else UDim2.fromOffset(arg1.props.iconSize, arg1.props.iconSize),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Image = arg1.props.icon,
                ImageColor3 = style.Theme.IconEmphasis.Color,
                ImageTransparency = style.Theme.IconEmphasis.Transparency,
                ZIndex = 1
            })
        end

        tbl4.Icon = bool1

        tbl4.ScalingIcon = arg1.props.useIconScaleAnimation
            and Roact.createElement(AnimatedScaleIcon, { icon = arg1.props.icon, iconSize = arg1.props.iconSize, style = style })
        local element2 = if arg1.props.enableFlashingDot then Roact.createElement(if GetFFlagFlashingDotUseAsyncInit() then FlashingDotV2 else FlashingDot) else nil
        tbl4.FlashingDot = element2

        tbl4.StateOverlayRound = if isNewTiltIconEnabled() then Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = tbl2.Transparency,
                BackgroundColor3 = tbl2.Color,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2
            },
            {
                UICorner = isNewTiltIconEnabled() and Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }) or nil
            }
        )
            or nil else nil

        tbl4.StateOverlay = if isNewTiltIconEnabled() then nil else Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Image = component_assetsCircle_17,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 8, 8),
            ImageColor3 = tbl2.Color,
            ImageTransparency = tbl2.Transparency,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 2
        })
            or nil
        return createElement(var4, tbl3, tbl4)
    end)
end

function var2.willUnmount(arg1)
    if arg1.disposeUiScaleEffect then
        arg1.disposeUiScaleEffect()
    end
end
return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var2, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
