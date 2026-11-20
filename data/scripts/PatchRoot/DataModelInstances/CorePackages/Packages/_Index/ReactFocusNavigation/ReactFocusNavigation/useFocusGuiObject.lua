-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local mockableWarn = require(scriptParentParent.FocusNavigationUtils).mockableWarn

local FocusNavigationContext = require(script.Parent.FocusNavigationContext)

local function useFocusGuiObject()
    local var1 = React.useContext(FocusNavigationContext)

    return React.useCallback(function(arg1, bool1: boolean?)
        if var1 then
            var1:focusGuiObject(arg1, not not bool1)
        elseif _G.__DEV__ then
            mockableWarn(
                "Could not capture focus with no FocusNavigationService.\n\nIntroduce a ReactFocusNavigation.FocusNavigationProvider above this component in the tree and provide it with a value returned from FocusNavigationService.new(...)"
            )
        end
    end, { var1 })
end

return useFocusGuiObject
