-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MessageBusService = game:GetService("MessageBusService")
local NotificationService = game:GetService("NotificationService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local React = require(BuildExperienceParent.React)
local RealtimeDelivery = require(BuildExperienceParent.RealtimeDelivery)
local ToastNotification = require(BuildExperienceParent.ToastNotification)
local ToastNotificationsProtocol = require(BuildExperienceParent.ToastNotificationsProtocol)

local GetCreatorAgentResumeStore = require(BuildExperience.Stores.GetCreatorAgentResumeStore)
local GetPlayButtonStore = require(BuildExperience.Stores.GetPlayButtonStore)
local getCurrentExperienceProject = require(BuildExperience.utils.getCurrentExperienceProject)
local AdsCampaignNotification = require(BuildExperience.utils.AdsCampaignNotification)
local openDeepLink = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.openDeepLink)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildExperienceHomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceHomeTelemetry)
local FFlagBuildAdUpsell = require(BuildExperienceParent.SharedFlags).FFlagBuildAdUpsell

local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary
local FFlagConnectionRelaunchBuildPlaytest = require(BuildExperienceParent.SharedFlags).FFlagConnectionRelaunchBuildPlaytest
local PlaytestRejoin = if FFlagBuildExperienceLibrary or FFlagConnectionRelaunchBuildPlaytest then require(BuildExperienceParent.BuildExperiencePlaytestLaunch.PlaytestRejoin) else nil
local ResumeNotification = CreatorAgentChat.ResumeNotification
local LifecycleEvents = ToastNotification.LifecycleEvents
local default = ToastNotificationsProtocol.ToastNotificationProtocol.default
local ToastNotificationProtocolConstants = ToastNotificationsProtocol.ToastNotificationProtocolConstants

local function disconnect(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return
    end

    if typeof(arg1.Disconnect) == "function" then
        arg1:Disconnect()
    elseif typeof(arg1.disconnect) == "function" then
        arg1:disconnect()
    end
end

local function decodeActionParams(tbl1): {kind: any, sessionId: string, universeId: number}?
    local visualItem = if typeof(tbl1) == "table" then tbl1.visualItem else nil
    local actionEventParams = if typeof(visualItem) == "table" then visualItem.actionEventParams else nil

    if typeof(actionEventParams) ~= "string" or actionEventParams == "" then
        return nil
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, actionEventParams)
    if not success or typeof(result) ~= "table" then
        return nil
    end

    local sessionId = result.sessionId
    if typeof(sessionId) ~= "string" or sessionId == "" then
        return nil
    end

    local kind = result.kind
    if kind ~= "turn_end" and kind ~= "local_tool_call" then
        return nil
    end

    local universeId = result.universeId
    local tbl2 = { kind = kind, sessionId = sessionId, universeId = 0 }
    if typeof(universeId) ~= "number" then
        universeId = nil
    end

    tbl2.universeId = universeId
    return tbl2
end

local function publishToast(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    MessageBusService:Publish(
        ToastNotificationProtocolConstants.MESSAGE_DISPLAY_TOAST_NOTIF,
        ResumeNotification.buildToastNotification(tbl1)
    )
end

local function sendResumeNotificationClick(tbl1, bool1: boolean, destination: string, placeId: number?)
    local tbl2 = {
        type = "creator_agent_resume",
        kind = tbl1.kind,
        destination = destination,
        isInExperience = if bool1 then "true" else "false"
    }
    sendBuildExperienceEvent(
        "NOTIFICATION_CLICK",
        {
            universeId = tbl1.universeId,
            placeId = placeId,
            conversationId = tbl1.sessionId
        },
        tbl2
    )
end

local function routeToBuildChat(tbl1, bool1: boolean, bool2: boolean)
    if bool1 and bool2 then
        local currentExperienceProject = getCurrentExperienceProject()
        if tbl1.universeId ~= nil and currentExperienceProject.universeId == tbl1.universeId then
            if FFlagBuildExperienceHomeTelemetry then
                sendResumeNotificationClick(tbl1, bool1, "build_sheet", currentExperienceProject.placeId)
            end
            local playButtonStore = GetPlayButtonStore()
            playButtonStore.setResumeTarget(
                {
                    universeId = tbl1.universeId,
                    placeId = currentExperienceProject.placeId,
                    sessionId = tbl1.sessionId
                }
            )
            playButtonStore.setIsActive(true)
            return
        end
    end

    if FFlagBuildExperienceHomeTelemetry then
        sendResumeNotificationClick(tbl1, bool1, "deep_link", nil)
    end
    openDeepLink(ResumeNotification.getResumeDeepLink(tbl1), bool1)
end

local function BuildEventReceiver(tbl1)
    local creatorAgentResumeStore = GetCreatorAgentResumeStore()
    local var1 = React.useMemo(function()
        return tbl1.RobloxEventReceiver or RealtimeDelivery.RobloxEventReceiver.new(NotificationService)
    end, { tbl1.RobloxEventReceiver })

    local bool1 = tbl1.isInExperience == true
    local bool2 = tbl1.isBuildModeActive == true

    React.useEffect(function()
        if PlaytestRejoin ~= nil and not bool1 then
            return (PlaytestRejoin.listen())
        end

        return nil
    end, { bool1 })

    if FFlagBuildAdUpsell then
        React.useEffect(function()
            return AdsCampaignNotification.connect(LifecycleEvents, function(arg1)
                openDeepLink(arg1, bool1)
            end, function(arg1)
                default:dismissNotification(arg1)
            end)
        end, { bool1 })
    end

    React.useEffect(function()
        local var2 = var1:observeEvent(ResumeNotification.CapRtnNamespace, function(arg1)
            local var2 = ResumeNotification.classifyRtnDetail(arg1)
            if var2 == nil then
                return
            end

            local activeTarget = creatorAgentResumeStore.getActiveTarget(false)
            if ResumeNotification.targetMatchesNotification(activeTarget, var2) then
                return
            end

            publishToast(var2)
        end)

        return function()
            disconnect(var2)
        end
    end, { var1, creatorAgentResumeStore })

    React.useEffect(function()
        local var2 = LifecycleEvents:RegisterCallback(LifecycleEvents.ToastEvents.UserAction, ResumeNotification.NotificationType, function(arg1)
            if typeof(arg1) ~= "table"
                or arg1.userActionType ~= "click"
                or typeof(arg1.visualItem) ~= "table"
                or arg1.visualItem.eventName ~= ResumeNotification.ResumeEventName
                or typeof(arg1.notificationData) ~= "table"
            then
                return
            end

            local var2 = decodeActionParams(arg1)
            if var2 == nil then
                return
            end

            default:dismissNotification(arg1.notificationData.id)
            routeToBuildChat(var2, bool1, bool2)
        end)

        return function()
            var2()
        end
    end, { bool1, bool2 })

    return nil
end

return BuildEventReceiver
