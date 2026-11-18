-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:41:11Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local Http = script:FindFirstAncestor("Http")
local Url = require(Http.Url)

return function(arg1, arg2)
    local str1 = table.concat(arg2, ",")
    local str2 = tostring(Players.LocalPlayer.UserId)

    return arg1(string.format("%s/users/%s/friends/statuses?userIds=%s", Url.FRIEND_URL, str2, str1), "GET")
end
