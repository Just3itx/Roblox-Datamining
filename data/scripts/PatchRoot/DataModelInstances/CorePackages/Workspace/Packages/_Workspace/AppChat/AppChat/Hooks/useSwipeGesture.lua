-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local ReactOtter = require(AppChatParent.ReactOtter)
local Cryo = require(AppChatParent.Cryo)
local SwipeDirection = require(AppChat.Enums.SwipeDirection)
local FFlagAppChatSwipeGestureLatestConfig = require(AppChat.Flags.FFlagAppChatSwipeGestureLatestConfig)

local swipeStartThreshold = game:DefineFastInt("AppChatSwipeStartThreshold", 10)
local swipeCompleteThreshold = game:DefineFastInt("AppChatSwipeCompleteThreshold", 50)
local swipeMaxVerticalDrift = game:DefineFastInt("AppChatSwipeMaxVerticalDrift", 35)
local bool1 = game:DefineFastFlag("AppChatGlobalSwipeTracking", false)

local currentCurrent = nil

local tbl1 = { frequency = 4, dampingRatio = 0.8 }

local tbl2 = {
    onSwipeComplete = function() end,
    direction = SwipeDirection.Right,
    swipeStartThreshold = swipeStartThreshold,
    swipeCompleteThreshold = swipeCompleteThreshold,
    swipeMaxVerticalDrift = swipeMaxVerticalDrift
}

local function useSwipeGesture(tbl3)
    local current = Cryo.Dictionary.union(tbl2, tbl3)
    local var2 = React.useRef(current)
    if FFlagAppChatSwipeGestureLatestConfig then
        var2.current = current
    end

    local swipeOffset, var4 = ReactOtter.useAnimatedBinding(0)
    local swipeProgress = React.useMemo(function()
        return swipeOffset:map(function(num4: number): number
            return math.clamp(num4 / current.swipeCompleteThreshold, 0, 1)
        end)
    end, { swipeOffset, current.swipeCompleteThreshold })

    local var6 = React.useRef(nil)
    local var7 = React.useRef(nil)
    local var8 = React.useRef(Vector2.zero)
    local var9 = React.useRef(false)

    local var10 = React.useMemo(function()
        local function disconnectInputListener() -- Luacid: Inlined by compiler; 1 call site recovered
            if var7.current then
                var7.current:Disconnect()
                var7.current = nil
            end
        end

        local function isPastCompleteThreshold() -- Luacid: Inlined by compiler; 2 call sites recovered
            return var9.current
        end

        return {
            getActiveInput = function()
                return var6.current
            end,
            setOffset = function(swipeCompleteThreshold: number)
                local current = var2.current
                var4(ReactOtter.spring(swipeCompleteThreshold, tbl1))

                if not isPastCompleteThreshold() and current.swipeCompleteThreshold < swipeCompleteThreshold then
                    var9.current = true
                    if current.onSwipeThresholdReached then
                        current.onSwipeThresholdReached()
                    end
                elseif isPastCompleteThreshold() and swipeCompleteThreshold <= current.swipeCompleteThreshold then
                    var9.current = false
                end
            end,
            isPastCompleteThreshold = isPastCompleteThreshold,
            startSwipe = function(current2, callback: (...any) -> (...any))
                if bool1 then
                    currentCurrent = current2
                end
                var6.current = current2
                var8.current = Vector2.new(current2.Position.X, current2.Position.Y)
                var7.current = current2.Changed:Connect(function()
                    callback()
                end)
            end,
            resetSwipe = function()
                if bool1 and currentCurrent == var6.current then
                    currentCurrent = nil
                end
                var6.current = nil
                var9.current = false
                disconnectInputListener()
                var4(ReactOtter.spring(0, tbl1))
            end,
            disconnectInputListener = disconnectInputListener
        }
    end, { var4 })

    local var11 = React.useCallback(function()
        local current = var2.current
        local activeInput = var10.getActiveInput()
        if not activeInput then
            return
        end

        if activeInput.UserInputState == Enum.UserInputState.End or activeInput.UserInputState == Enum.UserInputState.Cancel then
            if var10.isPastCompleteThreshold() then
                current.onSwipeComplete()
            end
            var10.resetSwipe()
            return
        end

        local var11 = Vector2.new(activeInput.Position.X, activeInput.Position.Y) - var8.current
        local var12 = if current.direction == SwipeDirection.Right then var11.X else -var11.X
        local num4 = math.abs(var11.Y)

        if var12 < current.swipeStartThreshold or current.swipeMaxVerticalDrift < num4 then
            var10.setOffset(0)
            return
        end

        local num5 = math.max(0, var12)
        var10.setOffset(num5)
    end, { var10 })

    React.useEffect(function()
        return var10.resetSwipe
    end, { var10.resetSwipe })

    local onInputBegan = React.useCallback(function(_, arg1)
        if (not bool1 or currentCurrent == nil)
            and var10.getActiveInput() == nil
            and (arg1.UserInputType == Enum.UserInputType.Touch or arg1.UserInputType == Enum.UserInputType.MouseButton1)
        then
            var10.startSwipe(arg1, var11)
        end
    end, { var10, var11 })

    return React.useMemo(function()
        return {
            swipeOffset = swipeOffset,
            swipeProgress = swipeProgress,
            onInputBegan = onInputBegan
        }
    end, { swipeOffset, swipeProgress, onInputBegan })
end

return useSwipeGesture
