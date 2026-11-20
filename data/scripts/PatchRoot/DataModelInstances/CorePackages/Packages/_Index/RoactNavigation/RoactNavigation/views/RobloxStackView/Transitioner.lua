-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local React = require(scriptParentParentParentParent.React)
local Otter = require(scriptParentParentParentParent.Otter)
local ScenesReducer = require(script.Parent.ScenesReducer)
local invariant = require(scriptParentParentParent.utils.invariant)

local tbl1 = { frequency = 4 }

local function buildTransitionProps(arg1, arg2)
    local navigation = arg1.navigation
    local options = arg1.options

    local layout = arg2.layout
    local position = arg2.position
    local scenes = arg2.scenes

    local var1 = nil
    for _, value in scenes do
        if value.isActive then
            var1 = value
            break
        end
    end

    invariant(var1, "Could not find active scene")

    return {
        layout = layout,
        navigation = navigation,
        position = position,
        scenes = scenes,
        scene = var1,
        options = options,
        index = var1.index
    }
end

local function filterStale(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = Array.filter(arg1, function(arg2): boolean
        return not arg2.isStale
    end)

    return if #var1 == #arg1 then arg1 else var1
end

local var1 = React.Component:extend("Transitioner")

function var1.init(arg1)
    local state = arg1.props.navigation.state
    local descriptors = arg1.props.descriptors

    arg1._ref = React.createRef()

    arg1.state = {
        layout = { initWidth = 0, initHeight = 0, isMeasured = false },
        position = Otter.createSingleMotor(state.index),
        scenes = ScenesReducer({}, state, nil, descriptors)
    }

    function arg1._doOnAbsoluteSizeChanged(...)
        return arg1:_onAbsoluteSizeChanged(...)
    end

    arg1._positionLastValue = state.index

    arg1._prevTransitionProps = nil
    arg1._transitionProps = buildTransitionProps(arg1.props, arg1.state)

    arg1._isMounted = false
    arg1._isTransitionRunning = false
    arg1._transitionQueue = {}

    arg1._completeSignalDisconnector = arg1.state.position:onComplete(function()
        if arg1._isMounted then
            arg1:_onTransitionEnd()
        end
    end)

    arg1._stepSignalDisconnector = arg1.state.position:onStep(function(arg2)
        if arg1._isMounted then
            arg1:_onPositionStep(arg2)
        end
    end)
end

function var1.didMount(arg1)
    arg1._isMounted = true
end

function var1.willUnmount(arg1)
    arg1._isMounted = false

    if arg1._completeSignalDisconnector then
        arg1._completeSignalDisconnector()
        arg1._completeSignalDisconnector = nil
    end

    if arg1._stepSignalDisconnector then
        arg1._stepSignalDisconnector()
        arg1._stepSignalDisconnector = nil
    end
end

function var1.didUpdate(arg1, prevProps)
    if not arg1.state.layout.isMeasured and arg1._ref.current then
        arg1:_onAbsoluteSizeChanged(arg1._ref.current)
    end

    if arg1.props == prevProps then
        return
    end

    if not arg1._isTransitionRunning then
        arg1:_startTransition(prevProps, arg1.props)
        return
    end

    if (arg1._transitionQueue[#arg1._transitionQueue] or {}).prevProps ~= prevProps then
        table.insert(arg1._transitionQueue, { prevProps = prevProps })
    end
end

function var1.render(arg1)
    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClipsDescendants = false,
            [React.Change.AbsoluteSize] = arg1._doOnAbsoluteSizeChanged,
            ref = arg1._ref
        },
        {
            TransitionerScenes = arg1.props.render(arg1._transitionProps, arg1._prevTransitionProps, arg1)
        }
    )
end

function var1._onAbsoluteSizeChanged(arg1, arg2)
    if not arg1._isMounted then
        return
    end

    local absoluteSizeX = arg2.AbsoluteSize.X
    local absoluteSizeY = arg2.AbsoluteSize.Y

    if absoluteSizeX == arg1.state.layout.initWidth and absoluteSizeY == arg1.state.layout.initHeight then
        return
    end

    local layout = Object.assign(
        table.clone(arg1.state.layout),
        { initWidth = absoluteSizeX, initHeight = absoluteSizeY, isMeasured = true }
    )

    local var3 = Object.assign(table.clone(arg1.state), { layout = layout })

    arg1._transitionProps = buildTransitionProps(arg1.props, var3)

    arg1:setState({ layout = layout })
end

function var1._computeScenes(arg1, arg2, arg3)
    local var2 = ScenesReducer(arg1.state.scenes, arg3.navigation.state, arg2.navigation.state, arg3.descriptors)

    if not arg3.navigation.state.isTransitioning then
        var2 = filterStale(var2)
    end

    if arg3.screenProps ~= arg1.props.screenProps then
        arg1:setState({ scenes = var2 })
    end

    return if var2 == arg1.state.scenes then nil else var2
end

function var1._startTransition(arg1, arg2, arg3)
    local bool1 = arg2.navigation.state.index ~= arg3.navigation.state.index
    local scenes = arg1:_computeScenes(arg2, arg3)

    if not scenes then
        arg1._prevTransitionProps = arg1._transitionProps

        if arg1._isTransitionRunning then
            arg1:_onTransitionEnd()
        end

        return
    end

    local var3 = Object.assign(table.clone(arg1.state), { scenes = scenes })

    local position = var3.position
    local index = arg3.navigation.state.index

    arg1._prevTransitionProps = arg1._transitionProps
    arg1._transitionProps = buildTransitionProps(arg3, var3)
    local isTransitioning = arg1._transitionProps.navigation.state.isTransitioning

    if isTransitioning and bool1 then
        arg1._isTransitionRunning = true
    end

    arg1:setState(var3, function()
        if not (isTransitioning and bool1) then
            if arg3.onTransitionStart then
                arg3.onTransitionStart(arg1._transitionProps, arg1._prevTransitionProps)
            end

            position:setGoal(Otter.instant(index))

            return
        end

        if arg3.onTransitionStart then
            arg3.onTransitionStart(arg1._transitionProps, arg1._prevTransitionProps)
        end

        if arg1._positionLastValue == index then
            position:setGoal(Otter.instant(arg3.navigation.state.index))
            return
        end

        local var4 = not arg3.configureTransition and {} or arg3.configureTransition(arg1._transitionProps, arg1._prevTransitionProps) or {}

        local var5 = Object.assign(table.clone(tbl1), var4)

        position:setGoal(Otter.spring(arg3.navigation.state.index, var5))
    end)
end

function var1._onTransitionEnd(arg1)
    local _prevTransitionProps = arg1._prevTransitionProps
    arg1._prevTransitionProps = nil

    local scenes = filterStale(arg1.state.scenes)

    local var3 = Object.assign(table.clone(arg1.state), { scenes = scenes })

    arg1._transitionProps = buildTransitionProps(arg1.props, var3)

    arg1:setState(var3, function()
        if arg1.props.onTransitionEnd then
            arg1.props.onTransitionEnd(arg1._transitionProps, _prevTransitionProps)
        end

        local var4 = arg1._transitionQueue[1]
        if not var4 then
            arg1._isTransitionRunning = false

            return
        end

        local prevProps = var4.prevProps

        arg1._transitionQueue = table.clone(arg1._transitionQueue)
        table.remove(arg1._transitionQueue, 1)
        arg1:_startTransition(prevProps, arg1.props)
    end)
end

function var1._onPositionStep(arg1, _positionLastValue)
    arg1._positionLastValue = _positionLastValue

    local index = arg1._transitionProps.index
    local var2 = if arg1._prevTransitionProps then arg1._prevTransitionProps.index else index

    if arg1.props.onTransitionStep and var2 ~= index then
        local var3 = (_positionLastValue - var2) / (index - var2)
        arg1.props.onTransitionStep(arg1._transitionProps, arg1._prevTransitionProps, var3)
    end
end

return var1
