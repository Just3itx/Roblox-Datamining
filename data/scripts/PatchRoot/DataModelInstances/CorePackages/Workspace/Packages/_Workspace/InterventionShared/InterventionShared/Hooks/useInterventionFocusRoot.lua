-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local useMemo = require(InterventionSharedParent.React).useMemo

local FocusNavigationUtils = require(InterventionSharedParent.FocusNavigationUtils)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(InterventionSharedParent.InputHandlers)
local useFocusedGuiObject = require(InterventionSharedParent.ReactFocusNavigation).useFocusedGuiObject
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.PageUp] = FocusNavigationEventNameEnum.ScrollUp,
    [Enum.KeyCode.LeftBracket] = FocusNavigationEventNameEnum.ScrollUp,
    [Enum.KeyCode.PageDown] = FocusNavigationEventNameEnum.ScrollDown,
    [Enum.KeyCode.RightBracket] = FocusNavigationEventNameEnum.ScrollDown
}

local function getScrollableAncestor(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return nil
    elseif arg1:IsA("ScrollingFrame") then
        return arg1
    end
    return arg1:FindFirstAncestorWhichIsA("ScrollingFrame")
end

local function scrollTo(arg1, y: number) -- Luacid: unused: defined but never referenced
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
end

local function useInterventionFocusRoot(tbl2)
    local scrollableAncestor = getScrollableAncestor((useFocusedGuiObject()))

    local eventHandlers = useMemo(function()
        local tbl3 = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onPress(function(arg1)
                    arg1:cancel()
                end)
            }
        }

        if scrollableAncestor then
            tbl3[FocusNavigationEventNameEnum.ScrollDown] = {
                handler = InputHandlers.onRelease(function(_)
                    local var1 = scrollableAncestor

                    if var1 == nil then
                        return
                    end

                    local y = var1.AbsoluteCanvasSize.Y - var1.AbsoluteWindowSize.Y

                    if var1.CanvasPosition.Y >= y - 350 then
                        var1.CanvasPosition = Vector2.new(0, y)
                        return
                    end

                    var1.CanvasPosition += Vector2.new(0, 300)
                end)
            }
            tbl3[FocusNavigationEventNameEnum.ScrollUp] = {
                handler = InputHandlers.onRelease(function(_)
                    local var1 = scrollableAncestor

                    if var1 == nil then
                        return
                    end

                    local _ = var1.AbsoluteCanvasSize.Y - var1.AbsoluteWindowSize.Y

                    if var1.CanvasPosition.Y <= 350 then
                        var1.CanvasPosition = Vector2.new(0, 0)
                        return
                    end
                    var1.CanvasPosition += Vector2.new(0, -300)
                end)
            }
        end

        return tbl3
    end, { scrollableAncestor })

    return useFocusRoot({
        surfaceIdentifier = tbl2.surfaceIdentifier,
        isAutoFocusRoot = tbl2.isAutoFocusRoot == nil or tbl2.isAutoFocusRoot,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
end

return useInterventionFocusRoot
