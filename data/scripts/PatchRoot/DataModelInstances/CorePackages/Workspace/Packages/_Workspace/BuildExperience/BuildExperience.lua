-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    AssistantBuild = require(script.Components.ChatSheet.AssistantBuild),
    BuildPage = require(script.BuildPage),
    BuildPillMenu = require(script.Components.BuildPillMenu.BuildPillMenu),
    BuildPillMenuPortalHost = require(script.Components.BuildPillMenu.BuildPillMenuPortalHost),
    BuildEventReceiver = require(script.BuildEventReceiver),
    GetBuildPillMenuPortalStore = require(script.Stores.GetBuildPillMenuPortalStore),
    GetAssistantBuildStore = require(script.Stores.GetAssistantBuildStore),
    GetAdsCampaignDeepLinkStore = require(script.Stores.GetAdsCampaignDeepLinkStore),
    requestAdsCampaign = require(script.utils.requestAdsCampaign),
    GetCreatorAgentResumeStore = require(script.Stores.GetCreatorAgentResumeStore),
    GetPlayButtonStore = require(script.Stores.GetPlayButtonStore),
    mountChatSheet = require(script.mountChatSheet),
    mountCreatorAgentResumeToastReceiver = require(script.mountCreatorAgentResumeToastReceiver),
    sendBuildExperienceEvent = require(script.Telemetry.sendBuildExperienceEvent),
    UnpublishedPlaytestModeTooltip = require(script.Components.UnpublishedPlaytestModeTooltip.UnpublishedPlaytestModeTooltip),
    ["jest.config"] = script["jest.config"]
}
