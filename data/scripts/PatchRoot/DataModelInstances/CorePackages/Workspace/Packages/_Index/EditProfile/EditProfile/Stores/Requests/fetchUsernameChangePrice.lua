-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local Http = require(EditProfileParent.Http)
local HttpRequest = require(EditProfileParent.HttpRequest)
local Enums = require(EditProfile.Common.Enums)

local Url = Http.Url

local var1 = HttpRequest.config({
    requestFunction = function(str1: string, arg1, arg2)
        return HttpRequest.requestFunctions.RequestInternal(str1, arg1, arg2)
    end
})

local function fetchUsernameChangePrice(_: string)
    local str1 = string.format("%sv1/username/change/price", Url.AUTH_URL)

    return var1(str1, Enums.RequestMethods.GET):andThen(function(arg1)
        local responseBody = arg1.responseBody

        return {
            priceInRobux = responseBody.priceInRobux,
            isFreeUsernameChange = responseBody.isFreeUsernameChange == true
        }
    end)
end

return fetchUsernameChangePrice
