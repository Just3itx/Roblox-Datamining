-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local Contexts = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.Enums.Contexts

local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)

return function()
    local var1 = useProfileWrapperContext()

    return React.useMemo(function()
        if var1.profileType == Enums.ProfileTypes.Community then
            return Contexts.CommunityProfile
        end

        if var1.profileType == Enums.ProfileTypes.User then
            return Contexts.PlayerProfile
        end

        return AppPage.ProfilePlatform
    end, { var1.profileType })
end
