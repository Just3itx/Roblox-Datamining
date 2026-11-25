-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)

local FFlagProfilePlatformMeTabMobileProfileHero = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformMeTabMobileProfileHero
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab

local FFlagProfilePlatformEnableAvatarBackground = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableAvatarBackground

local bool1 = game:DefineFastFlag("ProfilePlatformMeTabHeroDecoupleAvatarBackground", false)

local function useShouldResizeAvatar(): boolean
    if not FFlagProfilePlatformMeTabMobileProfileHero then
        return false
    end

    if not (FFlagAXEnableProfileTab and (bool1 or FFlagProfilePlatformEnableAvatarBackground)) then
        return false
    end

    local var1 = useProfileWrapperContext()
    local bool2 = useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide

    return var1.forceFullView == true and not bool2
end

return useShouldResizeAvatar
