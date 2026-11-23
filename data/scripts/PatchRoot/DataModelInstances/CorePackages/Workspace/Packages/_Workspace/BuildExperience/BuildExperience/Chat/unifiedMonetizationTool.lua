-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local SharedFlags = require(BuildExperienceParent.SharedFlags)
local FFlagBuildExperienceManageDevProduct = require(BuildExperience.Flags.FFlagBuildExperienceManageDevProduct)

local isEnabled = SharedFlags.FFlagBuildExperienceManageMonetizationTool and FFlagBuildExperienceManageDevProduct

local tbl1 = {}
local toolsByKind = ({})
local localToolDefinition

if isEnabled then
    local studioManageMonetizationTool = CreatorAgentChat.StudioManageMonetizationTool
    local tbl3 = {
        developerProduct = true,
        gamePass = SharedFlags.FFlagBuildExperienceManageGamePass,
        subscription = SharedFlags.FFlagBuildExperienceManageSubscription
    }
    for _, value in studioManageMonetizationTool.KINDS do
        if tbl3[value] then
            table.insert(tbl1, value)
            toolsByKind[value] = studioManageMonetizationTool.forKind(value, tbl3)
        end
    end
    localToolDefinition = studioManageMonetizationTool.createLocalToolDefinition(tbl1)
else
    localToolDefinition = nil
end

return {
    isEnabled = isEnabled,
    toolsByKind = toolsByKind,
    localToolDefinition = localToolDefinition
}
