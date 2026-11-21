-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local Url = require(AuthCommonParent.Http).Url
local var1 = require(AuthCommonParent.UrlBuilder).UrlBuilder.new(
    {
        base = Url.APIS_URL,
        path = "phone-number-api/v1/phone-prefix-list"
    }
)
return function(arg1)
    return arg1(var1(), "GET")
end
