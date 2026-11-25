-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent
local UrlBuilder = require(PhoneUpsellParent.UrlBuilder).UrlBuilder

return function(arg1)
    return arg1(UrlBuilder.fromString("accountinformation:phone/resend")(), "POST", { postBody = "" })
end
