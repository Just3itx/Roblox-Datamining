-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent
local React = require(FocusNavigationUtilsParent.React)
local ReactFocusNavigation = require(FocusNavigationUtilsParent.ReactFocusNavigation)
local InputHandlers = require(FocusNavigationUtilsParent.InputHandlers)
local useNavigation = require(FocusNavigationUtilsParent.Navigation).useNavigation
local FFlagFixDoubleBackNav = require(FocusNavigationUtilsParent.SharedFlags).FFlagFixDoubleBackNav
local useSelector = require(FocusNavigationUtilsParent.RoactUtils).Hooks.RoactRodux.useSelector
local canGoBack = require(FocusNavigationUtilsParent.Navigation).canGoBack
local FocusNavigationEventNameEnum = require(FocusNavigationUtils.FocusNavigationEventNameEnum)
local useFocusRegistryEntry = require(FocusNavigationUtils.FocusNavigableSurfaceRegistry).useFocusRegistryEntry
local FocusNavigableSurfaceIdentifierEnum = require(FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum)
local useDescendantHasFocus = require(FocusNavigationUtils.useDescendantHasFocus)
local useRegistryEntry = require(FocusNavigationUtils.FocusNavigableSurfaceRegistry).useRegistryEntry
local FocusNavigationDefaultEventMap = require(FocusNavigationUtils.FocusNavigationDefaultEventMap)

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

function useDefaultFocusNavigationBindings(arg1)
    local var1 = useNavigation()
    local var2 = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.SearchBar)
    local var3 = useFocusRegistryEntry(FocusNavigableSurfaceIdentifierEnum.SearchBar)
    local var4 = useFocusRegistryEntry(FocusNavigableSurfaceIdentifierEnum.NavBar)
    local var5 = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.NavBar)
    local var6 = useDescendantHasFocus(var5)
    local var7 = useSelector(function(arg2)
        return arg2.TabBarVisible
    end)
    local scrollableAncestor = getScrollableAncestor((ReactFocusNavigation.useFocusedGuiObject()))

    local bool1 = scrollableAncestor ~= nil

    local var8 = ReactFocusNavigation.useEventMap(FocusNavigationDefaultEventMap, arg1)

    local var9 = React.useMemo(function()
        local result = {}
        if not var6 then
            result[FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg2)
                    if canGoBack(var1) then
                        var1.goBack(false)
                    else
                        if not var7 then
                            return
                        end

                        var4()
                    end
                    if FFlagFixDoubleBackNav then
                        arg2.cancelled = true
                    end
                end)
            }
        end

        if var3 and var2 ~= nil then
            result[FocusNavigationEventNameEnum.Search] = {
                handler = InputHandlers.onRelease(function(_)
                    var3()

                    if var2 == nil then
                        return
                    end

                    local var9 = if var2:IsA("TextBox") then var2 else var2:FindFirstChildWhichIsA("TextBox", true)

                    if var9 then
                        var9:CaptureFocus()
                    end
                end)
            }
        end

        if bool1 then
            result[FocusNavigationEventNameEnum.ScrollDown] = {
                handler = InputHandlers.onRelease(function(_)
                    local var9 = scrollableAncestor

                    if var9 == nil then
                        return
                    end

                    local y = var9.AbsoluteCanvasSize.Y - var9.AbsoluteWindowSize.Y

                    if var9.CanvasPosition.Y >= y - 350 then
                        var9.CanvasPosition = Vector2.new(0, y)
                        return
                    end

                    var9.CanvasPosition += Vector2.new(0, 300)
                end)
            }
            result[FocusNavigationEventNameEnum.ScrollUp] = {
                handler = InputHandlers.onRelease(function(_)
                    local var9 = scrollableAncestor

                    if var9 == nil then
                        return
                    end

                    local _ = var9.AbsoluteCanvasSize.Y - var9.AbsoluteWindowSize.Y

                    if var9.CanvasPosition.Y <= 350 then
                        var9.CanvasPosition = Vector2.new(0, 0)
                        return
                    end
                    var9.CanvasPosition += Vector2.new(0, -300)
                end)
            }
        end
        return result
    end, {
        var1,
        var2,
        var3,
        var4,
        var6,
        var7,
        bool1
    })

    return (ReactFocusNavigation.useEventHandlerMap(var9, var8))
end
return useDefaultFocusNavigationBindings
