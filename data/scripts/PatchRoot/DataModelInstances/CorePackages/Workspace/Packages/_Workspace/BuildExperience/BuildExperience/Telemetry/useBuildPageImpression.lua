-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local function useBuildPageImpression(page: string, tbl1, bool1: boolean?)
    local universeId = if tbl1 == nil then nil else tbl1.universeId
    local placeId = if tbl1 == nil then nil else tbl1.placeId
    local sessionId = if tbl1 == nil then nil else tbl1.sessionId
    local bool2 = bool1 ~= false

    React.useEffect(function()
        if not bool2 then
            return
        end
        local tbl2 = {
            page = page,
            isInExperience = if game.GameId == 0 then "false" else "true"
        }
        sendBuildExperienceEvent(
            "PAGE_IMPRESSION",
            { universeId = universeId, placeId = placeId, conversationId = sessionId },
            tbl2
        )
    end, { page, universeId, bool2 })
end

return useBuildPageImpression
