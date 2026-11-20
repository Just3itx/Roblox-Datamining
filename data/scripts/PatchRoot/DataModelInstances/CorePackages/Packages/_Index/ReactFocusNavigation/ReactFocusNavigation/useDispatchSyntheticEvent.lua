-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local FocusNavigationContext = require(script.Parent.FocusNavigationContext)

local function useDispatchSyntheticEvent()
    local var1 = React.useContext(FocusNavigationContext)

    return (React.useCallback(function(str1: string, arg1, arg2)
        if not var1 then
            if _G.__DEV__ then
                warn("useDispatchSyntheticEvent: No FocusNavigationService available in context")
            end
            return false
        end

        assert(arg1:IsA("GuiObject"), "Synthetic events must be dispatched on GuiObjects")

        return var1:dispatchSyntheticEvent(str1, arg1, arg2)
    end, { var1 }))
end

return useDispatchSyntheticEvent
