-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local FocusNavigationContext = require(script.Parent.FocusNavigationContext)

local function useActiveEventMap()
    local var1 = React.useContext(FocusNavigationContext)

    local var2 = not var1 and {} or var1.activeEventMap:getValue()
    local var3, var4 = React.useState(var2)
    React.useEffect(function()
        if var3 ~= var2 then
            var4(var2)
        end

        if not var1 then
            return nil
        end

        local var5 = var1.activeEventMap:subscribe(var4)

        return function()
            var5:unsubscribe()
        end
    end, { var1 })

    return var3
end

return useActiveEventMap
