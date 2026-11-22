-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST("SetSocialLinks", function(arg1, tbl2)
        return arg1(API_URL):path("v1"):path("promotion-channels"):body({
            promotionChannelsVisibilityPrivacy = tbl2.promotionChannelsVisibilityPrivacy,
            facebook = tbl2.facebook,
            twitter = tbl2.twitter,
            youtube = tbl2.youtube,
            twitch = tbl2.twitch,
            guilded = tbl2.guilded
        })
    end)
end
