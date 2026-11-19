-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ScriptContext = game:GetService("ScriptContext")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local Modules = RobloxGui:WaitForChild("Modules")

ScriptContext:AddCoreScriptLocal("CoreScripts/CoreScriptErrorReporter", RobloxGui)

local Roact = require(CorePackages.Packages.Roact)
local Scheduler = require(CorePackages.Packages.Scheduler)
local CachedPolicyService = require(CorePackages.Workspace.Packages.CachedPolicyService)

local FFlagUseRoactGlobalConfigInCoreScripts = require(RobloxGui.Modules.Flags.FFlagUseRoactGlobalConfigInCoreScripts)

local GetFFlagScreenshotHudApi = require(RobloxGui.Modules.Flags.GetFFlagScreenshotHudApi)

local GetFFlagEnableNewInviteMenuIXP = require(Modules.Flags.GetFFlagEnableNewInviteMenuIXP)
local NewInviteMenuExperimentManager = require(Modules.Settings.Pages.ShareGame.NewInviteMenuExperimentManager)
local GetFFlagEnableSoundSessionTelemetry = require(Modules.Flags.GetFFlagEnableSoundSessionTelemetry)

local GetFFlagReportAnythingAnnotationIXP = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagReportAnythingAnnotationIXP
local TrustAndSafetyIXPManager = require(CorePackages.Workspace.Packages.TrustAndSafetyIxp).TrustAndSafetyIXPManager

local GetCoreScriptsLayers = require(Modules.Experiment.GetCoreScriptsLayers)

local GetFFlagRtMessaging = require(RobloxGui.Modules.Flags.GetFFlagRtMessaging)
local bool1 = game:DefineFastFlag("AddPublishAssetPrompt6", false)
local bool2 = game:DefineFastFlag("EnablePromptAgeCheckListener", false)
local isCharacterNameHandlerEnabled = require(CorePackages.Workspace.Packages.SharedFlags).isCharacterNameHandlerEnabled

local GetFFlagEnableSocialContextToast = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableSocialContextToast

local GetFFlagEnableAppChatInExperience = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableAppChatInExperience

local GetFFlagChromeCentralizedConfiguration = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagChromeCentralizedConfiguration
local GetFFlagEnableCrossExpVoice = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableCrossExpVoice
local FStringReactSchedulingContext = require(CorePackages.Workspace.Packages.SharedFlags).FStringReactSchedulingContext

local FFlagFriendsCallingClientGate_DEV = require(CorePackages.Workspace.Packages.SharedFlags).FFlagFriendsCallingClientGate_DEV

local bool3 = game:DefineFastFlag("LuaAppEnableToastNotificationsCoreScripts4", false)

local bool4 = game:DefineFastFlag("DisableLuobuWarningToast", false)

local FFlagDebugDisableExperienceChatMain = require(RobloxGui.Modules.Flags.FFlagDebugDisableExperienceChatMain)

local GetFFlagVoiceUserAgency3 = require(RobloxGui.Modules.Flags.GetFFlagVoiceUserAgency3)

local bool5 = game:DefineFastFlag("EnableSendCameraAccessAnalytics", false)

local bool6 = game:DefineFastFlag("EnableExperienceNotificationPrompts2", false)
local engineFeature = game:GetEngineFeature("EnableCancelSubscriptionApp")
local bool7 = game:DefineFastFlag("EnableCancelSubscriptionAppLua", false)
local engineFeature2 = game:GetEngineFeature("AudioFocusManagement")

local bool8 = game:DefineFastFlag("EnableExperienceGenericChallengeRenderingOnLoadingScript", false)
local engineFeature3 = game:GetEngineFeature("EnableRobloxCommerce")
local bool9 = game:DefineFastFlag("EnableLinkSharingEvent", false)
local FFlagEnableShareSheet = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableShareSheet
local FFlagUseUIOverlayForCloudPlay = require(CorePackages.Workspace.Packages.SharedFlags).FFlagUseUIOverlayForCloudPlay
local engineFeature4 = game:GetEngineFeature("PlayerFeedbackEnabled")

