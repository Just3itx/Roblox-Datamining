-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveysParent = script:FindFirstAncestor("OnPlatformSurveys").Parent

local FocusNavigationUtils = require(OnPlatformSurveysParent.FocusNavigationUtils)
local InputHandlers = require(OnPlatformSurveysParent.InputHandlers)
local React = require(OnPlatformSurveysParent.React)
local ReactFocusNavigation = require(OnPlatformSurveysParent.ReactFocusNavigation)

local bool1 = game:DefineFastFlag("InlineSurveyFocusRoot", false)

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useAppFocusRoot = FocusNavigationUtils.useAppFocusRoot
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useDefaultFocusBehavior = ReactFocusNavigation.useDefaultFocusBehavior
local useFocusedGuiObject = ReactFocusNavigation.useFocusedGuiObject

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
    local y2 = arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y

    if y > 0 and arg1.CanvasPosition.Y >= y2 - 350 then
        arg1.CanvasPosition = Vector2.new(0, y2)
    elseif y < 0 and arg1.CanvasPosition.Y <= 350 then
        arg1.CanvasPosition = Vector2.new(0, 0)
    else
        arg1.CanvasPosition += Vector2.new(0, y)
    end
end

local function mergeRefs(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(current)
        if type(arg1) == "function" then
            arg1(current)
        elseif arg1 ~= nil then
            arg1.current = current
        end

        if type(arg2) == "function" then
            arg2(current)
        elseif arg2 ~= nil then
            arg2.current = current
        end
    end
end

local function useSurveyFocusRefs(surfaceIdentifier, func1: (...any) -> (...any))
    local var1 = useDefaultFocusBehavior()
    local var2

    if bool1 then
        local scrollableAncestor = getScrollableAncestor((useFocusedGuiObject()))

        local eventHandlers = React.useMemo(function()
            local tbl2 = {
                [FocusNavigationEventNameEnum.NavigateBack] = {
                    handler = InputHandlers.onRelease(func1)
                }
            }

            if scrollableAncestor then
                tbl2[FocusNavigationEventNameEnum.ScrollUp] = {
                    handler = InputHandlers.onRelease(function()
                        local var3 = scrollableAncestor
                        local _ = var3.AbsoluteCanvasSize.Y - var3.AbsoluteWindowSize.Y

                        if var3.CanvasPosition.Y <= 350 then
                            var3.CanvasPosition = Vector2.new(0, 0)
                            return
                        end
                        var3.CanvasPosition += Vector2.new(0, -300)
                    end)
                }
                tbl2[FocusNavigationEventNameEnum.ScrollDown] = {
                    handler = InputHandlers.onRelease(function()
                        local var3 = scrollableAncestor
                        local y = var3.AbsoluteCanvasSize.Y - var3.AbsoluteWindowSize.Y

                        if var3.CanvasPosition.Y >= y - 350 then
                            var3.CanvasPosition = Vector2.new(0, y)
                            return
                        end

                        var3.CanvasPosition += Vector2.new(0, 300)
                    end)
                }
            end

            return tbl2
        end, { scrollableAncestor, func1 })

        var2 = useFocusRoot(
            {
                surfaceIdentifier = surfaceIdentifier,
                eventHandlers = eventHandlers,
                eventMap = eventMap,
                isAutoFocusRoot = true
            }
        )
    else
        var2 = useAppFocusRoot({
            surfaceIdentifier = surfaceIdentifier,
            customEventHandlers = {
                [FocusNavigationEventNameEnum.NavigateBack] = {
                    handler = InputHandlers.onRelease(func1)
                }
            },
            isAutoFocusRoot = true
        })
    end

    return React.useMemo(function()
        return mergeRefs(var2, var1)
    end, { var2, var1 })
end

return useSurveyFocusRefs
