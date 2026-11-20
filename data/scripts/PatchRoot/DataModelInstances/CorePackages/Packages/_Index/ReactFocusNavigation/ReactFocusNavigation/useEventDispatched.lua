-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local _FocusNavigation = require(scriptParentParent.FocusNavigation)

local FocusNavigationContext = require(script.Parent.FocusNavigationContext)

local function useEventDispatched(current: (...any) -> (...any))
    local var1 = React.useContext(FocusNavigationContext)
    local var2 = React.useRef(current)
    var2.current = current

    React.useEffect(function()
        if not var1 then
            return nil
        end

        local var3 = var1.eventDispatched:subscribe(function(arg1)
            if arg1 then
                var2.current(arg1)
            end
        end)

        return function()
            var3:unsubscribe()
        end
    end, { var1 })
end

return useEventDispatched
