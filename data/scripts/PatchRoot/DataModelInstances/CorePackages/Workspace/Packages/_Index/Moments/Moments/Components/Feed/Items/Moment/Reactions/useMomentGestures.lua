-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local UserInputService = game:GetService("UserInputService")

local React = require(MomentsParent.React)
local useEventConnection = require(MomentsParent.ReactUtils).useEventConnection

local function isActivationInput(current): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return current.UserInputType == Enum.UserInputType.MouseButton1 or current.UserInputType == Enum.UserInputType.Touch
end

local function withinDistance(vector2: Vector2, vector2_2: Vector2, magnitude: number): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return (vector2 - vector2_2).Magnitude <= magnitude
end

local function containsPoint(arg1, vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local absolutePosition = arg1.AbsolutePosition
    local var1 = absolutePosition + arg1.AbsoluteSize
    return vector2.X >= absolutePosition.X and vector2.X <= var1.X and vector2.Y >= absolutePosition.Y and vector2.Y <= var1.Y
end

local function useMomentGestures(bool1: boolean, current, func1: ((...any) -> (...any))?, tbl1)
    local ref = React.useRef(nil)

    local var2 = React.useRef(current)
    var2.current = current

    local var3 = func1 or os.clock

    local var4 = React.useRef(0)
    local var5 = React.useRef(Vector2.zero)
    local var6 = React.useRef(0)
    local var7 = React.useRef(nil)
    local var8 = React.useRef(nil)
    local var9 = React.useRef(nil)
    local var10 = React.useRef(false)
    local var11 = React.useRef(false)
    local var12 = React.useRef(nil)
    local var13 = React.useRef(false)
    local var14 = React.useRef(false)
    local var15 = if tbl1 == nil then 50 elseif tbl1.movementThreshold == nil then 50 else tbl1.movementThreshold

    local var16 = if tbl1 == nil then 0.5 elseif tbl1.longPressThreshold == nil then 0.5 else tbl1.longPressThreshold
    local scrollingFrameRef = if tbl1 == nil then nil else tbl1.scrollingFrameRef
    local cancellationSignal = if tbl1 == nil then nil else tbl1.cancellationSignal
    local bool2 = not (tbl1 == nil) and tbl1.cancelWhenInactive == true
    local bool3 = not (tbl1 == nil) and tbl1.cancelOnUserScroll == true

    local var17 = React.useCallback(function()
        if not var11.current then
            return
        end
        var11.current = false
        local onLongPressCancel = var2.current.onLongPressCancel
        if onLongPressCancel then
            onLongPressCancel()
        end
    end, {})

    local var18 = React.useCallback(function()
        var17()
        var9.current = nil
        var12.current = nil
        var13.current = false
        var14.current = false
        var10.current = false
        var6.current = 0
        if var7.current then
            task.cancel(var7.current)
            var7.current = nil
        end
        if var8.current then
            task.cancel(var8.current)
            var8.current = nil
        end
    end, {})

    local onInputBegan = React.useCallback(function(current2)
        if not (bool1 and isActivationInput(current2)) then
            return
        end

        var9.current = current2
        var10.current = false
        var13.current = false
        var14.current = false

        local var1 = var3()
        local vector2 = Vector2.new(current2.Position.X, current2.Position.Y)
        var12.current = vector2

        local bool4 = var1 - var4.current <= 0.25
        local bool5 = not not withinDistance(vector2, var5.current, 50)
        if bool4 and bool5 then
            local var20 = var6
            var20.current += 1
        else
            var6.current = 1
        end
        var4.current = var1
        var5.current = vector2

        if var6.current >= 2 and var8.current then
            task.cancel(var8.current)
            var8.current = nil
        end

        if var7.current then
            task.cancel(var7.current)
        end
        var17()
        var11.current = true
        local onLongPressStart = var2.current.onLongPressStart
        if onLongPressStart then
            onLongPressStart()
        end
        var7.current = task.delay(var16, function()
            if not bool1 then
                return
            end
            if var9.current ~= current2 or var10.current then
                return
            end

            var10.current = true
            var11.current = false
            local onLongPress = var2.current.onLongPress
            if onLongPress then
                onLongPress()
            end
        end)
    end, {
        bool1,
        var3,
        var16,
        var17
    })
    local onInputChanged = React.useCallback(function(arg1)
        local current2 = var9.current
        local current3 = var12.current
        local current4 = if scrollingFrameRef == nil then nil else scrollingFrameRef.current

        if bool3 and current4 ~= nil then
            local userInputType = arg1.UserInputType
            local vector2 = Vector2.new(arg1.Position.X, arg1.Position.Y)
            local bool4 = userInputType == Enum.UserInputType.Touch and arg1 == current2
            local bool5 = userInputType == Enum.UserInputType.MouseMovement
                and current2 ~= nil
                and current2.UserInputType == Enum.UserInputType.MouseButton1

            if current2 == nil or current3 == nil then
                bool5 = false
            elseif bool4 or bool5 then
                bool5 = not withinDistance(vector2, current3, 2)
            end

            local bool6 = userInputType == Enum.UserInputType.MouseWheel and containsPoint(current4, (UserInputService:GetMouseLocation()))
            local bool7 = not (var7.current == nil) and var2.current.onLongPress ~= nil

            if bool5 and bool7 and withinDistance(vector2, current3, 10) then
                var14.current = true
                var6.current = 0
                if var8.current then
                    task.cancel(var8.current)
                    var8.current = nil
                end
            elseif bool5 or bool6 then
                var18()
                return
            end
        end
        if not bool1
            or current2 == nil
            or arg1.UserInputType == Enum.UserInputType.Touch and arg1 ~= current2
            or current3 == nil
            or var13.current
            or withinDistance(Vector2.new(arg1.Position.X, arg1.Position.Y), current3, var15)
        then
            return
        end

        var13.current = true
        if var7.current then
            task.cancel(var7.current)
            var7.current = nil
        end
        var17()
    end, {
        bool1,
        var15,
        scrollingFrameRef,
        bool3,
        var18,
        var17
    })

    useEventConnection(UserInputService.InputChanged, onInputChanged, { onInputChanged })

    local onInputEnded = React.useCallback(function(current2)
        if var9.current ~= current2 then
            return
        end
        var9.current = nil

        if var7.current then
            task.cancel(var7.current)
            var7.current = nil
        end
        var17()

        if var10.current or var13.current or var14.current or not isActivationInput(current2) then
            return
        end

        local onTap = var2.current.onTap
        if onTap then
            onTap(var5.current, var6.current)
        end

        if var6.current >= 2 then
            if var8.current then
                task.cancel(var8.current)
                var8.current = nil
            end
            var6.current = 0
            local onDoubleTap = var2.current.onDoubleTap
            if onDoubleTap then
                onDoubleTap(var5.current)
            end

            return
        end

        if var8.current then
            task.cancel(var8.current)
        end

        local current3 = var5.current
        var8.current = task.delay(0.25, function()
            var8.current = nil
            if var6.current == 1 then
                local onSingleTapConfirmed = var2.current.onSingleTapConfirmed
                if onSingleTapConfirmed then
                    onSingleTapConfirmed(current3)
                end
            end
            var6.current = 0
        end)
    end, { var17 })

    useEventConnection(UserInputService.InputEnded, onInputEnded, { onInputEnded })

    React.useEffect(function()
        if cancellationSignal ~= nil then
            local connection = cancellationSignal:Connect(var18)
            return function()
                connection:Disconnect()
            end
        end
    end, { cancellationSignal, var18 })

    React.useEffect(function()
        if bool2 and not bool1 then
            var18()
        end
    end, { bool1, bool2, var18 })

    React.useEffect(function()
        local current2 = ref.current
        if current2 ~= nil then
            local connection = current2.InputBegan:Connect(onInputBegan)
            return function()
                connection:Disconnect()
            end
        end
    end, { onInputBegan })

    React.useEffect(function()
        return function()
            var11.current = false
            var18()
        end
    end, { var18 })

    return {
        ref = ref,
        onInputBegan = onInputBegan,
        onInputChanged = onInputChanged,
        onInputEnded = onInputEnded
    }
end

return useMomentGestures
