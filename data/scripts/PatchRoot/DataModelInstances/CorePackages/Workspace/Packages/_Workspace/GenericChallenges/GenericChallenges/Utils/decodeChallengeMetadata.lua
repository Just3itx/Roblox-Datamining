-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallenges = script:FindFirstAncestor("GenericChallenges")
local GenericChallengesParent = GenericChallenges.Parent

local HttpService = game:GetService("HttpService")

local Base64 = require(GenericChallengesParent.AuthCommon).Utils.Base64

local _ChallengeMetadata = require(GenericChallenges.Types.ChallengeMetadata)

local function decodeChallengeMetadata(str1: string?)
    if str1 == nil or str1 == "" then
        return nil
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(Base64.Decode(str1))
    end)
    return if success and typeof(result) == "table" then result else nil
end

return decodeChallengeMetadata
