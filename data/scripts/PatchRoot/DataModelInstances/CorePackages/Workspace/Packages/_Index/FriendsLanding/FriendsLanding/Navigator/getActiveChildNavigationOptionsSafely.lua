-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLandingParent = script:FindFirstAncestor("FriendsLanding").Parent
local RoactNavigation = require(FriendsLandingParent.RoactNavigation)

local function getUpdatedNavigation(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1._dangerouslyGetParent()
    if var1 and arg1.state and arg1.state.key then
        arg1 = var1.getChildNavigation(arg1.state.key) or arg1
    end

    return arg1
end

return function(arg1)
    local updatedNavigation = getUpdatedNavigation(arg1)
    return RoactNavigation.getActiveChildNavigationOptions(updatedNavigation)
end
