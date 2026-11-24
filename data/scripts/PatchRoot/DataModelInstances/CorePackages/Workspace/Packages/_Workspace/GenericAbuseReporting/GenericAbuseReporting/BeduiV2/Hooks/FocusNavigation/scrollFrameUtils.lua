-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:41:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local GamepadUtils = require(GenericAbuseReportingParent.InputUi).Gamepad.GamepadUtils

local function getScrollableAncestor(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return nil
    elseif arg1:IsA("ScrollingFrame") then
        return arg1
    end
    return arg1:FindFirstAncestorWhichIsA("ScrollingFrame")
end

local function canScrollVertically(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1.ScrollingEnabled then arg1.AbsoluteCanvasSize.Y > arg1.AbsoluteWindowSize.Y else false
end

local function clampCanvasY(arg1, num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return math.clamp(num1, 0, math.max(0, arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y))
end

local function isInsideContainer(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1 == nil or arg2 == nil) and (arg1 == arg2 or arg1:IsDescendantOf(arg2))
end

return {
    getScrollableAncestor = getScrollableAncestor,
    canScrollVertically = canScrollVertically,
    clampCanvasY = clampCanvasY,
    scrollByIncrement = function(arg1, y: number)
        if arg1 == nil then
            return
        end

        local y2 = arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y

        if y > 0 and arg1.CanvasPosition.Y >= y2 - 350 then
            arg1.CanvasPosition = Vector2.new(0, y2)
        elseif y < 0 and arg1.CanvasPosition.Y <= 350 then
            arg1.CanvasPosition = Vector2.new(0, 0)
        else
            arg1.CanvasPosition += Vector2.new(0, y)
        end
    end,
    scrollByAnalogInput = function(arg1, arg2, num1: number)
        if arg1 == nil or not canScrollVertically(arg1) then
            return
        end

        local vector2 = Vector2.new(arg2.Position.X, arg2.Position.Y)
        local var1 = GamepadUtils.normalizeStickByDeadzone(vector2)
        if var1.Y == 0 then
            return
        end

        local y = clampCanvasY(arg1, arg1.CanvasPosition.Y + num1 * -var1.Y * 1000)
        arg1.CanvasPosition = Vector2.new(arg1.CanvasPosition.X, y)
    end,
    isInsideContainer = isInsideContainer,
    resolveScrollTarget = function(arg1, arg2)
        if arg2 == nil then
            return nil
        end

        if not isInsideContainer(arg1, arg2) then
            return nil
        end

        local scrollableAncestor = getScrollableAncestor(arg1)

        if scrollableAncestor == nil then
            return nil
        end

        if scrollableAncestor == arg2 or scrollableAncestor:IsDescendantOf(arg2) then
            return scrollableAncestor
        end

        return nil
    end,
    SCROLL_INCREMENT = 300,
    STICK_MAX_SPEED = 1000
}
