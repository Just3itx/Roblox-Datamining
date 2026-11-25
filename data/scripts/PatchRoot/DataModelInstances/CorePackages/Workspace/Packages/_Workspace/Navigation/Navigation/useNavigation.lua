-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationParent = script:FindFirstAncestor("Navigation").Parent

local React = require(NavigationParent.React)
local RoactNavigation = require(NavigationParent.RoactNavigation)

local function useNavigation()
    return React.useContext(RoactNavigation.Context)
end

return useNavigation
