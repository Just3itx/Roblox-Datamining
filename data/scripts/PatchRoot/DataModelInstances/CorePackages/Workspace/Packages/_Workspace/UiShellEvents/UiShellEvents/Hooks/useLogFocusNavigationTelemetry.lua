-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local UiShellEvents = script:FindFirstAncestor("UiShellEvents")
local UiShellEventsParent = UiShellEvents.Parent
local React = require(UiShellEventsParent.React)
local ReactFocusNavigation = require(UiShellEventsParent.ReactFocusNavigation)
local FocusNavigationUtils = require(UiShellEventsParent.FocusNavigationUtils)
local focusNavigationTelemetry = require(UiShellEvents.Analytics.focusNavigationTelemetry)

local bool1 = game:DefineFastFlag("LogFocusNavExitTriggerKey", false)

local function isHoldAction(eventName: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return string.find(eventName, "^HoldTo") ~= nil
end

local function getFocusNavEntryExitInputType(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then "Gamepad" elseif arg1 == "None" then nil else arg1
end

local function isFocusNavActive(arg1, bool2: boolean, bool3: boolean): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1 == "Focus" or bool2 and not bool3
end

local function useLogFocusNavigationTelemetry(page: string?)
    local var1, var2 = FocusNavigationUtils.useLastInputMode()
    local var3 = FocusNavigationUtils.useLastInputMethod()
    local var4 = FocusNavigationUtils.useGamepadCursorEnabled()

    local var5 = React.useRef(false)
    local var6 = React.useRef(nil)

    React.useEffect(function()
        if not var5.current and var1 == "Focus" and var3 == "Keyboard" then
            var5.current = true
            focusNavigationTelemetry.logKeyboardFocusModeEntered()
        end
    end, { var1, var3 })

    React.useEffect(function()
        local function logFocusNavEntryExit()
            local current = var6.current
            local bool2 = GuiService.SelectedCoreObject ~= nil
            local bool3 = isFocusNavActive(var1, bool2, var4)
            local focusNavEntryExitInputType = getFocusNavEntryExitInputType(var3)

            if not bool3 or current ~= nil then
                if not bool3 and current ~= nil then
                    var6.current = nil
                    local logFocusNavToggled = focusNavigationTelemetry.logFocusNavToggled
                    local tbl1 = {
                        entry = "exit",
                        input_type = focusNavEntryExitInputType,
                        page = page,
                        keyboard_navigation_trigger = if bool1 and current.triggerKey then current.triggerKey.Name else nil,
                        keyboard_navigation_duration = if current.inputType == "Keyboard" then math.floor((os.clock() - current.startTime) * 1000) else nil
                    }
                    logFocusNavToggled(tbl1)
                end

                return
            end

            if bool1 then
                local triggerKey = if focusNavEntryExitInputType == "Keyboard" then var2 else nil
                var6.current = {
                    inputType = focusNavEntryExitInputType,
                    startTime = os.clock(),
                    triggerKey = triggerKey
                }
                focusNavigationTelemetry.logFocusNavToggled({
                    entry = "enter",
                    input_type = focusNavEntryExitInputType,
                    page = page,
                    keyboard_navigation_trigger = if triggerKey then triggerKey.Name else nil
                })
                return
            end

            var6.current = {
                inputType = focusNavEntryExitInputType,
                startTime = os.clock()
            }
            focusNavigationTelemetry.logFocusNavToggled({
                entry = "enter",
                input_type = focusNavEntryExitInputType,
                page = page,
                keyboard_navigation_trigger = if focusNavEntryExitInputType == "Keyboard" and var2 then var2.Name else nil
            })
        end

        logFocusNavEntryExit()
        local connection = GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(logFocusNavEntryExit)
        return function()
            connection:Disconnect()
        end
    end, {
        var1,
        var3,
        var2,
        var4,
        page
    })

    local var7 = React.useCallback(function(action: string, arg1, arg2)
        if not isFocusNavActive(var1, true, var4) then
            return
        end

        focusNavigationTelemetry.logFocusNavShortcutToggle({
            btn = if arg1 then arg1.Name else "Unknown",
            action = action,
            page = page,
            input_type = if arg2 then FocusNavigationUtils.getInputMethod(arg2) else nil
        })
    end, { var1, var4, page })

    React.useEffect(function()
        local connection = FocusNavigationUtils.ButtonHoldCompletedSignal:connect(var7)
        return function()
            connection:disconnect()
        end
    end, { var7 })

    local var8 = React.useCallback(function(arg1)
        local eventData = arg1.eventData

        if not arg1.synthetic
            and eventData
            and eventData.UserInputState == Enum.UserInputState.Begin
            and not isHoldAction(arg1.eventName)
        then
            var7(arg1.eventName, eventData.KeyCode, eventData.UserInputType)
        end
    end, { var7 })
    ReactFocusNavigation.useEventDispatched(var8)
end

return useLogFocusNavigationTelemetry
