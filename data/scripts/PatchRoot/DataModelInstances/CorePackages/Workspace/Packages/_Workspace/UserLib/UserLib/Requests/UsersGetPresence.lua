-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

local Url = require(UserLibParent.Http).Url

return function(arg1, arg2)
    local userIds = {}
    for _, value in pairs(arg2) do
        local var1 = tonumber(value)
        if var1 then
            table.insert(userIds, var1)
        end
    end

    local postBody = HttpService:JSONEncode({ userIds = userIds })

    return arg1(string.format("%s/presence/users", Url.PRESENCE_URL), "POST", { postBody = postBody })
end
