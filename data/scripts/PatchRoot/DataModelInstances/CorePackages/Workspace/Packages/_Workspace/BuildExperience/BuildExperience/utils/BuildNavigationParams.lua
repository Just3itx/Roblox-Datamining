-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local _chatTypes = require(BuildExperience.Chat.chatTypes)

return {
    BUILD_CHAT_SCREEN = "BuildChat",
    getTarget = function(arg1)
        return (arg1.getParam("target"))
    end,
    getSubagentTaskState = function(arg1)
        return (arg1.getParam("subagentTaskState"))
    end,
    getSubagentTaskGroupName = function(arg1)
        return (arg1.getParam("subagentTaskGroupName"))
    end,
    getInitialPrompt = function(arg1)
        return (arg1.getParam("initialPrompt"))
    end,
    getShouldDismissOnBack = function(arg1): boolean
        return arg1.getParam("dismissOnBack") == true
    end
}
