-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local TweenService = game:GetService("TweenService")

local _React = require(GenericAbuseReportingParent.React)

local function scrollToItem(arg1, arg2)
    if not (arg1 and arg1.current and arg2) then
        return
    end

    local instance = arg1.current:FindFirstChildWhichIsA("ScrollingFrame", true)
    if not instance then
        return
    end

    task.wait()

    local current = arg2.current
    if not current then
        return
    end

    local absolutePositionY = current.AbsolutePosition.Y
    local var1 = absolutePositionY + current.AbsoluteSize.Y
    local absolutePositionY2 = instance.AbsolutePosition.Y
    local var2 = absolutePositionY2 + instance.AbsoluteWindowSize.Y

    if absolutePositionY2 <= absolutePositionY and var1 <= var2 then
        return
    end

    local var3 = absolutePositionY - instance.AbsolutePosition.Y + instance.CanvasPosition.Y
    local var4 = var1 - instance.AbsolutePosition.Y + instance.CanvasPosition.Y

    local canvasPositionY = instance.CanvasPosition.Y
    if absolutePositionY < absolutePositionY2 then
        canvasPositionY = var3
    elseif var2 < var1 then
        canvasPositionY = var4 - instance.AbsoluteWindowSize.Y
    end

    local y = math.max(0, math.min(canvasPositionY, instance.AbsoluteCanvasSize.Y - instance.AbsoluteWindowSize.Y))

    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    TweenService:Create(instance, tweenInfo, { CanvasPosition = Vector2.new(0, y) }):Play()
end

return scrollToItem
