-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParent.React)
local ReactOtter = require(scriptParentParentParent.ReactOtter)
local ReactUtils = require(scriptParentParentParent.ReactUtils)

local NavigationType = require(scriptParentParent.Enums.NavigationType)

local isPointWithinBounds = require(scriptParentParent.Utils.isPointWithinBounds)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useEventConnection = ReactUtils.useEventConnection
local useMotor = ReactOtter.useMotor
local useRef = React.useRef
local useState = React.useState

local function useSnapScrollController(bool1: boolean, num1: number, vector2: Vector2, num2: number)
    local var1 = useRef(nil)
    local var2, var3 = useState(num1)
    local var4 = useRef(nil)
    local var5 = useRef(false)
    local var6 = useRef(nil)
    local var7 = useRef(nil)
    local var8 = useRef(nil)
    local var9 = useRef(nil)
    local var10 = useRef(false)

    local var11 = useCallback(function(yOffset: number?)
        if not var4.current then
            return
        end

        var4.current.Position = UDim2.new(0.5, 0, 0, yOffset)
    end, {})

    local var12 = useCallback(function()
        var5.current = false
    end, {})

    local var13 = useMotor((num1 - 1) * -vector2.Y, var11, var12)

    local var14 = React.useCallback(function(num3: number, bool2: boolean?)
        if not bool1 or not var4.current or not var1.current or var5.current or var10.current or num2 < 1 then
            return
        end

        assert(var4.current ~= nil, "motionRef.current is nil")

        var5.current = true

        local num4 = math.clamp(num3, 1, num2)
        local var14 = (num4 - 1) * -vector2.Y

        if bool2 then
            var13(ReactOtter.instant(var14))
        else
            var13(ReactOtter.spring(var14, { frequency = 8 }))
        end

        var3(num4)
    end, {
        bool1,
        vector2,
        num2,
        var13
    })
    local var15 = React.useCallback(function(arg1, bool2: boolean?)
        if arg1 == NavigationType.Previous then
            var14(var2 - 1, bool2)
        elseif arg1 == NavigationType.Next then
            var14(var2 + 1, bool2)
        else
            var14(var2, bool2)
        end
    end, { var2, var14 })

    useEffect(function()
        if not var4.current or var6.current == vector2 then
            return
        end

        var5.current = false
        var15(NavigationType.Current, true)
        var6.current = vector2
    end, { vector2, var15 })

    local var16 = React.useCallback(function(_, _, _, userInputState, _)
        if userInputState == Enum.UserInputState.Begin then
            var15(NavigationType.Current)
            var10.current = true
        elseif userInputState == Enum.UserInputState.End then
            var10.current = false
            var8.current = nil
        end
    end, { var15 })

    useEventConnection(UserInputService.TouchPinch, var16)

    local var17 = React.useCallback(function(current)
        if bool1
            and var4.current
            and var1.current
            and not var8.current
            and isPointWithinBounds(
                Vector2.new(current.Position.X, current.Position.Y),
                var1.current.AbsolutePosition,
                var1.current.AbsoluteSize
            )
        then
            var7.current = var4.current.Position.Y.Offset
            var9.current = current.Position.Y
            var8.current = current
            var13(ReactOtter.instant(var4.current.Position.Y.Offset))
        end
    end, { bool1, var13 })

    useEventConnection(UserInputService.TouchStarted, var17)

    local var18 = React.useCallback(function(current)
        if not bool1
            or not var4.current
            or not var1.current
            or var8.current ~= current
            or not var7.current
            or not var9.current
            or var10.current
        then
            return
        end

        local var18 = current.Position.Y - var9.current
        local num3 = math.clamp(var7.current + var18, (num2 - 1) * -vector2.Y - 100, 100)

        var13(ReactOtter.instant(num3))
    end, {
        bool1,
        vector2,
        num2,
        var13
    })
    useEventConnection(UserInputService.TouchMoved, var18)

    local var19 = React.useCallback(function(swipeDirection)
        if not bool1 or not var4.current or not var1.current or not var8.current or var10.current or var5.current then
            return
        end

        if swipeDirection == Enum.SwipeDirection.Up then
            var15(NavigationType.Next)
        elseif swipeDirection == Enum.SwipeDirection.Down then
            var15(NavigationType.Previous)
        else
            var15(NavigationType.Current)
        end
    end, { bool1, var15 })

    useEventConnection(UserInputService.TouchSwipe, var19)

    local var20 = React.useCallback(function(current)
        if not bool1 or not var4.current or not var1.current or var8.current ~= current or not var7.current or var5.current then
            return
        end

        local var20 = var4.current.Position.Y.Offset - var7.current

        if -var20 > vector2.Y * 0.25 then
            var15(NavigationType.Next)
        elseif vector2.Y * 0.25 < var20 then
            var15(NavigationType.Previous)
        else
            var15(NavigationType.Current)
        end

        var8.current = nil
        var7.current = nil
    end, { bool1, vector2, var15 })

    useEventConnection(UserInputService.TouchEnded, var20)

    local var21 = React.useCallback(function(num3: number, vector2_2: Vector2)
        if not bool1 then
            return
        end

        if num3 < 0 or vector2_2.Y < -0.1 then
            var15(NavigationType.Next)
        elseif num3 > 0 or vector2_2.Y > 0.1 then
            var15(NavigationType.Previous)
        end
    end, { bool1, var15 })

    useEventConnection(UserInputService.PointerAction, var21)

    return var2, var1, var4, var14, var15
end

return useSnapScrollController
