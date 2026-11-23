-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local gamePlayIntent = require(AppChatParent.DiscoveryAnalytics).Events.gamePlayIntent

local function ReportAnEvent(arg1, arg2, arg3)
    local tbl1, var1

    if arg2 == "gamePlayIntent" then
        tbl1 = {
            conversationId = arg1.conversationId,
            rootPlaceId = arg1.placeId,
            joinAttemptId = arg1.joinAttemptId
        }

        var1 = arg1.eventIngest
    else
        tbl1 = {
            conversationId = arg1.conversationId,
            placeId = arg1.placeId
        }

        var1 = arg1.eventStream
    end

    if arg2 ~= "gamePlayIntent" then
        var1:setRBXEventStream(arg3, arg2, tbl1)

        return
    end

    gamePlayIntent(var1, arg3, {
        placeId = tbl1.rootPlaceId,
        rootPlaceId = tonumber(tbl1.rootPlaceId),
        conversationId = tbl1.conversationId,
        joinAttemptId = tbl1.joinAttemptId
    })
end

return ReportAnEvent
