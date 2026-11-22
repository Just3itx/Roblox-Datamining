-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local PeekViewParent = script:FindFirstAncestor("PeekView").Parent
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local EventIngestService = game:GetService("EventIngestService")
local RunService = game:GetService("RunService")
local Cryo = require(PeekViewParent.Cryo)
local React = require(PeekViewParent.React)
local Roact = require(PeekViewParent.Roact)
local UIBlox = require(PeekViewParent.UIBlox)
local RoactGamepad = require(PeekViewParent.RoactGamepad)
local Focusable = RoactGamepad.Focusable
local RoactRodux = require(PeekViewParent.RoactRodux)
local PeekViewState = require(script.Parent.PeekViewState)
local Scrim = require(script.Parent.Scrim)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local ExternalEventConnection = require(PeekViewParent.RoactUtils).ExternalEventConnection
local ArgCheck = require(PeekViewParent.ArgCheck)
local InputTypeConstants = require(PeekViewParent.InputType).InputTypeConstants
local GamepadUtils = require(PeekViewParent.InputUi).Gamepad.GamepadUtils
local getInputGroup = require(PeekViewParent.InputType).getInputGroup
local peekViewDismissedEvent = require(script.Parent.analytics.peekViewDismissedEvent)
local var1 = require(PeekViewParent.Analytics).AnalyticsReporters.EventIngest.new(EventIngestService)
local switchAccountScrimError = require(PeekViewParent.UiShellEvents).switchAccountScrimError
local FocusNavigationUtils = require(PeekViewParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local usePeekViewFocusNavigationBindings = require(script.Parent.usePeekViewFocusNavigationBindings)

local GetFFlagEnablePeekViewStateOnMountParam = require(PeekViewParent.SharedFlags).GetFFlagEnablePeekViewStateOnMountParam
local GetFIntPeekViewTransitionDelayTiming = require(PeekViewParent.SharedFlags).GetFIntPeekViewTransitionDelayTiming
local FFlagProfilePlatformNewProfileHeader = require(PeekViewParent.SharedFlags).FFlagProfilePlatformNewProfileHeader
local FFlagProfilePlatformPeekDraggerContrast = require(PeekViewParent.SharedFlags).FFlagProfilePlatformPeekDraggerContrast
local bool1 = game:DefineFastFlag("EnableFastScrollingFixTest", false)
local GetFFlagPreventSuperBriefPeekViewClose = require(PeekViewParent.SharedFlags).GetFFlagPreventSuperBriefPeekViewClose
local bool2 = game:DefineFastFlag("AXMigratePeekViewToFocusNavigation", false)
local bool3 = game:DefineFastFlag("FixPeekViewAnimationJitter", false)
local FFlagPeekViewFixBriefHeightLayoutRace = require(PeekViewParent.SharedFlags).FFlagPeekViewFixBriefHeightLayoutRace

local rect = Rect.new(9, 9, 9, 9)
local iconsNavigationSwipe = Images["icons/navigation/swipe"]

local var2 = 0.1 * GetFIntPeekViewTransitionDelayTiming()

local Hidden = PeekViewState.Hidden
local Closed = PeekViewState.Closed
local SuperBrief = PeekViewState.SuperBrief
local Brief = PeekViewState.Brief
local Full = PeekViewState.Full
local Extended = PeekViewState.Extended

local var3 = Roact.PureComponent:extend("PeekView")

local defaultProps = {
    superBriefViewContentHeight = nil,
    briefViewContentHeight = UDim.new(0.5, 0),
    fullViewContentHeight = if bool2 then nil else UDim.new(1, 0),
    bottomDockedContainerHeight = 0,
    bottomDockedContainerContent = nil,
    elasticBehavior = Enum.ElasticBehavior.Always,
    hidden = false,
    showDraggerInClosedState = true,
    showDropShadow = true,
    stateOnMount = nil,
    mountAsFullView = false,
    mountAnimation = true,
    canDragFullViewToBrief = false,
    withNewThemeProvider = true,
    viewStateChanged = nil,
    briefToFullTransitionPercent = nil,
    peekHeaderClose = true,
    peekHeaderPositionYChange = nil,
    isScrollingEnabled = true,
    closeSignal = nil,
    hideDraggerInSuperBrief = false,
    minimizeToSuperBrief = false,
    customBackground = nil,
    shouldCaptureFocus = true,
    hasSolidDragger = true,
    draggerImageStyle = nil
}
var3.defaultProps = defaultProps

function var3.init(arg1)
    arg1.isMounted = false

    arg1.isTouched = false
    arg1.isInGoToState = false

    arg1.useReducedMotion = UserGameSettings.ReducedMotion

    arg1.viewType = Hidden
    arg1:setState({
        scrollableViewType = false,
        absoluteWindowSizeX = 0,
        absoluteWindowSizeY = 0,
        lastInputGroup = getInputGroup(UserInputService:GetLastInputType()),
        canvasGroupTransparency = 0
    })

    arg1.containerFrameRef = Roact.createRef()
    arg1.clipFrameRef = Roact.createRef()
    arg1.shadowRef = Roact.createRef()
    arg1.fillingAreaRef = Roact.createRef()
    arg1.swipeScrollingFrameRef = Roact.createRef()
    arg1.bottomContainerRef = Roact.createRef()

    local transitionPercent, setTransitionPercent = Roact.createBinding(0)
    arg1.transitionPercent = transitionPercent
    arg1.setTransitionPercent = setTransitionPercent

    function arg1.onAbsoluteWindowSizeChanged(arg2)
        if arg2.AbsoluteWindowSize.X ~= arg1.state.absoluteWindowSizeX
            or arg2.AbsoluteWindowSize.Y ~= arg1.state.absoluteWindowSizeY
        then
            arg1:setState({ absoluteWindowSizeX = arg2.AbsoluteWindowSize.X, absoluteWindowSizeY = arg2.AbsoluteWindowSize.Y })
        end
    end

    function arg1.withStyle(arg2)
        if arg1.props.withNewThemeProvider then
            return UIBlox.Style.withStyle(arg2)
        end

        return arg2({
            Theme = {
                BackgroundDefault = {
                    Color = Color3.fromRGB(35, 37, 39),
                    Transparency = 0
                },
                UIEmphasis = {
                    Color = Color3.fromRGB(255, 255, 255),
                    Transparency = 0.7
                },
                DropShadow = {
                    Color = Color3.fromRGB(0, 0, 0),
                    Transparency = 0
                }
            },
            Settings = { ReducedMotion = false }
        })
    end

    function arg1.inputBeganCallback(arg2)
        if arg1.isMounted and arg2.UserInputType == Enum.UserInputType.Touch then
            arg1.isTouched = true
        end
    end
    function arg1.inputEndedCallback(arg2)
        if arg1.isMounted and arg2.UserInputType == Enum.UserInputType.Touch then
            arg1.isTouched = false
            arg1.checkGoTo()
        end
    end
    function arg1.getViewSize(arg2)
        if arg2 == Hidden or arg2 == Closed then
            return UDim.new(0, 0)
        elseif arg2 == SuperBrief then
            if not arg1.props.superBriefViewContentHeight then
                return UDim.new(0, 0)
            end

            local superBriefViewContentHeight = arg1.props.superBriefViewContentHeight
            return UDim.new(superBriefViewContentHeight.Scale, superBriefViewContentHeight.Offset + 25)
        else
            if arg2 ~= Brief then
                return if arg2 == Full then arg1.props.fullViewContentHeight else nil
            end

            local briefViewContentHeight = arg1.props.briefViewContentHeight
            return UDim.new(briefViewContentHeight.Scale, briefViewContentHeight.Offset + 25)
        end
    end
    function arg1.hasNilRefs(): boolean
        local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current
        local current2 = if bool2 then arg1.props.containerFrameRef.current else arg1.containerFrameRef.current
        local current3 = arg1.clipFrameRef.current
        local current4 = arg1.shadowRef.current
        local current5 = arg1.fillingAreaRef.current

        return not (current and current2 and current3 and current4 and current5)
    end

    function arg1.reportRefStatus(callSite, arg2, arg3, arg4, arg5, arg6)
        switchAccountScrimError(var1, "switchAccountScrimError", {
            callSite = callSite,
            swipeScrollingFrame = if arg2 then "true" else "nil",
            containerFrame = if arg3 then "true" else "nil",
            clipFrame = if arg4 then "true" else "nil",
            shadow = if arg5 then "true" else "nil",
            fillingArea = if arg6 then "true" else "nil"
        })
    end

    function arg1.reconcileRbxInstances(str1: string?)
        local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current
        local canvasPositionY = current and current.CanvasPosition.Y or 0
        local current2 = if bool2 then arg1.props.containerFrameRef.current else arg1.containerFrameRef.current
        local current3 = arg1.clipFrameRef.current
        local current4 = arg1.shadowRef.current
        local current5 = arg1.fillingAreaRef.current

        if arg1.hasNilRefs() then
            arg1.reportRefStatus(str1, current, current2, current3, current4, current5)
            return
        end

        local absoluteSizeX = current2.AbsoluteSize.X
        local absoluteSizeY = current2.AbsoluteSize.Y

        current3.Size = UDim2.new(0, absoluteSizeX, 0, canvasPositionY)
        current4.Size = UDim2.new(0, absoluteSizeX, 0, 36)

        current3.Position = UDim2.new(0, 0, 1, -canvasPositionY)
        current4.Position = UDim2.new(0, 0, 1, -canvasPositionY - 30)

        current.Size = UDim2.new(0, absoluteSizeX, 0, absoluteSizeY)
        current.Position = UDim2.new(0, 0, 0, -(absoluteSizeY - canvasPositionY))

        current5.Size = UDim2.new(0, absoluteSizeX, 0, absoluteSizeY)

        local current6 = arg1.bottomContainerRef.current
        if current6 then
            local bottomDockedContainerHeight = arg1.props.bottomDockedContainerHeight
            if current3.AbsoluteSize.Y > 25 + bottomDockedContainerHeight then
                current6.Active = true
                current6.Position = UDim2.new(0, 0, 1, -bottomDockedContainerHeight)
            else
                current6.Active = false
                current6.Position = UDim2.new(0, 0, 1, -current3.AbsoluteSize.Y + 25)
            end
        end

        arg1.transitionCallbacks()
        if arg1.props.peekHeaderPositionYChange then
            arg1.props.peekHeaderPositionYChange(canvasPositionY)
        end
    end

    function arg1.updateSwipeScrollingFrame()
        local viewSize = arg1.getViewSize(arg1.viewType)
        local current = if bool2 then arg1.props.containerFrameRef.current and arg1.props.swipeScrollingFrameRef.current else arg1.containerFrameRef.current and arg1.swipeScrollingFrameRef.current

        if not viewSize or not current then
            return
        end

        local absoluteSizeY = (if bool2 then arg1.props.containerFrameRef.current else arg1.containerFrameRef.current).AbsoluteSize.Y
        local current2 = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current
        local y = absoluteSizeY * viewSize.Scale + viewSize.Offset
        if current2.CanvasPosition.Y == y then
            return
        end

        current2.CanvasPosition = Vector2.new(0, y)
        if arg1.props.peekHeaderPositionYChange then
            arg1.props.peekHeaderPositionYChange(y)
        end
    end

    function arg1.onContainerFrameAbsoluteSizeChanged()
        if not arg1.isMounted then
            return
        end

        arg1.reconcileRbxInstances("onContainerFrameAbsoluteSizeChanged")
        if not bool3 or not arg1:isAnimating() or arg1.viewType ~= Hidden then
            arg1.updateSwipeScrollingFrame()
        end
    end

    if FFlagPeekViewFixBriefHeightLayoutRace then
        function arg1.onAbsoluteCanvasSizeChanged()
            if not arg1.isMounted or arg1:isAnimating() or arg1.isTouched or arg1.viewType ~= Brief and arg1.viewType ~= SuperBrief then
                return
            end

            local viewSize = arg1.getViewSize(arg1.viewType)
            if not viewSize then
                return
            end

            local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current
            local current2 = if bool2 then arg1.props.containerFrameRef.current else arg1.containerFrameRef.current

            if not (current and current2) then
                return
            end

            local y = current2.AbsoluteSize.Y * viewSize.Scale + viewSize.Offset
            local var6 = current.AbsoluteCanvasSize.Y - current.AbsoluteWindowSize.Y
            if current.CanvasPosition.Y < y and y <= var6 then
                current.CanvasPosition = Vector2.new(0, y)
            end
        end
    end

    function arg1.onSwipeScrollingFrameCanvasPositionChanged()
        if not arg1.isMounted then
            return
        end

        local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current
        local canvasPositionY = current.CanvasPosition.Y
        if canvasPositionY ~= math.floor(canvasPositionY) then
            if not bool1 then
                if GetFFlagPreventSuperBriefPeekViewClose() then
                    local y = math.floor(canvasPositionY + 0.5)

                    if arg1.viewType == PeekViewState.SuperBrief and arg1.props.minimizeToSuperBrief then
                        local superBriefViewY = arg1.getSuperBriefViewY()
                        if superBriefViewY ~= nil and y ~= nil and y < superBriefViewY then
                            y = superBriefViewY
                        end
                    end

                    current.CanvasPosition = Vector2.new(0, y)
                else
                    current.CanvasPosition = Vector2.new(0, math.floor(canvasPositionY + 0.5))
                end
            end
            if arg1.props.peekHeaderPositionYChange then
                arg1.props.peekHeaderPositionYChange(canvasPositionY)
            end
            if not bool1 then
                return
            end
        end

        arg1.reconcileRbxInstances("onSwipeScrollingFrameCanvasPositionChanged")
        if arg1.state.lastInputGroup ~= InputTypeConstants.Gamepad then
            arg1.checkGoTo()
        end
    end

    function arg1.getBriefViewY()
        local absoluteSizeY = if bool2 then arg1.props.containerFrameRef.current.AbsoluteSize.Y else arg1.containerFrameRef.current.AbsoluteSize.Y
        local briefViewContentHeight = arg1.props.briefViewContentHeight
        return absoluteSizeY * briefViewContentHeight.Scale + briefViewContentHeight.Offset + 25
    end

    function arg1.getSuperBriefViewY()
        if bool2 then
            if not (arg1.props.superBriefViewContentHeight and arg1.props.containerFrameRef:getValue()) then
                return nil
            end
        elseif not (arg1.props.superBriefViewContentHeight and arg1.containerFrameRef:getValue()) then
            return nil
        end

        local absoluteSizeY = if bool2 then arg1.props.containerFrameRef:getValue().AbsoluteSize.Y else arg1.containerFrameRef:getValue().AbsoluteSize.Y
        local superBriefViewContentHeight = arg1.props.superBriefViewContentHeight
        return absoluteSizeY * superBriefViewContentHeight.Scale + superBriefViewContentHeight.Offset + 25
    end

    function arg1.getFullViewY()
        return arg1.containerFrameRef.current.AbsoluteSize.Y * arg1.props.fullViewContentHeight.Scale + arg1.props.fullViewContentHeight.Offset
    end

    function arg1.transitionCallbacks()
        local briefToFullTransitionPercent = arg1.props.briefToFullTransitionPercent

        local canvasPositionY = (if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current).CanvasPosition.Y
        local briefViewY = arg1.getBriefViewY()
        local fullViewY = if bool2 then arg1.props.getFullViewY() else arg1.getFullViewY()
        local var6 = fullViewY - briefViewY
        local num1 = 0
        if briefViewY < canvasPositionY and canvasPositionY <= fullViewY then
            num1 = (canvasPositionY - briefViewY) / var6
        elseif fullViewY < canvasPositionY then
            num1 = 1
        end

        arg1.setTransitionPercent(num1)

        if briefToFullTransitionPercent then
            briefToFullTransitionPercent(num1)
        end
    end

    function arg1.checkGoTo()
        if arg1.isInGoToState or arg1.isTouched then
            return
        end

        local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current

        if current and arg1.state.absoluteWindowSizeX == 0 and arg1.state.absoluteWindowSizeY == 0 then
            return
        end

        local briefViewY = arg1.getBriefViewY()
        local superBriefViewY = arg1.getSuperBriefViewY()
        local fullViewY = if bool2 then arg1.props.getFullViewY() else arg1.getFullViewY()

        if fullViewY < briefViewY
            or superBriefViewY and briefViewY < superBriefViewY
            or current.AbsoluteWindowSize.Y + 25 + arg1.props.bottomDockedContainerHeight > (current.AbsoluteCanvasSize.Y or current.CanvasSize.Y.Offset)
        then
            return
        end

        local scrollVelocityY = current.ScrollVelocity.Y
        local bool4 = scrollVelocityY < 0
        local bool5 = scrollVelocityY > 0
        local canvasPositionY = current.CanvasPosition.Y
        local bool6 = arg1.viewType == PeekViewState.Brief and canvasPositionY == briefViewY
        local bool7 = arg1.viewType == PeekViewState.Full and canvasPositionY == fullViewY

        if (bool6 or bool7) and scrollVelocityY == 0 then
            return
        end

        if fullViewY < canvasPositionY then
            arg1:handleCurYAboveFullViewY(bool4)
            return
        end

        if briefViewY < canvasPositionY and canvasPositionY <= fullViewY then
            arg1:handleCurYFromBriefToFull(canvasPositionY, scrollVelocityY, bool4, bool5)
            return
        end
        if not superBriefViewY then
            if canvasPositionY <= briefViewY then
                arg1:handleCurYFromClosedToBrief(canvasPositionY, bool5, bool4)
            end

            return
        end

        if superBriefViewY < canvasPositionY and canvasPositionY <= briefViewY then
            arg1:handleCurYFromSuperBriefToBrief(canvasPositionY, superBriefViewY, scrollVelocityY, bool4, bool5)
            return
        end

        if canvasPositionY <= superBriefViewY then
            arg1:handleCurYFromClosedToSuperBrief(canvasPositionY, superBriefViewY, scrollVelocityY, bool5, bool4)
        end
    end

    function arg1.onPeekHeaderActivated()
        if arg1.viewType == Closed then
            arg1.goTo(Brief)
            return
        end

        if arg1.viewType == Brief then
            arg1.goTo(Full)
            return
        end

        if arg1.viewType == SuperBrief then
            arg1.goTo(Brief)
            return
        end

        if arg1.viewType ~= Full then
            return
        end

        if arg1.props.peekHeaderClose then
            arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.handleTap })
            return
        end

        arg1.goTo(Brief)
    end

    function arg1.setViewType(viewType, arg2)
        if arg1.goToAnimationConnection then
            arg1.goToAnimationConnection:disconnect()
            arg1.goToAnimationConnection = nil
        end
        arg1.isInGoToState = false
        arg1.clipFrameRef.current.Active = false

        local viewType2 = arg1.viewType
        if viewType2 ~= viewType then
            arg1.viewType = viewType
            local scrollableViewType = arg1.viewType == Extended or arg1.viewType == Full
            arg1:setState({ scrollableViewType = scrollableViewType })

            local viewStateChanged = arg1.props.viewStateChanged
            if viewStateChanged then
                viewStateChanged(viewType, viewType2, arg2 or {})
            end
        end

        arg1.updateSwipeScrollingFrame()
    end

    function arg1.goTo(viewType, arg2, arg3, arg4)
        if arg1.viewType == viewType
            or ArgCheck.isEqual(arg1.isInGoToState, false, "self.isInGoToState")
            or ArgCheck.isEqual(arg1.goToAnimationConnection, nil, "self.goToAnimationConnection")
        then
            return
        end

        arg1.isInGoToState = true
        if bool2 then
            arg1.props.swipeScrollingFrameRef:getValue().ScrollVelocity = Vector2.new(0, 0)
        else
            arg1.swipeScrollingFrameRef:getValue().ScrollVelocity = Vector2.new(0, 0)
        end
        arg1.clipFrameRef.current.Active = true

        if arg2 == false then
            arg1.setViewType(viewType, arg4)

            if viewType == Full then
                arg1:adjustScrollingFramePosition()
            end

            return
        end

        local startTime = tick()

        if arg3 then
            if viewType ~= Closed then
                arg1.setViewType(viewType, arg4)

                if viewType == Full then
                    arg1:adjustScrollingFramePosition()
                end
            end

            arg1:setState({ canvasGroupTransparency = if viewType == Closed then 0 else 1 })

            arg1.goToAnimationConnection = RunService.RenderStepped:Connect(function()
                if not arg1.isMounted then
                    return
                end
                if viewType == Full then
                    arg1.updateSwipeScrollingFrame()
                end

                local var6 = tick() - startTime

                if not (var6 >= 0.35) then
                    arg1:setState({ canvasGroupTransparency = if viewType == Closed then var6 / 0.35 else 1 - var6 / 0.35 })

                    return
                end

                arg1:setState({ canvasGroupTransparency = if viewType == Closed then 1 else 0 })

                arg1.setViewType(viewType, arg4)

                if viewType == Full then
                    arg1:adjustScrollingFramePosition()
                end
            end)

            return
        end

        arg1:setState({ canvasGroupTransparency = if viewType == Closed then 1 else 0 })

        arg1.goToAnimationConnection = RunService.RenderStepped:Connect(function()
            if not arg1.isMounted then
                return
            end

            local var6 = tick() - startTime
            if viewType == Brief and not (var2 <= var6) then
                return
            end

            if bool2 then
                arg1.props.swipeScrollingFrameRef:getValue().ScrollVelocity = Vector2.new(0, 0)
            else
                arg1.swipeScrollingFrameRef:getValue().ScrollVelocity = Vector2.new(0, 0)
            end

            local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current
            local absoluteSizeY = if bool2 then arg1.props.containerFrameRef.current.AbsoluteSize.Y else arg1.containerFrameRef.current.AbsoluteSize.Y
            local var7 = ArgCheck.isNotNil(arg1.getViewSize(viewType), "self.goTo.viewSize")
            local var8 = absoluteSizeY * var7.Scale + var7.Offset
            if viewType == Brief then
                var6 -= var2
            end

            if var6 >= 0.35 then
                arg1.setViewType(viewType, arg4)

                if viewType == Full then
                    arg1:adjustScrollingFramePosition()
                end
                return
            end

            local canvasPositionY = current.CanvasPosition.Y
            local var9 = var8 - canvasPositionY
            current.CanvasPosition = Vector2.new(0, canvasPositionY + var9 * math.sin(var6 * 2.468394227820552))
        end)
    end

    arg1.selectedCoreObjectConnection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):connect(function()
        if bool2 then
            if arg1.props.swipeScrollingFrameRef.current and arg1.state.lastInputGroup == InputTypeConstants.Gamepad then
                arg1:adjustScrollingFramePosition()
            end
        elseif arg1.swipeScrollingFrameRef.current and arg1.state.lastInputGroup == InputTypeConstants.Gamepad then
            arg1:adjustScrollingFramePosition()
        end
    end)
