-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent

local React = require(RobloxAppNavigationParent.React)

local useIsRouteOnScreen = require(script.Parent.useIsRouteOnScreen)

local function useOnScreenNavigationListener<T>(callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    local current = useIsRouteOnScreen()
    local var2 = React.useRef(current)
    React.useEffect(function()
        if current == var2.current then
            return
        end
        var2.current = current
        if current then
            if callback ~= nil then
                callback()
            end
        elseif callback2 ~= nil then
            callback2()
        end
    end, { callback, callback2, current })
end

return useOnScreenNavigationListener
