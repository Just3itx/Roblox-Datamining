-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent
local Promise = require(PhoneUpsellParent.Promise)
local PostSetPhone = require(PhoneUpsell.Http.Requests.PostSetPhone)
local isStringPhone = require(PhoneUpsellParent.AuthCommon).Utils.isStringPhone

return function(arg1, str1: string, str2: string, str3: string, str4: string?)
    return function()
        if not isStringPhone(str2 .. str3) then
            return Promise.reject({ PhoneRegexFailed = true })
        end

        return PostSetPhone(arg1, str1, str2, str3, str4):andThen(function(_)
            return Promise.resolve()
        end, function(arg2)
            local errorCode = if arg2.Body then HttpService:JSONDecode(arg2.Body).errors[1].code else 0

            return Promise.reject({ ErrorCode = errorCode, PhoneRegexFailed = false })
        end)
    end
end
