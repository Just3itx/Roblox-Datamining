-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

return function(arg1, friendId: string, position: number, absolutePosition: number, rootPlaceId: number, fromWhere: string)
    assert(type(friendId) == "string", "Expected friendId to be a string")
    assert(type(position) == "number", "Expected position to be a number")
    assert(type(rootPlaceId) == "number", "Expected number to be a string")
    assert(type(fromWhere) == "string", "Expected fromWhere to be a string")
    assert(type(absolutePosition) == "number", "Expected absolutePosition to be a number")

    local userId = Players.LocalPlayer.UserId
    arg1:setRBXEventStream("contactFriendFinder", "goToGameDetailInPeopleList", {
        uid = tostring(userId),
        friendId = friendId,
        position = position,
        absolutePosition = absolutePosition,
        rootPlaceId = rootPlaceId,
        fromWhere = fromWhere
    })
end