local FFlagLuaAppInExperienceDetailsPrompt = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaAppInExperienceDetailsPrompt
local bool10 = game:DefineFastFlag("EnableSystemScrim", false)
local bool11 = game:DefineFastFlag("EnableCoreUISystemV2", false)
local FFlagEnableNewBackpack = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableNewBackpack
local bool12 = game:DefineFastFlag("EnableCorescriptsProfiler", false)
local bool13 = game:DefineFastFlag("CoreScriptsProfilerTelemetryContext", false)
local engineFeature5 = game:DefineFastFlag("SelfieFrontendConsoleDesktop3", false) and game:GetEngineFeature("EnableSelfieQRCode")

local GetEngineFeatureEnablePromptRobuxTransfer = require(CorePackages.Workspace.Packages.SharedFlags).GetEngineFeatureEnablePromptRobuxTransfer
local UIBlox = require(CorePackages.Packages.UIBlox)
local UIBloxInGameConfig = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).UIBloxInGameConfig
UIBlox.init(UIBloxInGameConfig)

if bool11 then
    require(CorePackages.Workspace.Packages.System)
end

local FFlagTopBarRefactor = require(CorePackages.Workspace.Packages.InExperienceTopBar).Flags.FFlagTopBarRefactor

require(CorePackages.Workspace.Packages.ExperimentCacheManager).ExperimentCacheManager.default:initialize()

if game:DefineFastFlag("LuaAppUseAppHttpStoreInExperience", false) then
    require(CorePackages.Workspace.Packages.HttpStore).Instance._create({})
end

local var1 = require(CorePackages.Workspace.Packages.SharedFlags).GetReactSchedulerIXPConfig()
if var1 then
    Scheduler.unstable_setSchedulerFlags(var1)
end

if require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableSchedulerFlagOverrides then
    local var2 = require(CorePackages.Workspace.Packages.SharedFlags).GetSchedulerFlagOverrides.getInExp()
    if var2 then
        Scheduler.unstable_setSchedulerFlags(var2)
    end
end

local FFlagEnableAEGIS2CommsFAEUpsell = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableAEGIS2CommsFAEUpsell

if require(CorePackages.Workspace.Packages.SharedFlags).FFlagInitializeSduiForInExperience then
    require(Modules.ServerDrivenUi.initializeSduiForInExperience)()
end

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local var2 = require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.teamCreateUtils).isViewer()
if var2 then
    require(CorePackages.Workspace.Packages.BuildExperience.mountTeamCreateViewer)(game.PlaceId, UserInputService)
end

if game:GetEngineFeature("SoundServiceControlsDefaultListenerLocation") then
    ScriptContext:AddCoreScriptLocal("CoreScripts/DefaultListenerLocation", script.Parent)
end

if GetFFlagEnableAppChatInExperience() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/AppChatMain", RobloxGui)
end

if FFlagFriendsCallingClientGate_DEV then
    ScriptContext:AddCoreScriptLocal("CoreScripts/FriendsCallingMain", RobloxGui)
end

if GetFFlagEnableCrossExpVoice() then
    require(CorePackages.Workspace.Packages.CrossExperienceVoice).IXPManager.default:initialize()
end

local _InExperienceSessionization = require(CorePackages.Workspace.Packages.InExperienceSessionization)

if require(CorePackages.Workspace.Packages.Chrome).Enabled() then
    local expChat = require(CorePackages.Workspace.Packages.ExpChat)
    expChat.GlobalFlags.AvatarChatEnabled = false
    expChat.GlobalFlags.ChromeEnabled = true
end

if require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagJoinWithoutMicPermissions() then
    require(CorePackages.Workspace.Packages.ExpChat).GlobalFlags.JoinWithoutMicPermissions = true
