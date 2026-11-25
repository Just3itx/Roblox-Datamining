-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")
local React = require(VirtualEvents.Parent.React)
local TweenService = game:GetService("TweenService")

local tbl1 = {
    linear = Enum.EasingStyle.Linear,
    quadratic = Enum.EasingStyle.Quad,
    cubic = Enum.EasingStyle.Cubic
}

local function stopTween(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl2.current then
        tbl2.current:Cancel()
        tbl2.current = nil
    end
end

local function isApproximatelyEqual(current: number, num1: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.abs(current - num1) < 0.001
end

local function useAnimation(tbl2)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)

    React.useEffect(function()
        local startOffset = tbl2.startOffset
        local endOffset = tbl2.endOffset or 0
        local duration = tbl2.duration or 0.2
        local easingStyle = tbl2.easingStyle or "quadratic"

        if isApproximatelyEqual(startOffset, endOffset) then
            return
        end

        local numberValue = Instance.new("NumberValue")
        numberValue.Value = startOffset
        var2.current = startOffset

        local easingStyle2 = tbl1[easingStyle] or tbl1.quadratic
        local tweenInfo = TweenInfo.new(duration, easingStyle2, Enum.EasingDirection.Out)

        stopTween(var1)
        var1.current = TweenService:Create(numberValue, tweenInfo, { Value = endOffset })

        local connection = numberValue:GetPropertyChangedSignal("Value"):Connect(function()
            local numberValueValue = numberValue.Value

            if var2.current == nil or not isApproximatelyEqual(numberValueValue, var2.current) then
                var2.current = numberValueValue
                tbl2.setAnimationOffset(numberValueValue)
            end
        end)

        if var1.current then
            var1.current.Completed:Connect(function()
                connection:Disconnect()
                numberValue:Destroy()
                var1.current = nil
                var2.current = nil
            end)
            var1.current:Play()
        end

        return function()
            connection:Disconnect()
            stopTween(var1)
            numberValue:Destroy()
            var2.current = nil
        end
    end, {
        tbl2.startOffset,
        tbl2.endOffset,
        tbl2.duration,
        tbl2.easingStyle,
        tbl2.setAnimationOffset
    })
end
return useAnimation
