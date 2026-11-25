-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PhoneUpsellParent = script:FindFirstAncestor("PhoneUpsell").Parent

local HttpService = game:GetService("HttpService")
local UrlBuilder = require(PhoneUpsellParent.UrlBuilder).UrlBuilder

return function(arg1, layerName: string, displayTime: number, userIgnored: boolean, bool1: boolean)
    local postBody = HttpService:JSONEncode({ layerName = layerName, displayTime = displayTime, userIgnored = userIgnored })

    return arg1(
        UrlBuilder.fromString("apis:upsellcard/v1/phone-verification/display-time")(),
        "POST",
        bool1 and { postBody = postBody } or postBody
    )
end
