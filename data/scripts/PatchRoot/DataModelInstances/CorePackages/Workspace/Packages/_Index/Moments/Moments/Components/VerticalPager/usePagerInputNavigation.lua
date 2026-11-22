-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local UserInputService = game:GetService("UserInputService")

local InputHandlers = require(MomentsParent.InputHandlers)
local React = require(MomentsParent.React)
local ReactFocusNavigation = require(MomentsParent.ReactFocusNavigation)
local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local useDescendantHasFocus = FocusNavigationUtils.useDescendantHasFocus
local useAutoFocus = FocusNavigationUtils.useAutoFocus
local useLastInputMode = FocusNavigationUtils.useLastInputMode

local Constants = require(script.Parent.Constants)
local _Types = require(script.Parent.Types)
local pagerNavigation = require(script.Parent.pagerNavigation)

local PREVIOUS_EVENT = pagerNavigation.PREVIOUS_EVENT
local NEXT_EVENT = pagerNavigation.NEXT_EVENT
local KEYBOARD_KEY_EVENTS = pagerNavigation.KEYBOARD_KEY_EVENTS

local function usePagerInputNavigation(tbl1)
    local active = tbl1.active
    local keyboardNavigation = tbl1.keyboardNavigation

    local var1 = React.useRef(tbl1.goNext)
    var1.current = tbl1.goNext
    local var2 = React.useRef(tbl1.goPrevious)
    var2.current = tbl1.goPrevious

    local var3, var4 = React.useState(nil)
    local var5 = useDescendantHasFocus(var3)

    local var6 = useAutoFocus({ var3 }, 0.1)

    local bool1 = useLastInputMode() == "Focus"
    local var7 = active and not (var3 == nil) and not var5 and bool1

    React.useEffect(function()
        local var8 = if var7 then var6() else nil

        return function()
            if var8 then
                var8.cancel()
            end
        end
    end, { var7, var6 })

    local var8 = React.useMemo(function()
        return pagerNavigation.buildEventMap(active, keyboardNavigation)
    end, { active, keyboardNavigation })

    local var9 = React.useMemo(function()
        return {
            [PREVIOUS_EVENT] = {
                handler = InputHandlers.onRelease(function()
                    var2.current()
                end)
            },
            [NEXT_EVENT] = {
                handler = InputHandlers.onRelease(function()
                    var1.current()
                end)
            }
        }
    end, {})

    local var10 = ReactFocusNavigation.useEventMap(var8)
    local var11 = ReactFocusNavigation.useEventHandlerMap(var9, var10)

    React.useEffect(function()
        if not active or not var5 then
            return
        end

        local num1 = 0
        local connection = UserInputService.InputChanged:Connect(function(input: InputObject)
            if input.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                return
            end
            local var12 = pagerNavigation.thumbstickDirection(input.Position.Y, Constants.THUMBSTICK_THRESHOLD)
            if var12 == nil then
                return
            end
            local now = os.clock()
            if now - num1 < Constants.THUMBSTICK_COOLDOWN_SECONDS then
                return
            end
            num1 = now
            if var12 == "previous" then
                var2.current()
                return
            end
            var1.current()
        end)

        return function()
            connection:Disconnect()
        end
    end, { active, var5 })

    React.useEffect(function()
        if not active or keyboardNavigation ~= "global" then
            return
        end

        local connection = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
            if gameProcessedEvent then
                return
            end
            local var12 = KEYBOARD_KEY_EVENTS[input.KeyCode]
            if var12 == PREVIOUS_EVENT then
                var2.current()
            elseif var12 == NEXT_EVENT then
                var1.current()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { active, keyboardNavigation })

    return React.useCallback(function(arg1)
        var11(arg1)
        var4(arg1)
    end, { var11 })
end

return usePagerInputNavigation
