-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local Promise = require(scriptParentParentParent.Promise)

local tbl1 = {}

local React = require(scriptParentParentParent.React)

local useRef = React.useRef
local useState = React.useState

local View = require(scriptParentParent.Components.View.View)
local FlatList = require(script.Parent.FlatList)

local function _getLength(horizontal: boolean?) -- Luacid: Inlined by compiler; 2 call sites recovered
    return function(vector2: Vector2)
        return if horizontal then vector2.X else vector2.Y
    end
end

tbl1.BidirectionalFlatList = React.forwardRef(function(arg1, ref)
    local function promiseFn()
        return Promise.resolve()
    end

    if arg1.activityIndicatorColor ~= nil then
        local _activityIndicatorColor = arg1.activityIndicatorColor
    end

    local var1 = if arg1.autoscrollToTopThreshold == nil then 100 else arg1.autoscrollToTopThreshold
    local data = arg1.data
    local enableAutoscrollToTop = arg1.enableAutoscrollToTop
    local footerLoadingIndicator = arg1.FooterLoadingIndicator
    local headerLoadingIndicator = arg1.HeaderLoadingIndicator
    local listHeaderComponent = arg1.ListHeaderComponent
    local listFooterComponent = arg1.ListFooterComponent
    local var2 = if arg1.onEndReached == nil then promiseFn else arg1.onEndReached
    local var3 = if arg1.onEndReachedThreshold == nil then 10 else arg1.onEndReachedThreshold
    local onScroll = arg1.onScroll
    if arg1.onStartReached ~= nil then
        promiseFn = arg1.onStartReached
    end

    local var4 = if arg1.onStartReachedThreshold == nil then 10 else arg1.onStartReachedThreshold
    local var5 = arg1.showDefaultLoadingIndicators == nil or arg1.showDefaultLoadingIndicators
    local enableRetryOnStartReached = not (arg1.enableRetryOnStartReached == nil) and arg1.enableRetryOnStartReached
    local enableRetryOnEndReached = not (arg1.enableRetryOnEndReached == nil) and arg1.enableRetryOnEndReached
    local var6, var7 = useState(false)
    local var8, var9 = useState(false)
    local var10, var11 = useState(0)
    local var12 = useRef({})
    local var13 = useRef({})
    local var14 = useRef(nil)
    local var15 = useRef(nil)

    local function maybeCallOnStartReached()
        if data and #data > 0 and var12.current[#data] then
            return
        end

        local bool1 = if arg1.inverted then var10 >= 3 else var10 >= 1

        if not bool1 then
            return
        end

        if data and #data > 0 and bool1 then
            var12.current[#data] = true
        end

        var7(true)
        local function p()
            return Promise.new(function(callback)
                var14.current = nil
                var7(false)
                callback()
            end)
        end

        if var15.current then
            var15.current:andThen(function()
                var14.current = promiseFn():andThen(p)
            end)

            return
        end

        var14.current = promiseFn():andThen(p)
    end

    local function maybeCallOnEndReached()
        if data and #data > 0 and var13.current[#data] then
            return
        end

        local bool1 = if arg1.inverted then var10 >= 3 else var10 >= 1

        if not bool1 then
            return
        end

        if data and #data > 0 and bool1 then
            var13.current[#data] = true
        end

        var9(true)
        local function p()
            return Promise.new(function(callback)
                var15.current = nil
                var9(false)
                callback()
            end)
        end

        if var14.current then
            var14.current:andThen(function()
                var15.current = var2():andThen(p)
            end)

            return
        end

        var15.current = var2():andThen(p)
    end

    local function renderHeaderLoadingIndicator()
        if not var5 then
            if listHeaderComponent then
                return React.createElement(listHeaderComponent, nil)
            end
            return nil
        end

        if not var6 then
            return nil
        end

        if headerLoadingIndicator then
            return React.createElement(headerLoadingIndicator, nil)
        end

        if _G.__DEV__ then
            warn("default activity indicator not available")
        end
        return nil
    end

    local function renderFooterLoadingIndicator()
        if not var5 then
            if listFooterComponent then
                return React.createElement(listFooterComponent, nil)
            end
            return nil
        end

        if not var8 then
            return nil
        end

        if footerLoadingIndicator then
            return React.createElement(footerLoadingIndicator, nil)
        end

        if _G.__DEV__ then
            warn("default activity indicator not available")
        end
        return nil
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var16 = nil
    local createElement2 = React.createElement
    local var17 = FlatList
    local assign = Object.assign
    local var18 = table.clone(arg1)

    local tbl2 = {
        renderItem = function(arg2)
            local item = arg2.item
            local createElement3 = React.createElement
            local var19 = View

            local tbl2 = {
                onLayout = function(arg3)
                    local current = if ref and ref.current then ref.current._listRef._scrollRef.getNativeScrollRef()._nativeRef.current else nil
                    local func1 = _getLength(arg1.horizontal)

                    if not item.shouldResizeOnMount or not current then
                        return
                    end

                    local var20 = func1(arg3.AbsoluteSize)

                    if var20 <= 0 or current == nil then
                        item.shouldResizeOnMount = false
                        return
                    end

                    local canvasPosition = current.CanvasPosition
                    local absoluteSize = current.AbsoluteSize
                    local absoluteCanvasSize = current.AbsoluteCanvasSize
                    local var21 = if enableAutoscrollToTop then var1 else nil

                    if var21
                        and (if arg1.inverted then func1(absoluteCanvasSize) - func1(canvasPosition) - func1(absoluteSize) else func1(canvasPosition)) < var21
                    then
                        item.shouldResizeOnMount = false
                        local var22

                        if arg1.inverted then
                            if arg1.horizontal then
                                var22 = Vector2.new(func1(absoluteCanvasSize) - func1(absoluteSize), current.CanvasPosition.Y)
                            else
                                var22 = Vector2.new(current.CanvasPosition.X, func1(absoluteCanvasSize) - func1(absoluteSize))
                            end
                        elseif arg1.horizontal then
                            var22 = Vector2.new(0, current.CanvasPosition.Y)
                        else
                            var22 = Vector2.new(current.CanvasPosition.X, 0)
                        end

                        current.CanvasPosition = var22

                        return
                    end

                    local var22

                    if arg1.inverted then
                        if arg1.horizontal then
                            var22 = Vector2.new(canvasPosition.X - var20, canvasPosition.Y)
                        else
                            var22 = Vector2.new(canvasPosition.X, canvasPosition.Y - var20)
                        end
                    elseif arg1.horizontal then
                        var22 = Vector2.new(canvasPosition.X + var20, canvasPosition.Y)
                    else
                        var22 = Vector2.new(canvasPosition.X, canvasPosition.Y + var20)
                    end
                    item.shouldResizeOnMount = false
                    current.CanvasPosition = var22
                end,
                AutomaticSize = if arg1.horizontal then Enum.AutomaticSize.X else Enum.AutomaticSize.Y,
                Size = if arg1.horizontal then UDim2.new(0, 0, 1, 0) else UDim2.new(1, 0, 0, 0),
                BorderSizePixel = 0,
                name = "resize"
            }

            return createElement3(var19, tbl2, { child = arg1.renderItem(arg2) })
        end,
        ref = ref,
        ListHeaderComponent = renderHeaderLoadingIndicator,
        ListFooterComponent = renderFooterLoadingIndicator,
        onEndReached = Object.None,
        onScroll = function(arg2) -- name: handleScroll
            var11(function(arg3): number
                return arg3 + 1
            end)

            if onScroll then
                onScroll(arg2)
            end

            local var19 = arg2:GetChildren()[1]
            local func1 = _getLength(arg1.horizontal)
            local var20 = func1(arg2.AbsoluteSize)
            local var21 = func1(var19.AbsoluteSize)
            local var22 = if arg1.inverted then func1(arg2.AbsoluteCanvasSize) - func1(arg2.CanvasPosition) - var20 else func1(arg2.CanvasPosition)
            local bool1 = var22 < var4
            local bool2 = var21 - var20 - var22 < var3

            if bool1 then
                maybeCallOnStartReached()
            elseif enableRetryOnStartReached and data and #data > 0 and var12.current[#data] then
                var12.current[#data] = false
            end

            if bool2 then
                maybeCallOnEndReached()
            elseif enableRetryOnEndReached and data and #data > 0 and var13.current[#data] then
                var13.current[#data] = false
            end
        end,
        maintainVisibleContentPosition = {
            autoscrollToTopThreshold = if enableAutoscrollToTop then var1 else nil,
            minIndexForVisible = 1
        }
    }

    return createElement(fragment, var16, createElement2(var17, assign(var18, tbl2)))
end)

return tbl1
