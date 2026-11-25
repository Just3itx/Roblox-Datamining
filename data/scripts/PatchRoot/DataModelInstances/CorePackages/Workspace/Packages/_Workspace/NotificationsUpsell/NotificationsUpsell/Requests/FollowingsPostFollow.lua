-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Url = require(scriptParentParentParent.Http).Url
local HttpService = game:GetService("HttpService")

return function(arg1, str1: string, str2: string)
    assert(type(str1) == "string", "FollowingsPostFollow request expects userId to be a string")
    assert(type(str2) == "string", "FollowingsPostFollow request expects universeId to be a string")

    return arg1(
        string.format("%s/v1/users/%s/universes/%s", Url.FOLLOWINGS_URL, str1, str2),
        "POST",
        {
            postBody = HttpService:JSONEncode({})
        }
    )
end
