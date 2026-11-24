-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Url = require(DataHydrationParent.Http).Url

local TrustedConnections = DataHydration.TrustedConnections
local myHttpRequest = require(TrustedConnections.Networking.myHttpRequest)

return function(input: string?, limit: number?)
    local tbl1 = {}
    if input ~= nil then
        table.insert(tbl1, string.format("cursor=%s", HttpService:UrlEncode(input)))
    end
    if limit ~= nil then
        table.insert(tbl1, string.format("limit=%d", limit))
    end

    local str1 = string.format("%s/my/trusted-friends/candidates", Url.FRIEND_URL)
    if #tbl1 > 0 then
        str1 = string.format("%s?%s", str1, table.concat(tbl1, "&"))
    end

    return myHttpRequest(str1, "GET"):andThen(function(arg1)
        return arg1 and arg1.responseBody
    end)
end
