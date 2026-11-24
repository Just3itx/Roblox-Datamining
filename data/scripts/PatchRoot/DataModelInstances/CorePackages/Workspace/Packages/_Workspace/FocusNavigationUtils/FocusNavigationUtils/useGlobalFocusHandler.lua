-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local UserInputService = game:GetService("UserInputService")
local SessionService = game:GetService("SessionService")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent
local React = require(FocusNavigationUtilsParent.React)
local ReactFocusNavigation = require(FocusNavigationUtilsParent.ReactFocusNavigation)
local MessageBus = require(FocusNavigationUtilsParent.MessageBus).MessageBus
local Navigation = require(FocusNavigationUtilsParent.Navigation)
local Responsive = require(FocusNavigationUtilsParent.Responsive)
local SessionType = require(FocusNavigationUtilsParent.Sessionization).SessionType
local useLastInputMethod = require(FocusNavigationUtils.useLastInputMethod)
local useLastInputMode = require(FocusNavigationUtils.useLastInputMode)
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject
local useFocusedGuiObject = ReactFocusNavigation.useFocusedGuiObject
local useRegistryEntry = require(FocusNavigationUtils.FocusNavigableSurfaceRegistry).useRegistryEntry
local useRegistryEntries = require(FocusNavigationUtils.FocusNavigableSurfaceRegistry).useRegistryEntries
local FocusNavigableSurfaceIdentifierEnum = require(FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum)
local useAutoFocus = require(FocusNavigationUtils.useAutoFocus)
local useDescendantHasFocus = require(FocusNavigationUtils.useDescendantHasFocus)
local useAnyDescendantHasFocus = require(FocusNavigationUtils.useAnyDescendantHasFocus)
local GlobalFocusTelemetry = require(FocusNavigationUtils.GlobalFocusTelemetry)
local useSelector = require(FocusNavigationUtilsParent.RoactUtils).Hooks.RoactRodux.useSelector
local CentralOverlayType = require(FocusNavigationUtilsParent.RobloxAppEnums).CentralOverlayType

local num1 = game:DefineFastInt("AutoFocusFailsafeThreshold", 5)
local SharedFlags = require(FocusNavigationUtilsParent.SharedFlags)
local FFlagAppIaHomeSubTab = SharedFlags.FFlagAppIaHomeSubTab
local FFlagLuaAppResponsiveEnginePreferredInput = SharedFlags.FFlagLuaAppResponsiveEnginePreferredInput
local FFlagEnableDrawerFocusNav = SharedFlags.FFlagEnableDrawerFocusNav
local FFlagSearchAllRegistryEntriesForAutoFocus = SharedFlags.FFlagSearchAllRegistryEntriesForAutoFocus
local FFlagFixGlobalFocusPriority = require(script.Parent.FFlagFixGlobalFocusPriority)

local FFlagGamepadDisconnectAutoFocusSuppression = require(script.Parent.Flags.FFlagGamepadDisconnectAutoFocusSuppression)

local tbl1 = {
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.MouseButton2] = true,
    [Enum.UserInputType.MouseButton3] = true,
    [Enum.UserInputType.Touch] = true
}

local subscriber = MessageBus.Subscriber.new()

local function gameLeaveMessageValidator(arg1): boolean
    return typeof(arg1) == "table"
end

local function createGlobalFocusFailureDetection(callback: (...any) -> (...any)): RBXScriptConnection -- Luacid: unused: defined but never referenced
    local bool1 = false
    local num2 = 0
    return (RunService.Heartbeat:Connect(function(deltaTime: number)
        num2 += deltaTime
        if num1 < num2 and not bool1 then
            callback()
            bool1 = true
            num2 = 0
        end
    end))
end

local function createGameLeaveSubscription(callback: (...any) -> (...any))
    local mid = MessageBus.getMessageId("Game", "onGameLeave")
    local var1 = nil

    subscriber:subscribe({ mid = mid, validateParams = gameLeaveMessageValidator }, function(_)
        var1 = task.delay(num1, function()
            callback()
        end)
    end)

    return {
        unsubscribe = function()
            subscriber:unsubscribeWithMsgId(mid)
            if var1 then
                task.cancel(var1)
            end
        end
    }
end

