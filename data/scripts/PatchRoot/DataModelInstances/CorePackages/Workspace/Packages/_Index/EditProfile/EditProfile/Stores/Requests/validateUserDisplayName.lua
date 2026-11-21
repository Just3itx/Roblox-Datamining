-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent

local Http = require(EditProfileParent.Http)
local HttpRequest = require(EditProfileParent.HttpRequest)
local Promise = require(EditProfileParent.Promise)
local Enums = require(EditProfile.Common.Enums)
local HttpService = game:GetService("HttpService")
local Url = Http.Url

local var1 = HttpRequest.config({
    requestFunction = function(str1: string, arg1, arg2)
        return HttpRequest.requestFunctions.RequestInternal(str1, arg1, arg2)
    end
})

local function validateUserDisplayName(str1: string, input: string)
    local str2 = string.format("%s/users/%s/display-names/validate", Url.USERS_URL, str1)
    local str3 = string.format("%s?displayName=%s", str2, HttpService:UrlEncode(input))

    return var1(str3, Enums.RequestMethods.GET):andThen(function(arg1)
        return arg1.responseBody or {}
    end):catch(function(arg1)
        if not arg1 then
            return Promise.reject(arg1)
        end

        local tbl1 = {
            statusCode = arg1.StatusCode,
            errors = {}
        }
        if arg1.Body then
            local success, result = pcall(function()
                return HttpService:JSONDecode(arg1.Body)
            end)
            if success and result and result.errors then
                tbl1.errors = result.errors
            end
        end
        return Promise.reject(tbl1)
    end)
end

return validateUserDisplayName
