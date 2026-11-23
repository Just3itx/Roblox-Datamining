-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local _Signals = require(BuildExperienceParent.Signals)

return {
    PENDING_USER_MESSAGE_ID_SUFFIX = ":pending",
    getResourceAttachmentUri = function(tbl1)
        return if tbl1.type == "resource_link" then tbl1.uri else tbl1.resource.uri
    end,
    makeAssistantTurnAnchorKey = function(str1: string?, num1: number?)
        local str2 = str1 or "project"

        if num1 ~= nil then
            return `turn:{str2}:sequence:{num1}`
        end
        return nil
    end
}
