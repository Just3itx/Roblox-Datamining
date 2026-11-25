-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent
local UrlBuilder = require(PhoneUpsellParent.UrlBuilder).UrlBuilder

return function(arg1, code: string)
    assert(type(code) == "string", "invalid code in verify phone code")

    assert(not string.match(code, "%D"), "invalid code in verify phone code")
    local string2 = UrlBuilder.fromString("accountinformation:phone/verify")
    local postBody = HttpService:JSONEncode({ code = code })

    return arg1(string2(), "POST", { postBody = postBody })
end
