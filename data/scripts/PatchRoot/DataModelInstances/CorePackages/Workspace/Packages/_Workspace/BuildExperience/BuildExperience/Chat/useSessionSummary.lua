-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local parseSessionStream = require(script.Parent.parseSessionStream)

local function useSessionSummary(arg1)
    local var1 = React.useCallback(function(arg2)
        return arg1.getMergedHistory(arg2)
    end, { arg1 })
    local var2 = SignalsReact.useSignalState(var1)
    return React.useMemo(function()
        local var3 = parseSessionStream(var2, { sessionId = arg1.getCasSessionId() })

        return {
            subagentTaskState = var3.subagentTaskState,
            hasPublishedTurn = var3.includesPublishTool
        }
    end, { var2, arg1 })
end

return useSessionSummary
