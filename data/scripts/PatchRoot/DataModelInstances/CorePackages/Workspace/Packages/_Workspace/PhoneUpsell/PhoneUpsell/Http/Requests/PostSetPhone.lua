-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent
local UrlBuilder = require(PhoneUpsellParent.UrlBuilder).UrlBuilder

return function(arg1, countryCode: string, prefix: string, phone: string, password)
    assert(type(countryCode) == "string", "invalid country code in set phone number")
    assert(type(prefix) == "string", "invalid prefix in set phone number")
    assert(type(phone) == "string", "invalid phone number in set phone number")

    assert(type(password) == "string" or password == nil, "invalid password in set phone number")
    local string2 = UrlBuilder.fromString("accountinformation:phone")
    local postBody = HttpService:JSONEncode({ password = password, countryCode = countryCode, prefix = prefix, phone = phone })

    return arg1(string2(), "POST", { postBody = postBody })
end
