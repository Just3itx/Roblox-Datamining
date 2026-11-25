-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local _Component = require(ProfilePlatform.Types.Component)
local Enums = require(ProfilePlatform.Common.Enums)
local getSupportedActionsForProfileType = require(ProfilePlatform.Hooks.getSupportedActionsForProfileType)

return function()
    return {
        {
            component = Enums.Components.ContactProfileHeader
        },
        {
            component = Enums.Components.ContactDescription
        },
        {
            component = Enums.Components.Actions,
            supportedActions = getSupportedActionsForProfileType(Enums.ProfileTypes.Contact),
            isActionsV2Supported = true
        }
    }
end
