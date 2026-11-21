-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent
local Url = require(AuthSignupParent.Http).Url

return function(arg1)
    return arg1(string.format("%sv1/account-creation/metadata", Url.AUTH_URL), "GET", { maxRetryCount = 0 })
end
