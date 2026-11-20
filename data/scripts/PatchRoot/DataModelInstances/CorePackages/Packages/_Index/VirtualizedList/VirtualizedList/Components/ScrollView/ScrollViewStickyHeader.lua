-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout

local tbl1 = {
    new = function(...)
        return nil
    end
}

local tbl2 = {
    new = function(...)
        return nil
    end
}

local React = require(scriptParentParentParentParent.React)

local StyleSheet = require(scriptParentParentParent.StyleSheet.StyleSheet)

local var1 = nil

local var2 = React.Component:extend("ScrollViewStickyHeader")
function var2.init(arg1, props)
    warn("ScrollViewStickyHeader not fully implemented")
    arg1.props = props
    arg1.state = {
        measured = false,
        layoutY = 0,
        layoutHeight = 0,
        nextHeaderLayoutY = arg1.props.nextHeaderLayoutY,
        translateY = nil
    }

    arg1._translateY = nil
    arg1._shouldRecreateTranslateY = true
    arg1._haveReceivedInitialZeroTranslateY = true

    arg1._debounceTimeout = 64

    function arg1.setNextHeaderY(_, nextHeaderLayoutY: number)
        arg1._shouldRecreateTranslateY = true
        arg1.setState({ nextHeaderLayoutY = nextHeaderLayoutY })
    end

    function arg1._onLayout(_, arg2)
        local y = arg2.nativeEvent.layout.y
        local height = arg2.nativeEvent.layout.height

        if y ~= arg1.state.layoutY or height ~= arg1.state.layoutHeight or arg1.state.measured ~= true then
            arg1._shouldRecreateTranslateY = true
        end
        arg1:setState({ measured = true, layoutY = y, layoutHeight = height })
        arg1.props:onLayout(arg2)
        local var3 = React.Children.only(arg1.props.children)
        if var3.props.onLayout then
            var3.props:onLayout(arg2)
        end
    end

    function arg1._setComponentRef(_, _ref)
        arg1._ref = _ref
    end
end

function var2.componentWillUnmount(arg1)
    if arg1._translateY ~= nil and arg1._animatedValueListenerId ~= nil then
        arg1._translateY:removeListener(arg1._animatedValueListenerId)
    end
    if Boolean.toJSBoolean(arg1._timer) then
        clearTimeout(arg1._timer)
    end
end

function var2.UNSAFE_componentWillReceiveProps(arg1, arg2)
    if arg2.scrollViewHeight ~= arg1.props.scrollViewHeight
        or arg2.scrollAnimatedValue ~= arg1.props.scrollAnimatedValue
        or arg2.inverted ~= arg1.props.inverted
    then
        arg1._shouldRecreateTranslateY = true
    end
end

function var2.updateTranslateListener(tbl3, translateY, bool1: boolean, arg1)
    if tbl3._translateY ~= nil and tbl3._animatedValueListenerId ~= nil then
        tbl3._translateY:removeListener(tbl3._animatedValueListenerId)
    end
    tbl3.translateY = if Boolean.toJSBoolean(arg1) then tbl1.new(translateY, arg1) else translateY

    tbl3._shouldRecreateTranslateY = false

    if not bool1 then
        return
    end

    if not tbl3._animatedValueListener then
        function tbl3._animatedValueListener(arg2)
            local value = arg2.value

            if value == 0 and not tbl3._haveReceivedInitialZeroTranslateY then
                tbl3._haveReceivedInitialZeroTranslateY = true
                return
            end
            if Boolean.toJSBoolean(tbl3._timer) then
                clearTimeout(tbl3._timer)
            end
            tbl3._timer = setTimeout(function()
                if value ~= tbl3.state.translateY then
                    tbl3:setState({ translateY = value })
                end
            end, tbl3._debounceTimeout)
        end
    end
    if tbl3.state.translateY ~= 0 and tbl3.state.translateY ~= nil then
        tbl3._haveReceivedInitialZeroTranslateY = false
    end
    tbl3._animatedValueListenerId = translateY:addListener(tbl3._animatedValueListener)
end

function var2.render(arg1)
    local var3 = arg1._ref
        and arg1._ref._internalInstanceHandle
        and arg1._ref._internalInstanceHandle.stateNode
        and Boolean.toJSBoolean(arg1._ref._internalInstanceHandle.stateNode.canonical)

    if arg1._shouldRecreateTranslateY then
        local inverted = arg1.props.inverted
        local scrollViewHeight = arg1.props.scrollViewHeight

        local measured = arg1.state.measured
        local layoutHeight = arg1.state.layoutHeight
        local layoutY = arg1.state.layoutY
        local nextHeaderLayoutY = arg1.state.nextHeaderLayoutY
        local inputRange = { -1, 0 }
        local outputRange = { 0, 0 }
        if measured then
            if inverted then
                if scrollViewHeight ~= nil then
                    local var4 = layoutY + layoutHeight - scrollViewHeight
                    if var4 > 0 then
                        table.insert(inputRange, var4)
                        table.insert(outputRange, 0)
                        table.insert(inputRange, var4 + 1)
                        table.insert(outputRange, 1)

                        local var5 = (nextHeaderLayoutY or 0) - layoutHeight - scrollViewHeight
                        if var4 < var5 then
                            table.insert(inputRange, var5)
                            table.insert(inputRange, var5 + 1)
                            table.insert(outputRange, var5 - var4)
                            table.insert(outputRange, var5 - var4)
                        end
                    end
                end
            else
                table.insert(inputRange, layoutY)
                table.insert(outputRange, 0)

                local var4 = (nextHeaderLayoutY or 0) - layoutHeight
                if layoutY <= var4 then
                    table.insert(inputRange, var4)
                    table.insert(inputRange, var4 + 1)
                    table.insert(outputRange, var4 - layoutY)
                    table.insert(outputRange, var4 - layoutY)
                else
                    table.insert(inputRange, layoutY + 1)
                    table.insert(outputRange, 1)
                end
            end
        end

        local var4 = arg1.props.scrollAnimatedValue:interpolate({ inputRange = inputRange, outputRange = outputRange })
        local var5 = if arg1.props.hiddenOnScroll then tbl2.new(
            arg1.props.scrollAnimatedValue:interpolate(
                {
                    extrapolateLeft = "clamp",
                    inputRange = { layoutY, layoutY + 1 },
                    outputRange = { 0, 1 }
                }
            ):interpolate(
                {
                    inputRange = { 0, 1 },
                    outputRange = { 0, -1 }
                }
            ),
            -arg1.state.layoutHeight,
            0
        ) else nil
        arg1:updateTranslateListener(var4, var3, var5)
    end

    local var4 = React.Children.only(arg1.props.children)

    local passthroughAnimatedPropExplicitValues = var3 and arg1.state.translateY ~= nil and {
        style = {
            transform = {{
                translateY = arg1.state.translateY
            }}
        }
    } or nil

    return React.createElement("AnimatedView", {
        collapsable = false,
        nativeID = arg1.props.nativeID,
        onLayout = arg1._onLayout,
        ref = arg1._setComponentRef,
        style = {
            var4.props.style,
            var1.header,
            {
                transform = {{
                    translateY = arg1._translateY
                }}
            }
        },
        passthroughAnimatedPropExplicitValues = passthroughAnimatedPropExplicitValues
    }, React.cloneElement(var4, { style = var1.fill, onLayout = nil }))
end

var1 = StyleSheet.create({ header = { zIndex = 10, position = "relative" }, fill = { flex = 1 } })

return var2