end

function var3.handleCurYAboveFullViewY(arg1, arg2)
    if arg1.viewType ~= Full and arg1.viewType ~= Extended then
        if arg2 then
            arg1.goTo(Full)
            return
        end
        arg1.setViewType(Extended)
        return
    end
    if arg1.viewType == Full then
        arg1.setViewType(Extended)
    end
end

function var3.handleCurYFromBriefToFull(arg1, arg2, arg3, arg4, arg5)
    local canDragFullViewToBrief = arg1.props.canDragFullViewToBrief
    local minimizeToSuperBrief = arg1.props.minimizeToSuperBrief
    local value = if bool2 then arg1.props.swipeScrollingFrameRef:getValue() else arg1.swipeScrollingFrameRef:getValue()
    local briefViewY = arg1.getBriefViewY()

    local var4 = (if bool2 then arg1.props.getFullViewY() else arg1.getFullViewY()) - briefViewY
    if arg1.viewType == Full then
        if value.AbsoluteCanvasSize.Y - value.AbsoluteWindowSize.Y - 1 < arg2 then
            return
        end

        if arg5 or arg2 < briefViewY + var4 * 0.8 then
            local var5 = arg5 and arg3 > 500
            if canDragFullViewToBrief and (not var5 or minimizeToSuperBrief) then
                arg1.goTo(Brief)
                return
            end
            arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.swipe })
        end
    elseif arg1.viewType == Extended then
        if not arg5 or arg2 < briefViewY + var4 * 0.8 or arg3 > -1 then
            arg1.goTo(Full)
        end
    else
        if arg4 or briefViewY + var4 * 0.2 < arg2 then
            arg1.goTo(Full)
            return
        end
        arg1.goTo(Brief)
    end
