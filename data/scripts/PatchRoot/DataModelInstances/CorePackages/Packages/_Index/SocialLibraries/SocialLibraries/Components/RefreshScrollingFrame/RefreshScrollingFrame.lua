-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local Otter = dependencies.Otter
local t = dependencies.t
local Cryo = dependencies.Cryo
local withStyle = UIBlox.Style.withStyle
local getIconSize = UIBlox.App.ImageSet.getIconSize

local ExternalEventConnection = require(script.Parent.ExternalEventConnection)
local Spinner = require(script.Parent.Spinner)

local iconSize = getIconSize(UIBlox.App.ImageSet.Enum.IconSize.Medium)

local tbl1 = { dampingRatio = 1, frequency = 3.5 }

local function lerp(num1: number, num2: number, arg1): number -- Luacid: Inlined by compiler; 3 call sites recovered
    arg1 = math.min(1, math.max(0, arg1))

    return num1 * (1 - arg1) + num2 * arg1
end

local var1 = Roact.PureComponent:extend("RefreshScrollingFrameNew")

var1.defaultProps = {
    ScrollingElement = "ScrollingFrame",
    refreshThreshold = 52,
    scrollingElementProps = {}
}

local interface = t.interface
local tbl2 = {
    ScrollingElement = t.union(t.string, t.callback, t.table),
    scrollingElementProps = t.optional(t.table),
    refreshThreshold = t.number,
    forwardRef = t.optional(t.table),
    onCanvasPositionChangedCallback = t.optional(t.callback),
    onStatusBarTapped = t.optional(t.callback),
    refresh = t.optional(t.callback),
    usesBuilderIcon = t.optional(t.boolean),
    [Roact.Children] = t.optional(t.any)
}
var1.validateProps = interface(tbl2)

function var1.init(arg1)
    arg1.state = { isRefreshing = false }

    arg1.startHeight = 0

    arg1.isUserInteracting = false

    local forwardRef = arg1.props.forwardRef

    local bool1 = type(forwardRef) ~= "function"
    local str1 = tostring(var1)
    assert(bool1, ("%s does not support function ref forwarding"):format(str1))

    arg1.scrollingFrameRef = forwardRef or Roact.createRef()
    arg1.spinnerFrameRef = Roact.createRef()
    arg1.spinnerRef = Roact.createRef()

    function arg1.updateSpinner(yOffset: number?)
        if not arg1.spinnerFrameRef.current then
            return
        end

        arg1.spinnerFrameRef.current.Size = UDim2.new(1, 0, 0, yOffset)
        local var2 = yOffset / arg1.props.refreshThreshold
        if arg1.props.usesBuilderIcon then
            arg1.spinnerRef.current.TextTransparency = lerp(1, 0, var2)
        else
            arg1.spinnerRef.current.ImageTransparency = lerp(1, 0, var2)
        end

        if not arg1.state.isRefreshing then
            arg1.spinnerRef.current.Rotation = lerp(-240, 0, var2)
        end
    end

    arg1.motor = Otter.createSingleMotor(0)
    arg1.motor:onStep(arg1.updateSpinner)

    function arg1.resetSpinner()
        arg1.motor:setGoal(Otter.spring(0, tbl1))
    end

    function arg1.scrollBack()
        if not arg1.scrollingFrameRef.current then
            return
        end

        if UserGameSettings.ReducedMotion then
            arg1.scrollingFrameRef.current.CanvasPosition = Vector2.new(0, 0)
            return
        end
        arg1.scrollingFrameRef.current:ScrollToTop()
    end

    function arg1.dispatchRefresh()
        local refresh = arg1.props.refresh
        local refreshThreshold = arg1.props.refreshThreshold
        local isRefreshing = arg1.state.isRefreshing

        if refresh == nil then
            return
        end

        if isRefreshing then
            return
        end

        arg1:setState({ isRefreshing = true })

        arg1.motor:setGoal(Otter.spring(refreshThreshold, tbl1))

        local function onRefreshComplete()
            if arg1.isMounted then
                arg1:setState({ isRefreshing = false })

                arg1.resetSpinner()
            end
        end

        refresh():andThen(onRefreshComplete, onRefreshComplete)
    end

    function arg1.onInputBegan(_)
        if not arg1.isUserInteracting then
            arg1.startHeight = arg1.scrollingFrameRef.current.CanvasPosition.Y
        end

        arg1.isUserInteracting = true
    end

    function arg1.onInputEnded(_)
        arg1.isUserInteracting = false

        local startHeight = arg1.startHeight
        arg1.startHeight = 0

        if arg1.props.refresh == nil or not arg1.scrollingFrameRef.current then
            return
        end

        local var2 = -arg1.scrollingFrameRef.current.CanvasPosition.Y
        if arg1.props.refreshThreshold < var2 and startHeight < var2 then
            arg1.dispatchRefresh()
        elseif var2 > 0 then
            arg1.resetSpinner()
        end
    end

    function arg1.statusBarTapCallback()
        if arg1.props.onStatusBarTapped then
            arg1.props.onStatusBarTapped()
        end
        arg1.scrollBack()
    end

    function arg1.onCanvasPositionChanged(arg2)
        if arg1.props.onCanvasPositionChangedCallback ~= nil then
            arg1.props.onCanvasPositionChangedCallback(arg2)
        end

        if arg1.props.refresh == nil or not arg1.isUserInteracting or arg1.state.isRefreshing then
            return
        end

        local var2 = -arg2.CanvasPosition.Y
        local refreshThreshold = arg1.props.refreshThreshold

        if var2 >= 0 and var2 <= refreshThreshold then
            arg1.motor:setGoal(Otter.instant(var2))
        end
    end

    function arg1.onCanvasSizeChanged(arg2)
        if arg1.props.onCanvasSizeChangedCallback ~= nil then
            arg1.props.onCanvasSizeChangedCallback(arg2)
        end
    end
