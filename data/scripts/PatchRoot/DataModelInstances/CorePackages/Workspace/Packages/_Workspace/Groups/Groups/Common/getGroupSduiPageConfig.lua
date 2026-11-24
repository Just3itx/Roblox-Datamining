-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local Http = require(GroupsParent.Http)

local function getGroupSduiPageConfig(str1: string, str2: string, arg1)
    local str3 = if str2 == "" then "unknown" else str2
    local groupId = if arg1 == nil then nil else tostring(arg1)

    if groupId and not string.match(groupId, "^[1-9]%d*$") then
        return nil
    end

    if str1 ~= "sidebarSection" or not groupId then
        return nil
    end

    return {
        surfaceKey = "GroupSidebarSection",
        configKey = `Groups-GroupSidebarSection-{str3}-{groupId}`,
        url = `{Http.Url.GROUPS_URL}v1/groups/{groupId}/pages/sidebar-section`,
        groupId = groupId
    }
end

return getGroupSduiPageConfig