end

function var3.handleCurYFromSuperBriefToBrief(arg1, arg2, arg3, arg4, arg5, arg6)
    local canDragFullViewToBrief = arg1.props.canDragFullViewToBrief
    local minimizeToSuperBrief = arg1.props.minimizeToSuperBrief

    local var4 = (if bool2 then arg1.props.getFullViewY() else arg1.getFullViewY()) - arg3
    if arg1.viewType == Full then
        if arg6 or arg2 < arg3 + var4 * 0.8 then
            local var5 = arg6 and arg4 > 500
            if canDragFullViewToBrief and (not var5 or minimizeToSuperBrief) then
                arg1.goTo(SuperBrief)
                return
            end
            arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.swipe })
            return
        end

        arg1.goTo(Brief)
        return
    end
    if arg1.viewType == Extended then
        if not arg6 or arg2 < arg3 + var4 * 0.8 or arg4 > -1 then
            arg1.goTo(Brief)
        end

        return
    end

    if arg5 or arg3 + var4 * 0.2 < arg2 then
        arg1.goTo(Brief)
        return
    end
    local var5 = arg6 and arg4 > 500
    if canDragFullViewToBrief and (not var5 or minimizeToSuperBrief) then
        arg1.goTo(SuperBrief)
        return
    end
    arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.swipe })
