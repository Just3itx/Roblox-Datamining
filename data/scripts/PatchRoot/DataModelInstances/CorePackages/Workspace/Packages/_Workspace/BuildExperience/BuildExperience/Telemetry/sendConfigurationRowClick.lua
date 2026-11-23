-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local function sendConfigurationRowClick(context: string, tbl1, str1: string)
    local tbl2 = {
        item = str1,
        context = context,
        isInExperience = if game.GameId == 0 then "false" else "true"
    }
    sendBuildExperienceEvent(
        "CONFIGURATION_ROW_CLICK",
        {
            universeId = tbl1.universeId,
            placeId = tbl1.placeId,
            conversationId = tbl1.sessionId
        },
        tbl2
    )
end

return sendConfigurationRowClick
