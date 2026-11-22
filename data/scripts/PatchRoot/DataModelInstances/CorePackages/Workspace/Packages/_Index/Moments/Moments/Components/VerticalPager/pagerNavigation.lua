-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local KEYBOARD_KEY_EVENTS = {
    [Enum.KeyCode.Up] = "VerticalPagerPrevious",
    [Enum.KeyCode.PageUp] = "VerticalPagerPrevious",
    [Enum.KeyCode.Down] = "VerticalPagerNext",
    [Enum.KeyCode.PageDown] = "VerticalPagerNext"
}

local DPAD_KEY_EVENTS = {
    [Enum.KeyCode.DPadUp] = "VerticalPagerPrevious",
    [Enum.KeyCode.DPadDown] = "VerticalPagerNext"
}

return {
    PREVIOUS_EVENT = "VerticalPagerPrevious",
    NEXT_EVENT = "VerticalPagerNext",
    KEYBOARD_KEY_EVENTS = KEYBOARD_KEY_EVENTS,
    DPAD_KEY_EVENTS = DPAD_KEY_EVENTS,
    buildEventMap = function(bool1: boolean, str1: string)
        if not bool1 then
            return {}
        end
        local var1 = table.clone(DPAD_KEY_EVENTS)
        if str1 == "focused" then
            for value, value2 in KEYBOARD_KEY_EVENTS do
                var1[value] = value2
            end
        end
        return var1
    end,
    thumbstickDirection = function(num1: number, num2: number): string?
        return if math.abs(num1) < num2 then nil elseif num2 <= num1 then "previous" else "next"
    end,
    shouldTrackDrag = function(bool1: boolean, bool2: boolean): boolean
        return not bool1 or bool2
    end,
    resolveWheelGesture = function(num1: number, num2: number, num3: number): (boolean, number)
        return num3 <= num1 - num2, num1
    end
}
