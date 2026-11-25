-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local PhoneUpsell = script:FindFirstAncestor("PhoneUpsell")
local PhoneUpsellParent = PhoneUpsell.Parent
local Promise = require(PhoneUpsellParent.Promise)
local PostVerifyPhoneCode = require(PhoneUpsell.Http.Requests.PostVerifyPhoneCode)

return function(arg1, str1: string)
    return function()
        return PostVerifyPhoneCode(arg1, str1):andThen(function(_)
            return Promise.resolve()
        end, function(arg2)
            local errorCode = if arg2.Body then HttpService:JSONDecode(arg2.Body).errors[1].code else 0

            return Promise.reject({ ErrorCode = errorCode })
        end)
    end
end
