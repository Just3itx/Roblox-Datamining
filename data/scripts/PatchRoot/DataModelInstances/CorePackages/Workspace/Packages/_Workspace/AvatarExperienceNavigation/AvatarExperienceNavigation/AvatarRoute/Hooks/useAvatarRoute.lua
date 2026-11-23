-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")
local AvatarExperienceNavigationParent = AvatarExperienceNavigation.Parent
local React = require(AvatarExperienceNavigationParent.React)
local ArgCheck = require(AvatarExperienceNavigationParent.ArgCheck)
local AvatarRouteContext = require(AvatarExperienceNavigation.AvatarRoute.Context.AvatarRouteContext)
local _Types = require(AvatarExperienceNavigation.AvatarRoute.Types)

local function useAvatarRoute()
    local var1 = React.useContext(AvatarRouteContext)
    return ArgCheck.isNotNil(var1, "AvatarRouteContext")
end

return useAvatarRoute