end

function var3.handleCurYFromClosedToSuperBrief(arg1, arg2, arg3, arg4, arg5, arg6)
    local var4 = arg3 - 0
    local minimizeToSuperBrief = arg1.props.minimizeToSuperBrief
    if arg1.viewType == SuperBrief then
        if (arg5 or arg2 < var4 * 0.8) and not minimizeToSuperBrief then
            arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.swipe })
            return
        end

        arg1.goTo(SuperBrief)
    elseif not (arg5 and arg4 > 500) and (arg6 or var4 * 0.8 < arg2) or minimizeToSuperBrief then
        arg1.goTo(SuperBrief)
    else
        arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.swipe })
    end
end

function var3.handleCurYFromClosedToBrief(arg1, arg2, arg3, arg4)
    local var4 = arg1.getBriefViewY() - 0
    if arg1.viewType == Brief then
        if arg3 or arg2 < 0 + var4 * 0.8 then
            arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.swipe })
            return
        end

        arg1.goTo(Brief)
    elseif arg4 or 0 + var4 * 0.2 < arg2 then
        arg1.goTo(Brief)
    else
        arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.swipe })
    end
end

function var3.adjustScrollingFramePosition(arg1)
    local selectedCoreObject = GuiService.SelectedCoreObject
    if not (selectedCoreObject
        and arg1.props.contentFrameRef
        and selectedCoreObject:IsDescendantOf(arg1.props.contentFrameRef.current)) then
        return
    end

    local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current

    if arg1.viewType ~= Extended and arg1.viewType ~= Full then
        local var4 = ArgCheck.isNotNil(arg1.getViewSize(arg1.viewType), "self.adjustScrollingFramePosition.viewSize")
        current.CanvasPosition = Vector2.new(current.CanvasPosition.X, var4.Offset)
        return
    end
    local var4 = selectedCoreObject.AbsolutePosition.Y - arg1.props.topBarHeight
    local absoluteSizeY = selectedCoreObject.AbsoluteSize.Y
    local absoluteWindowSizeY = current.AbsoluteWindowSize.Y
    local var5 = absoluteWindowSizeY - (var4 + absoluteSizeY)
    local canvasPositionY = current.CanvasPosition.Y
    if var5 < arg1.props.bottomDockedContainerHeight then
        absoluteWindowSizeY = canvasPositionY + arg1.props.bottomDockedContainerHeight - var5
    elseif not (var4 + absoluteSizeY + (canvasPositionY - absoluteWindowSizeY) < absoluteWindowSizeY - arg1.props.bottomDockedContainerHeight) then
        absoluteWindowSizeY = canvasPositionY
    end

    local y = math.max(
        0,
        math.min(
            absoluteWindowSizeY,
            (current.AbsoluteCanvasSize.Y or current.CanvasSize.Y.Offset) - current.AbsoluteWindowSize.Y
        )
    )
    current.CanvasPosition = Vector2.new(current.CanvasPosition.X, y)
