-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local console = LuauPolyfill.console
local setTimeout = LuauPolyfill.setTimeout

local HttpService = game:GetService("HttpService")

local tbl1 = {
    Value = {
        new = function(...)
            return {
                setOffset = function(_, _) end,
                interpolate = function(_, ...) end
            }
        end
    },
    attachNativeEvent = function(...)
        return nil
    end
}

local tbl2 = {
    get = function(...)
        return { height = 100 }
    end
}

local var1 = nil
var1 = {
    OS = "roblox",
    select = function(arg1)
        return arg1[var1.OS]
    end
}

local React = require(scriptParentParentParentParent.React)

local tbl3 = {
    findNodeHandle = function(...)
        return nil
    end
}

local ScrollViewStickyHeader = require(script.Parent.ScrollViewStickyHeader)
local StyleSheet = require(scriptParentParentParent.StyleSheet.StyleSheet)

local View = require(script.Parent.Parent.View.View)

local tbl4 = {
    measureLayout = function(...) end
}

local tbl5 = {
    addListener = function(...)
        return nil
    end
}

local tbl6 = {
    beginScroll = function(...)
        warn("FrameRateLogger.beginScroll not implemented")
    end,
    endScroll = function(...)
        warn("FrameRateLogger.endScroll not implemented")
    end
}

local tbl7 = {
    blurTextInput = function(...)
        warn("TextInputState.blurTextInput not implemented")
    end,
    currentlyFocusedInput = function(...)
        warn("TextInputState.currentlyFocusedInput not implemented")
        return nil
    end,
    isTextInput = function(...)
        warn("TextInputState.isTextInput not implemented")
        return nil
    end
}

local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
    warn("dismissKeyboard not implemented")
end

local function _<T>(arg1: T): T -- Luacid: unused: defined but never referenced
    return arg1
end

local invariant = require(scriptParentParentParent.jsUtils.invariant)
local processDecelerationRate = require(script.Parent.processDecelerationRate)

local function func2(style) -- Luacid: Inlined by compiler; 1 call site recovered
    return { outer = style, inner = style }
end

local setAndForwardRef = require(script.Parent.Parent.Parent.Utilities.setAndForwardRef)

local ScrollViewContext = require(script.Parent.ScrollViewContext)
local default = ScrollViewContext.default
local HORIZONTAL = ScrollViewContext.HORIZONTAL
local VERTICAL = ScrollViewContext.VERTICAL
local _ScrollViewStickyHeader = require(script.Parent.ScrollViewStickyHeader)

local default2 = require(script.Parent.ScrollViewCommands).default

local ScrollContentViewNativeComponent = require(script.Parent.ScrollContentViewNativeComponent)
local ScrollViewNativeComponent = require(script.Parent.ScrollViewNativeComponent)

local var2 = nil

local var3 = var1.OS == "android"
    and {
        NativeHorizontalScrollViewTuple = { "Frame", "Frame" },
        NativeVerticalScrollViewTuple = { ScrollViewNativeComponent, View }
    }
    or {
        NativeHorizontalScrollViewTuple = {
            ScrollViewNativeComponent,
            ScrollContentViewNativeComponent
        },
        NativeVerticalScrollViewTuple = {
            ScrollViewNativeComponent,
            ScrollContentViewNativeComponent
        }
    }

local NativeHorizontalScrollViewTuple = var3.NativeHorizontalScrollViewTuple
local NativeVerticalScrollViewTuple = var3.NativeVerticalScrollViewTuple

local var4 = React.Component:extend("ScrollView")
var4.Context = default

