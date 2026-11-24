-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local InputHandlers = require(GenericAbuseReportingParent.InputHandlers)
local React = require(GenericAbuseReportingParent.React)
local ReactFocusNavigation = require(GenericAbuseReportingParent.ReactFocusNavigation)

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local scrollFrameUtils = require(script.Parent.scrollFrameUtils)
local useThumbstickScroll = require(script.Parent.useThumbstickScroll)

local tbl1 = {}
local tbl2 = {}

local tbl3 = {
    [Enum.KeyCode.PageUp] = FocusNavigationEventNameEnum.ScrollUp,
    [Enum.KeyCode.LeftBracket] = FocusNavigationEventNameEnum.ScrollUp,
    [Enum.KeyCode.PageDown] = FocusNavigationEventNameEnum.ScrollDown,
    [Enum.KeyCode.RightBracket] = FocusNavigationEventNameEnum.ScrollDown
}

local function scrollFocusedContainer(num1: number, current) -- Luacid: Inlined by compiler; 2 call sites recovered
    if current == nil then
        return
    end

    local var1 = scrollFrameUtils.resolveScrollTarget(GuiService.SelectedCoreObject, current)
    scrollFrameUtils.scrollByIncrement(var1, num1)
end

local function useScrollNavigationBindings(tbl4)
    local containerRef = React.useRef(nil)
    local var2 = tbl4 == nil or tbl4.includeDiscreteScroll == nil or tbl4.includeDiscreteScroll

    local var3 = React.useMemo(function()
        return if var2 then tbl3 else tbl1
    end, { var2 })

    local var4 = React.useMemo(function()
        if not var2 then
            return tbl2
        end

        return {
            [FocusNavigationEventNameEnum.ScrollDown] = {
                handler = InputHandlers.onRelease(function(_)
                    scrollFocusedContainer(scrollFrameUtils.SCROLL_INCREMENT, containerRef.current)
                end)
            },
            [FocusNavigationEventNameEnum.ScrollUp] = {
                handler = InputHandlers.onRelease(function(_)
                    scrollFocusedContainer(-scrollFrameUtils.SCROLL_INCREMENT, containerRef.current)
                end)
            }
        }
    end, { var2 })

    local var5 = ReactFocusNavigation.useEventMap(var3, containerRef)
    local var6 = ReactFocusNavigation.useEventHandlerMap(var4, var5)

    useThumbstickScroll({ containerRef = containerRef, enabled = true })

    return var6
end

return useScrollNavigationBindings
