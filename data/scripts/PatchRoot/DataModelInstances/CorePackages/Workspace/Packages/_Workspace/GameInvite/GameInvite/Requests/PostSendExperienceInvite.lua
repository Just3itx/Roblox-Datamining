-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local Url = require(GameInviteParent.Http).Url

game:DefineFastFlag("LuaAppExperienceJoinIdempotencyKey", false)

return function(arg1, recipientUserId: string, placeId: string, trigger: string, inviteMessageId: string?, launchData: string?)
    local postBody = HttpService:JSONEncode({
        recipientUserId = recipientUserId,
        inviteMessageId = inviteMessageId,
        placeId = placeId,
        launchData = launchData,
        trigger = trigger,
        idempotencyKey = if game:GetFastFlag("LuaAppExperienceJoinIdempotencyKey") then HttpService:GenerateGUID(false) else nil
    })

    return arg1(string.format("%snotifications/v1/send-experience-invite", Url.APIS_URL), "POST", { postBody = postBody })
end
