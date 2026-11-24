-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local Friends = DataHydration.Friends
local myHttpRequest = require(Friends.Networking.myHttpRequest)

local function isNumericUserId(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return string.match(str1, "^%d+$") ~= nil
end

return function(arg1, tbl1)
    local tbl2 = {}
    for _, value in tbl1 do
        if isNumericUserId(value) then
            table.insert(tbl2, value)
        end
    end

    local str1 = HttpService:UrlEncode(table.concat(tbl2, ","))

    local str2 = string.format("%s/users/%s/friends/statuses?userIds=%s", Url.FRIEND_URL, tostring(arg1), str1)

    return myHttpRequest(str2, "GET"):andThen(function(arg2)
        return if arg2 then arg2.responseBody else nil
    end)
end
