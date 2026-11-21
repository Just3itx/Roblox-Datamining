-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local FriendsCarouselParent = FriendsCarousel.Parent

local _GraphQLServer = require(FriendsCarouselParent.GraphQLServer)

local _LocalTypes = require(FriendsCarousel.Common.LocalTypes)

return function(arg1)
    local universeId = nil
    if arg1.__typename ~= "Friend" then
        if arg1.isFriendWithUser then
            universeId = arg1.universeId
        end

        return universeId
    end

    local presence = arg1.presence or {}
    if not presence.universeId then
        return nil
    end

    return tonumber(presence.universeId)
end
