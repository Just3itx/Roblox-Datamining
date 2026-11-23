-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function coerceToString(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return ""
    end
    return tostring(arg1)
end

function module.sanitizeSegment(arg1)
    return (coerceToString(arg1):gsub("%s+", "_"):gsub("[^%w_]", ""))
end

function module.build(tbl1): string
    local tbl2 = {}
    for _, value in tbl1 do
        local var1 = module.sanitizeSegment(value)
        if var1 ~= "" then
            table.insert(tbl2, var1)
        end
    end
    return table.concat(tbl2, "-")
end

function module.chatLandingTopBarIconButton(str1: string)
    return module.build({ "chat", "chatLanding", "topBar", "button", str1 })
end

function module.appChatLoadingOverlayBackButton()
    return module.build({ "chat", "loadingOverlay", "button", "back" })
end

function module.chatLandingConversationListHeader(str1: string)
    return module.build({ "chat", "chatLanding", "conversationList", "conversationListHeader", str1 })
end

function module.chatLandingConversationEntry(str1: string)
    return module.build({ "chat", "chatLanding", "conversationList", "conversationEntry", str1 })
end

function module.chatLandingConversationEntrySquadButton(str1: string)
    return module.build({ "chat", "chatLanding", "conversationList", "conversationEntry", "button", `squad_{str1}` })
end

function module.chatDetailsTopBarActionButton(str1: string)
    return module.build({ "chat", "chatDetails", "topBar", "button", str1 })
end

function module.chatDetailsListActionButton(str1: string)
    return module.build({ "chat", "chatDetails", "detailsList", "button", str1 })
end

function module.chatDetailsParticipantMoreButton(str1: string)
    return module.build({
        "chat",
        "chatDetails",
        "detailsList",
        "participantList",
        "participantEntry",
        "button",
        `{str1}_moreDetails`
    })
end

function module.chatConversationTopBarButton(str1: string)
    return module.build({ "chat", "chatConversation", "topBar", "button", str1 })
end

function module.chatConversationSystemMessageCard(arg1)
    local build = module.build
    local str1 = "chat"
    local str2 = "chatConversation"
    local str3 = "messageList"
    local str4 = "systemMessageCard"
    if type(arg1) == "table" then
        arg1 = table.concat(arg1, "_")
    end

    return build({ str1, str2, str3, str4, arg1 })
end

function module.chatConversationSystemMessage(str1: string)
    return module.build({ "chat", "chatConversation", "messageList", "systemMessageText", str1 })
end

function module.selectChatMembersUserCellWithCheckbox(str1: string, bool1: boolean)
    return module.build({
        "chat",
        "selectChatMembers",
        "friendsList",
        "userCellWithCheckbox",
        "checkbox",
        `{str1}_{if bool1 then "checked" else "unchecked"}`
    })
end

function module.selectChatMembersSearchInput(str1: string?)
    return module.build({ "chat", "selectChatMembers", "searchBar", "textInput", str1 })
end

function module.selectChatMembersTopBarActionButton(str1: string)
    return module.build({ "chat", "selectChatMembers", "topBar", "button", str1 })
end

return module
