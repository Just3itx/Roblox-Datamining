-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local NavigationContext = require(script.Parent.NavigationContext)

local function useNavigation()
    return React.useContext(NavigationContext)
end

return useNavigation