end

function var3.handleThumbstickInput(arg1, arg2, arg3)
    local position = arg2.Position
    local value = arg1.swipeScrollingFrameRef:getValue()
    if not arg1.containerFrameRef:getValue() or not value then
        return
    end

    local y = value.CanvasPosition.Y + arg3 * -GamepadUtils.normalizeStickByDeadzone(position).Y * 1000
    if arg1.getFullViewY() < y then
        value.CanvasPosition = Vector2.new(0, y)
    end
end

function var3.renderWithStyle(arg1, arg2)
    local prop = arg1.props[Roact.Children]

    local bottomDockedContainerHeight = arg1.props.bottomDockedContainerHeight
    local bottomDockedContainerContent = arg1.props.bottomDockedContainerContent
    local scrollableViewType = arg1.props.thumbstickScrollEnabled and arg1.state.scrollableViewType

    local backgroundContrastColor = arg2.Theme.BackgroundContrast.Color

    local var4 = FFlagProfilePlatformNewProfileHeader and not arg1.props.hasSolidDragger
    local var5, var6

    if FFlagProfilePlatformPeekDraggerContrast then
        local draggerImageStyle = arg1.props.draggerImageStyle
        if draggerImageStyle then
            var5 = draggerImageStyle.Color3
        else
            var5 = arg2.Theme.UIEmphasis.Color
        end

        if draggerImageStyle then
            var6 = draggerImageStyle.Transparency
        else
            var6 = arg2.Theme.UIEmphasis.Transparency
        end
    else
        var5 = arg2.Theme.UIEmphasis.Color
        var6 = arg2.Theme.UIEmphasis.Transparency
    end

    local function getDraggerTransparency()
        local current = if bool2 then arg1.props.swipeScrollingFrameRef.current else arg1.swipeScrollingFrameRef.current

        if not current then
            return var6
        end

        local canvasPositionY = current.CanvasPosition.Y
        local briefViewY = arg1.getBriefViewY()
        local fullViewY = if bool2 then arg1.props.getFullViewY() else arg1.getFullViewY()
        local num1 = math.max(0, math.min(1, (canvasPositionY - briefViewY) / (fullViewY - briefViewY)))
        return var6 + num1 * (1 - var6)
    end

    local imageTransparency = if var4 then getDraggerTransparency() else var6
    local createElement = Roact.createElement
    local str1 = "TextButton"
    local tbl2 = {
        Text = "",
        LayoutOrder = 3,
        ZIndex = 3,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 25),
        [Roact.Event.Activated] = arg1.onPeekHeaderActivated,
        Selectable = false
    }
    local tbl3 = { Dragger = 0 }
    local element

    if arg1.props.hideDraggerInSuperBrief and arg1.props.peekViewState == SuperBrief then
        element = nil
    else
        element = Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 36, 0, 36),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Image = iconsNavigationSwipe,
            ImageColor3 = var5,
            ImageTransparency = imageTransparency,
            Active = false
        })
    end

    tbl3.Dragger = element
    local peekHeader = createElement(str1, tbl2, tbl3)

    local createElement2 = Roact.createElement
    local frame = Focusable.Frame

    local tbl4 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        [Roact.Ref] = arg1.clipFrameRef,
        restorePreviousChildFocus = true,
        inputBindings = not bool2 and scrollableViewType and {
            ScrollPeekView = RoactGamepad.Input.onStep(Enum.KeyCode.Thumbstick2, function(arg3, arg4)
                arg1:handleThumbstickInput(arg3, arg4)
            end)
        } or nil
    }

    local tbl5 = { SwipeScrollingFrame = 0, BottomContainer = 0 }
    local createElement3 = Roact.createElement
    local str2 = "ScrollingFrame"
    local tbl6 = {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Selectable = false,
        CanvasSize = UDim2.fromScale(1, 0),
        Active = true,
        BackgroundTransparency = 1,
        ZIndex = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        ClipsDescendants = false,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ElasticBehavior = arg1.props.elasticBehavior,
        ScrollingEnabled = arg1.props.isScrollingEnabled,
        [Roact.Ref] = if bool2 then arg1.props.swipeScrollingFrameRef else arg1.swipeScrollingFrameRef,
        [Roact.Change.CanvasPosition] = arg1.onSwipeScrollingFrameCanvasPositionChanged,
        [Roact.Change.AbsoluteWindowSize] = arg1.onAbsoluteWindowSizeChanged,
        [Roact.Change.AbsoluteCanvasSize] = if FFlagPeekViewFixBriefHeightLayoutRace then arg1.onAbsoluteCanvasSizeChanged else nil
    }

    local tbl7 = {
        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0, 0),
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        FillingArea = Roact.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Active = false,
                [Roact.Ref] = arg1.fillingAreaRef
            }
        ),
        BackgroundFrame = 0,
        PeekHeader = 0,
        ContentFrame = 0,
        BottomContainerPlaceHolder = 0
    }
    local createElement4 = Roact.createElement
    local str3 = "Frame"
    local tbl8 = {
        LayoutOrder = 2,
        ZIndex = 1,
        Size = UDim2.new(1, 0, 0, 0),
        Active = false
    }
    local tbl9 = { BackgroundImage = 0 }
    local createElement5 = Roact.createElement
    local var8 = ImageSetLabel
    local tbl10 = {
        Size = UDim2.new(1, 0, 0, 9999),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = rect,
        BackgroundColor3 = 0,
        Active = false
    }

    if arg1.props.customBackground then
        backgroundContrastColor = arg1.props.customBackground
    end

    tbl10.BackgroundColor3 = backgroundContrastColor
    tbl9.BackgroundImage = createElement5(var8, tbl10)
    tbl7.BackgroundFrame = createElement4(str3, tbl8, tbl9)

    tbl7.PeekHeader = if FFlagProfilePlatformNewProfileHeader and not arg1.props.hasSolidDragger then nil else peekHeader

    local createElement6 = Roact.createElement
    local frame2 = Focusable.Frame
    local tbl11 = {
        LayoutOrder = 4,
        ZIndex = 2,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        [Roact.Ref] = arg1.props.contentFrameRef,
        restorePreviousChildFocus = true
    }

    function tbl11.onFocusGained()
        if arg1.viewType == Brief and arg1.props.peekViewState ~= Full then
            arg1.goTo(Full)
        end
    end

    tbl7.ContentFrame = createElement6(
        frame2,
        tbl11,
        FFlagProfilePlatformNewProfileHeader
            and not arg1.props.hasSolidDragger
            and {
                PeekHeader = peekHeader,
                Content = Roact.createElement(
                    "Frame",
                    {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y
                    },
                    prop
                )
            }
            or prop
    )

    tbl7.BottomContainerPlaceHolder = bottomDockedContainerHeight > 0
        and Roact.createElement(
            "Frame",
            {
                LayoutOrder = 5,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, bottomDockedContainerHeight),
                Active = false
            }
        )
    tbl5.SwipeScrollingFrame = createElement3(str2, tbl6, tbl7)
    local element3 = bottomDockedContainerHeight > 0
        and Roact.createElement("Frame", {
            Active = true,
            ZIndex = 2,
            Size = UDim2.new(1, 0, 0, bottomDockedContainerHeight),
            BackgroundTransparency = 1,
            [Roact.Ref] = arg1.bottomContainerRef
        }, bottomDockedContainerContent)
    tbl5.BottomContainer = element3
    local element2_2 = createElement2(frame, tbl4, tbl5)

    local createFragment = Roact.createFragment
    local tbl12 = {
        DropShadowBackground = Roact.createElement(
            "Frame",
            {
                ZIndex = 0,
                Visible = arg1.props.showDropShadow,
                [Roact.Ref] = arg1.shadowRef
            },
            {
                UIGradient = Roact.createElement("UIGradient", {
                    Rotation = 90,
                    Color = ColorSequence.new(
                        { ColorSequenceKeypoint.new(0, arg2.Theme.DropShadow.Color), ColorSequenceKeypoint.new(1, arg2.Theme.DropShadow.Color) }
                    ),
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.7) })
                })
            }
        ),
        ClipFrameContainer = if arg1.props.shouldCaptureFocus then Roact.createElement(
            FocusNavigableSurfaceWrapper,
            {
                surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.PeekView,
                isIsolated = true
            },
            { ClipFrame = element2_2 }
        ) else nil,
        ClipFrame = 0,
        InputBegan = 0,
        InputEnded = 0
    }

    if arg1.props.shouldCaptureFocus then
        element2_2 = nil
    end

    tbl12.ClipFrame = element2_2
    tbl12.InputBegan = Roact.createElement(
        ExternalEventConnection,
        {
            event = UserInputService.InputBegan,
            callback = arg1.inputBeganCallback
        }
    )
    tbl12.InputEnded = Roact.createElement(
        ExternalEventConnection,
        {
            event = UserInputService.InputEnded,
            callback = arg1.inputEndedCallback
        }
    )
    return createFragment(tbl12)