end

local bool14 = game:DefineFastFlag("InExperienceInterventionApp", false)

local FFlagLuaAppEnableInExperienceDataModelStreamStarter = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaAppEnableInExperienceDataModelStreamStarter

if FFlagUseRoactGlobalConfigInCoreScripts and RunService:IsStudio() then
    Roact.setGlobalConfig({ propValidation = true, elementTracing = true })
end

local UIBlox2 = require(CorePackages.Packages.InGameMenuDependencies).UIBlox
if UIBlox2 ~= UIBlox then
    UIBlox2.init(UIBloxInGameConfig)
end

local Sounds = Instance.new("Folder")
Sounds.Name = "Sounds"
Sounds.Parent = RobloxGui

local function safeRequire(arg1) -- Luacid: Inlined by compiler; 15 call sites recovered
    local success, result = pcall(require, arg1)
    if success then
        return result
    end
    warn("Failure to Start CoreScript module " .. arg1.Name .. ".\n" .. result)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/NotificationScript2", RobloxGui)

if FFlagLuaAppEnableInExperienceDataModelStreamStarter then
    ScriptContext:AddCoreScriptLocal("CoreScripts/InExperienceDataModelStreamStarter", script.Parent)
end

if game:GetEngineFeature("ProtocolLaunchPrivateChannelUpdateCheckEngineFeature") then
    local var3 = safeRequire(Modules.ChannelUpdatePrompt)
    if var3 then
        var3.init()
    end
end

if not var2 and GetFFlagChromeCentralizedConfiguration() then
    coroutine.wrap(safeRequire)(Modules.Chrome.ConfigureChrome)
end

coroutine.wrap(safeRequire)(Modules.SelfieView)

if not var2 then
    coroutine.wrap(safeRequire)(Modules.TopBar)
end

if FFlagUseUIOverlayForCloudPlay and not var2 then
    local var3 = coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.InExperienceCloudPlay)
    if var3 then
        var3.mountCloudPlayUIOverlay()
    end
end

local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
if not var2 and isSideSheetEnabled then
    coroutine.wrap(safeRequire)(Modules.InExperienceSideSheet)
end

if require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableWhatsNew then
    coroutine.wrap(safeRequire)(Modules.InGameWhatsNew)
end

if require(CorePackages.Workspace.Packages.SharedFlags).FFlagAppNavMyStatsTab then
    local var3 = coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.BuildModeLaunch)
    local var4 = coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.BuildExperience)
    local var5 = var4 and var3 and var3:hasBuildMode()
    if var4 then
        var4.mountCreatorAgentResumeToastReceiver(var5 == true)
    end
    if var4 and var5 and not var2 then
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

        local fFlagBuildExperienceInGameCaptureToChat = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBuildExperienceInGameCaptureToChat
        var4.mountChatSheet(fFlagBuildExperienceInGameCaptureToChat and {
            takeCapture = function(arg1)
                require(RobloxGui.Modules.Captures.CapturesApp).takeCapture(arg1)
            end
        } or nil)
    end
end

if FFlagTopBarRefactor then
    local var3 = coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.InExperienceOverlay)
    if var3 then
        var3.createOverlay()
    end
end

if game:GetEngineFeature("LuobuModerationStatus") then
    coroutine.wrap(function()
        safeRequire(Modules.Watermark)
    end)()
end

if bool14 then
    coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.InExperienceIntervention)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/MainBotChatScript2", RobloxGui)

if game:GetEngineFeature("ProximityPrompts") then
    ScriptContext:AddCoreScriptLocal("CoreScripts/ProximityPrompt", RobloxGui)
end

if game:GetEngineFeature("ValidateUGCBodyAPIFeature") then
    require(Modules.Server.UGCValidation.UGCValidationFunctionInstaller)()
end

coroutine.wrap(function()
    ScriptContext:AddCoreScriptLocal("CoreScripts/ScreenTimeInGame", RobloxGui)
end)()

