-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent
local React = require(FocusNavigationUtilsParent.React)

local FocusNavigableSurfaceRegistry = require(FocusNavigationUtils.FocusNavigableSurfaceRegistry)
local useRegisterFocusNavigableSurface = FocusNavigableSurfaceRegistry.useRegisterFocusNavigableSurface
local useDeRegisterFocusNavigableSurface = FocusNavigableSurfaceRegistry.useDeRegisterFocusNavigableSurface
local _FocusNavigableSurfaceIdentifierEnum = require(FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum)

return function<T>(arg1: T, arg2: T, bool1: boolean?)
    local var1 = useRegisterFocusNavigableSurface()
    local var2 = useDeRegisterFocusNavigableSurface()

    if arg1 == nil then
        bool1 = false
    elseif bool1 == nil then
        bool1 = true
    end

    React.useEffect(function()
        if bool1 then
            var1(arg2, arg1)
        else
            var2(arg2, arg1)
        end

        return function()
            var2(arg2, arg1)
        end
    end, { bool1, arg2, arg1 })
end