end

function var3.render(arg1)
    return arg1.withStyle(function(arg2)
        local var4 = if arg1.useReducedMotion then Roact.createElement(
            "CanvasGroup",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                GroupTransparency = arg1.state.canvasGroupTransparency
            },
            { arg1:renderWithStyle(arg2) }
        ) else arg1:renderWithStyle(arg2)

        if not arg1.props.hasScrim then
            return Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ClipsDescendants = false,
                [Roact.Ref] = if bool2 then arg1.props.containerFrameRef else arg1.containerFrameRef,
                [Roact.Change.AbsoluteSize] = arg1.onContainerFrameAbsoluteSizeChanged
            }, var4)
        end

        local createElement = Roact.createElement
        local var5 = Scrim
        local tbl2 = {
            [Roact.Ref] = if bool2 then arg1.props.containerFrameRef else arg1.containerFrameRef
        }

        function tbl2.onActivated()
            if arg1.isInGoToState then
                return
            end

            arg1.goTo(Closed, nil, nil, { dismissMethod = peekViewDismissedEvent.dismissMethodEnum.scrimTap })
        end

        tbl2.onSizeChanged = arg1.onContainerFrameAbsoluteSizeChanged
        return createElement(var5, tbl2, var4)
    end)
end

function var3.didMount(arg1)
    arg1.isMounted = true

    if arg1.props.closeSignal then
        arg1.closeSignalConnection = arg1.props.closeSignal:connect(function()
            if not arg1.isInGoToState then
                arg1.goTo(Closed, true, arg1.useReducedMotion)
            end
        end)
    end

    local hidden = arg1.props.hidden

    local mountAsFullView = arg1.props.mountAsFullView
    local mountAnimation = arg1.props.mountAnimation
    local stateOnMount = if GetFFlagEnablePeekViewStateOnMountParam() then arg1.props.stateOnMount else nil

    if not hidden then
        if mountAsFullView then
            arg1.goTo(Full, mountAnimation, arg1.useReducedMotion)
        elseif stateOnMount ~= nil then
            arg1.goTo(stateOnMount, mountAnimation, arg1.useReducedMotion)
        else
            arg1.goTo(Brief, mountAnimation, arg1.useReducedMotion)
        end
    end

    arg1:setState({ lastInputGroup = getInputGroup(UserInputService:GetLastInputType()) })
    UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
        arg1:setState({ lastInputGroup = getInputGroup(lastInputType) })
    end)
