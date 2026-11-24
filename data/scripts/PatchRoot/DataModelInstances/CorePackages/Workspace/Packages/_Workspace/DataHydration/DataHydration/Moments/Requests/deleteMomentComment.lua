-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)

local function commentPath(str1: string, str2: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `moment-comments-api/v1/moments/{str1}/comments/{str2}`
end

local function deleteMomentComment(str1: string, str2: string, network)
    local url, headers = constructApiUrl((commentPath(str1, str2)))

    return HttpClient.fetch({
        method = "DELETE",
        url = url,
        headers = headers,
        analyticsKey = "moments.delete-comment",
        network = network,
        decode = function(_)
            return nil
        end
    })
end

return deleteMomentComment
