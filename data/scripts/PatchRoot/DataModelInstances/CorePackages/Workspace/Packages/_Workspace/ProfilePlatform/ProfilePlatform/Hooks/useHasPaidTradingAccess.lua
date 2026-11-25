-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local useSelector = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useSelector
local useIsRobloxSubscriber = require(ProfilePlatformParent.UserProfiles).Hooks.useIsRobloxSubscriber
local FFlagEnableBlackbirdCheck = require(ProfilePlatformParent.SharedFlags).FFlagEnableBlackbirdCheck

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)

local function useHasPaidTradingAccess(str1: string?)
    local var1 = useIsRobloxSubscriber(str1)
    local var2 = useSelector(function(arg1): boolean
        if not str1 then
            return false
        end
        local users = arg1.Users
        local user = users and users[str1]
        return if user then user.membership == Enum.MembershipType.Premium else false
    end)

    local var3 = useProfileWrapperContext()
    local var4 = useProfileJsonComponent(Enums.Components.UserProfileHeader)
    local bool1 = tostring(var3.profileId) == tostring(str1) and var4.isPremium == true

    return var2 or bool1 or FFlagEnableBlackbirdCheck and var1
end

return useHasPaidTradingAccess
