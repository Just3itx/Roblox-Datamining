-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParentParent.React)
local _Types = require(script.Parent.Types)
local ProgressIcon = require(script.Parent.ProgressIcon)

local function useRenderStepped(tbl1, tbl2, tbl3)
    local var1 = React.useRef(0)
    local var2 = React.useRef(0)

    local isAnimationRunning = tbl1.isAnimationRunning
    local isKeyPressed = tbl1.isKeyPressed
    local isKeyHolding = tbl1.isKeyHolding

    local onKeyHolding = tbl2.onKeyHolding
    local onAnimationRunning = tbl2.onAnimationRunning
    local onComplete = tbl2.onComplete
    local onReset = tbl2.onReset

    local animationTriggerTime = tbl3.animationTriggerTime
    local animationKeyHoldingTime = tbl3.animationKeyHoldingTime
    local animationCoolDownTime = tbl3.animationCoolDownTime

    local var3 = React.useCallback(function(num1: number)
        var2.current += num1
        if var2.current >= animationTriggerTime then
            onKeyHolding()
        end
    end, { onKeyHolding, animationTriggerTime })

    local var4 = React.useCallback(function(num1: number)
        local var4 = var1
        var4.current = math.clamp(var1.current + num1 / animationKeyHoldingTime, 0, 1)
        onAnimationRunning(var1.current)
        if var1.current >= 1 then
            onComplete()
        end
    end, { onAnimationRunning, animationKeyHoldingTime, onComplete })

    local var5 = React.useCallback(function(num1: number)
        local var5 = var1
        var5.current = math.clamp(var1.current - num1 / animationCoolDownTime, 0, 1)
        onAnimationRunning(var1.current)
        if var1.current <= 0 then
            onReset()
        end
    end, { onAnimationRunning, animationCoolDownTime, onReset })

    React.useEffect(function()
        local connection = nil
        local var6 = nil
        if isKeyHolding then
            var1.current = 0
            var6 = var4
        elseif isKeyPressed then
            var6 = var3
        elseif isAnimationRunning then
            var6 = var5
        end

        if var6 then
            connection = RunService.RenderStepped:Connect(var6)
        end

        return if connection then function()
            if isKeyPressed then
                var2.current = 0
            end
            connection:Disconnect()
        end else function() end
    end, {
        isKeyPressed,
        isKeyHolding,
        isAnimationRunning,
        var3,
        var4,
        var5
    })
end

local function ProgressIconAnimated(arg1)
    local isKeyPressed, var2 = React.useState(false)
    local isKeyHolding, var4 = React.useState(false)
    local isAnimationRunning, var6 = React.useState(false)
    local var7, var8 = React.useState(false)

    local var9, var10 = React.useBinding(nil)

    local onKeyHolding = React.useCallback(function()
        var4(true)
        var6(true)
    end, {})

    local onAnimationRunning = React.useCallback(function(arg2)
        var10(arg2)
    end, {})

    local onComplete = React.useCallback(function()
        var2(false)
        var4(false)
        var6(false)
        var8(true)
        if arg1.onHoldComplete then
            arg1.onHoldComplete()
        end
    end, { arg1.onHoldComplete })

    local onReset = React.useCallback(function()
        var6(false)
        var10(nil)
    end, {})

    useRenderStepped(
        {
            isKeyPressed = isKeyPressed,
            isKeyHolding = isKeyHolding,
            isAnimationRunning = isAnimationRunning
        },
        {
            onKeyHolding = onKeyHolding,
            onAnimationRunning = onAnimationRunning,
            onComplete = onComplete,
            onReset = onReset
        },
        {
            animationTriggerTime = arg1.animationTriggerTime,
            animationKeyHoldingTime = arg1.animationKeyHoldingTime,
            animationCoolDownTime = arg1.animationCoolDownTime
        }
    )
    local var15 = React.useCallback(function(arg2)
        if arg2.UserInputType ~= Enum.UserInputType.Keyboard and arg2.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end

        if arg2.KeyCode ~= arg1.keyCode then
            return
        end

        if arg2.UserInputState ~= Enum.UserInputState.Begin then
            if arg2.UserInputState == Enum.UserInputState.End then
                var2(false)
                var4(false)
            end

            return
        end

        var2(true)
        var8(false)
        if isAnimationRunning then
            var4(true)
            return
        end
        var10(nil)
    end, { arg1.keyCode, isAnimationRunning })

    React.useEffect(function()
        if arg1.progress then
            return function() end
        end

        local connection = UserInputService.InputBegan:Connect(var15)
        local connection2 = UserInputService.InputEnded:Connect(var15)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var15, arg1.progress })

    local bool1 = false
    if arg1.progress or isKeyHolding or isAnimationRunning or var7 then
        bool1 = true
    end

    return React.createElement(
        ProgressIcon,
        {
            progress = arg1.progress or var9,
            icon = arg1.icon,
            iconHolding = arg1.iconHolding,
            isHolding = bool1
        }
    )
end
return ProgressIconAnimated
