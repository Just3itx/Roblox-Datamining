-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationParent = script:FindFirstAncestor("Navigation").Parent

local React = require(NavigationParent.React)
local RoactNavigation = require(NavigationParent.RoactNavigation)
local useNavigation = require(script.Parent.useNavigation)

local function useNavigationFocus()
    local var1 = useNavigation()

    local var2, var3 = React.useState(var1.isFocused())

    React.useEffect(function()
        local var4 = var1.addListener(RoactNavigation.Events.WillFocus, function()
            var3(true)
        end)
        local var5 = var1.addListener(RoactNavigation.Events.WillBlur, function()
            var3(false)
        end)
        var3(var1.isFocused())

        return function()
            var4.remove()
            var5.remove()
        end
    end, {})

    return var2
end

return useNavigationFocus
