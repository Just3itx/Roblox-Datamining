-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local Constants = require(script.Parent.Constants)
local _Types = require(script.Parent.Types)
local snapMath = require(script.Parent.snapMath)
local usePagerController = require(script.Parent.usePagerController)
local usePagerInputNavigation = require(script.Parent.usePagerInputNavigation)
local FFlagMomentsFeedSwipeSensitivityConfig = require(Moments.Flags.FFlagMomentsFeedSwipeSensitivityConfig)
local FIntMomentsFeedSnapSensitivityMilli = require(Moments.Flags.FIntMomentsFeedSnapSensitivityMilli)
local FIntMomentsFeedAnimationSpeed = require(Moments.Flags.FIntMomentsFeedAnimationSpeed)

local VerticalPagerContext = require(script.Parent.VerticalPagerContext)
local VerticalPagerContext2 = VerticalPagerContext.VerticalPagerContext
local PagerItemContext = VerticalPagerContext.PagerItemContext

local var1 = React.memo(function(tbl1) -- name: PagerItemProviderInner
    local index = tbl1.index
    local getActiveIndex = tbl1.getActiveIndex

    local getIsActive = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return getActiveIndex(arg1) == index
        end)
    end, { getActiveIndex, index })

    local getIsVisible = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return math.abs(getActiveIndex(arg1) - index) <= 1
        end)
    end, { getActiveIndex, index })

    local value = React.useMemo(function()
        return {
            index = index,
            item = tbl1.item,
            getIsActive = getIsActive,
            getIsVisible = getIsVisible
        }
    end, {
        index,
        tbl1.item,
        getIsActive,
        getIsVisible
    })
    return React.createElement(PagerItemContext.Provider, { value = value }, {
        Item = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, snapMath.offsetForIndex(index, tbl1.stride)),
            Size = UDim2.new(1, 0, 0, tbl1.itemHeight)
        }, {
            Content = tbl1.renderItem(tbl1.item, index)
        })
    })
end)

