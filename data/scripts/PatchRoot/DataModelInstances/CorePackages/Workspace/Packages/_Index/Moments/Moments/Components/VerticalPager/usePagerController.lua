-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local Constants = require(script.Parent.Constants)
local _Types = require(script.Parent.Types)
local snapMath = require(script.Parent.snapMath)
local pagerNavigation = require(script.Parent.pagerNavigation)

local usePreferences = Foundation.Hooks.usePreferences

local function usePagerController(tbl1)
    local scrollingFrame = tbl1.scrollingFrame
    local store = tbl1.store
    local itemHeight = tbl1.itemHeight
    local gap = tbl1.gap
    local active = tbl1.active
    local nativeScrollEnabled = tbl1.nativeScrollEnabled

    local var1 = React.useRef(store)
    var1.current = store
    local var2 = React.useRef(itemHeight)
    var2.current = itemHeight

    local var3 = React.useRef(itemHeight + gap)
    var3.current = itemHeight + gap
    local var4 = React.useRef(tbl1.snapSensitivity)
    var4.current = tbl1.snapSensitivity
    local var5 = React.useRef(tbl1.animationSpeed)
    var5.current = tbl1.animationSpeed
    local var6 = React.useRef(tbl1.analytics)
    var6.current = tbl1.analytics

    local var7 = React.useRef(active)
    var7.current = active

    local reducedMotion = usePreferences().reducedMotion
    local var8 = React.useRef(reducedMotion)
    var8.current = reducedMotion

    local var9 = React.useRef(nil)
    local var10 = React.useRef(false)
    local var11 = React.useRef(0)

    local var12 = React.useRef(0)
    local var13 = React.useRef(false)

    local var14 = React.useRef({})

    local var15 = React.useRef(0)

    local var16 = React.useRef(0)

    local var17 = React.useRef(store.getCurrentIndex(false))
    local var18 = React.useRef(0)

    local var19 = React.useRef(0)
    local var20 = React.useRef(false)

    local var21 = React.useRef(true)

    local var22 = React.useRef(nil)

    local var23 = React.useMemo(function()
        local get, set = Signals.createSignal(var1.current.getCurrentIndex(false))
        return { get = get, set = set }
    end, {})
    local var24 = React.useMemo(function()
        local get, set = Signals.createSignal("Idle")
        return { get = get, set = set }
    end, {})

    local var25 = React.useCallback(function(arg1)
        if var24.get(false) == arg1 then
            return
        end
        var24.set(arg1)
        local current = var6.current
        if current and current.onScrollStateChanged then
            current.onScrollStateChanged(arg1)
        end
    end, { var24 })

    local var26 = React.useCallback(function(num1: number)
        if var23.get(false) == num1 then
            return
        end
        var23.set(num1)
        local current = var6.current
        if current and current.onActiveItemChanged then
            current.onActiveItemChanged(num1, var1.current.getItems(false)[num1])
        end
    end, { var23 })

    local var27 = React.useCallback(function()
        local current = var22.current
        if current ~= nil then
            var22.current = nil
            var1.current.removeItem(current)
        end
    end, {})

    local var28 = React.useCallback(function()
        if var9.current then
            var9.current:Disconnect()
            var9.current = nil
        end
        var10.current = false

        var27()
    end, { var27 })

    local var29 = React.useCallback(function(y: number)
        if not scrollingFrame then
            return
        end

        var28()
        var10.current = true
        var25("Settling")

        var12.current = scrollingFrame.CanvasPosition.Y
        scrollingFrame:ResetScrollVelocity()

        var9.current = RunService.Heartbeat:Connect(function(deltaTime: number)
            local var29 = scrollingFrame

            if not var29 or not var10.current or var13.current or not var21.current then
                var28()
                return
            end

            var29:ResetScrollVelocity()

            local num1 = math.min(deltaTime, Constants.MAX_SPRING_DELTA)
            local y2, current = snapMath.advanceCriticalDampedSpring(var12.current, var11.current, y, num1, var5.current)

            var11.current = current
            var12.current = y2
            var29.CanvasPosition = Vector2.new(0, y2)

            local var31 = y - y2

            if math.abs(var31) < Constants.POSITION_THRESHOLD and math.abs(var11.current) < Constants.VELOCITY_THRESHOLD then
                var29.CanvasPosition = Vector2.new(0, y)
                var12.current = y

                var28()
                var25("Idle")
            end
        end)
    end, { scrollingFrame, var28, var25 })

    local var30 = React.useCallback(function(num1: number, current: number, bool1: boolean?)
        if not scrollingFrame then
            return
        end
        local current2 = var1.current
        local var30 = snapMath.clampIndex(num1, current2.getCount(false))
        local currentIndex = current2.getCurrentIndex(false)
        local current3 = var6.current
        local onTargetCommitted = if var30 == currentIndex or current3 == nil then nil else current3.onTargetCommitted
        local onUserStep = if bool1 and var30 ~= currentIndex and current3 ~= nil then current3.onUserStep else nil

        local function commitTarget() -- Luacid: Inlined by compiler; 3 call sites recovered
            if onTargetCommitted ~= nil then
                onTargetCommitted(currentIndex, var30, current2.getItems(false)[var30])
            end
            if onUserStep ~= nil then
                onUserStep(currentIndex, var30)
            end
            current2.goToItem(var30)
        end

        var17.current = var30

        if var2.current <= 0 then
            commitTarget()
            return
        end

        local y = snapMath.offsetForIndex(var30, var3.current)
        if var8.current then
            commitTarget()
            var28()
            scrollingFrame.CanvasPosition = Vector2.new(0, y)

            var26(var30)
            var25("Idle")
            return
        end

        if onTargetCommitted ~= nil then
            var25("Settling")
        end

        commitTarget()
        var11.current = current
        var29(y)
    end, {
        scrollingFrame,
        var29,
        var28,
        var25,
        var26
    })

    local var31 = React.useCallback(function(velocity: number)
        if not scrollingFrame then
            return
        end
        local count = var1.current.getCount(false)
        local current = var2.current
        if count <= 0 or current <= 0 then
            return
        end

        local canvasPositionY = scrollingFrame.CanvasPosition.Y
        local current2 = var3.current

        local toIndex = snapMath.resolveSnapIndex(canvasPositionY, velocity, current2, count, var4.current)

        local current3 = var6.current
        if current3 and current3.onSnap then
            local fromIndex = snapMath.nearestIndexForOffset(canvasPositionY, current2, count)
            current3.onSnap({ fromIndex = fromIndex, toIndex = toIndex, velocity = velocity })
        end

        var30(toIndex, -velocity, true)
    end, { scrollingFrame, var30 })

    local scrollToIndex = React.useCallback(function(num1: number)
        var30(num1, 0)
    end, { var30 })

    local var32 = React.useCallback(function()
        var30(var1.current.getCurrentIndex(false) + 1, 0, true)
    end, { var30 })

    local previous = React.useCallback(function()
        var30(var1.current.getCurrentIndex(false) - 1, 0, true)
    end, { var30 })

    local removeItem = React.useCallback(function(current: number)
        local current2 = var1.current

        if var22.current ~= nil then
            return
        end
        local currentIndex = current2.getCurrentIndex(false)
        local count = current2.getCount(false)

        if current ~= currentIndex or count <= 1 then
            current2.removeItem(current)
            return
        end

        local var33 = snapMath.neighborForRemoval(currentIndex, count)
        local current3 = var2.current

        if not scrollingFrame or current3 <= 0 or var8.current then
            current2.removeItem(current)
            return
        end

        var17.current = var33
        var11.current = 0

        var29(snapMath.offsetForIndex(var33, var3.current))
        var22.current = current
    end, { scrollingFrame, var29 })

    React.useEffect(function()
        local var36 = scrollingFrame
        if not var36 then
            return
        end

        local connection = var36:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            if var2.current <= 0 then
                return
            end

            local count = var1.current.getCount(false)
            var26(snapMath.nearestIndexForOffset(var36.CanvasPosition.Y, var3.current, count))

            if var13.current or var10.current or not active then
                return
            end

            var19.current = os.clock()
            if var20.current then
                return
            end
            var20.current = true

            local function runSettle()
                if not var21.current or var13.current or var10.current or not var7.current then
                    var20.current = false
                    return
                end

                if os.clock() - var19.current < Constants.SETTLE_DEBOUNCE_SECONDS then
                    task.delay(Constants.SETTLE_DEBOUNCE_SECONDS, runSettle)
                    return
                end

                var20.current = false

                if var2.current <= 0 then
                    return
                end
                local current = var3.current
                local canvasPositionY = var36.CanvasPosition.Y
                local currentIndex = var1.current.getCurrentIndex(false)
                local var37 = snapMath.resolveSettleIndex(
                    currentIndex,
                    canvasPositionY,
                    current,
                    var1.current.getCount(false),
                    Constants.WHEEL_PAGE_TURN_FRACTION,
                    1
                )
                if var37 ~= currentIndex
                    or math.abs(canvasPositionY - snapMath.offsetForIndex(currentIndex, current)) > Constants.POSITION_THRESHOLD
                then
                    var30(var37, 0, true)
                end
            end

            task.delay(Constants.SETTLE_DEBOUNCE_SECONDS, runSettle)
        end)

        return function()
            connection:Disconnect()
            var20.current = false
        end
    end, {
        scrollingFrame,
        active,
        var26,
        var30
    })

    React.useEffect(function()
        local var36 = scrollingFrame
        if not var36 or not active then
            return
        end

        local function isDragInput(input): boolean -- Luacid: Inlined by compiler; 1 call site recovered
            return input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1
        end

        local var37 = pagerNavigation.shouldTrackDrag(true, nativeScrollEnabled)

        var14.current = {}

        local function isWithinFrame(input): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
            local inputPosition = input.Position
            local absolutePosition = var36.AbsolutePosition
            local absoluteSize = var36.AbsoluteSize

            return inputPosition.X >= absolutePosition.X
                and inputPosition.X <= absolutePosition.X + absoluteSize.X
                and inputPosition.Y >= absolutePosition.Y
                and inputPosition.Y <= absolutePosition.Y + absoluteSize.Y
        end

        local connection = UserInputService.InputBegan:Connect(function(input: InputObject)
            if not var37 or not isDragInput(input) or var14.current[input] or not isWithinFrame(input) then
                return
            end
            local bool1 = next(var14.current) == nil
            var14.current[input] = true
            if bool1 then
                var13.current = true
                var15.current = var36.CanvasPosition.Y
                var28()
                var25("Dragging")
            end
        end)

        local connection2 = UserInputService.InputEnded:Connect(function(input: InputObject)
            if not var14.current[input] then
                return
            end
            var14.current[input] = nil

            if next(var14.current) ~= nil then
                return
            end
            var13.current = false

            local scrollVelocityY = var36:GetScrollVelocity().Y
            if not (math.abs(var36.CanvasPosition.Y - var15.current) > Constants.POSITION_THRESHOLD)
                and math.abs(scrollVelocityY) < Constants.VELOCITY_THRESHOLD
            then
                var25("Idle")
                return
            end
            var31(scrollVelocityY)
        end)

        local connection3 = nil

        local function onWheel(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
            local var38, current = pagerNavigation.resolveWheelGesture(os.clock(), var16.current, Constants.WHEEL_COOLDOWN_SECONDS)

            var16.current = current

            if var38 then
                var30(var1.current.getCurrentIndex(false) + num1, 0, true)
            end
        end

        if not nativeScrollEnabled then
            connection3 = UserInputService.InputChanged:Connect(function(input: InputObject)
                if input.UserInputType ~= Enum.UserInputType.MouseWheel or not isWithinFrame(input) then
                    return
                end

                local inputPositionZ = input.Position.Z
                if inputPositionZ > 0 then
                    onWheel(-1)
                elseif inputPositionZ < 0 then
                    onWheel(1)
                end
            end)
        end

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            if connection3 then
                connection3:Disconnect()
            end
        end
    end, {
        scrollingFrame,
        active,
        nativeScrollEnabled,
        var28,
        var25,
        var31,
        var30,
        var32,
        previous
    })

    local var36 = SignalsReact.useSignalState(store.getCount)
    local var37 = SignalsReact.useSignalState(store.getCurrentIndex)

    React.useEffect(function()
        local var38 = scrollingFrame
        local current = itemHeight + gap
        if not var38 or itemHeight <= 0 then
            var18.current = current
            return
        end

        local var33 = snapMath.clampIndex(var37, var36)

        if current ~= var18.current or var33 ~= var17.current then
            var28()
            var38.CanvasPosition = Vector2.new(0, snapMath.offsetForIndex(var33, current))
            var17.current = var33

            var26(var33)

            var25("Idle")
        end

        var18.current = current
    end, {
        scrollingFrame,
        var36,
        var37,
        itemHeight,
        gap,
        var28,
        var26,
        var25
    })

    React.useEffect(function()
        if not active then
            var28()
            var25("Idle")
        end
    end, { active, var28, var25 })

    React.useEffect(function()
        var21.current = true
        return function()
            var21.current = false
            var28()
        end
    end, { var28 })

    return React.useMemo(function()
        return {
            getActiveIndex = var23.get,
            getScrollState = var24.get,
            scrollToIndex = scrollToIndex,
            next = var32,
            previous = previous,
            removeItem = removeItem
        }
    end, {
        var23,
        var24,
        scrollToIndex,
        var32,
        previous,
        removeItem
    })
end

return usePagerController
