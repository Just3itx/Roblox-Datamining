-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:31:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local Http = require(GroupsParent.Http)
local var1 = require(GroupsParent.UrlBuilder).UrlBuilder.new(
    {
        base = Http.Url.GROUPS_URL,
        path = "v1/groups/{groupId}/pages/overview"
    }
)

local function getGroupOverviewPaneConfig(str1: string, arg1)
    local groupId = if arg1 == nil then nil else tostring(arg1)

    if groupId == nil or string.match(groupId, "^[1-9]%d*$") == nil then
        return nil
    end

    return {
        surfaceKey = "OverviewPane",
        configKey = `Groups-OverviewPane-{if str1 == "" then "unknown" else str1}-{groupId}`,
        url = var1({ groupId = groupId }),
        groupId = groupId
    }
end

return getGroupOverviewPaneConfig
