-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSduiParent = script:FindFirstAncestor("GroupPeekSdui").Parent

local UrlBuilder = require(GroupPeekSduiParent.UrlBuilder).UrlBuilder
local Url = require(GroupPeekSduiParent.Http).Url

local urlBuilder = UrlBuilder.new(
    {
        base = Url.GROUPS_URL,
        path = "v1/groups/{groupId}/forms/{formId}/results",
        query = { cfVertical = "{cfVertical}" }
    }
)
local urlBuilder2 = UrlBuilder.new({ base = Url.GROUPS_URL, path = "v1/groups/{groupId}/forms/{formId}/responses" })

return {
    results = function(groupId: string, formId: string, cfVertical: string) -- name: getGroupCustomFormResultsUrl
        return urlBuilder({ groupId = groupId, formId = formId, cfVertical = cfVertical })
    end,
    responses = function(groupId: string, formId: string) -- name: getGroupCustomFormResponsesUrl
        return urlBuilder2({ groupId = groupId, formId = formId })
    end
}
