-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLandingParent = script:FindFirstAncestor("FriendsLanding").Parent
local AppPage = require(FriendsLandingParent.RobloxAppEnums).AppPage

local function getLuaAppsNavigator(arg1)
    local var1 = arg1._dangerouslyGetParent()

    if var1 then
        local var2 = var1._dangerouslyGetParent()

        if var2 then
            return var2.state.routeName == AppPage.CoHubMyConnections
        end
    end
    return false
end

return getLuaAppsNavigator
