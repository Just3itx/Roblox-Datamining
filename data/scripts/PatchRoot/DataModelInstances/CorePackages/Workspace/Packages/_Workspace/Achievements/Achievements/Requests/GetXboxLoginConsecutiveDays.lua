-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AchievementsParent = script:FindFirstAncestor("Achievements").Parent

local Url = require(AchievementsParent.Http).Url

return function(arg1)
    return arg1(string.format("%sv1/xbox/get-login-consecutive-days", Url.AUTH_URL), "GET")
end
