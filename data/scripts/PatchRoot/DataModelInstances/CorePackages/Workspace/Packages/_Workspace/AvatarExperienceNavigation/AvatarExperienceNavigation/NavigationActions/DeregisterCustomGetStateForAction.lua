-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")

local AvatarRootNavigationAction = require(AvatarExperienceNavigation.Enums.AvatarRootNavigationAction)
local _CustomGetStateForAction = require(AvatarExperienceNavigation.Enums.CustomGetStateForAction)

local function DeregisterCustomGetStateForAction(handlerId)
    return {
        type = AvatarRootNavigationAction.DeregisterCustomGetStateForAction,
        handlerId = handlerId
    }
end

return DeregisterCustomGetStateForAction
