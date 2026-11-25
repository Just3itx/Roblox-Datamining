-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationParent = script:FindFirstAncestor("Navigation").Parent

local React = require(NavigationParent.React)
local RoactNavigation = require(NavigationParent.RoactNavigation)

local useNavigation = require(script.Parent.useNavigation)

local function useEarlyIsFocused()
    local var1 = useNavigation()

    local var2, var3 = React.useState(var1.isFocused())

    React.useEffect(function()
        var3(var1.isFocused())

        local var4 = var1.addListener(RoactNavigation.Events.WillFocus, function()
            var3(true)
        end)

        local var5 = var1.addListener(RoactNavigation.Events.WillBlur, function()
            var3(false)
        end)

        return function()
            var4.remove()
            var5.remove()
        end
    end, { var1 })

    return var2
end

return useEarlyIsFocused