end

function var1.didMount(arg1)
    arg1.isMounted = true
    arg1.resetSpinner()
end

function var1.willUnmount(arg1)
    arg1.isMounted = false

    arg1.motor:destroy()
    arg1.motor = nil
end

function var1.render(arg1)
    local prop = arg1.props[Roact.Children]
    local isRefreshing = arg1.state.isRefreshing

    return withStyle(function(_)
        local createElement = Roact.createElement
        local scrollingElement = arg1.props.ScrollingElement
        local var2 = Cryo.Dictionary.join({
            [Roact.Change.CanvasPosition] = arg1.onCanvasPositionChanged,
            [Roact.Change.CanvasSize] = arg1.onCanvasSizeChanged,
            [Roact.Ref] = arg1.scrollingFrameRef
        }, arg1.props.scrollingElementProps)
        local tbl3 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            SpinnerFrame = 0,
            Content = 0,
            inputBegan = 0,
            inputEnded = 0,
            statusBarTapped = 0
        }
        local createElement2 = Roact.createElement
        local tbl4 = {
            Size = UDim2.new(1, 0, 0, 0),
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            ClipsDescendants = false,
            [Roact.Ref] = arg1.spinnerFrameRef
        }
        local tbl5 = {
            Spinner = Roact.createElement(Spinner, {
                Size = UDim2.new(0, iconSize, 0, iconSize),
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, 0),
                isSpinning = isRefreshing,
                [Roact.Ref] = arg1.spinnerRef
            })
        }
        tbl3.SpinnerFrame = createElement2("Frame", tbl4, tbl5)

        tbl3.Content = Roact.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, 0, 1, 0)
            },
            prop
        )
        tbl3.inputBegan = Roact.createElement(ExternalEventConnection, { event = UserInputService.InputBegan, callback = arg1.onInputBegan })

        tbl3.inputEnded = Roact.createElement(ExternalEventConnection, { event = UserInputService.InputEnded, callback = arg1.onInputEnded })

        tbl3.statusBarTapped = Roact.createElement(
            ExternalEventConnection,
            {
                event = UserInputService.StatusBarTapped,
                callback = arg1.statusBarTapCallback
            }
        )
        return createElement(scrollingElement, var2, tbl3)
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
