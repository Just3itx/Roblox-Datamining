-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent

local Object = require(scriptParentParentParentParent.LuauPolyfill).Object
local React = require(scriptParentParentParentParent.React)
local StackPresentationStyle = require(scriptParent.StackPresentationStyle)
local StackViewTransitionConfigs = require(scriptParent.StackViewTransitionConfigs)
local StackViewOverlayFrame = require(scriptParent.StackViewOverlayFrame)
local StackViewCard = require(scriptParent.StackViewCard)
local SceneView = require(scriptParentParent.SceneView)

local tbl1 = {
    absorbInput = true,
    absorbInputSelectable = true,
    overlayEnabled = false,
    overlayColor3 = Color3.new(0, 0, 0),
    overlayTransparency = 0.7,
    renderOverlay = function(navigationOptions, initialTransitionValue, transitionChangedSignal)
        return React.createElement(StackViewOverlayFrame, {
            navigationOptions = navigationOptions,
            initialTransitionValue = initialTransitionValue,
            transitionChangedSignal = transitionChangedSignal
        })
    end,
    transparent = false
}

local function calculateTransitionValue(index, arg1): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.max(math.min(1 + arg1 - index, 1), 0)
end

local var1 = React.Component:extend("StackViewLayout")

function var1.init(arg1)
    arg1:setState({})
    local index = arg1.props.transitionProps.navigation.state.index

    arg1._isMounted = false
    arg1._positionLastValue = index

    function arg1._renderScene(arg2)
        return arg1:_renderInnerScene(arg2)
    end

    function arg1._subscribeToOverlayUpdates(callback)
        local position = arg1.props.transitionProps.position
        local index2 = arg1.props.transitionProps.scene.index

        return position:onStep(function(arg2)
            callback((calculateTransitionValue(index2, arg2)))
        end)
    end
end

function var1._renderCard(arg1, scene, arg2)
    local transitionProps = arg1.props.transitionProps
    local lastTransitionProps = arg1.props.lastTransitionProps
    local transitionConfig = arg1.state.transitionConfig

    local cardColor3 = arg2.cardColor3
    local overlayEnabled = arg2.overlayEnabled
    local transparent = arg2.transparent

    local index = transitionProps.scene.index
    if lastTransitionProps then
        index = lastTransitionProps.scene.index
    end

    local screenInterpolator = transitionConfig.screenInterpolator
    local var2 = not screenInterpolator and {}
        or screenInterpolator(Object.assign(table.clone(transitionProps), { initialPositionValue = index, scene = scene }))

    local createElement = React.createElement
    local var3 = StackViewCard
    local assign = Object.assign
    local var4 = table.clone(transitionProps)
    local tbl2 = {
        key = "card_" .. tostring(scene.key),
        scene = scene,
        renderScene = arg1._renderScene,
        cardColor3 = 0
    }

    if overlayEnabled or transparent then
        cardColor3 = nil
    end

    tbl2.cardColor3 = cardColor3
    return createElement(var3, assign(var4, var2, tbl2))
end

function var1._renderInnerScene(arg1, arg2)
    local navigation = arg2.descriptor.navigation

    local component = arg2.descriptor.getComponent()
    local screenProps = arg1.props.screenProps

    return React.createElement(SceneView, { screenProps = screenProps, navigation = navigation, component = component })
end

function var1.render(arg1)
    local transitionProps = arg1.props.transitionProps
    local topMostOpaqueSceneIndex = arg1.state.topMostOpaqueSceneIndex

    local tbl2 = {}

    for _, value in transitionProps.scenes do
        local bool1 = value.index < topMostOpaqueSceneIndex and not value.isActive
        local var2 = if value.descriptor.options then Object.assign(table.clone(tbl1), value.descriptor.options) else table.clone(tbl1)
        local overlayEnabled = var2.overlayEnabled
        local absorbInput = var2.absorbInput
        local absorbInputSelectable = var2.absorbInputSelectable
        local renderOverlay = var2.renderOverlay
        local element = if overlayEnabled then React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                BorderSizePixel = 0,
                ZIndex = 1
            },
            {
                Overlay = renderOverlay(var2, calculateTransitionValue(value.index, arg1._positionLastValue), arg1._subscribeToOverlayUpdates)
            }
        ) else nil
        local element2 = if bool1 or not absorbInput then nil else React.createElement("TextButton", {
            Active = true,
            Selectable = absorbInputSelectable,
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Text = " ",
            ZIndex = 2 * value.index - 1
        })
        local createElement = React.createElement
        local fragment = React.Fragment
        local tbl3 = { AbsorbInput = element2 }

        local str1 = tostring(value.index)
        local createElement2 = React.createElement
        local tbl4 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClipsDescendants = false,
            ZIndex = 2 * value.index,
            Visible = not bool1
        }
        local tbl5 = {
            StationaryContent = element,
            DynamicContent = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    ClipsDescendants = false,
                    BorderSizePixel = 0,
                    ZIndex = 2
                },
                {
                    ["card_" .. value.key] = arg1:_renderCard(value, var2)
                }
            )
        }
        tbl3[str1] = createElement2("Frame", tbl4, tbl5)
        local element3 = createElement(fragment, {}, tbl3)

        local key = value.key
        tbl2[tostring(key)] = element3
    end

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = false,
            BorderSizePixel = 0
        },
        tbl2
    )
end

function var1.getDerivedStateFromProps(arg1, _)
    local transitionProps = arg1.transitionProps
    local scenes = transitionProps.scenes
    local isTransitioning = transitionProps.navigation.state.isTransitioning
    local scenesLen = #scenes

    local bool1 = arg1.mode == StackPresentationStyle.Modal or arg1.mode == StackPresentationStyle.Overlay

    local num1 = 0

    for i = scenesLen, 1, -1 do
        local var2 = scenes[i]
        local var3 = if var2.descriptor.options then Object.assign(table.clone(tbl1), var2.descriptor.options) else table.clone(tbl1)

        if not (var3.transparent or bool1 and var3.overlayEnabled) and (not isTransitioning or i ~= scenesLen) then
            num1 = i
            break
        end
    end

    return {
        topMostOpaqueSceneIndex = num1,
        transitionConfig = StackViewTransitionConfigs.getTransitionConfig(
            arg1.transitionConfig,
            arg1.transitionProps,
            arg1.lastTransitionProps,
            arg1.mode
        )
    }
end

function var1.didMount(arg1)
    arg1._isMounted = true

    arg1._positionDisconnector = arg1.props.transitionProps.position:onStep(function(...)
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
    local position = arg1.props.transitionProps.position

    if position ~= arg2.transitionProps.position then
        arg1._positionDisconnector()
        arg1._positionDisconnector = position:onStep(function(...)
            arg1:_onPositionStep(...)
        end)
    end
end

function var1._onPositionStep(arg1, _positionLastValue)
    if arg1._isMounted then
        arg1._positionLastValue = _positionLastValue
    end
end

return var1
