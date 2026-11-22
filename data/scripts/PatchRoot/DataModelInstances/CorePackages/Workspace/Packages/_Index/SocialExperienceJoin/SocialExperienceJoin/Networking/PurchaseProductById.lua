-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent

local Url = require(SocialExperienceJoinParent.Http).Url

return require(SocialExperienceJoin.Networking.myRoduxNetworking).POST(script.Name, function(arg1, str1: string, tbl1)
    return arg1(Url.ECONOMY_URL):path("v1"):path("purchases"):path("products"):id(str1):body(tbl1 or {})
end)
