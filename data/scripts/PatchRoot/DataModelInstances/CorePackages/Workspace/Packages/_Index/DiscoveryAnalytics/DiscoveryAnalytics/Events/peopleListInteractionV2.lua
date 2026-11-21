-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

return function(arg1, btn: string, friendId: string, position: number, arg2, absolutePosition: number, arg3)
    assert(type(btn) == "string", "Expected buttonName to be a string")
    assert(type(friendId) == "string", "Expected friendId to be a string")
    assert(type(position) == "number", "Expected position to be a number")
    assert(arg2 == nil or type(arg2) == "string", "Expected context to be nil or string")
    assert(type(absolutePosition) == "number", "Expected absolutePosition to be a number")
    assert(arg3 == nil or type(arg3) == "table", "Expected extraArgs to be nil or table")

    local var1 = arg2 or "contactFriendFinder"
    local userId = Players.LocalPlayer.UserId

    local str1 = "buttonClick"
    local tbl1 = {
        uid = tostring(userId),
        friendId = friendId,
        position = position,
        btn = btn,
        absolutePosition = absolutePosition,
        universeId = if arg3 then arg3.universeId else nil,
        source = if arg3 then arg3.source else nil
    }
    arg1:setRBXEventStream(var1, str1, tbl1)
end
