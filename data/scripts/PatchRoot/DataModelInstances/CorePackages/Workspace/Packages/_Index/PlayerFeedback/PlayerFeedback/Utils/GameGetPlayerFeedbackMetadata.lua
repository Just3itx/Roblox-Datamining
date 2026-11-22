-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerFeedbackParent = script:FindFirstAncestor("PlayerFeedback").Parent
local GetFStringEdpPlayerFeedbackServiceRoute = require(PlayerFeedbackParent.SharedFlags).GetFStringEdpPlayerFeedbackServiceRoute
local Url = require(PlayerFeedbackParent.Http).Url

return function(arg1, str1: string, str2: string)
    assert(type(str1) == "string", "GamesGetPlayerFeedbackMetadata request expects channelId to be a string")
    assert(type(str2) == "string", "GamesGetPlayerFeedbackMetadata request expects assetId to be a string")

    return arg1(
        string.format("%s%s/v1/channels/%s/assets/%s", Url.APIS_URL, GetFStringEdpPlayerFeedbackServiceRoute(), str1, str2),
        "GET"
    )
end