if not bool4 then
    coroutine.wrap(function()
        if not CachedPolicyService:IsSubjectToChinaPolicies() then
            return
        end

        if not game:IsLoaded() then
            game.Loaded:Wait()
        end

        safeRequire(Modules.LuobuWarningToast)
    end)()
end

ScriptContext:AddCoreScriptLocal("CoreScripts/PerformanceStatsManagerScript", RobloxGui)

ScriptContext:AddCoreScriptLocal("CoreScripts/PlayerRagdoll", RobloxGui)

coroutine.wrap(safeRequire)(RobloxGui.Modules.ChatSelector)
coroutine.wrap(safeRequire)(RobloxGui.Modules.PlayerList.PlayerListManager)

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserRoactBubbleChatBeta")
end)
if game:GetEngineFeature("EnableBubbleChatFromChatService") or success and result then
    ScriptContext:AddCoreScriptLocal("CoreScripts/PlayerBillboards", RobloxGui)
end

coroutine.wrap(function()
    local var3 = safeRequire(CorePackages.Workspace.Packages.PurchasePrompt)

    if var3 then
        var3.mountPurchasePrompt()
    end
end)()

if bool1 then
    coroutine.wrap(safeRequire)(Modules.PublishAssetPrompt)
end

coroutine.wrap(safeRequire)(Modules.ExperienceEvents.ExperienceEventsApp)

if engineFeature4 then
    coroutine.wrap(safeRequire)(Modules.PlayerFeedback)
end

coroutine.wrap(safeRequire)(Modules.Groups.GroupsApp)

coroutine.wrap(safeRequire)(Modules.AvatarGeneration.SelfieConsent)

if engineFeature5 then
    coroutine.wrap(safeRequire)(Modules.AvatarGeneration.SelfieQr)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/BlockPlayerPrompt", RobloxGui)
ScriptContext:AddCoreScriptLocal("CoreScripts/FriendPlayerPrompt", RobloxGui)

if bool2 then
    local var3 = safeRequire(Modules.PromptAgeCheckHandler)
    if var3 then
        var3.init()
    end
end

ScriptContext:AddCoreScriptLocal("CoreScripts/AvatarContextMenu", RobloxGui)

if FFlagEnableNewBackpack then
    require(CorePackages.Workspace.Packages.Backpack)
else
    coroutine.wrap(safeRequire)(RobloxGui.Modules.BackpackScript)
end

coroutine.wrap(safeRequire)(RobloxGui.Modules.KeyboardUINavigation)

coroutine.wrap(safeRequire)(RobloxGui.Modules.EmotesMenu.EmotesMenuMaster)

coroutine.wrap(safeRequire)(RobloxGui.Modules.Captures.CapturesApp)

coroutine.wrap(safeRequire)(Modules.AvatarEditorPrompts)

if require(CorePackages.Workspace.Packages.SharedFlags).FFlagVirtualCursorModularization then
    coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.VirtualCursorModular)
else
    coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.VirtualCursor)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/VehicleHud", RobloxGui)
ScriptContext:AddCoreScriptLocal("CoreScripts/InviteToGamePrompt", RobloxGui)

if if game:GetEngineFeature("TouchScreenEnabled") then UserInputService.TouchScreenEnabled else UserInputService.TouchEnabled then
    ScriptContext:AddCoreScriptLocal("CoreScripts/ContextActionTouch", RobloxGui)

    RobloxGui:WaitForChild("ControlFrame")
    RobloxGui.ControlFrame:WaitForChild("BottomLeftControl")
    RobloxGui.ControlFrame.BottomLeftControl.Visible = false
end

ScriptContext:AddCoreScriptLocal("CoreScripts/InspectAndBuy", RobloxGui)

