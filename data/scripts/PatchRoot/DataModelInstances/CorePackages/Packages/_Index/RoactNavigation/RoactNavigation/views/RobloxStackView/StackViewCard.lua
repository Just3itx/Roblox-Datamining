-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local invariant = require(scriptParentParentParent.utils.invariant)

local var1 = React.Component:extend("StackViewCard")

function var1.init(arg1)
    local index = arg1.props.navigation.state.index

    arg1._isMounted = false
    arg1._positionLastValue = index

    arg1._ref = React.createRef()
end

function var1.render(arg1)
    local forceHidden = arg1.props.forceHidden
    local cardColor3 = arg1.props.cardColor3
    local initialPosition = arg1.props.initialPosition
    local renderScene = arg1.props.renderScene
    local scene = arg1.props.scene

    invariant(type(renderScene) == "function", "renderScene must be a function")

    return React.createElement("Frame", {
        Position = initialPosition,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = cardColor3,
        BackgroundTransparency = if cardColor3 == nil then 1 else nil,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        Visible = not forceHidden,
        ref = arg1._ref
    }, {
        Content = renderScene(scene)
    })
end

function var1.didMount(arg1)
    arg1._isMounted = true

    arg1._positionDisconnector = arg1.props.position:onStep(function(...)
        arg1:_onPositionStep(...)
    end)
end

function var1.willUnmount(arg1)
    arg1._isMounted = false

    if arg1._positionDisconnector then
        arg1._positionDisconnector()
        arg1._positionDisconnector = nil
    end
end

function var1.didUpdate(arg1, arg2)
    local position = arg1.props.position
    local positionStep = arg1.props.positionStep

    if position ~= arg2.position then
        arg1._positionDisconnector()
        arg1._positionDisconnector = position:onStep(function(...)
            arg1:_onPositionStep(...)
        end)
    end

    if positionStep ~= arg2.positionStep then
        arg1:_onPositionStep(arg1._positionLastValue)
    end
end

function var1._onPositionStep(arg1, _positionLastValue)
    if not arg1._isMounted then
        return
    end

    local positionStep = arg1.props.positionStep

    if positionStep then
        positionStep(arg1._ref, _positionLastValue)
    end

    arg1._positionLastValue = _positionLastValue
end

return var1
