-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local myRoduxNetworking = require(ProfilePlatform.Networking.myRoduxNetworking)
local ProfilePlatformParent = ProfilePlatform.Parent
local Http = require(ProfilePlatformParent.Http)
local _Enums = require(ProfilePlatform.Common.Enums)

local FFlagProfilePlatformEnableLazyLoadingComponents = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableLazyLoadingComponents)
local _SocialCommon = require(ProfilePlatformParent.SocialCommon)

local _Component = require(ProfilePlatform.Types.Component)

return myRoduxNetworking.POST("GetProfile", function(arg1, tbl1)
    local var1 = arg1(Http.Url.APIS_URL .. "profile-platform-api"):path("v1"):path("profiles"):path("get")
    local tbl2 = {
        profileType = tbl1.profileType,
        profileId = tbl1.profileId,
        components = tbl1.components,
        includeComponentOrdering = tbl1.includeComponentOrdering,
        onlyEssentialComponents = if FFlagProfilePlatformEnableLazyLoadingComponents then tbl1.onlyEssentialComponents else nil
    }
    return var1:body(tbl2)
end)
