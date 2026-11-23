-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")

local AvatarMainStackNavigationAction = require(AvatarExperienceNavigation.Enums.AvatarMainStackNavigationAction)

local function ClearScreens(routeNames)
    return {
        type = AvatarMainStackNavigationAction.ClearScreens,
        routeNames = routeNames
    }
end

return ClearScreens