coroutine.wrap(function()
    if not VRService.VREnabled then
        VRService:GetPropertyChangedSignal("VREnabled"):Wait()
    end

    safeRequire(RobloxGui.Modules.VR.VRAvatarHeightScaling)
    safeRequire(RobloxGui.Modules.VR.VirtualKeyboard)
    safeRequire(RobloxGui.Modules.VR.UserGui)
end)()

coroutine.wrap(safeRequire)(RobloxGui.Modules.VR.VRAvatarGestures.VRAvatarGesturesClient)

ScriptContext:AddCoreScriptLocal("CoreScripts/NetworkPause", RobloxGui)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

if game:GetEngineFeature("GameplayPopOverlay")
    and (SharedFlags.FFlagEnableGameplayPopLatencyOverlay or SharedFlags.FFlagEnableGameplayPopLatencyOverlayForAdmins)
then
    ScriptContext:AddCoreScriptLocal("CoreScripts/GameplayPopOverlay", RobloxGui)
end

if GetFFlagScreenshotHudApi() and not CachedPolicyService:IsSubjectToChinaPolicies() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/ScreenshotHud", RobloxGui)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/MicrophoneDevicePermissionsLoggingInitializer", RobloxGui)

if game:GetEngineFeature("VoiceChatSupported") then
    ScriptContext:AddCoreScriptLocal("CoreScripts/VoiceDefaultChannel", RobloxGui)
end
coroutine.wrap(function()
    require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper:InitializeAsync(
        LocalPlayer.UserId,
        GetCoreScriptsLayers()
    )
    if GetFFlagEnableNewInviteMenuIXP() then
        NewInviteMenuExperimentManager.default:initialize()
    end

    if GetFFlagReportAnythingAnnotationIXP() then
        TrustAndSafetyIXPManager.default:initialize()
    end
end)()

if not FFlagDebugDisableExperienceChatMain then
    ScriptContext:AddCoreScriptLocal("CoreScripts/ExperienceChatMain", RobloxGui)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/ChatEmoteUsage", script.Parent)

if bool3 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/ToastNotificationGUI", script.Parent)
end

if GetFFlagRtMessaging() then
    game:GetService("RtMessagingService")
end

if game:GetEngineFeature("FacialAnimationStreaming2") then
    ScriptContext:AddCoreScriptLocal("CoreScripts/FacialAnimationStreaming", script.Parent)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/AvatarMood", script.Parent)

ScriptContext:AddCoreScriptLocal("CoreScripts/PortalTeleportGUI", RobloxGui)

coroutine.wrap(function()
    local var3 = safeRequire(CorePackages.Workspace.Packages.AdsEudsa)

    if var3 and var3.starterScript then
        var3.starterScript()
    end
end)()

if game:GetEngineFeature("EnableAdGuiInteractivityControlRefactor") then
    coroutine.wrap(function()
        local var3 = safeRequire(CorePackages.Workspace.Packages.AdGuiInteractivity)

        if var3 and var3.starterScript then
            var3.starterScript()
        end
    end)()
end
coroutine.wrap(function()
    local var3 = safeRequire(CorePackages.Workspace.Packages.EnhancedVideo)

    if var3 and var3.starterScript then
        var3.starterScript()
    end
end)()

coroutine.wrap(function()
    local var3 = safeRequire(CorePackages.Workspace.Packages.InExperienceClickout)

    if var3 and var3.starterScript then
        var3.starterScript()
    end
end)()

if game:GetEngineFeature("EnableLuaAdPlayer") then
    safeRequire(CorePackages.Workspace.Packages.AdPlayer).init()
end

if game:GetEngineFeature("EnableVoiceAttention") then
    ScriptContext:AddCoreScriptLocal("CoreScripts/VoiceAttention", script.Parent)
end

if GetFFlagEnableSoundSessionTelemetry() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/SoundTelemetry", script.Parent)
end

coroutine.wrap(safeRequire)(Modules.ApolloClient)

if isCharacterNameHandlerEnabled() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/CharacterNameHandler", script.Parent)
end

