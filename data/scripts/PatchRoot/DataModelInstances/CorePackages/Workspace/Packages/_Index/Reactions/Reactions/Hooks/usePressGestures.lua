-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactionsParent = script:FindFirstAncestor("Reactions").Parent

local UserInputService = game:GetService("UserInputService")

local _Foundation = require(ReactionsParent.Foundation)
local React = require(ReactionsParent.React)

local function isPressInput(current): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return current.UserInputType == Enum.UserInputType.Touch or current.UserInputType == Enum.UserInputType.MouseButton1
end

local function toVector2(position: vector): Vector2 -- Luacid: Inlined by compiler; 3 call sites recovered
    return Vector2.new(position.X, position.Y)
end

local function usePressGestures(tbl1, current)
    local var1 = React.useRef(current)
    var1.current = current

    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(Vector2.zero)
    local var5 = React.useRef(nil)
    local var6 = React.useRef(false)
    local var7 = React.useRef(false)

    local var8 = React.useRef(nil)
    local var9 = React.useRef(Vector2.zero)
    local var10 = React.useRef(nil)
    local var11 = React.useRef(nil)

    local var12 = React.useCallback(function()
        var2.current = nil
        var6.current = false
        var7.current = false
        if var3.current ~= nil then
            var3.current:Disconnect()
            var3.current = nil
        end
        if var5.current ~= nil then
            task.cancel(var5.current)
            var5.current = nil
        end
    end, {})

    local var13 = React.useCallback(function(vector2: Vector2)
        if var6.current then
            local onHoldMoved = var1.current.onHoldMoved
            if onHoldMoved then
                onHoldMoved(vector2)
            end
        elseif (vector2 - var4.current).Magnitude > 10 then
            var12()
        end
    end, { var12 })

    local var14 = React.useCallback(function(arg1)
        local current2 = var6.current
        local current3 = var7.current
        local bool1 = arg1.UserInputState == Enum.UserInputState.Cancel
        var12()

        local current4 = var1.current
        if current2 then
            if current4.onHoldEnded then
                current4.onHoldEnded(if bool1 then nil else toVector2(arg1.Position))
            end

            return
        end

        if bool1 then
            return
        end

        local vector2 = toVector2(arg1.Position)
        if current4.onDoubleTap == nil then
            if current4.onTap then
                current4.onTap()
            end

            return
        end
        if current3 then
            current4.onDoubleTap(vector2)
            return
        end
        var9.current = vector2
        var8.current = task.delay(0.25, function()
            var8.current = nil
            local onTap = var1.current.onTap
            if onTap then
                onTap()
            end
        end)
    end, { var12 })

    local onInputBegan = React.useCallback(function(current2)
        if not isPressInput(current2) or var2.current ~= nil then
            return
        end

        local vector2 = toVector2(current2.Position)

        local current3 = var8.current
        if current3 ~= nil then
            task.cancel(current3)
            var8.current = nil
            if (vector2 - var9.current).Magnitude <= 50 then
                var7.current = true
            else
                local onTap = var1.current.onTap
                if onTap then
                    onTap()
                end
            end
        end

        var2.current = current2
        var4.current = vector2
        var3.current = current2.Changed:Connect(function(str1: string)
            if str1 == "Position" then
                var13(toVector2(current2.Position))
            elseif str1 == "UserInputState" then
                local userInputState = current2.UserInputState
                if userInputState == Enum.UserInputState.End or userInputState == Enum.UserInputState.Cancel then
                    var14(current2)
                end
            end
        end)

        if var1.current.onHold == nil then
            return
        end
        local holdDuration = var1.current.holdDuration or 0.4
        var5.current = task.delay(holdDuration, function()
            var5.current = nil
            if var2.current ~= current2 then
                return
            end
            var6.current = true
            local onHold = var1.current.onHold
            if onHold then
                onHold()
            end
        end)
    end, { var13, var14 })

    local onInputChanged = React.useCallback(function(arg1)
        local current2 = var2.current
        if current2 == nil
            or current2.UserInputType ~= Enum.UserInputType.MouseButton1
            or arg1.UserInputType ~= Enum.UserInputType.MouseMovement
        then
            return
        end
        var13(toVector2(arg1.Position))
    end, { var13 })

    React.useEffect(function()
        local current2 = tbl1.current
        if current2 == var10.current then
            return
        end
        if var11.current ~= nil then
            var11.current:Disconnect()
            var11.current = nil
        end
        var10.current = current2

        if current2 ~= nil and (if typeof(current2) == "Instance" then current2:IsA("GuiObject") else current2.InputBegan ~= nil) then
            var11.current = current2.InputBegan:Connect(onInputBegan)
        end
    end)

    React.useEffect(function()
        local connection = UserInputService.InputChanged:Connect(onInputChanged)
        return function()
            connection:Disconnect()
        end
    end, { onInputChanged })

    React.useEffect(function()
        return function()
            var12()
            if var11.current ~= nil then
                var11.current:Disconnect()
                var11.current = nil
            end
            if var8.current ~= nil then
                task.cancel(var8.current)
                var8.current = nil
            end
        end
    end, { var12 })

    return { onInputBegan = onInputBegan, onInputChanged = onInputChanged }
end

return usePressGestures
