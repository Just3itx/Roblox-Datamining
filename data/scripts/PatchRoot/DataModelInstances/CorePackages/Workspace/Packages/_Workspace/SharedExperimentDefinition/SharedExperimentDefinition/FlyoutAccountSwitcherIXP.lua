-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("EnableFlyoutUsernameAccountSwitcher", false)
local bool2 = game:DefineFastFlag("FlyoutEnableSwitchAccountTooltip", false)
local num1 = game:DefineFastInt("FlyoutUsernameAccountSwitcherVariant", 0)

local function isUsernameAccountSwitcherEnabled() -- Luacid: Inlined by compiler; 7 call sites recovered
    return bool1
end

local function isProfileHandleEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isUsernameAccountSwitcherEnabled() and num1 == 1
end

local function isProfileIconButtonEnabled(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return isUsernameAccountSwitcherEnabled() and num1 == 2
end

return {
    isUsernameAccountSwitcherEnabled = isUsernameAccountSwitcherEnabled,
    isSwitchAccountTooltipEnabled = function(): boolean
        return isUsernameAccountSwitcherEnabled() and bool2
    end,
    isProfileHandleEnabled = isProfileHandleEnabled,
    isProfileIconButtonEnabled = isProfileIconButtonEnabled,
    isBottomButtonEnabled = function(): boolean
        return (not isUsernameAccountSwitcherEnabled() or num1 ~= 1 or false) and not isProfileIconButtonEnabled()
    end,
    getClickSource = function(): string
        return if isProfileHandleEnabled() then "handle" elseif isProfileIconButtonEnabled() then "icon_button" else "bottom_button"
    end
}
