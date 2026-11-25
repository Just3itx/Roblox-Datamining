-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local useSelector = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useSelector

local Constants = require(ProfilePlatform.Common.Constants)
local getDeepValue = require(ProfilePlatform.Utils.getDeepValue)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)

return function()
    local var1 = useProfileWrapperContext()
    local profileId = var1.profileId
    local profileType = var1.profileType

    return useSelector(function(arg1)
        return getDeepValue(arg1, `{Constants.RODUX_KEY}.Profiles.{profileType}.{profileId}`) or {}
    end)
end