function var4.init(getScrollResponder, props)
    getScrollResponder.props = props

    getScrollResponder._scrollAnimatedValueAttachment = nil
    getScrollResponder._stickyHeaderRefs = Map.new()
    getScrollResponder._headerLayoutYs = Map.new()

    getScrollResponder._keyboardWillOpenTo = nil
    getScrollResponder._additionalScrollOffset = 0
    getScrollResponder._isTouching = false
    getScrollResponder._lastMomentumScrollBeginTime = 0
    getScrollResponder._lastMomentumScrollEndTime = 0

    getScrollResponder._observedScrollSinceBecomingResponder = false
    getScrollResponder._becameResponderWhileAnimating = false
    getScrollResponder._preventNegativeScrollOffset = nil

    getScrollResponder._animated = nil

    getScrollResponder._subscriptionKeyboardWillShow = nil
    getScrollResponder._subscriptionKeyboardWillHide = nil
    getScrollResponder._subscriptionKeyboardDidShow = nil
    getScrollResponder._subscriptionKeyboardDidHide = nil

    getScrollResponder.state = { layoutHeight = nil }
    getScrollResponder._listLayoutRef = React.createRef()

    getScrollResponder._setNativeRef = setAndForwardRef({
        getForwardedRef = function()
            return getScrollResponder.props.scrollViewRef
        end,
        setLocalRef = function(_scrollViewRef)
            getScrollResponder._scrollViewRef = _scrollViewRef

            if _scrollViewRef ~= nil then
                _scrollViewRef.getScrollResponder = getScrollResponder.getScrollResponder
                _scrollViewRef.getScrollableNode = getScrollResponder.getScrollableNode
                _scrollViewRef.getInnerViewNode = getScrollResponder.getInnerViewNode
                _scrollViewRef.getInnerViewRef = getScrollResponder.getInnerViewRef
                _scrollViewRef.getNativeScrollRef = getScrollResponder.getNativeScrollRef
                _scrollViewRef.scrollTo = getScrollResponder.scrollTo
                _scrollViewRef.scrollToEnd = getScrollResponder.scrollToEnd
                _scrollViewRef.flashScrollIndicators = getScrollResponder.flashScrollIndicators
                _scrollViewRef.scrollResponderZoomTo = getScrollResponder.scrollResponderZoomTo
                _scrollViewRef.scrollResponderScrollNativeHandleToKeyboard = getScrollResponder.scrollResponderScrollNativeHandleToKeyboard
            end

            return nil
        end
    })

    function getScrollResponder.getScrollResponder()
        return getScrollResponder
    end

    function getScrollResponder.getScrollableNode()
        return tbl3:findNodeHandle(getScrollResponder._scrollViewRef)
    end

    function getScrollResponder.getInnerViewNode()
        return tbl3:findNodeHandle(getScrollResponder._innerViewRef)
    end

    function getScrollResponder.getInnerViewRef()
        return getScrollResponder._innerViewRef
    end

    function getScrollResponder.getNativeScrollRef()
        return getScrollResponder._scrollViewRef
    end

    function getScrollResponder.scrollTo(arg2)
        local x, y, animated

        if arg2 == nil then
            x = nil
            y = nil
            animated = nil
        else
            y = arg2.y
            x = arg2.x
            animated = arg2.animated
        end

        if getScrollResponder._scrollViewRef == nil or getScrollResponder._scrollViewRef._nativeRef.current == nil then
            return
        end

        default2.scrollTo(
            getScrollResponder._scrollViewRef,
            Boolean.toJSBoolean(x) and x or 0,
            Boolean.toJSBoolean(y) and y or 0,
            not not animated
        )
    end

    function getScrollResponder.scrollToEnd(arg2)
        local bool1 = (not (arg2 == nil) and arg2.animated) ~= false
        if getScrollResponder._scrollViewRef == nil then
            return
        end
        default2.scrollToEnd(getScrollResponder._scrollViewRef, bool1)
    end

    function getScrollResponder.flashScrollIndicators()
        if getScrollResponder._scrollViewRef == nil then
            return
        end
        default2.flashScrollIndicators(getScrollResponder._scrollViewRef)
    end

    function getScrollResponder.scrollResponderScrollNativeHandleToKeyboard(arg2, num1: number?, bool1: boolean?)
        getScrollResponder._additionalScrollOffset = Boolean.toJSBoolean(num1) and num1 or 0
        getScrollResponder._preventNegativeScrollOffset = Boolean.toJSBoolean(bool1)

        if getScrollResponder._innerViewRef == nil then
            return
        end

        if typeof(arg2) == "number" then
            tbl4:measureLayout(
                arg2,
                tbl3:findNodeHandle(getScrollResponder),
                getScrollResponder._textInputFocusError,
                getScrollResponder._inputMeasureAndScrollToKeyboard
            )
        else
            arg2:measureLayout(
                getScrollResponder._innerViewRef,
                getScrollResponder._inputMeasureAndScrollToKeyboard,
                getScrollResponder._textInputFocusError
            )
        end
    end

    function getScrollResponder.scrollResponderZoomTo(tbl8, bool1: boolean?)
        invariant(var1.OS == "ios", "zoomToRect is not implemented")
        if Array.indexOf(Object.keys(tbl8), "animated") ~= -1 then
            getScrollResponder._animated = tbl8.animated
            tbl8.animated = nil
        elseif typeof(bool1) ~= "nil" then
            console.warn("`scrollResponderZoomTo` `animated` argument is deprecated. Use `options.animated` instead")
        end

        if getScrollResponder._scrollViewRef == nil then
            return
        end
        default2.zoomToRect(getScrollResponder._scrollViewRef, tbl8, bool1 ~= false)
    end

    function getScrollResponder._inputMeasureAndScrollToKeyboard(_: number, num1: number, _: number, num2: number)
        local height = tbl2:get("window").height
        local function scrollTextInputIntoVisibleRect()
            if getScrollResponder._keyboardWillOpenTo ~= nil then
                height = getScrollResponder._keyboardWillOpenTo.endCoordinates.screenY
            end
            local var5 = num1 - height + num2 + getScrollResponder._additionalScrollOffset

            if getScrollResponder._preventNegativeScrollOffset == true then
                var5 = math.max(0, var5)
            end
            getScrollResponder.scrollTo({ x = 0, y = var5, animated = true })

            getScrollResponder._additionalScrollOffset = 0
            getScrollResponder._preventNegativeScrollOffset = false
        end

        if getScrollResponder._keyboardWillOpenTo == nil then
            setTimeout(function()
                scrollTextInputIntoVisibleRect()
            end, 0)
        else
            scrollTextInputIntoVisibleRect()
        end
    end

    function getScrollResponder._handleScroll(arg2)
        if _G.__DEV__
            and getScrollResponder.props.onScroll
            and getScrollResponder.props.scrollEventThrottle == nil
            and var1.OS == "ios"
        then
            console.log(
                "You specified `onScroll` on a <ScrollView> but not `scrollEventThrottle`. You will only receive one event. Using `16` you get all the events but be aware that it may cause frame drops, use a bigger number if you don't need as much precision."
            )
        end

        getScrollResponder._observedScrollSinceBecomingResponder = true
        if getScrollResponder.props.onScroll then
            getScrollResponder.props.onScroll(arg2)
        end
    end

    function getScrollResponder._handleLayout(arg2)
        if getScrollResponder.props.invertStickyHeaders == true then
            getScrollResponder:setState({ layoutHeight = arg2.AbsoluteWindowSize.Y })
        end
        if getScrollResponder.props.onLayout then
            getScrollResponder.props.onLayout(arg2)
        end
    end

    function getScrollResponder._overrideAutomaticCanvasSize(xOffset: number?, yOffset: number?)
        if getScrollResponder._scrollViewRef == nil then
            return
        end

        local current = getScrollResponder._scrollViewRef._nativeRef.current
        if current == nil then
            return
        end

        if getScrollResponder.props.AutomaticCanvasSize == Enum.AutomaticSize.XY
            or getScrollResponder.props.AutomaticCanvasSize == nil
        then
            current.CanvasSize = UDim2.new(0, xOffset, 0, yOffset)
        elseif getScrollResponder.props.AutomaticCanvasSize == Enum.AutomaticSize.X then
            current.CanvasSize = UDim2.new(0, xOffset, 0, current.AbsoluteCanvasSize.Y)
        elseif getScrollResponder.props.AutomaticCanvasSize == Enum.AutomaticSize.Y then
            current.CanvasSize = UDim2.new(0, current.AbsoluteCanvasSize.X, 0, yOffset)
        end
    end

    function getScrollResponder._handleContentOnLayout(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        local absoluteSizeY = arg2.AbsoluteSize.Y
        if getScrollResponder.props.overrideAutomaticCanvasSize then
            getScrollResponder._overrideAutomaticCanvasSize(absoluteSizeX, absoluteSizeY)
        end

        if getScrollResponder.props.onContentSizeChange then
            getScrollResponder.props.onContentSizeChange(absoluteSizeX, absoluteSizeY)
        end
    end

    getScrollResponder._scrollViewRef = nil

    getScrollResponder._innerViewRef = nil
    getScrollResponder._setInnerViewRef = setAndForwardRef({
        getForwardedRef = function()
            return getScrollResponder.props.innerViewRef
        end,
        setLocalRef = function(_innerViewRef)
            getScrollResponder._innerViewRef = _innerViewRef

            return nil
        end
    })

    function getScrollResponder.scrollResponderKeyboardWillShow(_keyboardWillOpenTo)
        getScrollResponder._keyboardWillOpenTo = _keyboardWillOpenTo
        if getScrollResponder.props.onKeyboardWillShow then
            getScrollResponder.props.onKeyboardWillShow(_keyboardWillOpenTo)
        end
    end

    function getScrollResponder.scrollResponderKeyboardWillHide(arg2)
        getScrollResponder._keyboardWillOpenTo = nil
        if getScrollResponder.props.onKeyboardWillHide then
            getScrollResponder.props.onKeyboardWillHide(arg2)
        end
    end

    function getScrollResponder.scrollResponderKeyboardDidShow(_keyboardWillOpenTo)
        if Boolean.toJSBoolean(_keyboardWillOpenTo) then
            getScrollResponder._keyboardWillOpenTo = _keyboardWillOpenTo
        end
        if getScrollResponder.props.onKeyboardDidShow then
            getScrollResponder.props.onKeyboardDidShow(_keyboardWillOpenTo)
        end
    end

    function getScrollResponder.scrollResponderKeyboardDidHide(arg2)
        getScrollResponder._keyboardWillOpenTo = nil
        if getScrollResponder.props.onKeyboardDidHide then
            getScrollResponder.props.onKeyboardDidHide(arg2)
        end
    end

    function getScrollResponder._handleMomentumScrollBegin(arg2)
        getScrollResponder._lastMomentumScrollBeginTime = os.clock() * 1000
        if getScrollResponder.props.onMomentumScrollBegin then
            getScrollResponder.props.onMomentumScrollBegin(arg2)
        end
    end

    function getScrollResponder._handleMomentumScrollEnd(arg2)
        tbl6:endScroll()
        getScrollResponder._lastMomentumScrollEndTime = os.clock() * 1000
        if getScrollResponder.props.onMomentumScrollEnd then
            getScrollResponder.props.onMomentumScrollEnd(arg2)
        end
    end

    function getScrollResponder._handleScrollBeginDrag(arg2)
        tbl6:beginScroll()
        if var1.OS == "android" and getScrollResponder.props.keyboardDismissMode == "on-drag" then
            func1()
        end

        if getScrollResponder.props.onScrollBeginDrag then
            getScrollResponder.props.onScrollBeginDrag(arg2)
        end
    end

    function getScrollResponder._handleScrollEndDrag(arg2, arg3)
        if not getScrollResponder:_isAnimating() and (not Boolean.toJSBoolean(nil) or (nil).x == 0 and (nil).y == 0) then
            tbl6:endScroll()
        end
        if getScrollResponder.props.onScrollEndDrag then
            getScrollResponder.props.onScrollEndDrag(arg2, arg3)
        end
    end

    function getScrollResponder._isAnimating(): boolean
        return os.clock() * 1000 - getScrollResponder._lastMomentumScrollEndTime < 16
    end

    function getScrollResponder._handleResponderGrant(arg2)
        getScrollResponder._observedScrollSinceBecomingResponder = false
        if getScrollResponder.props.onResponderGrant then
            getScrollResponder.props.onResponderGrant(arg2)
        end
        getScrollResponder._becameResponderWhileAnimating = getScrollResponder:_isAnimating()
    end

    function getScrollResponder._handleResponderReject() end

    function getScrollResponder._handleResponderRelease(arg2)
        getScrollResponder._isTouching = #arg2.nativeEvent.touches ~= 0
        if getScrollResponder.props.onResponderRelease then
            getScrollResponder.props.onResponderRelease(arg2)
        end

        if typeof(arg2.target) == "number" then
            if _G.__DEV__ then
                console.error("Did not expect event target to be a number. Should have been a native component")
            end
            return
        end

        local var5 = tbl7:currentlyFocusedInput()

        if getScrollResponder.props.keyboardShouldPersistTaps ~= true
            and getScrollResponder.props.keyboardShouldPersistTaps ~= "always"
            and getScrollResponder:_keyboardIsDismissible()
            and arg2.target ~= var5
            and not (getScrollResponder._observedScrollSinceBecomingResponder or getScrollResponder._becameResponderWhileAnimating)
        then
            tbl7:blurTextInput(var5)
        end
    end

    function getScrollResponder._handleResponderTerminationRequest(): boolean
        return not getScrollResponder._observedScrollSinceBecomingResponder
    end

    function getScrollResponder._handleScrollShouldSetResponder()
        return not (getScrollResponder.props.disableScrollViewPanResponder == true) and getScrollResponder._isTouching
    end

    function getScrollResponder._handleStartShouldSetResponder(arg2): boolean
        if getScrollResponder.props.disableScrollViewPanResponder == true then
            return false
        end

        local var5 = tbl7:currentlyFocusedInput()

        return not not (getScrollResponder.props.keyboardShouldPersistTaps == "handled"
            and getScrollResponder:_keyboardIsDismissible()
            and arg2.target ~= var5)
    end

    function getScrollResponder._handleStartShouldSetResponderCapture(arg2): boolean
        if getScrollResponder:_isAnimating() then
            return true
        end

        if getScrollResponder.props.disableScrollViewPanResponder == true then
            return false
        end

        local keyboardShouldPersistTaps = getScrollResponder.props.keyboardShouldPersistTaps
        local bool1 = not Boolean.toJSBoolean(keyboardShouldPersistTaps) or keyboardShouldPersistTaps == "never"

        if typeof(arg2.target) ~= "number" then
            return not not (bool1
                and getScrollResponder:_keyboardIsDismissible()
                and arg2.target ~= nil
                and not Boolean.toJSBoolean(tbl7:isTextInput(arg2.target)))
        end

        if _G.__DEV__ then
            console.error("Did not expect event target to be a number. Should have been a native component")
        end

        return false
    end

    function getScrollResponder._keyboardIsDismissible()
        local var5 = tbl7:currentlyFocusedInput()
        local var6 = not (var5 == nil) and tbl7:isTextInput(var5)
        local bool1 = getScrollResponder._keyboardWillOpenTo ~= nil or var1.OS == "android"
        return var6 and bool1
    end

    function getScrollResponder._handleTouchEnd(arg2, arg3)
        getScrollResponder._isTouching = false

        if getScrollResponder.props.onTouchEnd then
            getScrollResponder.props.onTouchEnd(arg2, arg3)
        end
    end

    function getScrollResponder._handleTouchCancel(arg2, arg3)
        getScrollResponder._isTouching = false

        if getScrollResponder.props.onTouchCancel then
            getScrollResponder.props.onTouchCancel(arg2, arg3)
        end
    end

    function getScrollResponder._handleTouchStart(arg2, arg3)
        getScrollResponder._isTouching = true
        if getScrollResponder.props.onTouchStart then
            getScrollResponder.props.onTouchStart(arg2, arg3)
        end
    end

    function getScrollResponder._handleTouchMove(arg2, arg3)
        if getScrollResponder.props.onTouchMove then
            getScrollResponder.props.onTouchMove(arg2, arg3)
        end
    end

    getScrollResponder._scrollAnimatedValue = tbl1.Value.new(
        if getScrollResponder.props.contentOffset then if Boolean.toJSBoolean(getScrollResponder.props.contentOffset.y) then getScrollResponder.props.contentOffset.y else 0 else 0
    )

    getScrollResponder._scrollAnimatedValue:setOffset(
        if getScrollResponder.props.contentInset then if Boolean.toJSBoolean(getScrollResponder.props.contentInset.top) then getScrollResponder.props.contentInset.top else 0 else 0
    )
end

function var4.componentDidMount(arg1)
    if typeof(arg1.props.keyboardShouldPersistTaps) == "boolean" then
        console.warn(
            ("'keyboardShouldPersistTaps={%s}' is deprecated. "):format(
                if arg1.props.keyboardShouldPersistTaps == true then "true" else "false"
            )
                .. ("Use 'keyboardShouldPersistTaps=\"%s\"' instead"):format(
                    if Boolean.toJSBoolean(arg1.props.keyboardShouldPersistTaps) then "always" else "never"
                )
        )
    end

    arg1._keyboardWillOpenTo = nil
    arg1._additionalScrollOffset = 0

    arg1._subscriptionKeyboardWillShow = tbl5:addListener("keyboardWillShow", arg1.scrollResponderKeyboardWillShow)
    arg1._subscriptionKeyboardWillHide = tbl5:addListener("keyboardWillHide", arg1.scrollResponderKeyboardWillHide)
    arg1._subscriptionKeyboardDidShow = tbl5:addListener("keyboardDidShow", arg1.scrollResponderKeyboardDidShow)
    arg1._subscriptionKeyboardDidHide = tbl5:addListener("keyboardDidHide", arg1.scrollResponderKeyboardDidHide)
    arg1:_updateAnimatedNodeAttachment()
end

function var4.componentDidUpdate(arg1, arg2)
    local var5 = if arg2.contentInset then arg2.contentInset.top else 0
    local var6 = if arg1.props.contentInset then arg1.props.contentInset.top else 0
    if var5 ~= var6 then
        arg1._scrollAnimatedValue:setOffset(Boolean.toJSBoolean(var6) and var6 or 0)
    end

    arg1:_updateAnimatedNodeAttachment()
end

function var4.componentWillUnmount(arg1)
    if arg1._subscriptionKeyboardWillShow ~= nil then
        arg1._subscriptionKeyboardWillShow:remove()
    end
    if arg1._subscriptionKeyboardWillHide ~= nil then
        arg1._subscriptionKeyboardWillHide:remove()
    end
    if arg1._subscriptionKeyboardDidShow ~= nil then
        arg1._subscriptionKeyboardDidShow:remove()
    end
    if arg1._subscriptionKeyboardDidHide ~= nil then
        arg1._subscriptionKeyboardDidHide:remove()
    end

    if arg1._scrollAnimatedValueAttachment then
        arg1._scrollAnimatedValueAttachment:detach()
    end
end

function var4._textInputFocusError()
    console.warn("Error measuring text field.")
end

function var4._getKeyForIndex(arg1, arg2)
    local var5 = arg2[arg1]
    return var5 and var5.key
end

function var4._updateAnimatedNodeAttachment(arg1)
    if arg1._scrollAnimatedValueAttachment then
        arg1._scrollAnimatedValueAttachment:detach()
    end
    if not arg1.props.stickyHeaderIndices or not (#arg1.props.stickyHeaderIndices > 0) then
        return
    end

    arg1._scrollAnimatedValueAttachment = tbl1:attachNativeEvent(
        arg1._scrollViewRef,
        "onScroll",
        {{
            nativeEvent = {
                contentOffset = {
                    y = arg1._scrollAnimatedValue
                }
            }
        }}
    )
end

function var4._setStickyHeaderRef(tbl8, str1: string, arg1)
    if Boolean.toJSBoolean(arg1) then
        tbl8._stickyHeaderRefs:set(str1, arg1)
        return
    end
    tbl8._stickyHeaderRefs:delete(str1)
end

function var4._onStickyHeaderLayout(arg1, arg2, arg3, arg4)
    local stickyHeaderIndices = arg1.props.stickyHeaderIndices
    if not stickyHeaderIndices then
        return
    end
    local var5 = React.Children.toArray(arg1.props.children)
    if arg4 ~= arg1._getKeyForIndex(arg2, var5) then
        return
    end
    local y = arg3.nativeEvent.layout.y
    arg1._headerLayoutYs:set(arg4, y)

    local stickyHeaderIndex = stickyHeaderIndices[Array.indexOf(stickyHeaderIndices, arg2) - 1]
    if stickyHeaderIndex == nil then
        return
    end

    local var6 = arg1._stickyHeaderRefs:get(arg1._getKeyForIndex(stickyHeaderIndex, var5))
    if Boolean.toJSBoolean(var6) and var6.setNextHeaderY then
        var6:setNextHeaderY(y)
    end
end

function var4.render(arg1)
    local var5, var6 = table.unpack(
        if arg1.props.horizontal == true then NativeHorizontalScrollViewTuple else NativeVerticalScrollViewTuple,
        1,
        2
    )

    local contentContainerStyle = arg1.props.contentContainerStyle

    if _G.__DEV__ and arg1.props.style ~= nil then
        local style = arg1.props.style
        local input = Array.filter({ "alignItems", "justifyContent" }, function(arg2): boolean
            return type(style) == "table" and style[arg2] ~= nil
        end)

        invariant(
            #input == 0,
            "ScrollView child layout (" .. HttpService:JSONEncode(input) .. ") must be applied through the contentContainerStyle prop."
        )
    end

    local var7 = arg1.props.onContentSizeChange ~= nil and {
        onLayout = arg1._handleContentOnLayout
    } or nil

    local stickyHeaderIndices = arg1.props.stickyHeaderIndices

    local children = arg1.props.children

    if stickyHeaderIndices ~= nil and #stickyHeaderIndices > 0 then
        local var8 = React.Children.toArray(arg1.props.children)

        children = Array.map(var8, function(arg2, arg3)
            local var9 = if Boolean.toJSBoolean(arg2) then Array.indexOf(stickyHeaderIndices, arg3) else -1
            if not (var9 > -1) then
                return arg2
            end

            local key = arg2.key
            local stickyHeaderIndex = stickyHeaderIndices[var9 + 1]
            local var10 = if arg1.props.StickyHeaderComponent then arg1.props.StickyHeaderComponent else ScrollViewStickyHeader

            return (React.createElement(var10, {
                Name = "StickyHeaderComponent",
                key = key,
                nativeID = "StickyHeader-" .. tostring(key),
                ref = function(arg4)
                    return arg1:_setStickyHeaderRef(key, arg4)
                end,
                nextHeaderLayoutY = arg1._headerLayoutYs:get(arg1._getKeyForIndex(stickyHeaderIndex, var8)),
                onLayout = function(arg4)
                    return arg1:_onStickyHeaderLayout(arg3, arg4, key)
                end,
                scrollAnimatedValue = arg1._scrollAnimatedValue,
                inverted = arg1.props.invertStickyHeaders,
                hiddenOnScroll = arg1.props.stickyHeaderHiddenOnScroll,
                scrollViewHeight = arg1.state.layoutHeight
            }, arg2))
        end)
    end

    local element = React.createElement(
        default.Provider,
        {
            value = if arg1.props.horizontal == true then HORIZONTAL else VERTICAL
        },
        React.createElement("UIListLayout", {
            ref = arg1._listLayoutRef,
            key = "layout",
            Name = if arg1.props.horizontal then "HorizontalLayout" else "VerticalLayout",
            FillDirection = if arg1.props.horizontal then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical,
            VerticalAlignment = if arg1.props.horizontal then Enum.VerticalAlignment.Center elseif arg1.props.layoutStyle then arg1.props.layoutStyle.VerticalAlignment else Enum.VerticalAlignment.Top,
            HorizontalAlignment = if arg1.props.horizontal then if arg1.props.layoutStyle then arg1.props.layoutStyle.HorizontalAlignment else Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        children
    )

    local var8 = Array.isArray(stickyHeaderIndices) and #stickyHeaderIndices > 0

    local element2 = React.createElement(
        var6,
        Object.assign({}, var7, {
            ref = arg1._setInnerViewRef
        }, {
            style = contentContainerStyle,
            Size = if arg1.props.horizontal then UDim2.new(0, 0, 1, 0) else UDim2.new(1, 0, 0, 0),
            AutomaticSize = if arg1.props.horizontal then Enum.AutomaticSize.X else Enum.AutomaticSize.Y,
            removeClippedSubviews = not (var1.OS == "android" and var8) and arg1.props.removeClippedSubviews,
            collapsable = false
        }),
        element
    )
    local alwaysBounceHorizontal = if arg1.props.alwaysBounceHorizontal ~= nil then arg1.props.alwaysBounceHorizontal else arg1.props.horizontal
    local alwaysBounceVertical = if arg1.props.alwaysBounceVertical ~= nil then arg1.props.alwaysBounceVertical else not arg1.props.horizontal
    local var10 = if arg1.props.horizontal == true then var2.baseHorizontal else var2.baseVertical
    local var11 = Object.assign(table.clone(arg1.props), {
        alwaysBounceHorizontal = alwaysBounceHorizontal,
        alwaysBounceVertical = alwaysBounceVertical,
        style = StyleSheet.compose(var10, arg1.props.style),
        onContentSizeChange = Object.None,
        onLayout = arg1._handleLayout,
        onMomentumScrollBegin = arg1._handleMomentumScrollBegin,
        onMomentumScrollEnd = arg1._handleMomentumScrollEnd,
        onResponderGrant = arg1._handleResponderGrant,
        onResponderReject = arg1._handleResponderReject,
        onResponderRelease = arg1._handleResponderRelease,
        onResponderTerminationRequest = arg1._handleResponderTerminationRequest,
        onScrollBeginDrag = arg1._handleScrollBeginDrag,
        onScrollEndDrag = arg1._handleScrollEndDrag,
        onScrollShouldSetResponder = arg1._handleScrollShouldSetResponder,
        onStartShouldSetResponder = arg1._handleStartShouldSetResponder,
        onStartShouldSetResponderCapture = arg1._handleStartShouldSetResponderCapture,
        onTouchEnd = arg1._handleTouchEnd,
        onTouchMove = arg1._handleTouchMove,
        onTouchStart = arg1._handleTouchStart,
        onTouchCancel = arg1._handleTouchCancel,
        onScroll = arg1._handleScroll,
        scrollEventThrottle = if var8 then 1 else arg1.props.scrollEventThrottle,
        sendMomentumEvents = if arg1.props.onMomentumScrollBegin then true else not not arg1.props.onMomentumScrollEnd,
        snapToStart = arg1.props.snapToStart ~= false,
        snapToEnd = arg1.props.snapToEnd ~= false,
        pagingEnabled = var1.select({
            ios = arg1.props.pagingEnabled == true and arg1.props.snapToInterval == nil and arg1.props.snapToOffsets == nil,
            android = arg1.props.pagingEnabled == true or arg1.props.snapToInterval ~= nil or arg1.props.snapToOffsets ~= nil
        }),
        AutomaticCanvasSize = if arg1.props.overrideAutomaticCanvasSize then Enum.AutomaticSize.None else nil
    })

    local decelerationRate = arg1.props.decelerationRate

    if decelerationRate ~= nil then
        var11.decelerationRate = processDecelerationRate(decelerationRate)
    end

    local refreshControl = arg1.props.refreshControl

    if Boolean.toJSBoolean(refreshControl) then
        if var1.OS == "ios" or var1.OS == "roblox" then
            return React.createElement(var5, Object.assign(table.clone(var11), { ref = arg1._setNativeRef }), refreshControl, element2)
        end

        if var1.OS == "android" then
            local tbl8 = func2(var11.style)
            return React.cloneElement(
                refreshControl,
                Object.assign({ style = StyleSheet.compose(var10, tbl8.outer) }),
                React.createElement(
                    var5,
                    Object.assign({}, var11, { style = StyleSheet.compose(var10, tbl8.inner), ref = arg1._setNativeRef }),
                    element2
                )
            )
        end
    end

    var11.ref = arg1._setNativeRef

    return React.createElement(var5, var11, element2)
end

var2 = StyleSheet.create({
    baseVertical = {
        ScrollingDirection = Enum.ScrollingDirection.Y
    },
    baseHorizontal = {
        ScrollingDirection = Enum.ScrollingDirection.X
    }
})

local var5 = React.forwardRef(function(arg1, scrollViewRef) -- name: Wrapper
    return React.createElement(var4, Object.assign(table.clone(arg1), { scrollViewRef = scrollViewRef }))
end)

var5.Context = default

var5.displayName = "ScrollView"

return var5
