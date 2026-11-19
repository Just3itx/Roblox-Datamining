-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Url = require(script.Parent.Parent.Url)

return function(arg1, arg2, userSort)
    local var1 = Url:makeQueryString({ userSort = userSort })

    return arg1(string.format("%s/users/%s/friends?%s", Url.FRIEND_URL, arg2, var1), "GET")
end
