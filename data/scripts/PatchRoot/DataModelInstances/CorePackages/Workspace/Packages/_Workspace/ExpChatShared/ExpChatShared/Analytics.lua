-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local TelemetryService = game:GetService("TelemetryService")
local TextChatService = game:GetService("TextChatService")

local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Dictionary = require(ExpChatSharedParent.llama).Dictionary

local var1 = require(ExpChatShared.Logger):new("ExpChat/" .. script.Name)

local module = {}
local rbxAnalyticsService = RbxAnalyticsService

local function withDefaultArgs(arg1)
    return Dictionary.join(arg1, { gameId = tostring(game.GameId), placeId = tostring(game.PlaceId) })
end

local function setRbxEventStream(target: string, eventContext: string, eventName: string, arg1)
    if rbxAnalyticsService then
        var1:debug("Event: {}", eventName)
        rbxAnalyticsService:SetRBXEventStream(target, eventContext, eventName, withDefaultArgs(arg1 or {}))
    end
end

local function sendEventDeferred(target: string, eventContext: string, eventName: string, arg1)
    if rbxAnalyticsService then
        var1:debug("SendEventDeferred: {}", eventName)
        rbxAnalyticsService:SendEventDeferred(target, eventContext, eventName, withDefaultArgs(arg1 or {}))
    end
end

function module.with(arg1)
    rbxAnalyticsService = arg1 or RbxAnalyticsService
end

function module.FireRccAnalyticsWithEventName(eventName: string, arg1)
    setRbxEventStream("rcc", "experienceChat", eventName, arg1)
end

function module.FireClientAnalyticsWithEventName(eventName: string, arg1)
    setRbxEventStream("client", "experienceChat", eventName, arg1)
end

function module.reportHistoryReplayed(receivedCount: number, keptCount: number, latencyMs: number)
    module.FireClientAnalyticsWithEventName(
        "HistoryReplayed",
        { receivedCount = receivedCount, keptCount = keptCount, latencyMs = latencyMs }
    )
end

function module.reportCounter(counterName: string, num1: number?)
    if rbxAnalyticsService then
        var1:debug("Counter: {}", counterName)
        rbxAnalyticsService:ReportCounter(counterName, num1 or 1)
    end
end

module.ExpChatChatEnabledUserCountFetchConfig = {
    eventName = "ExpChatChatEnabledUserCountFetch",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2026, 7, 22 },
    description = "Counts successful and failed attempts to fetch the local chat-enabled system message user count.",
    links = ""
}

function module.reportChatEnabledUserCountFetchResult(bool1: boolean)
    TelemetryService:LogCounter(
        module.ExpChatChatEnabledUserCountFetchConfig,
        {
            customFields = {
                result = if bool1 then "success" else "failure"
            }
        },
        1
    )
end

function module.FireRccAnalyticsDeferred(eventName: string, arg1)
    sendEventDeferred("RCC", "experienceChat", eventName, arg1)
end

function module.TelemetryLogEvent(_, config, customFields, standardizedFields)
    TelemetryService:LogEvent(config, { customFields = customFields, standardizedFields = standardizedFields })
end

module.DefaultStandardizedFields = {
    "addOSInfo",
    "addSessionInfo",
    "addUniverseId",
    "addPlaceId"
}
function module.reportTextChatCommandClientSent(tbl1, textChatCommandName: string)
    TextChatService:SendTextChatCommandClientSent(textChatCommandName)
    tbl1.FireClientAnalyticsWithEventName("CommandSent", { commandName = textChatCommandName })
end

module.RewriteDropdownToggledConfig = {
    eventName = "RewriteDropdownToggled",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("ExpChatRewriteDropdownToggledThrottlePerMyriad", 10000),
    lastUpdated = { 26, 4, 21 },
    description = "When a user activates the AI rewrite dropdown toggle on a rewritten chat message.",
    links = ""
}

module.ExpChatGlobalChatTabClickedConfig = {
    eventName = "ExpChatGlobalChatTabClicked",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("ExpChatGlobalChatTabClickedThrottlePerMyriad", 0),
    lastUpdated = { 26, 5, 13 },
    description = "When a user selects the Global channel tab in the experience chat channel bar.",
    links = ""
}

module.ExpChatTabClickedConfig = {
    eventName = "ExpChatTabClicked",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("ExpChatTabClickedThrottlePerMyriad", 10000),
    lastUpdated = { 26, 8, 12 },
    description = "When a user clicks any tab in the experience chat channel bar.",
    links = "https://roblox.atlassian.net/wiki/spaces/SOCIAL/pages/4777640083/Friends+Chat+In+Exp+Tech+Spec#Experience-Chat-Tab-Events-Proposal"
}

module.ExpChatTabImpressionConfig = {
    eventName = "ExpChatTabImpression",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("ExpChatTabImpressionThrottlePerMyriad", 10000),
    lastUpdated = { 26, 7, 27 },
    description = "When an experience chat tab is rendered or a tracked field (index, overflow, visibility, badge count) changes.",
    links = "https://roblox.atlassian.net/wiki/spaces/SOCIAL/pages/4777640083/Friends+Chat+In+Exp+Tech+Spec#Experience-Chat-Tab-Events-Proposal"
}

module.ExpChatPresetActionConfig = {
    eventName = "ExpChatPresetAction",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("ExpChatPresetActionThrottlePerMyriad", 10000),
    lastUpdated = { 26, 6, 1 },
    description = "When a user interacts with the preset chat UI.",
    links = "https://roblox.atlassian.net/browse/EXPCHAT-1243"
}

return module
