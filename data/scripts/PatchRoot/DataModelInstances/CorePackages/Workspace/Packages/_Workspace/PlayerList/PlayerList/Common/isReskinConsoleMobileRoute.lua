-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local FFlagPlayerListReskin = require(scriptParentParent.Flags.FFlagPlayerListReskin)
local FFlagEnableMobilePlayerListOnConsole = require(scriptParentParent.Flags.FFlagEnableMobilePlayerListOnConsole)
local FFlagEnableMobilePlayerListOnGamepad = require(scriptParentParent.Flags.FFlagEnableMobilePlayerListOnGamepad)

local FFlagLuaSupportMicroGamepadPreferredInput = require(scriptParentParentParent.SharedFlags).FFlagLuaSupportMicroGamepadPreferredInput

local function isGamepadPreferredInput(preferredInput, bool1: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return preferredInput == Enum.PreferredInput.Gamepad or bool1 and preferredInput == Enum.PreferredInput.MicroGamepad
end

local function isReskinConsoleMobileRoute(tbl1, tbl2)
    local var1 = if tbl2 ~= nil then tbl2.isReskinEnabled else FFlagPlayerListReskin
    local var2 = if tbl2 ~= nil then tbl2.isConsoleMobileEnabled else FFlagEnableMobilePlayerListOnConsole
    local var3 = if tbl2 ~= nil then tbl2.isGamepadMobileEnabled else FFlagEnableMobilePlayerListOnGamepad
    local var4 = if tbl2 ~= nil then tbl2.isMicroGamepadEnabled else FFlagLuaSupportMicroGamepadPreferredInput

    if not var1 then
        return false
    end

    local bool1 = isGamepadPreferredInput(tbl1.preferredInput, var4)
    local bool2 = tbl1.preferredInput == Enum.PreferredInput.Touch or bool1
    return if var2 and bool2 and tbl1.displaySize == Enum.DisplaySize.Large then true else var3 and bool1
end

return isReskinConsoleMobileRoute
