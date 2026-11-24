-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent

local GuiService = game:GetService("GuiService")

local React = require(FocusNavigationUtilsParent.React)

local ReactFocusNavigation = require(FocusNavigationUtilsParent.ReactFocusNavigation)
local _FocusNavigableSurfaceIdentifierEnum = require(FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum)

local useFocusNavigableSurfaceRegistryConnection = require(FocusNavigationUtils.useFocusNavigableSurfaceRegistryConnection)
local useAutoFocus = require(FocusNavigationUtils.useAutoFocus)
local useDescendantHasFocus = require(FocusNavigationUtils.useDescendantHasFocus)
local useLastInputMode = require(FocusNavigationUtils.useLastInputMode)

local tbl1 = {}

local function useFocusRoot(tbl2)
    local var1, var2 = React.useState(nil)
    local current = var1

    local var4 = tbl2.eventMap or tbl1
    local var5 = ReactFocusNavigation.useEventMap(var4, var2)
    local var6 = tbl2.eventHandlers or tbl1
    local var7 = ReactFocusNavigation.useEventHandlerMap(var6, var5)

    local var8 = tbl2.isFocusable == nil or tbl2.isFocusable
    local var9 = tbl2.shouldRestoreFocus == nil or tbl2.shouldRestoreFocus
    local var10 = ReactFocusNavigation.useMostRecentFocusBehavior(var7)
    if var9 then
        var7 = var10
    end
    useFocusNavigableSurfaceRegistryConnection(current, tbl2.surfaceIdentifier, var8)

    local var11 = useDescendantHasFocus(current)
    local var12 = useAutoFocus({ current }, 0.1)
    local bool1 = useLastInputMode() == "Focus"
    local var13 = tbl2.isAutoFocusRoot and var8 and bool1 and current and not var11

    React.useEffect(function()
        local var14 = if var13 then var12() else nil

        return function()
            if var14 then
                var14.cancel()
            end
        end
    end, { var13, var12 })

    local var14 = React.useRef(current)
    React.useEffect(function()
        if current then
            var14.current = current
        end
    end, { current })

    React.useEffect(function()
        return function()
            if not var14.current then
                return
            end

            local selectedCoreObject = GuiService.SelectedCoreObject
            if not selectedCoreObject then
                return
            end

            if selectedCoreObject:IsDescendantOf(var14.current) or not selectedCoreObject:IsDescendantOf(game) then
                GuiService.SelectedCoreObject = nil
            end
        end
    end, {})

    return var7
end

return useFocusRoot