end

function var3.isAnimating(arg1): boolean
    return arg1.goToAnimationConnection ~= nil
end

function var3.didUpdate(arg1, arg2, arg3)
    if arg3.absoluteWindowSizeX ~= arg1.state.absoluteWindowSizeX
        or arg3.absoluteWindowSizeY ~= arg1.state.absoluteWindowSizeY
    then
        arg1.reconcileRbxInstances("didUpdate")

        if not arg1:isAnimating() then
            arg1.updateSwipeScrollingFrame()
        end
    end

    if arg2.bottomDockedContainerHeight ~= arg1.props.bottomDockedContainerHeight then
        arg1.onContainerFrameAbsoluteSizeChanged()
    end
    if arg2.briefViewContentHeight ~= arg1.props.briefViewContentHeight and not arg1:isAnimating() then
        arg1.updateSwipeScrollingFrame()
    end

    if arg2.hidden == false and arg1.props.hidden == true then
        arg1.goTo(Hidden)
    elseif arg2.hidden == true and arg1.props.hidden == false then
        arg1.goTo(Brief)
    end

    local peekViewState = arg1.props.peekViewState

    local isInGoToState = arg1.isInGoToState

    if peekViewState ~= arg2.peekViewState
        and arg1.viewType == arg2.peekViewState
        and peekViewState ~= Extended
        and not isInGoToState
    then
        arg1.goTo(arg1.props.peekViewState)
    end
