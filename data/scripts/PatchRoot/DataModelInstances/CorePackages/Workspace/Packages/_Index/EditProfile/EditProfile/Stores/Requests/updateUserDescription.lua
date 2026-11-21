-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:55Z
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

local function updateUserDescription(description: string)
    local str1 = string.format("%s/description", Url.USERS_URL)

    return var1(str1, Enums.RequestMethods.POST, { postBody = HttpService:JSONEncode({ description = description }) }):andThen(
        function(arg1)
            return arg1.responseBody and arg1.responseBody.description or description
        end
    ):catch(
        function(arg1)
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
        end
    )
end
return updateUserDescription
