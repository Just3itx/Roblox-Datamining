-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatNetworkingParent = script:FindFirstAncestor("AppChatNetworking").Parent
local Http = require(AppChatNetworkingParent.Http)

local tbl1 = {
    ABUSE_TYPE_PROFANITY = "ABUSE_CATEGORY_SWEARING",
    ABUSE_TYPE_PRIVACY_ASKING_FOR_PII = "ABUSE_CATEGORY_PERSONAL_QUESTION",
    ABUSE_TYPE_HARASSMENT = "ABUSE_CATEGORY_BULLYING",
    ABUSE_TYPE_DATING_AND_ROMANTIC_CONTENT = "ABUSE_CATEGORY_DATING",
    ABUSE_TYPE_CHEAT_AND_EXPLOITS = "ABUSE_CATEGORY_CHEATING",
    ABUSE_TYPE_SCAMMING = "ABUSE_CATEGORY_SCAMMING",
    ABUSE_TYPE_SEXUAL_CONTENT = "ABUSE_CATEGORY_INAPT_CONTENT",
    ABUSE_TYPE_REAL_LIFE_THREATS = "ABUSE_CATEGORY_REAL_LIFE_THREATS_AND_SUICIDE_THREATS",
    ABUSE_TYPE_OTHER = "ABUSE_CATEGORY_OTHER"
}

return require(script.Parent.RoduxNetworking).POST(script.Name, function(arg1, tbl2)
    local var1 = arg1(Http.Url.APIS_URL):path("abuse-reporting"):path("v1"):path("abuse-report")
    local tbl3 = {
        abuseVector = "web_chat",
        category = tbl1[tbl2.reportCategory] or "ABUSE_CATEGORY_OTHER",
        comment = if string.len(tbl2.comment) > 0 then tbl2.comment else " ",
        custom = {
            COMMUNICATION_CHANNEL_ID = tbl2.conversationId
        },
        submitterId = tbl2.submitterUserId,
        targetIdStr = tbl2.reportedUserId,
        targetType = "user"
    }
    return var1:body(tbl3)
end)
