-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent
local Url = require(PhoneUpsellParent.Http).Url

return function(arg1, upsellCardType: string)
    return arg1(
        string.format("%supsellcard/trial-opt-in", Url.APIS_URL),
        "POST",
        {
            postBody = HttpService:JSONEncode({ upsellCardType = upsellCardType })
        }
    )
end