if GetFFlagVoiceUserAgency3() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/VoiceUserAgency", RobloxGui)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/CoreScriptsGlobalEffects", script.Parent)

require(CorePackages.Workspace.Packages.SoundManager).SoundManager.init()

if GetFFlagEnableSocialContextToast() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/SocialContextToast", RobloxGui)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/GameInviteModalGUI", script.Parent)

if bool6 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/ExperienceNotifications", script.Parent)
end

require(CorePackages.Workspace.Packages.Achievements).InExpAchievementManager.new():startUp()

if require(RobloxGui.Modules.Common.Flags.GetFFlagPlayerViewRemoteEnabled)() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/PlayerView", RobloxGui)
end

if bool5 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/SendCameraAccessAnalytics", RobloxGui)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/BulkPurchaseApp", RobloxGui)

if GetEngineFeatureEnablePromptRobuxTransfer() then
    ScriptContext:AddCoreScriptLocal("CoreScripts/InExperienceTransferApp", RobloxGui)
end

if engineFeature2 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/ExperienceAudioFocusBinder", RobloxGui)
end

if engineFeature and bool7 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/CancelSubscriptionApp", RobloxGui)
end

if engineFeature3 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/CommercePurchaseApp", RobloxGui)
end

if bool10 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/SystemScrim", RobloxGui)
end

ScriptContext:AddCoreScriptLocal("CoreScripts/CoreGuiEnableAnalytics", RobloxGui)

if bool9 then
    ScriptContext:AddCoreScriptLocal("CoreScripts/OpenShareSheetWithLink", RobloxGui)
end

if FFlagEnableShareSheet then
    ScriptContext:AddCoreScriptLocal("CoreScripts/UniversalShareSheetScreenGui", RobloxGui)
end

if FFlagLuaAppInExperienceDetailsPrompt then
    ScriptContext:AddCoreScriptLocal("CoreScripts/InExperienceDetailsPrompt", RobloxGui)
end

if not bool8 then
    coroutine.wrap(function()
        require(CorePackages.Workspace.Packages.GenericChallenges).Middleware.InitExperienceChallengeInterceptor()
    end)()
end

local ReactPerfTracker = require(Modules.Common.ReactPerfTracker)
if ReactPerfTracker then
    local reactPerfTracker = ReactPerfTracker.new()

    task.delay(5, function()
        reactPerfTracker:start()
    end)
end

local num1 = game:DefineFastInt("ReactSchedulingTrackerStartUpDelayMs", 5000) / 1000

local ReactSchedulingTracker = require(Modules.Common.ReactSchedulingTracker)

task.delay(num1, function()
    ReactSchedulingTracker:start()
end)

local Memory = require(CorePackages.Workspace.Packages.Memory)
Memory.start(true, FStringReactSchedulingContext, Memory.MemoryScope.InExperience)

if game:GetEngineFeature("RecordingServicePlaybackApiLua") then
    coroutine.wrap(safeRequire)(CorePackages.Workspace.Packages.ExperienceStateReplay)
end

if FFlagEnableAEGIS2CommsFAEUpsell then
    coroutine.wrap(function()
        local var3 = safeRequire(CorePackages.Workspace.Packages.SocialUpsell)

        if var3 then
            var3.Overlay.initializeInExpOverlay()
        end
    end)()
end
coroutine.wrap(function()
    local var3 = safeRequire(CorePackages.Workspace.Packages.Display)
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function()
        var3.GetDisplayStore().setTopBarHeight(GuiService.TopbarInset.Height)
    end)
end)()

if not bool12 then
    return
end
local coreScriptsProfilerTelemetry = require(CorePackages.Workspace.Packages.CoreScriptsProfiler).CoreScriptsProfilerTelemetry

if not coreScriptsProfilerTelemetry then
    return
end

if not bool13 then
    FStringReactSchedulingContext = nil
end

coreScriptsProfilerTelemetry(FStringReactSchedulingContext):start()
