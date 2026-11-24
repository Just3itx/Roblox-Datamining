-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local SharedFlags = require(DataHydrationParent.SharedFlags)
local types = require(script.types)

local requestBuildSuggestions = require(script.BuildSuggestions.requestBuildSuggestions)

local StudioAskUserTool = require(script.StudioAskUserTool)

local StudioProposePlanTool = require(script.StudioProposePlanTool)
local SubagentTasks = require(script.SubagentTasks)
local StudioClientLogsTool = require(script.StudioClientLogsTool)
local StudioClientDataModelTools = require(script.StudioClientDataModelTools)
local StudioManageDevProductTool = require(script.StudioManageDevProductTool)
local FFlagBuildExperienceManageGamePass = SharedFlags.FFlagBuildExperienceManageGamePass
local FFlagBuildExperienceManageSubscription = SharedFlags.FFlagBuildExperienceManageSubscription
local FFlagBuildExperienceManageMonetizationTool = SharedFlags.FFlagBuildExperienceManageMonetizationTool
local PreviewSpecs = require(script.PreviewSpecs)

return {
    FFlagBuildAgentAdCampaignCard = require(script.FFlagBuildAgentAdCampaignCard),
    FFlagBuildExperienceThoughtStatus = require(script.FFlagBuildExperienceThoughtStatus),
    getCreatorAgentChatStore = require(script.getCreatorAgentChatStore),
    createCreatorAgentChatStore = require(script.createCreatorAgentChatStore),
    createMockStore = require(script.createMockStore),
    TurnStateReducer = require(script.turnState),
    PublishToolUtils = require(script.publishToolUtils),
    ResumeNotification = require(script.ResumeNotification),
    StudioAskUserTool = StudioAskUserTool,
    StudioProposePlanTool = StudioProposePlanTool,
    SubagentTasks = SubagentTasks,
    SubagentTaskStatus = types.SubagentTaskStatus,
    SubagentTaskCategory = types.SubagentTaskCategory,
    RequestFailureKind = types.RequestFailureKind,
    StudioClientLogsTool = StudioClientLogsTool,
    StudioClientDataModelTools = StudioClientDataModelTools,
    StudioManageDevProductTool = StudioManageDevProductTool,
    StudioManageGamePassTool = if FFlagBuildExperienceManageGamePass then require(script.StudioManageGamePassTool) else nil,
    StudioManageSubscriptionTool = if FFlagBuildExperienceManageSubscription then require(script.StudioManageSubscriptionTool) else nil,
    StudioManageMonetizationTool = if FFlagBuildExperienceManageMonetizationTool then require(script.StudioManageMonetizationTool) else nil,
    ClientToolItems = require(script.ClientToolItems),
    decodeAdCampaignEligibilityResult = require(script.decodeAdCampaignEligibilityResult),
    classifyAdCampaignFailure = require(script.classifyAdCampaignFailure),
    requestBuildSuggestions = requestBuildSuggestions,
    debug = require(script.debug),
    experimentOverride = require(script.experimentOverride),
    chatOpenTelemetry = require(script.chatOpenTelemetry),
    captureSendConfiguration = require(script.sendConfiguration).capture,
    PreviewSpecs = PreviewSpecs,
    ErrorCodes = require(script.Acp.AcpProtocol).ErrorCodes,
    resolveCreatorAgentAcp = require(script.Env.resolveAcpUrl).resolveCreatorAgentAcp
}
