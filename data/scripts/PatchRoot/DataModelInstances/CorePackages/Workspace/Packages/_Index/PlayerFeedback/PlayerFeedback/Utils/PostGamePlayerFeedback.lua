-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PlayerFeedback = script:FindFirstAncestor("PlayerFeedback")
local HttpService = game:GetService("HttpService")
local PlayerFeedbackParent = PlayerFeedback.Parent
local GetFStringEdpPlayerFeedbackServiceRoute = require(PlayerFeedbackParent.SharedFlags).GetFStringEdpPlayerFeedbackServiceRoute
local Url = require(PlayerFeedbackParent.Http).Url

return function(arg1, str1: string, str2: string, categoryType: string, categoryOptionIds, comment: string)
    assert(type(str1) == "string", "PostGamePlayerFeedback request expects channelId to be a string")
    assert(type(str2) == "string", "PostGamePlayerFeedback request expects assetId to be a string")
    assert(type(categoryType) == "string", "PostGamePlayerFeedback request expects a valid category type")

    return arg1(
        string.format(
            "%s%s/v1/channels/%s/assets/%s/reviews",
            Url.APIS_URL,
            GetFStringEdpPlayerFeedbackServiceRoute(),
            str1,
            str2
        ),
        "POST",
        {
            postBody = HttpService:JSONEncode({ category_type = categoryType, category_option_ids = categoryOptionIds, comment = comment })
        }
    )
end
