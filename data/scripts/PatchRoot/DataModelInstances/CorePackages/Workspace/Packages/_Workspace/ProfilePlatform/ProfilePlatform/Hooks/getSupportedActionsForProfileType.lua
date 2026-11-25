-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")

local _Enums = require(ProfilePlatform.Common.Enums)
local SupportedProfileTypes = require(ProfilePlatform.Components.CTARow.ProfileActions.SupportedProfileTypes)

return function(arg1)
    return SupportedProfileTypes[arg1] or {}
end
