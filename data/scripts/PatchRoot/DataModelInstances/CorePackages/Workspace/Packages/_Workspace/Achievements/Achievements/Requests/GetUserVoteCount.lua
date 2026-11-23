-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AchievementsParent = script:FindFirstAncestor("Achievements").Parent

local Url = require(AchievementsParent.Http).Url

return function(arg1)
    return arg1(string.format("%svoting-api/user/get-vote-count?targetType=Place", Url.APIS_URL), "GET")
end
