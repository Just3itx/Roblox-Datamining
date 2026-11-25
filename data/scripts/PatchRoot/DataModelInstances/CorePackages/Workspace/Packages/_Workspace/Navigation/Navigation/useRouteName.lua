-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationParent = script:FindFirstAncestor("Navigation").Parent

local FFlagOptionalNavigation = require(NavigationParent.SharedFlags).FFlagOptionalNavigation

local useNavigation = require(script.Parent.useNavigation)

local function useRouteName()
    local var1 = useNavigation()

    return if FFlagOptionalNavigation and var1 == nil then nil else var1.state.routeName
end

return useRouteName
