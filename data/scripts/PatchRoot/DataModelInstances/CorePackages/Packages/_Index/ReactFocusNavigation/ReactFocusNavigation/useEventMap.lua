-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local FocusNavigationContext = require(script.Parent.FocusNavigationContext)
local useComposedRef = require(script.Parent.useComposedRef)
local useEventLifecycleRef = require(script.Parent.useEventLifecycleRef)

local function useEventMap(arg1, arg2)
    local var1 = React.useContext(FocusNavigationContext)

    local var2 = React.useCallback(function(arg3)
        if var1 then
            assert(arg3:IsA("GuiObject"), "EventMaps can only be mapped to GuiObjects")
            var1:registerEventMap(arg3, arg1)
        end
    end, { var1, arg1 })

    local var3 = React.useCallback(function(arg3)
        if var1 then
            assert(arg3:IsA("GuiObject"), "EventMaps can only be mapped to GuiObjects")
            var1:deregisterEventMap(arg3, arg1)
        end
    end, { var1, arg1 })

    local var4 = useEventLifecycleRef(var2, var3)
    return useComposedRef(var4, arg2)
end

return useEventMap
