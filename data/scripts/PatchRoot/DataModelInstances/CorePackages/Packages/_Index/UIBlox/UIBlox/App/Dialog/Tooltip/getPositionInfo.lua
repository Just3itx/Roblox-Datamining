-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TooltipOrientation = require(script.Parent.Enum.TooltipOrientation)

return function(xOffset, yOffset, updatedOrientation, arg2, arg3, arg4, arg5)
    local result = {}

    local var1 = arg2 + arg3 * 0.5
    local var2 = arg2 + arg3

    local xOffset2 = 0
    local yOffset2 = 0
    local x, x2, yOffset3, y

    if updatedOrientation == TooltipOrientation.Bottom or updatedOrientation == TooltipOrientation.Top then
        if not arg5 and yOffset + 8 + 12 > arg4.Y - var2.Y then
            updatedOrientation = TooltipOrientation.Top
        end

        local var3 = arg4.X - 12 - xOffset
        x = math.clamp(var1.X - xOffset * 0.5, 12, var3)

        x2 = x - arg2.X

        local var4 = xOffset - 12 - 16

        if xOffset < 40 then
            result.caretPosition = UDim2.fromScale(0.5, 0)
        elseif arg5 then
            local xOffset3 = math.clamp(arg3.X * 0.5 + math.abs(arg3.X * arg5.X.Scale + arg5.X.Offset), 12, var4)
            result.caretPosition = UDim2.fromOffset(xOffset3, 0)
        elseif var1.X - xOffset * 0.5 >= 12 and var1.X + xOffset * 0.5 <= arg4.X - 12 then
            result.caretPosition = UDim2.fromScale(0.5, 0)
        else
            local xOffset3 = math.clamp(var1.X - x, 12, var4)
            result.caretPosition = UDim2.fromOffset(xOffset3, 0)
        end

        result.caretFrameSize = UDim2.fromOffset(xOffset, 8)
        result.caretImageSize = UDim2.fromOffset(16, 8)
        result.caretAnchorPoint = Vector2.new(0.5, 0)
        result.fillDirection = Enum.FillDirection.Vertical

        if updatedOrientation == TooltipOrientation.Bottom then
            yOffset3 = arg2.Y + arg3.Y
            y = arg3.Y
            result.caretLayoutOrder = 1
            result.contentLayoutOrder = 2
            yOffset2 = 4
        else
            yOffset3 = arg2.Y - yOffset - 8
            y = -(yOffset + 8)
            result.caretLayoutOrder = 2
            result.contentLayoutOrder = 1
            yOffset2 = -4
        end
    else
        local var3 = arg4.Y - 12 - yOffset
        yOffset3 = math.clamp(var1.Y - yOffset * 0.5, 12, var3)
        y = yOffset3 - arg2.Y

        local var4 = yOffset - 12 - 16
        if arg5 then
            local yOffset4 = math.clamp(arg3.Y * 0.5 + math.abs(arg3.Y * arg5.Y.Scale + arg5.Y.Offset), 12, var4)
            result.caretPosition = UDim2.fromOffset(0, yOffset4)
        elseif var1.Y - yOffset * 0.5 >= 12 and var1.Y + yOffset * 0.5 <= arg4.Y - 12 or yOffset <= 40 then
            result.caretPosition = UDim2.fromScale(0, 0.5)
        else
            local var5 = yOffset - 12 - 16
            local yOffset4 = math.clamp(var1.Y - yOffset3, 12, var5)
            result.caretPosition = UDim2.fromOffset(0, yOffset4)
        end

        result.caretFrameSize = UDim2.fromOffset(8, yOffset)
        result.caretImageSize = UDim2.fromOffset(8, 16)
        result.caretAnchorPoint = Vector2.new(0, 0.5)
        result.fillDirection = Enum.FillDirection.Horizontal

        if updatedOrientation == TooltipOrientation.Right then
            x = var2.X
            x2 = arg3.X
            result.caretLayoutOrder = 1
            result.contentLayoutOrder = 2
            xOffset2 = 4
        else
            x = arg2.X - xOffset - 8
            x2 = -(xOffset - 8)
            result.caretLayoutOrder = 2
            result.contentLayoutOrder = 1
            xOffset2 = -4
        end
    end

    result.absolutePosition = UDim2.fromOffset(x, yOffset3)
    result.position = UDim2.fromOffset(x2, y)
    result.animatedDistance = UDim2.fromOffset(xOffset2, yOffset2)
    result.updatedOrientation = updatedOrientation
    return result
end
