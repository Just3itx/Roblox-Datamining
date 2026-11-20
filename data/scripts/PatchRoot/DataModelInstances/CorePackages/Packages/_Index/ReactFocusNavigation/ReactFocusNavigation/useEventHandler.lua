-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local FocusNavigationContext = require(script.Parent.FocusNavigationContext)
local useComposedRef = require(script.Parent.useComposedRef)
local useEventLifecycleRef = require(script.Parent.useEventLifecycleRef)

local function useEventHandler(str1: string, str2: string, str3: string, arg1)
    local var1 = React.useContext(FocusNavigationContext)

    local var2 = React.useCallback(function(arg2)
        if var1 then
            assert(arg2:IsA("GuiObject"), "Event handlers can only be applied to GuiObjects")
            var1:registerEventHandler(arg2, str1, str2, str3)
        end
    end, {
        var1,
        str1,
        str2,
        str3
    })
    local var3 = React.useCallback(function(arg2)
        if var1 then
            assert(arg2:IsA("GuiObject"), "Event handlers can only be applied to GuiObjects")
            var1:deregisterEventHandler(arg2, str1, str2, str3)
        end
    end, {
        var1,
        str1,
        str2,
        str3
    })
    local var4 = useEventLifecycleRef(var2, var3)
    return useComposedRef(var4, arg1)
end

return useEventHandler
