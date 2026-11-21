-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local Url = require(AuthCommonParent.Http).Url

return function(arg1)
    return arg1(string.format("%s/users/authenticated/app-launch-info", Url.USERS_URL), "GET", { maxRetryCount = 0 })
end