end

function var3.willUnmount(arg1)
    arg1.isMounted = false

    if arg1.closeSignalConnection then
        arg1.closeSignalConnection:disconnect()
        arg1.closeSignalConnection = nil
    end

    if arg1.goToAnimationConnection then
        arg1.goToAnimationConnection:disconnect()
        arg1.goToAnimationConnection = nil
    end

    if arg1.selectedCoreObjectConnection then
        arg1.selectedCoreObjectConnection:disconnect()
        arg1.selectedCoreObjectConnection = nil
    end
end

local function PeekViewContainer(arg1)
    local var4 = React.useRef(nil)
    if arg1.scrollingFrameRef then
        var4 = arg1.scrollingFrameRef
    end
    local containerFrameRef = React.useRef(nil)
    local fullViewContentHeight = if arg1.fullViewContentHeight then arg1.fullViewContentHeight else UDim.new(1, 0)

    local getFullViewY = React.useCallback(function()
        return containerFrameRef.current.AbsoluteSize.Y * fullViewContentHeight.Scale + fullViewContentHeight.Offset
    end, { fullViewContentHeight, containerFrameRef })

    local var8 = React.useCallback(function(arg2, num1: number)
        local position = arg2.Position
        local value = var4:getValue()

        if not containerFrameRef:getValue() or not value then
            return
        end

        local y = value.CanvasPosition.Y + num1 * -GamepadUtils.normalizeStickByDeadzone(position).Y * 1000

        if getFullViewY() < y then
            value.CanvasPosition = Vector2.new(0, y)
        end
    end, { getFullViewY, var4, containerFrameRef })

    usePeekViewFocusNavigationBindings(var8)

    return React.createElement(
        var3,
        Cryo.Dictionary.join(arg1, {
            swipeScrollingFrameRef = var4,
            containerFrameRef = containerFrameRef,
            fullViewContentHeight = fullViewContentHeight,
            getFullViewY = getFullViewY
        })
    )
end

var3 = RoactRodux.connect(function(arg1, _) -- name: mapStateToProps
    return {
        topBarHeight = arg1.TopBar and arg1.TopBar.topBarHeight or 0
    }
end, nil)(var3)

return if bool2 then PeekViewContainer else var3
