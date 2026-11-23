-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local LocalUserIdStore = require(BuildExperienceParent.LocalUserIdStore).LocalUserIdStore
local FFlagBuildExperienceModelPicker = require(BuildExperience.Flags.FFlagBuildExperienceModelPicker)

local useSessionSummary = require(script.Parent.useSessionSummary)

local function isPublishLatest(bool1: boolean, bool2: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return bool1 or bool2
end

return {
    isPublishLatest = isPublishLatest,
    usePublishStatus = function(tbl1)
        local var1 = React.useMemo(function()
            return UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(tbl1.universeId)
        end, { tbl1.universeId })
        local var2 = SignalsReact.useSignalState(var1.data)
        local var3 = if FFlagBuildExperienceModelPicker then SignalsReact.useSignalState(LocalUserIdStore.getCurrentUserId) else nil

        local var4 = React.useMemo(function()
            return CreatorAgentChat.getCreatorAgentChatStore().getSessionForProject(tbl1.universeId, tbl1.placeId, tbl1.sessionId)
        end, {
            tbl1.universeId,
            tbl1.placeId,
            tbl1.sessionId,
            var3
        })

        local hasPublishedTurn = useSessionSummary(var4).hasPublishedTurn
        local isActive = not (var2 == nil) and var2.isActive
        return {
            hasPublishedTurn = hasPublishedTurn,
            hasPublishedVersion = isActive,
            isPublishLatest = isPublishLatest(isActive, hasPublishedTurn)
        }
    end
}
