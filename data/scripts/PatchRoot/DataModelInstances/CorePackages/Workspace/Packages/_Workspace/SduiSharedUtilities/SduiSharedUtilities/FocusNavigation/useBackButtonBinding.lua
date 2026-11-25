-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local FocusNavigationUtils = require(SduiSharedUtilitiesParent.FocusNavigationUtils)
local React = require(SduiSharedUtilitiesParent.React)
local ReactFocusNavigation = require(SduiSharedUtilitiesParent.ReactFocusNavigation)

local useOnNavigateBack = require(script.Parent.NavigateBackBindings).useOnNavigateBack

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local tbl1 = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useBackButtonBinding(func1: (...any) -> (...any))
    local var1, var2 = React.useState(nil)

    local var3 = ReactFocusNavigation.useEventMap(tbl1)
    local var4 = useOnNavigateBack(func1, var3)

    React.useEffect(function()
        if var4 then
            var4(var1)
        end
    end, { var4, var1 })

    return var2
end

return useBackButtonBinding
