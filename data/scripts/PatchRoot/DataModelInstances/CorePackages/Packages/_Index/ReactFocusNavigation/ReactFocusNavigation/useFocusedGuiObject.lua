-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local FocusNavigationContext = require(script.Parent.FocusNavigationContext)

local function useCurrentFocus()
    local var1 = React.useContext(FocusNavigationContext)
    local value = if var1 then var1.focusedGuiObject:getValue() else nil
    local var2, var3 = React.useState(value)
    React.useEffect(function()
        if var2 ~= value then
            var3(value)
        end

        if not var1 then
            return nil
        end

        local var4 = var1.focusedGuiObject:subscribe(var3)

        return function()
            var4:unsubscribe()
        end
    end, { var1 })

    return var2
end

return useCurrentFocus
