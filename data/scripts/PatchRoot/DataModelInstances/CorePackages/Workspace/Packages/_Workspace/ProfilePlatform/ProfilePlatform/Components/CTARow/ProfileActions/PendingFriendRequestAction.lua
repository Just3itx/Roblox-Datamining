-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local ButtonVariant = require(ProfilePlatformParent.Foundation).Enums.ButtonVariant

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local ProfileTypes = Enums.ProfileTypes

local module = {}
module[Enums.ProfileActions.PendingFriendRequest] = function(arg1)
    local tbl1 = {
        variant = ButtonVariant.Subtle,
        text = arg1.localized[Enums.ProfileActions.PendingFriendRequest],
        onActivated = 0,
        isDisabled = true
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function() end

    tbl1.onActivated = onActivated
    return tbl1
end

return module