local function useNativeScrollEnabled()
    local function isNonTouch(userInputType): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return userInputType == Enum.UserInputType.MouseWheel
            or userInputType == Enum.UserInputType.MouseButton1
            or userInputType == Enum.UserInputType.MouseMovement
            or userInputType == Enum.UserInputType.Keyboard
    end

    local var2, var3 = React.useState(function(): boolean
        return not isNonTouch((UserInputService:GetLastInputType()))
    end)

    React.useEffect(function()
        local connection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
            if lastInputType == Enum.UserInputType.Touch then
                var3(true)
            elseif isNonTouch(lastInputType) then
                var3(false)
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    return var2
end

local function VerticalPager(arg1)
    local store = arg1.store
    local renderItem = arg1.renderItem
    local keyExtractor = arg1.keyExtractor
    local analytics = arg1.analytics
    local tuning = arg1.tuning or {}

    local defaultSnapSensitivity = Constants.DEFAULT_SNAP_SENSITIVITY
    local defaultAnimationSpeed = Constants.DEFAULT_ANIMATION_SPEED
    if FFlagMomentsFeedSwipeSensitivityConfig then
        defaultSnapSensitivity = FIntMomentsFeedSnapSensitivityMilli / 1000
        defaultAnimationSpeed = FIntMomentsFeedAnimationSpeed
    end
    local snapSensitivity = tuning.snapSensitivity or defaultSnapSensitivity
    local animationSpeed = tuning.animationSpeed or defaultAnimationSpeed
    local var4 = tuning.overscan or Constants.DEFAULT_OVERSCAN
    local onEndReached = arg1.onEndReached
    local var5 = tuning.endReachedThreshold or Constants.DEFAULT_END_REACHED_THRESHOLD
    local var6 = arg1.active == nil or arg1.active
    local gap = tuning.gap or 0
    local initialIndex = arg1.initialIndex

    local keyboardNavigation = tuning.keyboardNavigation or "global"

    local function keyOf(arg2, num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if keyExtractor ~= nil then
            return (keyExtractor(arg2, num1))
        end

        return tostring(num1)
    end

    local scrollingFrame, var8 = React.useState(nil)
    local itemHeight, var10 = React.useState(0)

    local var11 = React.useRef(nil)

    local var12 = React.useRef({})

    local ref = React.useCallback(function(arg2)
        var8(arg2)
        if arg2 then
            var10(arg2.AbsoluteSize.Y)
        end
    end, {})

    local var14 = React.useCallback(function(arg2)
        var10(arg2.AbsoluteSize.Y)
    end, {})

    local var15 = useNativeScrollEnabled()

    local var16 = usePagerController({
        scrollingFrame = scrollingFrame,
        store = store,
        itemHeight = itemHeight,
        gap = gap,
        snapSensitivity = snapSensitivity,
        animationSpeed = animationSpeed,
        active = var6,
        nativeScrollEnabled = var15,
        analytics = analytics
    })

    local var2 = usePagerInputNavigation(
        {
            active = var6,
            keyboardNavigation = keyboardNavigation,
            goNext = var16.next,
            goPrevious = var16.previous
        }
    )
    local var18 = SignalsReact.useSignalState(store.getCount)
    local current = SignalsReact.useSignalState(store.getItems)
    local var20 = SignalsReact.useSignalState(var16.getActiveIndex)

    React.useEffect(function()
        if onEndReached == nil or var18 <= 0 then
            return
        end
        if var20 >= var18 - var5 and var11.current ~= current then
            var11.current = current
            onEndReached()
        end
    end, {
        var20,
        var18,
        current,
        var5,
        onEndReached
    })

    React.useEffect(function()
        local onItemImpression = if analytics == nil then nil else analytics.onItemImpression

        if onItemImpression == nil or var18 <= 0 then
            return
        end
        local var21 = current[var20]
        if var21 == nil then
            return
        end
        local var22 = keyOf(var21, var20)
        if var12.current[var22] then
            return
        end
        var12.current[var22] = true
        onItemImpression(var20, var21)
    end, {
        var20,
        var18,
        current,
        analytics,
        keyExtractor
    })
    local value = React.useMemo(function()
        return {
            store = store,
            getActiveIndex = var16.getActiveIndex,
            getScrollState = var16.getScrollState,
            scrollToIndex = var16.scrollToIndex,
            next = var16.next,
            previous = var16.previous,
            removeItem = var16.removeItem,
            analytics = analytics
        }
    end, { store, var16, analytics })

    local var22 = React.useRef(false)
    React.useEffect(function()
        if var22.current then
            return
        end

        if initialIndex == nil then
            var22.current = true
            return
        end

        if var18 < initialIndex then
            return
        end

        var22.current = true
        if initialIndex ~= store.getCurrentIndex(false) then
            store.goToItem(initialIndex)
        end
    end, {
        initialIndex,
        var18,
        store.getCurrentIndex,
        store.goToItem
    })

    React.useImperativeHandle(arg1.controllerRef, function()
        return var16
    end, { var16 })

    local stride = itemHeight + gap
    local yOffset = if itemHeight > 0 then if var18 > 0 then (var18 - 1) * stride + itemHeight else 0 else 0

    local tbl1 = {}
    if itemHeight > 0 and var18 > 0 then
        local visibleWindow = snapMath.getVisibleWindow(var20, var4, var18)
        for index = visibleWindow.startIndex, visibleWindow.endIndex do
            local var24 = current[index]
            if var24 == nil then
                continue
            end

            table.insert(
                tbl1,
                React.createElement(var1, {
                    key = keyOf(var24, index),
                    index = index,
                    item = var24,
                    itemHeight = itemHeight,
                    stride = stride,
                    getActiveIndex = var16.getActiveIndex,
                    renderItem = renderItem
                })
            )
        end
    end

    local createElement = React.createElement
    local provider = VerticalPagerContext2.Provider
    local tbl2 = { value = value }
    local tbl3 = { Container = 0 }

    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        Active = var6,
        AnchorPoint = arg1.AnchorPoint,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.LayoutOrder,
        Position = arg1.Position,
        Selectable = var6,
        SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
        SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
        SelectionGroup = true,
        Size = arg1.Size or UDim2.fromScale(1, 1),
        ZIndex = arg1.ZIndex,
        ref = var2
    }
    local tbl5 = { Scroller = 0 }
    local createElement3 = React.createElement
    local str2 = "ScrollingFrame"
    local tbl6 = {
        AutomaticCanvasSize = Enum.AutomaticSize.None,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(1, 0, 0, yOffset),
        ClipsDescendants = true,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y
    }

    if var6 then
        if not (var18 > 1) then
            var15 = false
        end
    else
        var15 = var6
    end

    tbl6.ScrollingEnabled = var15

    tbl6.Selectable = false
    tbl6.Size = UDim2.fromScale(1, 1)
    tbl6.ref = ref
    tbl6[React.Change.AbsoluteSize] = var14
    tbl5.Scroller = createElement3(str2, tbl6, tbl1)
    tbl3.Container = createElement2(str1, tbl4, tbl5)
    return createElement(provider, tbl2, tbl3)
end

return VerticalPager
