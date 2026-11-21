-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local UrlBuilder = require(AuthCommonParent.UrlBuilder).UrlBuilder

return function(arg1)
    return arg1(UrlBuilder.fromString("auth:v1/session/refresh")(), "POST", { postBody = "" })
end
