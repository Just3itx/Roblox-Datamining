-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local Url = require(GameInviteParent.Http).Url

return function(arg1, trigger, recipientUserId)
    local var1 = Url:makeQueryString({ RecipientUserId = recipientUserId, Trigger = trigger, PlaceId = game.PlaceId })

    return arg1(string.format("%snotifications/v1/can-prompt-experience-invite?%s", Url.APIS_URL, var1), "GET")
end
