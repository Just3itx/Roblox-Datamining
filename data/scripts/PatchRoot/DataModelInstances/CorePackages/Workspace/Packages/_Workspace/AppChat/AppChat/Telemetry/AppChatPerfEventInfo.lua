-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local AppChatPerfEvent = require(AppChat.Telemetry.AppChatPerfEvent)
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)

local tbl1 = {
    ChatLandingTTI = { baseName = "AppChat_TTI_ChatLanding", page = "ChatLanding" },
    ChatConversationTTI = { baseName = "AppChat_TTI_ChatConversation", page = "ChatConversation" },
    MessageSendTTI = { baseName = "AppChat_TTI_MessageSend", page = "ChatConversation" },
    MessageReceiveTTI = { baseName = "AppChat_TTI_MessageReceive", page = "ChatConversation" }
}

local tbl2 = {
    ScrollConversationList = {
        name = "AppChat_Scroll_ConversationList",
        parentTTI = AppChatPerfEvent.ChatLandingTTI
    },
    PaginationConversationList = {
        name = "AppChat_Pagination_ConversationList",
        parentTTI = AppChatPerfEvent.ChatLandingTTI
    },
    ScrollMessageList = {
        name = "AppChat_Scroll_MessageList",
        parentTTI = AppChatPerfEvent.ChatConversationTTI
    },
    PaginationMessageList = {
        name = "AppChat_Pagination_MessageList",
        parentTTI = AppChatPerfEvent.ChatConversationTTI
    },
    MessageSendToPendingRender = {
        name = "AppChat_Message_SendToPendingRender",
        parentTTI = AppChatPerfEvent.ChatConversationTTI
    },
    MessageSendResponseToFinalRender = {
        name = "AppChat_Message_SendResponseToFinalRender",
        parentTTI = AppChatPerfEvent.ChatConversationTTI
    },
    MessageSendToFinalRender = {
        name = "AppChat_Message_SendToFinalRender",
        parentTTI = AppChatPerfEvent.ChatConversationTTI
    },
    MessageReceiveToRender = {
        name = "AppChat_Message_ReceiveToRender",
        parentTTI = AppChatPerfEvent.ChatConversationTTI
    },
    TopBarRenderInterval = {
        name = "AppChat_TopBar_RenderInterval",
        parentTTI = AppChatPerfEvent.ChatLandingTTI
    }
}

local function getTTIBaseName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[arg1].baseName
end

return {
    Events = AppChatPerfEvent,
    TTI_CATEGORY = "AppChat",
    isTTIEvent = function(arg1): boolean
        return tbl1[arg1] ~= nil
    end,
    isIntervalEvent = function(arg1): boolean
        return tbl2[arg1] ~= nil
    end,
    getTTIBaseName = getTTIBaseName,
    getTTIPage = function(arg1)
        return tbl1[arg1].page
    end,
    getTTICategory = function(): string
        return "AppChat"
    end,
    buildTTIEventName = function(arg1, arg2, bool1: boolean)
        return getTTIBaseName(arg1) .. (if ChatPlacementContext.isPlacementInExperience(arg2) then "_InExp" else "_UA") .. (if bool1 then "_Cold" else "_Warm")
    end,
    getIntervalName = function(arg1)
        return tbl2[arg1].name
    end,
    getParentTTI = function(arg1)
        return tbl2[arg1].parentTTI
    end,
    getIntervalsForTTI = function(parentTti)
        local intervalsForTti = {}
        for value, value2 in tbl2 do
            if value2.parentTTI == parentTti then
                table.insert(intervalsForTti, value)
            end
        end
        return intervalsForTti
    end
}