local function useGlobalFocusHandler(bool1: boolean?)
    local tag = useLastInputMethod()
    local var1 = useFocusGuiObject()
    local current = useFocusedGuiObject()
    local var3 = React.useRef(current)
    local var4 = React.useRef(false)
    local bool2 = useLastInputMode() == "Focus"
    local var5 = if FFlagLuaAppResponsiveEnginePreferredInput then Responsive.usePreferredInput() else nil

    React.useEffect(function()
        if current ~= nil and var3.current == nil then
            SessionService:SetSession(
                SessionType.StructuralIdentifier.Level1,
                SessionType.StructuralIdentifier.FocusNavigation,
                tag
            )
            var3.current = current
        end
        if current ~= nil and var4.current then
            GlobalFocusTelemetry.sendAutoFocusRecoveryCounter()
            var4.current = false
        end
    end, { current })

    React.useEffect(function()
        local connection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
            if not (if FFlagLuaAppResponsiveEnginePreferredInput then not (var5 == Responsive.Input.Directional) and tbl1[lastInputType] else tbl1[lastInputType]) then
                return
            end

            if var3.current ~= nil then
                SessionService:RemoveSession(SessionType.StructuralIdentifier.FocusNavigation)
                var3.current = nil
                var1(nil)
                return
            end
            var1(nil)
        end)

        return function()
            connection:Disconnect()
        end
    end, FFlagLuaAppResponsiveEnginePreferredInput and { var1, var5 } or { var1 })

    local var6 = Navigation.useNavigation()
    local state = if var6 then var6.state else nil
    local index = if state then state.index else nil
    local var7 = React.useRef(index)
    React.useEffect(function()
        if bool2 and var7.current ~= nil and index ~= nil and var7.current < index then
            var7.current = index
            var1(nil)
        end
    end, { index, bool2 })

    local var8 = React.useRef(nil)
    local var9 = React.useRef(nil)

    local currentRouteState = Navigation.getCurrentRouteState(var6)
    local routeName = if currentRouteState then currentRouteState.routeName else nil

    React.useEffect(function()
        if routeName ~= var8.current then
            var9.current = var8.current
            var8.current = routeName
        end
    end, { routeName })

    local globalNavBar = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.NavBar)
    local routerView = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.RouterView)
    local centralOverlay = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.CentralOverlay)
    local moderationOverlay = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.ModerationOverlay)
    local popUp = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.PopUp)
    local contextualMenu = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.ContextualMenu)
    local searchBar = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.SearchBar)
    local peekView = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.PeekView)
    local subRouterView = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.SubRouterView)
    local auxiliaryView = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.Auxiliary)
    local headerView = if FFlagAppIaHomeSubTab then useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.HeaderView) else nil
    local var21 = if FFlagEnableDrawerFocusNav then useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.Drawer) else nil

    local var22 = useSelector(function(arg1)
        return arg1.CentralOverlay.OverlayType
    end)

    local bool3 = if FFlagGamepadDisconnectAutoFocusSuppression then var22 == CentralOverlayType.GamepadDisconnected and moderationOverlay == nil else false
    local useMemo = React.useMemo
    local function func1()
        local result = {}
        if moderationOverlay then
            table.insert(result, moderationOverlay)
            return result
        end

        if centralOverlay then
            table.insert(result, centralOverlay)
            return result
        end

        if contextualMenu then
            table.insert(result, contextualMenu)
            return result
        end

        if popUp then
            table.insert(result, popUp)
            return result
        end

        if peekView then
            table.insert(result, peekView)
            return result
        end

        if FFlagEnableDrawerFocusNav and var21 then
            table.insert(result, var21)
            return result
        end
        if routerView then
            table.insert(result, routerView)
        end
        if subRouterView then
            table.insert(result, subRouterView)
        end
        if globalNavBar then
            table.insert(result, globalNavBar)
        end
        if searchBar then
            table.insert(result, searchBar)
        end
        if auxiliaryView then
            table.insert(result, auxiliaryView)
        end
        if FFlagAppIaHomeSubTab and headerView then
            table.insert(result, headerView)
        end

        return result
    end

    local var23 = if FFlagAppIaHomeSubTab then headerView else nil
    local var24 = if FFlagEnableDrawerFocusNav then searchBar else nil
    local var25 = if FFlagEnableDrawerFocusNav then var21 else nil
    local var2 = useMemo(func1, {
        moderationOverlay,
        routerView,
        globalNavBar,
        centralOverlay,
        contextualMenu,
        popUp,
        peekView,
        subRouterView,
        auxiliaryView,
        var23,
        var24,
        var25
    })

    local var27 = useAutoFocus(var2, 0.1)

    local var28 = useDescendantHasFocus(globalNavBar)
    local var29 = useDescendantHasFocus(routerView)
    local var30

    if FFlagSearchAllRegistryEntriesForAutoFocus then
        local var31 = useRegistryEntries(FocusNavigableSurfaceIdentifierEnum.RouterView)
        var30 = useAnyDescendantHasFocus(var31)
    else
        var30 = nil
    end
    local var31 = useDescendantHasFocus(centralOverlay)
    local var32 = useDescendantHasFocus(moderationOverlay)
    local var33 = useDescendantHasFocus(contextualMenu)
    local var34 = useDescendantHasFocus(popUp)
    local var35 = useDescendantHasFocus(searchBar)
    local var36 = useDescendantHasFocus(subRouterView)
    local var37 = useDescendantHasFocus(auxiliaryView)
    local var38 = useDescendantHasFocus(peekView)
    local var39 = if FFlagAppIaHomeSubTab then useDescendantHasFocus(headerView) else false
    local var40 = if FFlagEnableDrawerFocusNav then useDescendantHasFocus(var21) else false
    local var41

    if moderationOverlay then
        var41 = var32
    elseif centralOverlay then
        var41 = var31
    elseif contextualMenu then
        var41 = var33
    elseif popUp then
        var41 = var34
    elseif peekView then
        var41 = var38
    elseif FFlagEnableDrawerFocusNav and var21 then
        var41 = var40
    elseif var28 then
        var41 = var28
    else
        if not FFlagSearchAllRegistryEntriesForAutoFocus then
            var30 = var29
        end

        var41 = var30 or var35 or var36 or var37 or FFlagAppIaHomeSubTab and var39
    end

    local var42 = React.useRef(var2)
    local bool4 = moderationOverlay and not var32 and true
        or centralOverlay and not var31 and true
        or contextualMenu and not var33 and true
        or popUp and not var34 and true
        or peekView and not var38 and true
        or FFlagEnableDrawerFocusNav and var21 and not var40 and true
        or routerView and not var29 and true
        or (if subRouterView and not var36 then true elseif globalNavBar and not var28 then true elseif searchBar and not var35 then true elseif auxiliaryView and not var37 then true else not not (FFlagAppIaHomeSubTab and headerView and not var39))

    if FFlagFixGlobalFocusPriority then
        if moderationOverlay then
            bool4 = not var32
        elseif centralOverlay then
            bool4 = not var31
        elseif contextualMenu then
            bool4 = not var33
        elseif popUp then
            bool4 = not var34
        elseif peekView then
            bool4 = not var38
        elseif FFlagEnableDrawerFocusNav and var21 then
            bool4 = not var40
        elseif routerView then
            bool4 = not var29
        elseif subRouterView then
            bool4 = not var36
        elseif globalNavBar then
            bool4 = not var28
        elseif searchBar then
            bool4 = not var35
        elseif auxiliaryView then
            bool4 = not var37
        elseif FFlagAppIaHomeSubTab and headerView then
            bool4 = not var39
        else
            bool4 = false
        end
    end
    React.useEffect(function()
        if var5 == Responsive.Input.Directional and var42.current ~= var2 and not bool1 and bool4 then
            var1(nil)
        end
        var42.current = var2
    end, {
        var2,
        var5,
        bool1,
        bool4,
        var1
    })

    local bool5 = (if FFlagLuaAppResponsiveEnginePreferredInput then var5 == Responsive.Input.Directional or bool2 else bool2)
        and not var41
        and not (bool1 or bool3)

    React.useEffect(function()
        local var43 = nil
        local connection = nil

        local function setAutoFocusing() -- Luacid: Inlined by compiler; 2 call sites recovered
            if var43 then
                var43.cancel()
            end
            var43 = var27()
        end

        if bool5 then
            setAutoFocusing()

            local function func2()
                GlobalFocusTelemetry.sendAutoFocusFailureCounter(var2)
                GlobalFocusTelemetry.sendAutoFocusFailureEvent(current, var42.current, var2, {
                    moderationOverlay = moderationOverlay,
                    centralOverlay = centralOverlay,
                    contextualMenu = contextualMenu,
                    popUp = popUp,
                    peekView = peekView,
                    routerView = routerView,
                    subRouterView = subRouterView,
                    globalNavBar = globalNavBar,
                    searchBar = searchBar,
                    auxiliaryView = auxiliaryView,
                    headerView = headerView
                }, var9.current, var8.current, var22)

                var4.current = true
                setAutoFocusing()
            end

            local bool6 = false
            local num2 = 0
            connection = RunService.Heartbeat:Connect(function(deltaTime: number)
                num2 += deltaTime
                if num1 < num2 and not bool6 then
                    func2()
                    bool6 = true
                    num2 = 0
                end
            end)
        end

        local gameLeaveSubscription = if bool5 then createGameLeaveSubscription(setAutoFocusing) else nil

        return function()
            if var43 then
                var43.cancel()
            end
            if gameLeaveSubscription then
                gameLeaveSubscription.unsubscribe()
            end
            if connection then
                connection:Disconnect()
            end
        end
    end, {
        bool5,
        var27,
        var2,
        current
    })
end
return useGlobalFocusHandler
