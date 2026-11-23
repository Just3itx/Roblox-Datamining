-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")

local AvatarExperienceNavigationParent = AvatarExperienceNavigation.Parent
local _Navigation = require(AvatarExperienceNavigationParent.Navigation)

local AvatarRootNavigationAction = require(AvatarExperienceNavigation.Enums.AvatarRootNavigationAction)
local _CustomGetStateForAction = require(AvatarExperienceNavigation.Enums.CustomGetStateForAction)

local function RegisterCustomGetStateForAction(handlerId, handler: (...any) -> (...any))
    return {
        type = AvatarRootNavigationAction.RegisterCustomGetStateForAction,
        handlerId = handlerId,
        handler = handler
    }
end

return RegisterCustomGetStateForAction
