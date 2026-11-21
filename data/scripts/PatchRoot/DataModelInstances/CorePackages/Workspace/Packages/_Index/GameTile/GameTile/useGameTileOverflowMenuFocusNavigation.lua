-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local GameTileParent = script:FindFirstAncestor("GameTile").Parent

local AppBlox = require(GameTileParent.AppBlox)
local FocusNavigationUtils = require(GameTileParent.FocusNavigationUtils)
local InputHandlers = require(GameTileParent.InputHandlers)
local React = require(GameTileParent.React)
local ReactFocusNavigation = require(GameTileParent.ReactFocusNavigation)
local Responsive = require(GameTileParent.Responsive)
local SharedFlags = require(GameTileParent.SharedFlags)

local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local GetInputModeStore = Responsive.GetInputModeStore

local FFlagLuaAppFixExplicitFeedbackConsoleTelemetry = SharedFlags.FFlagLuaAppFixExplicitFeedbackConsoleTelemetry
local FFlagLuaAppGameTileOverflowMenuFocusTransferFix = SharedFlags.FFlagLuaAppGameTileOverflowMenuFocusTransferFix

local tbl1 = {
    [Enum.KeyCode.ButtonStart] = FocusNavigationEventNameEnum.OpenQuickMenu
}

local tbl2 = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useGameTileOverflowMenuFocusNavigation(str1: string, current: boolean?, arg1, callback: ((...any) -> (...any))?)
    local var1, var2 = React.useState(nil)
    local var3 = React.useRef(false)

    local useMemo = React.useMemo

    local function func1()
        local tbl3 = {
            [FocusNavigationEventNameEnum.OpenQuickMenu] = {
                handler = InputHandlers.onRelease(function()
                    getOverflowMenuSignalStore().openMenu(str1)
                    if FFlagLuaAppFixExplicitFeedbackConsoleTelemetry and callback then
                        callback(false)
                    end
                end)
            }
        }
        local tbl4 = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function()
                    getOverflowMenuSignalStore().closeMenu(str1)
                    if FFlagLuaAppFixExplicitFeedbackConsoleTelemetry and callback then
                        callback(true)
                    end
                end)
            }
        }

        return tbl3, tbl4
    end

    local var4 = if FFlagLuaAppFixExplicitFeedbackConsoleTelemetry then callback else nil
    local var5, var6 = useMemo(func1, { str1, var4 })

    local var7 = ReactFocusNavigation.useEventMap(tbl1)
    local var8 = ReactFocusNavigation.useEventMap(tbl2)

    local var9 = ReactFocusNavigation.useEventHandlerMap(var5, var7)

    local var10 = ReactFocusNavigation.useEventHandlerMap(var6, var8)

    React.useEffect(function()
        if var9 and arg1 then
            var9(arg1.current)
        end
    end, { var9, arg1 })

    React.useEffect(function()
        if var10 then
            var10(var1)
        end
    end, { var10, var1 })

    React.useEffect(function()
        if GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Directional and current and var1 then
            GuiService:Select(var1)
        end
    end, { var1 })

    local var11 = React.useRef(current)
    local useEffect = React.useEffect
    local function func2()
        if var11.current == current then
            return
        end

        var11.current = current
        if current or var3.current then
            return
        end

        local overflowMenuSignalStore = getOverflowMenuSignalStore()
        if not overflowMenuSignalStore.getIsMenuOpen(str1) then
            overflowMenuSignalStore.closeMenu(str1)
            return
        end
        local selectedCoreObject = GuiService.SelectedCoreObject
        local isDescendantOf = FFlagLuaAppGameTileOverflowMenuFocusTransferFix
            and var1
            and selectedCoreObject
            and selectedCoreObject:IsDescendantOf(var1)

        if arg1
            and arg1.current
            and selectedCoreObject
            and not selectedCoreObject:IsDescendantOf(arg1.current)
            and not (FFlagLuaAppGameTileOverflowMenuFocusTransferFix and isDescendantOf)
        then
            overflowMenuSignalStore.closeMenu(str1)
        end
    end

    local var12 = if FFlagLuaAppGameTileOverflowMenuFocusTransferFix then var1 else nil
    useEffect(func2, { current, str1, arg1, var12 })

    local var13 = React.useCallback(function()
        if var1 and GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(var1) then
            var3.current = true
        elseif var3.current ~= false then
            var3.current = false
            getOverflowMenuSignalStore().closeMenu(str1)
        end
    end, { var1, str1 })

    React.useLayoutEffect(function()
        local connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(var13)
        var13()

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var13 })

    return var2
end

return useGameTileOverflowMenuFocusNavigation
