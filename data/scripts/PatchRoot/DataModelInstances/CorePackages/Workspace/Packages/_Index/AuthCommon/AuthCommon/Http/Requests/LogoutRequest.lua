-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local Url = require(AuthCommonParent.Http).Url
local FFlagEnableLogoutV3 = require(AuthCommonParent.SharedFlags).FFlagEnableLogoutV3

return function(arg1)
    return arg1(
        if FFlagEnableLogoutV3 then string.format("%sv3/logout", Url.AUTH_URL) else string.format("%sv1/logout", Url.AUTH_URL),
        "POST",
        {
            postBody = if FFlagEnableLogoutV3 then "{}" else "",
            maxRetryCount = 0
        }
    )
end
