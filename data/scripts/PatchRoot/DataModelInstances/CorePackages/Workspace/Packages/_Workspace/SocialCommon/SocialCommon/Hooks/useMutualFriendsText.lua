-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent

local useLocalization = require(SocialCommonParent.Localization).Hooks.useLocalization

local getMutualFriendsText = require(SocialCommon.Utils.getMutualFriendsText)

return function(num1: number)
    local localized = useLocalization({
        singularMutualConnection = "Feature.Friends.Label.MutualFriendTitle",
        mutualConnections = { "Feature.Friends.Label.MutualFriendsTitle", numConnections = num1 }
    })

    return getMutualFriendsText({ mutualFriendsCount = num1, localized = localized })
end
