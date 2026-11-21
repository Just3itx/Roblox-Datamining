-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local Http = require(EditProfileParent.Http)
local HttpRequest = require(EditProfileParent.HttpRequest)
local _DataHydration = require(EditProfileParent.DataHydration)
local Enums = require(EditProfile.Common.Enums)
local HttpService = game:GetService("HttpService")
local FFlagEditProfileUseProfilePlatformBio = require(EditProfile.Flags.FFlagEditProfileUseProfilePlatformBio)

local Url = Http.Url

local var1 = HttpRequest.config({
    requestFunction = function(str1: string, arg1, arg2)
        return HttpRequest.requestFunctions.RequestInternal(str1, arg1, arg2)
    end
})

local function fetchUserDescription(profileId: string)
    if not FFlagEditProfileUseProfilePlatformBio then
        local str1 = string.format("%s/users/%s", Url.USERS_URL, profileId)

        return var1(str1, Enums.RequestMethods.GET):andThen(function(arg1)
            return arg1.responseBody.description or ""
        end):catch(function(arg1)
            error(arg1)
        end)
    end

    return var1(Url.APIS_URL .. "profile-platform-api/v1/profiles/get", Enums.RequestMethods.POST, {
        postBody = HttpService:JSONEncode({
            profileType = "User",
            profileId = profileId,
            components = {{ component = "About" }},
            includeComponentOrdering = false
        })
    }):andThen(
        function(arg1)
            local components = arg1.responseBody.components
            local about = components and components.About
            return about and about.description or ""
        end
    )
end
return fetchUserDescription
