-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local lerp = require(scriptParentParentParent.utils.lerp)

local var1 = React.Component:extend("StackViewOverlayFrame")

function var1.init(arg1)
    arg1._signalDisconnect = nil

    arg1._ref = React.createRef()
end

function var1.render(arg1)
    local navigationOptions = arg1.props.navigationOptions
    local initialTransitionValue = arg1.props.initialTransitionValue

    local backgroundTransparency = lerp(1, navigationOptions.overlayTransparency, initialTransitionValue)

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = navigationOptions.overlayColor3,
        BackgroundTransparency = backgroundTransparency,
        BorderSizePixel = 0,
        ref = arg1._ref
    })
end

function var1.didUpdate(arg1, arg2)
    local transitionChangedSignal = arg1.props.transitionChangedSignal

    if transitionChangedSignal == arg2.transitionChangedSignal then
        return
    end

    if arg1._signalDisconnect then
        arg1._signalDisconnect()
    end

    arg1._signalDisconnect = transitionChangedSignal(function(...)
        arg1:_transitionChanged(...)
    end)
end

function var1.didMount(arg1)
    arg1._isMounted = true
    arg1._signalDisconnect = arg1.props.transitionChangedSignal(function(...)
        arg1:_transitionChanged(...)
    end)
end

function var1.willUnmount(arg1)
    arg1._isMounted = false
    if arg1._signalDisconnect then
        arg1._signalDisconnect()
        arg1._signalDisconnect = nil
    end
end

function var1._transitionChanged(arg1, arg2)
    if not arg1._isMounted then
        return
    end

    if arg1._ref.current then
        local navigationOptions = arg1.props.navigationOptions
        local backgroundTransparency = lerp(1, navigationOptions.overlayTransparency, arg2)
        arg1._ref.current.BackgroundTransparency = backgroundTransparency
    end
end

return var1
