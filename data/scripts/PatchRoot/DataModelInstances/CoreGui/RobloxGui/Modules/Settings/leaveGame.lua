-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local Players = game:GetService("Players")

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableGameLeftMessage = SharedFlags.FFlagEnableGameLeftMessage
local FFlagSurvBloxEventTypeEnabled = SharedFlags.FFlagSurvBloxEventTypeEnabled
local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")
local isExitModalRemoved = require(RobloxGui.Modules.Settings.Flags.isExitModalRemoved)

local var1 = require(CorePackages.Workspace.Packages.VoiceChatCore).Flags.GetFFlagVoiceVolumeControlsEnableVoiceVolumeImpressionsTelemetry()

local PerfUtils = require(RobloxGui.Modules.Common.PerfUtils)
local Cryo = require(CorePackages.Packages.Cryo)
local MessageBus = require(CorePackages.Workspace.Packages.MessageBus).MessageBus
local ExperienceService = require(CorePackages.Workspace.Packages.ExperienceService).ExperienceService
local SurveyEventPublisher = require(CorePackages.Workspace.Packages.OnPlatformSurveys.SurveyEventPublisher)
local WebViewEventType = require(CorePackages.Workspace.Packages.OnPlatformSurveys.WebViewEventType)
local var2 = require(script:FindFirstAncestor("Settings").Analytics.CoreGuiFinalStateAnalytics).new()

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")

local GetFFlagEnableInGameMenuDurationLogger = require(RobloxGui.Modules.Common.Flags.GetFFlagEnableInGameMenuDurationLogger)
local FFlagLeaveActionChromeShortcutTelemetry = require(RobloxGui.Modules.Chrome.Flags.FFlagLeaveActionChromeShortcutTelemetry)

local GetDefaultQualityLevel = require(CorePackages.Workspace.Packages.AppCommonLib).GetDefaultQualityLevel

local Constants = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))
local ReactSchedulingTracker = require(RobloxGui.Modules.Common.ReactSchedulingTracker)
local default = if var1 then require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default else nil

return function(bool1: boolean, tbl1)
    if FFlagEnableGameLeftMessage and not (tbl1 and tbl1.inhibitAppRating) then
        MessageBus.publish(Constants.OnAppRatingPromptEventDescriptor, { gameTime = game:getGameTime() })
    end

    if GetFFlagEnableInGameMenuDurationLogger() then
        PerfUtils.leavingGame()
    end
    ReactSchedulingTracker:reportSession()
    local var3 = require(CorePackages.Workspace.Packages.Memory).MemoryTracker()
    if var3 then
        var3:destroy()
    end

    GuiService.SelectedCoreObject = nil

    local playsessionid = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else ""

    local additionalArgs = {
        confirmed = Constants.AnalyticsConfirmedName,
        universeid = 0,
        source = 0,
        playsessionid = 0
    }
    local gameId = game.GameId
    additionalArgs.universeid = tostring(gameId)
    additionalArgs.source = Constants.AnalyticsLeaveGameSource
    additionalArgs.playsessionid = playsessionid

    if FFlagLeaveActionChromeShortcutTelemetry and tbl1 and tbl1.telemetryFields then
        additionalArgs = Cryo.Dictionary.join(additionalArgs, tbl1.telemetryFields)
    end
    RbxAnalyticsService:SetRBXEventStream(
        Constants.AnalyticsTargetName,
        if tbl1 and tbl1.telemetryContext then tbl1.telemetryContext else Constants.AnalyticsInGameMenuName,
        Constants.AnalyticsLeaveGameName,
        additionalArgs
    )

    if bool1 then
        if FFlagSurvBloxEventTypeEnabled then
            SurveyEventPublisher.publishSurveyEvent(WebViewEventType.LeaveButtonClick)
        else
            local customProps = {
                chromeSeenCount = tostring(0)
            }
            local userId = tostring(Players.LocalPlayer.UserId)
            MessageBus.publish(
                Constants.OnSurveyEventDescriptor,
                {
                    eventType = Constants.SurveyEventType,
                    userId = userId,
                    customProps = customProps
                }
            )
        end
    end
    var2:sendCoreGuiFinalAnalytic()
    if var1 then
        default:ReportVoiceVolumeImpressionsIfNeeded()
    end

    RunService.RenderStepped:wait()
    RunService.RenderStepped:wait()

    if tbl1 and tbl1.leaveReason then
        ExperienceService:LeaveExperienceWithReason(tbl1.leaveReason)
        settings().Rendering.QualityLevel = GetDefaultQualityLevel()
        return
    end

    if not (isExitModalRemoved and tbl1 and tbl1.shouldNativeExit) then
        game:Shutdown()
    end

    settings().Rendering.QualityLevel = GetDefaultQualityLevel()

    if isExitModalRemoved and tbl1 and tbl1.shouldNativeExit then
        local notificationTypeList = GuiService:GetNotificationTypeList()
        GuiService:BroadcastNotification("", notificationTypeList.NATIVE_EXIT)
    end
end
