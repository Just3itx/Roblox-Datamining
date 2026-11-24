-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpRequest = require(DataHydrationParent.HttpRequest)
local _Http = require(DataHydrationParent.Http)

local UserVoteFeedbackMetdataUrlBuilder = require(script.Parent.UserVoteFeedbackMetdataUrlBuilder)

local function fetchUserVoteFeedbackMetadata(str1: string)
    local userVoteFeedbackMetadataUrl = UserVoteFeedbackMetdataUrlBuilder.buildUserVoteFeedbackMetadataUrl(str1)

    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.HttpRbxApi(str2, str3, arg1)
        end
    })(userVoteFeedbackMetadataUrl, "GET")
end

return fetchUserVoteFeedbackMetadata
