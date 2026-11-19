-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local TeleportService = game:GetService("TeleportService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local LocalizationService = game:GetService("LocalizationService")
local VRService = game:GetService("VRService")
local CorePackages = game:GetService("CorePackages")
local TelemetryService = game:GetService("TelemetryService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local bool1 = game:DefineFastFlag("ConnectionRemoveLoadingTimeout", false)

CorePackages:WaitForChild("Workspace"):WaitForChild("Packages", bool1 and math.huge or nil)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local ErrorPrompt = require(RobloxGui.Modules.ErrorPrompt)
local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local Logging = require(CorePackages.Workspace.Packages.AppCommonLib).Logging
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
local mutedError = require(CorePackages.Workspace.Packages.Loggers).mutedError
local LinkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol).LinkingProtocol

local bool2 = game:DefineFastFlag("DebugEnableErrorStringTesting", false)
local bool3 = game:DefineFastFlag("ShouldMuteUnlocalizedError", false)

local bool4 = game:DefineFastFlag("ShowScreentimeLockoutKickMessage", false)

local config = {
    eventName = "ConnectionEvent",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 2025, 7, 31 },
    description = "Counter to track connection events.",
    links = "https://roblox.atlassian.net/browse/CSC-585"
}

local num1 = game:DefineFastInt("PotentialClientTimeoutSeconds", 7200)

local num2 = game:DefineFastInt("MaxKickMessageLength", 200)

local bool5 = game:DefineFastFlag("RefactorReconnectUnblockTeleport", false)

local bool6 = game:DefineFastFlag("ConnectionEnableAutoReconnect", false)

local num3 = game:DefineFastInt("ConnectionAutoReconnectFirstDelayMs", 2000)
local num4 = game:DefineFastInt("ConnectionAutoReconnectBaseDelayMs", 5000)
local num5 = game:DefineFastInt("ConnectionAutoReconnectMaxDelayMs", 20000)
local num6 = game:DefineFastInt("ConnectionAutoReconnectJitterMs", 2000)
local num7 = game:DefineFastInt("ConnectionAutoReconnectMaxDurationSeconds", 300)

local bool7 = game:DefineFastFlag("RbxTransportHandleUniqueErrors", false)
local engineFeature = game:GetEngineFeature("RbxTransportUniqueConnectionErrors")

local var1 = if bool6 then Random.new() else nil

local engineFeature2 = game:GetEngineFeature("CoreGuiOverflowDetection")

local FFlagCoreScriptShowTeleportPrompt = require(RobloxGui.Modules.Flags.FFlagCoreScriptShowTeleportPrompt)

local FFlagAllowDisconnectGuiForOkUnknown = require(RobloxGui.Modules.Flags.FFlagAllowDisconnectGuiForOkUnknown)

local bool8 = game:DefineFastFlag("EnableExperienceGenericChallengeRenderingConnection2", false)

local GetFFlagDisplayChannelNameOnErrorPrompt = require(RobloxGui.Modules.Flags.GetFFlagDisplayChannelNameOnErrorPrompt)

local function safeGetFInt(arg1, arg2) -- Luacid: unused: defined but never referenced
    local success, result = pcall(function(): number?
        return tonumber(settings():GetFVariable(arg1))
    end)
    if success then
        arg2 = result or arg2
    end

    return arg2
end

local function safeGetFString(str1: string, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return settings():GetFVariable(str1)
    end)
    if success then
        arg1 = result or arg1
    end

    return arg1
end

local function computeAutoReconnectDelaySeconds(attempt) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = if attempt <= 1 then num3 elseif attempt == 2 then num4 else math.min(num4 * 2 ^ (attempt - 2), num5)

    if num6 > 0 then
        var2 += var1:NextInteger(0, num6)
    end

    return var2 / 1000
end

local str1 = "DefaultTimeoutTimeMs"

local success, result = pcall(function(): number?
    return tonumber(settings():GetFVariable(str1))
end)
local var2 = (success and result or 10000) / 1000

local fFlag = settings():GetFFlag("ReconnectDisabled")
local var3 = safeGetFString("ReconnectDisabledReason", "We're sorry, Roblox is temporarily unavailable.  Please try again later.")

local var4 = tick()

local bool9 = game:DefineFastFlag("AddPlacelaunchDeviceBlock2", false)
local bool10 = game:DefineFastFlag("AddContextualPlayabilityConnectionErrors", false)
local bool11 = game:DefineFastFlag("AddVipOwnerNotPresentConnectionError", false)
local bool12 = game:DefineFastFlag("VipOwnerNotPresentEnableReconnect", false)

local bool13 = game:DefineFastFlag("RAKickLogic2", false)
local num8 = game:DefineFastInt("RAMinEngineVersion", 725)

local bool14 = false
if bool13 then
    local robloxVersion = RunService:GetRobloxVersion()
    local var5 = tonumber(string.match(robloxVersion, "%.(%d+)%."))
    if var5 and num8 <= var5 then
        bool14 = true
    end
end

local FFlagConnectionAmpParentalApprovalUpsell = require(CorePackages.Workspace.Packages.SharedFlags).FFlagConnectionAmpParentalApprovalUpsell

local FFlagConnectionParentalApprovalLeaveOnly = require(CorePackages.Workspace.Packages.SharedFlags).FFlagConnectionParentalApprovalLeaveOnly

local FFlagConnectionUpsellAnalytics = require(CorePackages.Workspace.Packages.SharedFlags).FFlagConnectionUpsellAnalytics
local isPioneerLaunch = require(CorePackages.Workspace.Packages.PioneerUtils).isPioneerLaunch

local var5 = require(CorePackages.Workspace.Packages.SharedFlags).FFlagErrorPromptUseLeaveGameHelper or isPioneerLaunch()

local leaveGame = if var5 then require(RobloxGui.Modules.Settings.leaveGame) else nil

local FFlagConnectionRelaunchBuildPlaytest = require(CorePackages.Workspace.Packages.SharedFlags).FFlagConnectionRelaunchBuildPlaytest

local playtestReconnect = if FFlagConnectionRelaunchBuildPlaytest then require(CorePackages.Workspace.Packages.BuildExperiencePlaytestLaunch.playtestReconnect) else nil

local bool15 = game:DefineFastFlag("AddCollaborationCoreGatedConnectionError2", false)

local engineFeature3 = game:GetEngineFeature("PlacelaunchCollaborationCoreGatedConnectionError")

local ConnectionAmpUpsellOnLeave = require(RobloxGui.Modules.ConnectionAmpUpsellOnLeave)

local buildRobloxExperienceKickContent = require(CorePackages.Workspace.Packages.InterventionShared.buildRobloxExperienceKickContent)
local showFeatureRestrictionDirect = require(CorePackages.Workspace.Packages.UniversalFeatureRestrictions.showFeatureRestrictionDirect)

local function fetchUniverseIdFromPlaceId(placeId: number)
    local success2, result2 = pcall(
        HttpRbxApiService.GetAsyncFullUrl,
        HttpRbxApiService,
        string.format("%suniverses/v1/places/%d/universe", Url.APIS_URL, placeId)
    )

    if not success2 or type(result2) ~= "string" then
        return nil
    end
    local success3, result3 = pcall(HttpService.JSONDecode, HttpService, result2)
    if not success3 or type(result3) ~= "table" then
        return nil
    end
    local universeId = result3.universeId
    return if type(universeId) == "number" and not (universeId <= 0) then universeId else nil
end

local function translateString(str2: string, tbl1)
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    local localization = Localization.new(robloxLocaleId)
    localization:SetLocale(robloxLocaleId)

    local success2, result2 = pcall(function()
        return localization:Format(str2, tbl1)
    end)
    if success2 then
        return result2
    end
    Logging.warn("Failed to translate string with key: " .. str2 .. ", LocaleId: " .. robloxLocaleId)
    return ""
end

local var6 = nil
local num9 = -1
local AbsoluteSizeX = RobloxGui.AbsoluteSize.X
local AbsoluteSizeY = RobloxGui.AbsoluteSize.Y

local tbl1 = {
    NONE = 1,
    RECONNECT_PLACELAUNCH = 2,
    RECONNECT_DISCONNECT = 3,
    TELEPORT_FAILED = 4,
    IS_RECONNECTING = 5,
    RECONNECT_DISABLED_DISCONNECT = 6,
    RECONNECT_DISABLED_PLACELAUNCH = 7,
    RECONNECT_DISABLED = 8,
    OUT_OF_MEMORY_KEEPPLAYING_LEAVE = 9,
    RECONNECT_CONNECT_FAILURE = 10,
    RECONNECT_DISABLED_CONNECT_FAILURE = 11,
    RECONNECT_AGE_CHECK_REQUIRED = 12,
    RECONNECT_PARENT_APPROVAL_REQUIRED = 13,
    RECONNECT_COLLABORATION_CORE_GATED = 14
}

if bool6 then
    tbl1.AUTO_RECONNECTING = 15
end

local NONE = tbl1.NONE

local OK = Enum.ConnectionError.OK

local tbl2 = {
    [tbl1.RECONNECT_PLACELAUNCH] = "Join Error",
    [tbl1.RECONNECT_DISABLED_PLACELAUNCH] = "Join Error",
    [tbl1.RECONNECT_DISCONNECT] = "Disconnected",
    [tbl1.RECONNECT_DISABLED_DISCONNECT] = "Disconnected",
    [tbl1.TELEPORT_FAILED] = "Teleport Failed",
    [tbl1.RECONNECT_DISABLED] = "Error",
    [tbl1.OUT_OF_MEMORY_KEEPPLAYING_LEAVE] = "Low Memory Warning",
    [tbl1.RECONNECT_CONNECT_FAILURE] = "Connection Failed",
    [tbl1.RECONNECT_DISABLED_CONNECT_FAILURE] = "Connection Failed",
    [tbl1.RECONNECT_AGE_CHECK_REQUIRED] = "Join Error",
    [tbl1.RECONNECT_PARENT_APPROVAL_REQUIRED] = "Join Error"
}
if bool15 then
    tbl2[tbl1.RECONNECT_COLLABORATION_CORE_GATED] = "Join Error"
end

if bool6 then
    tbl2[tbl1.AUTO_RECONNECTING] = "Disconnected"
end

local tbl3 = {
    [tbl1.RECONNECT_PLACELAUNCH] = "InGame.ConnectionError.Title.JoinError",
    [tbl1.RECONNECT_DISABLED_PLACELAUNCH] = "InGame.ConnectionError.Title.JoinError",
    [tbl1.RECONNECT_DISCONNECT] = "InGame.ConnectionError.Title.Disconnected",
    [tbl1.RECONNECT_DISABLED_DISCONNECT] = "InGame.ConnectionError.Title.Disconnected",
    [tbl1.TELEPORT_FAILED] = "InGame.ConnectionError.Title.TeleportFailed",
    [tbl1.RECONNECT_DISABLED] = "InGame.CommonUI.Title.Error",
    [tbl1.OUT_OF_MEMORY_KEEPPLAYING_LEAVE] = "InGame.ConnectionError.Title.LowMemoryWarning",
    [tbl1.RECONNECT_CONNECT_FAILURE] = "InGame.ConnectionError.Title.ConnectionFailed",
    [tbl1.RECONNECT_DISABLED_CONNECT_FAILURE] = "InGame.ConnectionError.Title.ConnectionFailed",
    [tbl1.RECONNECT_AGE_CHECK_REQUIRED] = "InGame.ConnectionError.Title.JoinError",
    [tbl1.RECONNECT_PARENT_APPROVAL_REQUIRED] = "InGame.ConnectionError.Title.JoinError"
}
if bool15 then
    tbl3[tbl1.RECONNECT_COLLABORATION_CORE_GATED] = "InGame.ConnectionError.Title.JoinError"
end

if bool6 then
    tbl3[tbl1.AUTO_RECONNECTING] = "InGame.ConnectionError.Title.Disconnected"
end

local var7 = Create("ScreenGui")(
    {
        Parent = CoreGui,
        Name = "RobloxPromptGui",
        OnTopOfCoreBlur = true,
        DisplayOrder = 9,
        AutoLocalize = false
    }
)

local var8 = Create("Frame")({
    Name = "promptOverlay",
    BackgroundColor3 = Color3.new(0, 0, 0),
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 36),
    Position = UDim2.new(0, 0, 0, -36),
    Active = false,
    Parent = var7
})

coroutine.wrap(function()
    local constants = require(RobloxGui.Modules.TopBar.Constants)
    local yOffset = constants.ApplyDisplayScale(constants.TopBarHeight)

    var8.Size = UDim2.new(1, 0, 1, yOffset)
    var8.Position = UDim2.new(0, 0, 0, -yOffset)
end)()

local function openCollaboratorsPageForUniverseId(arg1)
    TelemetryService:LogCounter(config, { customFields = { selectedItem = "ViewCollaboratorsOpenUrl" } }, 1)

    local str2 = string.format("%sdashboard/creations/experiences/%s/safety/collaborators", Url.CREATE_URL, tostring(arg1))

    LinkingProtocol.default:openURL(str2)
end

local function Callback()
    TelemetryService:LogCounter(config, { customFields = { selectedItem = "ViewCollaboratorsInitiated" } }, 1)

    local gameId = game.GameId
    if gameId and gameId ~= 0 then
        openCollaboratorsPageForUniverseId(gameId)
        return
    end

    local placeId = game.PlaceId
    if not placeId or placeId == 0 then
        TelemetryService:LogCounter(config, { customFields = { selectedItem = "ViewCollaboratorsMissingPlaceId" } }, 1)
        return
    end

    coroutine.wrap(function()
        local var9 = fetchUniverseIdFromPlaceId(placeId)
        if var9 then
            openCollaboratorsPageForUniverseId(var9)
            return
        end

        TelemetryService:LogCounter(config, { customFields = { selectedItem = "ViewCollaboratorsUniverseIdLookupFailed" } }, 1)
    end)()
end

local function func1()
    tick()
    if NONE == tbl1.IS_RECONNECTING then
        TelemetryService:LogCounter(config, { customFields = { selectedItem = "UserClickWhileReconnecting" } }, 1)
        return
    end

    TelemetryService:LogCounter(config, { customFields = { selectedItem = "ReconnectInitiated" } }, 1)

    RbxAnalyticsService:ReportCounter("ReconnectPrompt-ReconnectActivated")
    NONE = tbl1.IS_RECONNECTING
    var6:primaryShimmerPlay()
    local relaunchPlaceId = if FFlagConnectionRelaunchBuildPlaytest then playtestReconnect.getRelaunchPlaceId() else nil

    if relaunchPlaceId ~= nil then
        TelemetryService:LogCounter(config, { customFields = { selectedItem = "ReconnectBuildPlaytestRelaunch" } }, 1)
        playtestReconnect.relaunch(relaunchPlaceId)
        return
    end

    TelemetryService:LogCounter(config, { customFields = { selectedItem = "ReconnectSameServer" } }, 1)
    TeleportService:TeleportReconnect()

    if not FFlagCoreScriptShowTeleportPrompt then
        return
    end

    if bool5 then
        TeleportService:UnblockAsync()
        return
    end
    GuiService:SetMenuIsOpen(false, "ErrorPrompt")
end

local function func3()
    if NONE == tbl1.IS_RECONNECTING then
        TelemetryService:LogCounter(config, { customFields = { selectedItem = "UserClickWhileReconnecting" } }, 1)
        return
    end

    local placeId = game.PlaceId
    if not placeId or placeId == 0 then
        TelemetryService:LogCounter(config, { customFields = { selectedItem = "PlacelaunchRetryMissingPlaceId" } }, 1)
        return
    end

    TelemetryService:LogCounter(config, { customFields = { selectedItem = "PlacelaunchRetryInitiated" } }, 1)
    NONE = tbl1.IS_RECONNECTING
    var6:primaryShimmerPlay()

    GuiService:ClearError()
    TeleportService:Teleport(placeId)
end

local function func4()
    TelemetryService:LogCounter(config, { customFields = { selectedItem = "LeaveInitiated" } }, 1)
    if var5 then
        leaveGame(false, { shouldNativeExit = isPioneerLaunch(), inhibitAppRating = true, telemetryContext = "ErrorPrompt" })
        return
    end

    GuiService.SelectedCoreObject = nil

    RunService.RenderStepped:wait()
    RunService.RenderStepped:wait()

    game:Shutdown()
end

local function func2()
    GuiService:ClearError()
end

local tbl4 = {
    active = false,
    attempt = 0,
    pendingThread = nil,
    nextAttemptAt = 0,
    tickerThread = nil,
    errorCode = nil,
    baseMessage = nil,
    lastRenderedText = nil,
    lastRemaining = nil
}

local function pushErrorToPrompt(arg1, errorCode) -- Luacid: Inlined by compiler; 1 call site recovered
    if not var6 then
        return
    end

    if GetFFlagDisplayChannelNameOnErrorPrompt() then
        var6:onErrorChanged(arg1, errorCode, true)
    else
        var6:onErrorChanged(arg1, errorCode)
    end
end

local function renderAutoReconnectPrompt()
    if not var6 or NONE ~= tbl1.AUTO_RECONNECTING and NONE ~= tbl1.IS_RECONNECTING then
        return
    end

    local var9 = if NONE == tbl1.IS_RECONNECTING then -1 else math.max(0, math.ceil(tbl4.nextAttemptAt - tick()))

    if var9 == tbl4.lastRemaining then
        return
    end
    tbl4.lastRemaining = var9

    local attempt = tbl4.attempt
    local var10 = if var9 <= 0 then translateString("InGame.ConnectionError.ReconnectingAttempt", { RBX_ATTEMPT = attempt }) elseif var9 == 1 then translateString("InGame.ConnectionError.ReconnectingAttemptInSecond", { RBX_ATTEMPT = attempt }) else translateString("InGame.ConnectionError.ReconnectingAttemptInSeconds", { RBX_ATTEMPT = attempt, RBX_SECONDS = var9 })

    if tbl4.baseMessage and tbl4.baseMessage ~= "" then
        var10 = tbl4.baseMessage .. "\n" .. var10
    end

    if var10 == tbl4.lastRenderedText then
        return
    end
    tbl4.lastRenderedText = var10
    pushErrorToPrompt(var10, tbl4.errorCode)
end

local function ensureAutoReconnectTicker() -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl4.tickerThread then
        return
    end
    tbl4.tickerThread = task.spawn(function()
        while tbl4.active do
            task.wait(0.25)
            renderAutoReconnectPrompt()
        end
        tbl4.tickerThread = nil
    end)
end

local function cancelAutoReconnect() -- Luacid: Inlined by compiler; 3 call sites recovered
    tbl4.active = false
    tbl4.attempt = 0
    tbl4.nextAttemptAt = 0
    tbl4.errorCode = nil
    tbl4.baseMessage = nil
    tbl4.lastRenderedText = nil
    tbl4.lastRemaining = nil
    if tbl4.pendingThread then
        task.cancel(tbl4.pendingThread)
        tbl4.pendingThread = nil
    end
    if tbl4.tickerThread then
        task.cancel(tbl4.tickerThread)
        tbl4.tickerThread = nil
    end
end

local function autoReconnectAttemptBucket(attempt): string -- Luacid: Inlined by compiler; 1 call site recovered
    if attempt <= 5 then
        return tostring(attempt)
    end

    return if attempt <= 8 then "6-8" else "9+"
end

local function fireAutoReconnect()
    tbl4.pendingThread = nil

    if NONE == tbl1.IS_RECONNECTING then
        return
    end

    TelemetryService:LogCounter(
        config,
        {
            customFields = {
                selectedItem = "AutoReconnectAttempt",
                attemptBucket = autoReconnectAttemptBucket(tbl4.attempt)
            }
        },
        1
    )

    NONE = tbl1.IS_RECONNECTING
    renderAutoReconnectPrompt()
    if var6 then
        var6:primaryShimmerPlay()
    end
    TeleportService:TeleportReconnect()

    if not FFlagCoreScriptShowTeleportPrompt then
        return
    end

    if bool5 then
        TeleportService:UnblockAsync()
        return
    end
    GuiService:SetMenuIsOpen(false, "ErrorPrompt")
end

local function scheduleAutoReconnect()
    tbl4.active = true
    if tbl4.pendingThread then
        task.cancel(tbl4.pendingThread)
        tbl4.pendingThread = nil
    end
    tbl4.attempt += 1
    local var9 = computeAutoReconnectDelaySeconds(tbl4.attempt)
    tbl4.nextAttemptAt = tick() + var9
    tbl4.lastRenderedText = nil
    tbl4.lastRemaining = nil
    TelemetryService:LogCounter(config, { customFields = { selectedItem = "AutoReconnectScheduled" } }, 1)
    ensureAutoReconnectTicker()
    tbl4.pendingThread = task.delay(var9, fireAutoReconnect)
end

local function autoReconnectNowFunction()
    if NONE == tbl1.IS_RECONNECTING then
        TelemetryService:LogCounter(config, { customFields = { selectedItem = "UserClickWhileReconnecting" } }, 1)
        return
    end
    TelemetryService:LogCounter(config, { customFields = { selectedItem = "AutoReconnectManualNow" } }, 1)
    if tbl4.pendingThread then
        task.cancel(tbl4.pendingThread)
        tbl4.pendingThread = nil
    end
    fireAutoReconnect()
end

local function func5()
    TelemetryService:LogCounter(config, { customFields = { selectedItem = "AutoReconnectLeave" } }, 1)
    cancelAutoReconnect()
    func4()
end

local tbl5 = {
    [Enum.ConnectionError.IPRecentlyConnected] = true,
    [Enum.ConnectionError.ConnectionBanned] = true,
    [Enum.ConnectionError.InvalidPassword] = true,
    [Enum.ConnectionError.OurSystemRequiresSecurity] = true,
    [Enum.ConnectionError.IncompatibleProtocolVersion] = true,
    [Enum.ConnectionError.DisconnectLuaKick] = true,
    [Enum.ConnectionError.DisconnectSecurityKeyMismatch] = true,
    [Enum.ConnectionError.DisconnectNewSecurityKeyMismatch] = true,
    [Enum.ConnectionError.DisconnectDuplicateTicket] = true,
    [Enum.ConnectionError.DisconnectWrongVersion] = true,
    [Enum.ConnectionError.DisconnectProtocolMismatch] = true,
    [Enum.ConnectionError.DisconnectBadhash] = true,
    [Enum.ConnectionError.DisconnectIllegalTeleport] = true,
    [Enum.ConnectionError.DisconnectDuplicatePlayer] = true,
    [Enum.ConnectionError.DisconnectCloudEditKick] = true,
    [Enum.ConnectionError.DisconnectOnRemoteSysStats] = true,
    [Enum.ConnectionError.DisconnectBySecurityPolicy] = true,
    [Enum.ConnectionError.DisconnectBlockedIP] = true,
    [Enum.ConnectionError.DisconnectPrivateServerKickout] = true,
    [Enum.ConnectionError.DisconnectCollaboratorPermissionRevoked] = true,
    [Enum.ConnectionError.DisconnectCollaboratorUnderage] = true,
    [Enum.ConnectionError.PlacelaunchFlooded] = true,
    [Enum.ConnectionError.PlacelaunchHashException] = true,
    [Enum.ConnectionError.PlacelaunchHashExpired] = true,
    [Enum.ConnectionError.PlacelaunchUnauthorized] = true,
    [Enum.ConnectionError.PlacelaunchUserLeft] = true,
    [Enum.ConnectionError.PlacelaunchRestricted] = true,
    [Enum.ConnectionError.PlacelaunchUserPrivacyUnauthorized] = true,
    [Enum.ConnectionError.PlacelaunchCreatorBan] = true,
    [Enum.ConnectionError.AndroidAnticheatKick] = true,
    [Enum.ConnectionError.AndroidEmulatorKick] = true,
    [Enum.ConnectionError.AndroidRootedKick] = true
}

if engineFeature2 then
    tbl5[Enum.ConnectionError.DisconnectClientFailure] = true
end

if bool4 then
    tbl5[Enum.ConnectionError.ScreentimeLockoutKick] = true
end

if bool9 then
    tbl5[Enum.ConnectionError.PlacelaunchDeviceBlock] = true
end

if bool10 then
    tbl5[Enum.ConnectionError.PlacelaunchAgeVerificationRequired] = true
    tbl5[Enum.ConnectionError.PlacelaunchParentalApprovalRequired] = true
    tbl5[Enum.ConnectionError.PlacelaunchCoreGated] = true
end

if bool11 and not bool12 then
    tbl5[Enum.ConnectionError.PlacelaunchVipOwnerNotPresent] = true
end

local PlacelaunchCollaborationCoreGated = if bool15 and engineFeature3 then Enum.ConnectionError.PlacelaunchCollaborationCoreGated else nil

if bool15 and PlacelaunchCollaborationCoreGated then
    tbl5[PlacelaunchCollaborationCoreGated] = true
end

if bool13 and bool14 then
    tbl5[Enum.ConnectionError.DisconnectRemoteAttestationUnsupported] = true
    tbl5[Enum.ConnectionError.DisconnectRemoteAttestationGeneralFailure] = true
    tbl5[Enum.ConnectionError.DisconnectRemoteAttestationOSOutOfDate] = true
    tbl5[Enum.ConnectionError.DisconnectRemoteAttestationBootValidationFailure] = true
end

local tbl6 = ({})
if bool6 then
    tbl6 = {
        [Enum.ConnectionError.DisconnectConnectionLost] = true,
        [Enum.ConnectionError.DisconnectTimeout] = true,
        [Enum.ConnectionError.DisconnectRaknetErrors] = true,
        [Enum.ConnectionError.DisconnectReceivePacketError] = true,
        [Enum.ConnectionError.DisconnectReceivePacketStreamError] = true,
        [Enum.ConnectionError.DisconnectSendPacketError] = true,
        [Enum.ConnectionError.DisconnectHashTimeout] = true,
        [Enum.ConnectionError.ReplicatorTimeout] = true,
        [Enum.ConnectionError.NetworkTimeout] = true,
        [Enum.ConnectionError.NetworkInternal] = true,
        [Enum.ConnectionError.NetworkSend] = true
    }

    if bool7 and engineFeature then
        local disconnectTransportIoInternetError = Enum.ConnectionError.DisconnectTransportIoInternetError
        tbl6[disconnectTransportIoInternetError] = true
    end
end

local tbl7 = {
    [tbl1.RECONNECT_PLACELAUNCH] = {
        {
            Text = "Retry",
            LocalizationKey = "InGame.CommonUI.Button.Retry",
            LayoutOrder = 2,
            Callback = func1,
            Primary = true
        },
        {
            Text = "Cancel",
            LocalizationKey = "Feature.SettingsHub.Action.CancelSearch",
            LayoutOrder = 1,
            Callback = func4
        }
    },
    [tbl1.RECONNECT_DISCONNECT] = {
        {
            Text = "Reconnect",
            LocalizationKey = "InGame.ConnectionError.Button.Reconnect",
            LayoutOrder = 2,
            Callback = func1,
            Primary = true
        },
        {
            Text = "Leave",
            LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
            LayoutOrder = 1,
            Callback = func4
        }
    },
    [tbl1.TELEPORT_FAILED] = {{
        Text = "OK",
        LocalizationKey = "InGame.CommonUI.Button.Ok",
        LayoutOrder = 1,
        Callback = func2,
        Primary = true
    }},
    [tbl1.RECONNECT_DISABLED_DISCONNECT] = {{
        Text = "Leave",
        LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
        LayoutOrder = 1,
        Callback = func4,
        Primary = true
    }},
    [tbl1.RECONNECT_DISABLED_PLACELAUNCH] = {{
        Text = "Leave",
        LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
        LayoutOrder = 1,
        Callback = func4,
        Primary = true
    }},
    [tbl1.RECONNECT_DISABLED] = {{
        Text = "Leave",
        LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
        LayoutOrder = 1,
        Callback = func4,
        Primary = true
    }},
    [tbl1.OUT_OF_MEMORY_KEEPPLAYING_LEAVE] = {
        {
            Text = "Keep Playing",
            LocalizationKey = "InGame.CommonUI.Button.KeepPlaying",
            LayoutOrder = 1,
            Callback = func2
        },
        {
            Text = "Leave",
            LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
            LayoutOrder = 2,
            Callback = func4,
            Primary = true
        }
    },
    [tbl1.RECONNECT_CONNECT_FAILURE] = {
        {
            Text = "Retry",
            LocalizationKey = "InGame.CommonUI.Button.Retry",
            LayoutOrder = 2,
            Callback = func1,
            Primary = true
        },
        {
            Text = "Cancel",
            LocalizationKey = "Feature.SettingsHub.Action.CancelSearch",
            LayoutOrder = 1,
            Callback = func4
        }
    },
    [tbl1.RECONNECT_DISABLED_CONNECT_FAILURE] = {{
        Text = "Leave",
        LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
        LayoutOrder = 1,
        Callback = func4,
        Primary = true
    }}
}

local ageCheckCallback = ConnectionAmpUpsellOnLeave.createAgeCheckCallback(config, func3, 9)

tbl7[tbl1.RECONNECT_AGE_CHECK_REQUIRED] = {
    {
        Text = "Leave",
        LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
        LayoutOrder = 1,
        Callback = func4
    },
    {
        Text = ConnectionAmpUpsellOnLeave.PrimaryButtonText,
        LocalizationKey = ConnectionAmpUpsellOnLeave.PrimaryButtonLocalizationKey,
        LayoutOrder = 2,
        Callback = ageCheckCallback,
        Primary = true
    }
}

if FFlagConnectionAmpParentalApprovalUpsell then
    local callback = ConnectionAmpUpsellOnLeave.createParentalApprovalCallback(config, func3, 9)

    tbl7[tbl1.RECONNECT_PARENT_APPROVAL_REQUIRED] = {
        {
            Text = "Leave",
            LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
            LayoutOrder = 1,
            Callback = func4
        },
        {
            Text = ConnectionAmpUpsellOnLeave.PrimaryButtonText,
            LocalizationKey = ConnectionAmpUpsellOnLeave.PrimaryButtonLocalizationKey,
            LayoutOrder = 2,
            Callback = callback,
            Primary = true
        }
    }
end

if FFlagConnectionParentalApprovalLeaveOnly then
    tbl7[tbl1.RECONNECT_PARENT_APPROVAL_REQUIRED] = {{
        Text = "Leave",
        LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
        LayoutOrder = 1,
        Callback = func4,
        Primary = true
    }}
end

if bool15 then
    tbl7[tbl1.RECONNECT_COLLABORATION_CORE_GATED] = {
        {
            Text = "Ok",
            LocalizationKey = "InGame.ConnectionError.Action.Ok",
            LayoutOrder = 1,
            Callback = func4
        },
        {
            Text = "View collaborators",
            LocalizationKey = "InGame.ConnectionError.Action.ViewCollaborators",
            LayoutOrder = 2,
            Callback = Callback,
            Primary = true
        }
    }
end

if bool6 then
    tbl7[tbl1.AUTO_RECONNECTING] = {
        {
            Text = "Reconnect Now",
            LocalizationKey = "InGame.ConnectionError.Button.ReconnectNow",
            LayoutOrder = 2,
            Callback = autoReconnectNowFunction,
            Primary = true
        },
        {
            Text = "Leave",
            LocalizationKey = "Feature.SettingsHub.Label.LeaveButton",
            LayoutOrder = 1,
            Callback = func5
        }
    }
end

if isPioneerLaunch() then
    for _, value in pairs(tbl7) do
        for _, value2 in ipairs(value) do
            if value2.Callback == func4 or value2.Callback == func5 then
                value2.Text = "Quit"
                value2.LocalizationKey = "Feature.SettingsHub.Label.QuitButton"
            end
        end
    end
end

local tbl8 = {}
tbl8[tbl1.NONE] = function()
    RunService:SetRobloxGuiFocused(false)
    var8.Active = false
    var8.Transparency = 1
end

tbl8[tbl1.RECONNECT_DISCONNECT] = function()
    if VRService.VREnabled then
        RunService:SetRobloxGuiFocused(false)
    else
        RunService:SetRobloxGuiFocused(true)
    end
    var8.Active = true
    var8.Transparency = 1
end

tbl8[tbl1.RECONNECT_PLACELAUNCH] = function()
    RunService:SetRobloxGuiFocused(false)
    var8.Active = true
    var8.Transparency = 0.3
end

tbl8[tbl1.TELEPORT_FAILED] = function()
    RunService:SetRobloxGuiFocused(false)
    var8.Active = true
    var8.Transparency = 0.3
end

tbl8[tbl1.RECONNECT_DISABLED_DISCONNECT] = function()
    if VRService.VREnabled then
        RunService:SetRobloxGuiFocused(false)
    else
        RunService:SetRobloxGuiFocused(true)
    end
    var8.Active = true
    var8.Transparency = 1
end

tbl8[tbl1.RECONNECT_DISABLED_PLACELAUNCH] = function()
    RunService:SetRobloxGuiFocused(false)
    var8.Active = true
    var8.Transparency = 0.3
end

tbl8[tbl1.RECONNECT_DISABLED] = function()
    if VRService.VREnabled then
        RunService:SetRobloxGuiFocused(false)
    else
        RunService:SetRobloxGuiFocused(true)
    end
    var8.Active = true
    var8.Transparency = 1
end

tbl8[tbl1.RECONNECT_CONNECT_FAILURE] = function()
    RunService:SetRobloxGuiFocused(false)
    var8.Active = true
    var8.Transparency = 0.3
end

tbl8[tbl1.RECONNECT_DISABLED_CONNECT_FAILURE] = function()
    RunService:SetRobloxGuiFocused(false)
    var8.Active = true
    var8.Transparency = 0.3
end

local var9 = tbl8[tbl1.RECONNECT_PLACELAUNCH]
tbl8[tbl1.RECONNECT_AGE_CHECK_REQUIRED] = var9
if FFlagConnectionAmpParentalApprovalUpsell then
    tbl8[tbl1.RECONNECT_PARENT_APPROVAL_REQUIRED] = var9
end

if bool15 then
    tbl8[tbl1.RECONNECT_COLLABORATION_CORE_GATED] = function()
        RunService:SetRobloxGuiFocused(false)
        var8.Active = true
        var8.Transparency = 0.3
    end
end

if bool6 then
    tbl8[tbl1.AUTO_RECONNECTING] = tbl8[tbl1.RECONNECT_DISCONNECT]
end

local function onEnter(arg1)
    if not var6 then
        var6 = ErrorPrompt.new("Default", { MenuIsOpenKey = "ConnectionErrorPrompt", PlayAnimation = not bool2 })
        var6:setParent(var8)
        var6:resizeWidthAndHeight(AbsoluteSizeX, AbsoluteSizeY)
    end
    if tbl8[arg1] then
        tbl8[arg1]()
    end
    var6:setErrorTitle(tbl2[arg1], tbl3[arg1])
    var6:updateButtons(tbl7[arg1])
end

local function onExit(isReconnecting) -- Luacid: Inlined by compiler; 1 call site recovered
    if isReconnecting == tbl1.IS_RECONNECTING then
        var6:primaryShimmerStop()
    end
end

local function stateTransit(connectionError, connectionError2, arg1)
    if FFlagAllowDisconnectGuiForOkUnknown then
        if connectionError2 == Enum.ConnectionError.OK then
            return tbl1.NONE
        end
    elseif connectionError == Enum.ConnectionError.OK then
        return tbl1.NONE
    end

    if arg1 == tbl1.NONE then
        if fFlag then
            return tbl1.RECONNECT_DISABLED
        end
        var4 = tick()

        if FFlagAllowDisconnectGuiForOkUnknown then
            assert(connectionError2 ~= Enum.ConnectionError.OK)
            if connectionError == Enum.ConnectionError.OK then
                return tbl1.RECONNECT_DISCONNECT
            end
        end

        if connectionError == Enum.ConnectionError.ConnectErrors then
            num9 = tick() + var2
            OK = Enum.ConnectionError.ConnectErrors
            if tbl5[connectionError2] then
                return tbl1.RECONNECT_DISABLED_CONNECT_FAILURE
            end
            TelemetryService:LogCounter(config, { customFields = { selectedItem = "ConnectError" } }, 1)
            TelemetryService:LogCounter(config, { customFields = { selectedItem = "ConnectFailed" } }, 1)
            return tbl1.RECONNECT_CONNECT_FAILURE
        end
        if connectionError == Enum.ConnectionError.DisconnectErrors then
            num9 = tick() + var2
            OK = Enum.ConnectionError.DisconnectErrors
            if connectionError2 == Enum.ConnectionError.DisconnectOutOfMemoryKeepPlayingLeave then
                return tbl1.OUT_OF_MEMORY_KEEPPLAYING_LEAVE
            end
            if tbl5[connectionError2] then
                return tbl1.RECONNECT_DISABLED_DISCONNECT
            end
            TelemetryService:LogCounter(config, { customFields = { selectedItem = "Disconnected" } }, 1)
            RbxAnalyticsService:ReportCounter("ReconnectPrompt-Disconnect")

            if FFlagConnectionRelaunchBuildPlaytest and playtestReconnect.getRelaunchPlaceId() ~= nil then
                return tbl1.RECONNECT_DISCONNECT
            end

            if bool6 and tbl6[connectionError2] then
                return tbl1.AUTO_RECONNECTING
            end

            return tbl1.RECONNECT_DISCONNECT
        end

        if connectionError == Enum.ConnectionError.PlacelaunchErrors then
            OK = Enum.ConnectionError.PlacelaunchErrors
            local ageVerificationRequiredEnum = ConnectionAmpUpsellOnLeave.AgeVerificationRequiredEnum
            if ageVerificationRequiredEnum and connectionError2 == ageVerificationRequiredEnum then
                TelemetryService:LogCounter(config, { customFields = { selectedItem = "PlaceLaunchAgeVerificationRequired" } }, 1)
                if FFlagConnectionUpsellAnalytics then
                    ConnectionAmpUpsellOnLeave.fireImpressionAgeCheck(config, game.PlaceId)
                end
                return tbl1.RECONNECT_AGE_CHECK_REQUIRED
            end
            if FFlagConnectionAmpParentalApprovalUpsell then
                local parentalApprovalRequiredEnum = ConnectionAmpUpsellOnLeave.ParentalApprovalRequiredEnum
                if parentalApprovalRequiredEnum and connectionError2 == parentalApprovalRequiredEnum then
                    TelemetryService:LogCounter(config, { customFields = { selectedItem = "PlaceLaunchParentalApprovalRequired" } }, 1)
                    if FFlagConnectionUpsellAnalytics then
                        ConnectionAmpUpsellOnLeave.fireImpressionParentalApproval(config, game.PlaceId)
                    end
                    return tbl1.RECONNECT_PARENT_APPROVAL_REQUIRED
                end
            end
            if bool15 and PlacelaunchCollaborationCoreGated and connectionError2 == PlacelaunchCollaborationCoreGated then
                TelemetryService:LogCounter(config, { customFields = { selectedItem = "PlaceLaunchCollaborationCoreGated" } }, 1)
                return tbl1.RECONNECT_COLLABORATION_CORE_GATED
            end
            if tbl5[connectionError2] then
                return tbl1.RECONNECT_DISABLED_PLACELAUNCH
            end
            TelemetryService:LogCounter(config, { customFields = { selectedItem = "PlaceLaunchError" } }, 1)
            RbxAnalyticsService:ReportCounter("ReconnectPrompt-PlaceLaunch")
            return tbl1.RECONNECT_PLACELAUNCH
        end

        if connectionError == Enum.ConnectionError.TeleportErrors then
            TelemetryService:LogCounter(config, { customFields = { selectedItem = "TeleportError" } }, 1)
            RbxAnalyticsService:ReportCounter("ReconnectPrompt-TeleportFailed")
            return tbl1.TELEPORT_FAILED
        end
    end

    if arg1 == tbl1.IS_RECONNECTING then
        TelemetryService:LogCounter(config, { customFields = { selectedItem = "ReconnectFailed" } }, 1)
        RbxAnalyticsService:ReportCounter("ReconnectPrompt-ReconnectFailed")

        if connectionError == Enum.ConnectionError.TeleportErrors then
            if tick() > var4 + num1 then
                TelemetryService:LogCounter(config, { customFields = { selectedItem = "ReconnectTimedOut" } }, 1)
                return if OK == Enum.ConnectionError.PlacelaunchErrors then tbl1.RECONNECT_DISABLED_PLACELAUNCH else tbl1.RECONNECT_DISABLED_DISCONNECT
            end

            if OK == Enum.ConnectionError.PlacelaunchErrors then
                TelemetryService:LogCounter(config, { customFields = { selectedItem = "PlaceLaunchReconnectFailed" } }, 1)
                return tbl1.RECONNECT_PLACELAUNCH
            end

            if OK == Enum.ConnectionError.DisconnectErrors then
                TelemetryService:LogCounter(config, { customFields = { selectedItem = "DisconnectReconnectFailed" } }, 1)
                if bool6 and tbl4.active then
                    local num10 = num7
                    if num10 <= 0 or tick() <= var4 + num10 then
                        return tbl1.AUTO_RECONNECTING
                    end
                    TelemetryService:LogCounter(config, { customFields = { selectedItem = "AutoReconnectExhausted" } }, 1)
                end
                return tbl1.RECONNECT_DISCONNECT
            end

            if OK == Enum.ConnectionError.ConnectErrors then
                TelemetryService:LogCounter(config, { customFields = { selectedItem = "ConnectReconnectFailed" } }, 1)
                return tbl1.RECONNECT_CONNECT_FAILURE
            end
        end
    end

    if not bool6 or arg1 ~= tbl1.AUTO_RECONNECTING then
        return arg1
    end

    if fFlag then
        return tbl1.RECONNECT_DISABLED
    end

    if connectionError == Enum.ConnectionError.DisconnectErrors and tbl5[connectionError2] then
        return tbl1.RECONNECT_DISABLED_DISCONNECT
    end

    return arg1
end

local function getCreatorBanString(str2: string)
    local errorDetails = GuiService:GetErrorDetails()
    if not errorDetails then
        return str2
    end

    local var10

    if errorDetails.time then
        local minutes = errorDetails.minutes
        local hours = errorDetails.hours
        local days = errorDetails.days
        local var11 = if minutes == 1 then translateString("InGame.ConnectionError.CreatorBanMinutesSingular") else translateString("InGame.ConnectionError.CreatorBanMinutesPlural", { RBX_TIME_MINUTES = minutes })
        local var12 = if hours == 1 then translateString("InGame.ConnectionError.CreatorBanHoursSingular") else translateString("InGame.ConnectionError.CreatorBanHoursPlural", { RBX_TIME_HOURS = hours })
        local var13 = if days == 1 then translateString("InGame.ConnectionError.CreatorBanDaysSingular") else translateString("InGame.ConnectionError.CreatorBanDaysPlural", { RBX_TIME_DAYS = days })

        if var11 == "" or var12 == "" or var13 == "" then
            return str2
        end

        if hours > 0 then
            var11 = var12 .. ", " .. var11
        end
        if days > 0 then
            var11 = var13 .. ", " .. var11
        end

        var10 = translateString("InGame.ConnectionError.CreatorBanWithTime", { RBX_TIME_REMAINING = var11 })
    else
        var10 = translateString("InGame.ConnectionError.CreatorBanNoTime")
    end

    if var10 == "" then
        return str2
    end

    local displayReason = errorDetails.displayReason
    if not displayReason or displayReason == "" then
        return var10
    end

    local var11 = translateString("InGame.ConnectionError.CreatorBanMessage", { RBX_STR = displayReason })
    return if var11 == "" then str2 else var10 .. " " .. var11
end

local bool16 = game:DefineFastFlag("RemoveRefToMissingLocInConnection", false)

local tbl9 = {
    [Enum.ConnectionError.ConnectErrors] = "InGame.ConnectionError.ConnectErrors",
    [Enum.ConnectionError.AlreadyConnected] = "InGame.ConnectionError.ConnectionFailedWaitAndTry",
    [Enum.ConnectionError.NoFreeIncomingConnections] = "InGame.ConnectionError.ConnectionFailedWaitAndTry",
    [Enum.ConnectionError.IPRecentlyConnected] = "InGame.ConnectionError.ConnectErrors",
    [Enum.ConnectionError.ConnectionBanned] = "InGame.ConnectionError.ConnectionBanned",
    [Enum.ConnectionError.InvalidPassword] = "InGame.ConnectionError.ConnectionFailedRobloxVersion",
    [Enum.ConnectionError.OurSystemRequiresSecurity] = "InGame.ConnectionError.ConnectionFailedRobloxVersion",
    [Enum.ConnectionError.IncompatibleProtocolVersion] = "InGame.ConnectionError.ConnectionFailedRobloxVersion",
    [Enum.ConnectionError.DisconnectErrors] = "InGame.ConnectionError.DisconnectErrors",
    [Enum.ConnectionError.DisconnectBadhash] = "InGame.ConnectionError.DisconnectBadhash",
    [Enum.ConnectionError.DisconnectSecurityKeyMismatch] = "InGame.ConnectionError.DisconnectSecurityKeyMismatch",
    [Enum.ConnectionError.DisconnectProtocolMismatch] = "InGame.ConnectionError.DisconnectProtocolMismatch",
    [Enum.ConnectionError.DisconnectReceivePacketError] = "InGame.ConnectionError.DisconnectReceivePacketError",
    [Enum.ConnectionError.DisconnectReceivePacketStreamError] = "InGame.ConnectionError.DisconnectReceivePacketStreamError",
    [Enum.ConnectionError.DisconnectSendPacketError] = "InGame.ConnectionError.DisconnectSendPacketError",
    [Enum.ConnectionError.DisconnectIllegalTeleport] = "InGame.ConnectionError.DisconnectIllegalTeleport",
    [Enum.ConnectionError.DisconnectDuplicatePlayer] = "InGame.ConnectionError.DisconnectDuplicatePlayer",
    [Enum.ConnectionError.DisconnectDuplicateTicket] = "InGame.ConnectionError.DisconnectDuplicateTicket",
    [Enum.ConnectionError.DisconnectTimeout] = "InGame.ConnectionError.DisconnectTimeout",
    [Enum.ConnectionError.DisconnectLuaKick] = "InGame.ConnectionError.DisconnectLuaKick",
    [Enum.ConnectionError.DisconnectOnRemoteSysStats] = "InGame.ConnectionError.DisconnectOnRemoteSysStats",
    [Enum.ConnectionError.DisconnectHashTimeout] = "InGame.ConnectionError.DisconnectHashTimeout",
    [Enum.ConnectionError.DisconnectCloudEditKick] = "InGame.ConnectionError.DisconnectCloudEditKick",
    [Enum.ConnectionError.DisconnectPlayerless] = "InGame.ConnectionError.DisconnectPlayerless",
    [Enum.ConnectionError.DisconnectNewSecurityKeyMismatch] = "InGame.ConnectionError.DisconnectNewSecurityKeyMismatch",
    [Enum.ConnectionError.DisconnectEvicted] = "InGame.ConnectionError.DisconnectEvicted",
    [Enum.ConnectionError.DisconnectDevMaintenance] = "InGame.ConnectionError.DisconnectDevMaintenance",
    [Enum.ConnectionError.DisconnectRobloxMaintenance] = "InGame.ConnectionError.DisconnectRobloxMaintenance",
    [Enum.ConnectionError.DisconnectRejoin] = "InGame.ConnectionError.DisconnectRejoin",
    [Enum.ConnectionError.DisconnectConnectionLost] = "InGame.ConnectionError.DisconnectConnectionLost",
    [Enum.ConnectionError.DisconnectIdle] = "InGame.ConnectionError.DisconnectIdle",
    [Enum.ConnectionError.DisconnectRaknetErrors] = "InGame.ConnectionError.DisconnectRaknetErrors",
    [Enum.ConnectionError.DisconnectWrongVersion] = "InGame.ConnectionError.DisconnectWrongVersion",
    [Enum.ConnectionError.DisconnectBySecurityPolicy] = "InGame.ConnectionError.DisconnectBlockedConnection",
    [Enum.ConnectionError.DisconnectBlockedIP] = "InGame.ConnectionError.DisconnectBlockedConnection",
    [Enum.ConnectionError.DisconnectClientFailure] = "InGame.ConnectionError.DisconnectClientFailure",
    [Enum.ConnectionError.DisconnectClientRequest] = "InGame.ConnectionError.DisconnectClientRequest",
    [Enum.ConnectionError.DisconnectPrivateServerKickout] = "InGame.ConnectionError.DisconnectPrivateServerKickout",
    [Enum.ConnectionError.DisconnectModeratedGame] = "InGame.ConnectionError.ServerShutdown",
    [Enum.ConnectionError.ServerShutdown] = "InGame.ConnectionError.ServerShutdown",
    [Enum.ConnectionError.ReplicatorTimeout] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.PlayerRemoved] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.DisconnectOutOfMemoryKeepPlayingLeave] = "InGame.ConnectionError.DisconnectOutOfMemoryKeepPlayingLeave",
    [Enum.ConnectionError.DisconnectRomarkEndOfTest] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.DisconnectCollaboratorPermissionRevoked] = "InGame.ConnectionError.DisconnectCollaboratorPermissionRevoked",
    [Enum.ConnectionError.DisconnectCollaboratorUnderage] = "InGame.ConnectionError.DisconnectCollaboratorUnderage",
    [Enum.ConnectionError.NetworkInternal] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.NetworkSend] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.NetworkTimeout] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.NetworkMisbehavior] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.NetworkSecurity] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.ReplacementReady] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.ServerEmpty] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.PhantomFreeze] = "InGame.ConnectionError.DisconnectTryAgain",
    [Enum.ConnectionError.AndroidAnticheatKick] = "InGame.ConnectionError.AndroidAnticheatKick",
    [Enum.ConnectionError.AndroidEmulatorKick] = "InGame.ConnectionError.AndroidEmulatorKick",
    [Enum.ConnectionError.PlacelaunchErrors] = "InGame.ConnectionError.PlacelaunchErrors",
    [Enum.ConnectionError.PlacelaunchDisabled] = "InGame.ConnectionError.PlacelaunchDisabled",
    [Enum.ConnectionError.PlacelaunchError] = "InGame.ConnectionError.PlacelaunchError",
    [Enum.ConnectionError.PlacelaunchGameEnded] = "InGame.ConnectionError.PlacelaunchGameEnded",
    [Enum.ConnectionError.PlacelaunchGameFull] = "InGame.ConnectionError.PlacelaunchGameFull",
    [Enum.ConnectionError.PlacelaunchUserLeft] = "InGame.ConnectionError.PlacelaunchUserLeft",
    [Enum.ConnectionError.PlacelaunchRestricted] = "InGame.ConnectionError.PlacelaunchRestricted",
    [Enum.ConnectionError.PlacelaunchUnauthorized] = "InGame.ConnectionError.PlacelaunchUnauthorized",
    [Enum.ConnectionError.PlacelaunchFlooded] = "InGame.ConnectionError.PlacelaunchFlooded",
    [Enum.ConnectionError.PlacelaunchHashExpired] = "InGame.ConnectionError.PlacelaunchHashExpired",
    [Enum.ConnectionError.PlacelaunchHashException] = "InGame.ConnectionError.PlacelaunchHashException",
    [Enum.ConnectionError.PlacelaunchPartyCannotFit] = "InGame.ConnectionError.PlacelaunchPartyCannotFit",
    [Enum.ConnectionError.PlacelaunchHttpError] = "InGame.ConnectionError.PlacelaunchHttpError",
    [Enum.ConnectionError.PlacelaunchUserPrivacyUnauthorized] = "InGame.ConnectionError.PlacelaunchUserPrivacyUnauthorized",
    [Enum.ConnectionError.PlacelaunchCreatorBan] = "InGame.ConnectionError.CreatorBanNoTime",
    [Enum.ConnectionError.PlacelaunchCustomMessage] = if bool16 then nil else "InGame.ConnectionError.PlacelaunchCustomMessage",
    [Enum.ConnectionError.PlacelaunchOtherError] = "InGame.ConnectionError.PlacelaunchOtherError",
    [Enum.ConnectionError.TeleportErrors] = "InGame.ConnectionError.TeleportErrors",
    [Enum.ConnectionError.TeleportFailure] = "InGame.ConnectionError.TeleportFailure",
    [Enum.ConnectionError.TeleportGameNotFound] = "InGame.ConnectionError.TeleportGameNotFound",
    [Enum.ConnectionError.TeleportGameEnded] = "InGame.ConnectionError.TeleportGameEnded",
    [Enum.ConnectionError.TeleportGameFull] = "InGame.ConnectionError.TeleportGameFull",
    [Enum.ConnectionError.TeleportUnauthorized] = "InGame.ConnectionError.TeleportUnauthorized",
    [Enum.ConnectionError.TeleportFlooded] = "InGame.ConnectionError.TeleportFlooded",
    [Enum.ConnectionError.TeleportIsTeleporting] = if bool16 then nil else "InGame.ConnectionError.TeleportIsTeleporting",
    [Enum.ConnectionError.DisconnectVerboselyModeratedGame] = "InGame.ConnectionError.DisconnectVerboselyModeratedGame"
}

if bool4 then
    tbl9[Enum.ConnectionError.ScreentimeLockoutKick] = "Feature.Screentime.Content.ScreentimeLimitDialog"
end

if bool9 then
    tbl9[Enum.ConnectionError.PlacelaunchDeviceBlock] = "InGame.ConnectionError.PlacelaunchDeviceBlock"
end

if bool10 then
    tbl9[Enum.ConnectionError.PlacelaunchAgeVerificationRequired] = "InGame.ConnectionError.Description.AgeCheckRequired"
    tbl9[Enum.ConnectionError.PlacelaunchParentalApprovalRequired] = "InGame.ConnectionError.Description.ParentalApprovalRequired"
    tbl9[Enum.ConnectionError.PlacelaunchCoreGated] = "InGame.ConnectionError.Description.LockedByAge"
end

if bool11 then
    tbl9[Enum.ConnectionError.PlacelaunchVipOwnerNotPresent] = "InGame.ConnectionError.Description.VipOwnerNotPresent"
end

if bool15 and PlacelaunchCollaborationCoreGated then
    tbl9[PlacelaunchCollaborationCoreGated] = "InGame.ConnectionError.Description.CollaborationRequiresTrustedFriends"
end

if bool13 and bool14 then
    tbl9[Enum.ConnectionError.DisconnectRemoteAttestationTimeout] = "InGame.ConnectionError.RemoteAttestationTimeout"
    tbl9[Enum.ConnectionError.DisconnectRemoteAttestationUnsupported] = "InGame.ConnectionError.RemoteAttestationUnsupported"
    tbl9[Enum.ConnectionError.DisconnectRemoteAttestationGeneralFailure] = "InGame.ConnectionError.RemoteAttestationGeneralFailure"
    tbl9[Enum.ConnectionError.DisconnectRemoteAttestationOSOutOfDate] = "InGame.ConnectionError.RemoteAttestationOSOutOfDate"
    tbl9[Enum.ConnectionError.DisconnectRemoteAttestationBootValidationFailure] = "InGame.ConnectionError.RemoteAttestationBootValidationFailure"
end

if bool7 and engineFeature then
    tbl9[Enum.ConnectionError.DisconnectTransportIoError] = "InGame.ConnectionError.DisconnectTryAgain"
    tbl9[Enum.ConnectionError.DisconnectTransportIoInternetError] = "InGame.ConnectionError.DisconnectConnectionLost"
    tbl9[Enum.ConnectionError.DisconnectTransportProtocolError] = "InGame.ConnectionError.DisconnectTryAgain"
    tbl9[Enum.ConnectionError.DisconnectTransportNgtcp2Error] = "InGame.ConnectionError.DisconnectTryAgain"
    tbl9[Enum.ConnectionError.DisconnectTransportQuicError] = "InGame.ConnectionError.DisconnectTryAgain"
    tbl9[Enum.ConnectionError.DisconnectTransportRnaError] = "InGame.ConnectionError.DisconnectTryAgain"
end

local function getErrorString(rbxStr: string, connectionError, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if connectionError == Enum.ConnectionError.OK then
        return ""
    elseif arg1 then
        local var10 = translateString("InGame.ConnectionError.ReconnectFailed")
        return if var10 == "" then "Reconnect was unsuccessful. Please try again." else var10
    elseif connectionError == Enum.ConnectionError.DisconnectLuaKick and rbxStr ~= "" then
        rbxStr = rbxStr:sub(1, num2)

        local var10 = translateString("InGame.ConnectionError.DisconnectLuaKickWithMessage", { RBX_STR = rbxStr })
        return if var10 == "" then rbxStr else var10
    else
        local var10 = tbl9[connectionError]
        if not var10 then
            mutedError("Cannot find localization key for " .. tostring(connectionError))
            var10 = "InGame.ConnectionError.UnknownError"
        end

        local var11 = if connectionError == Enum.ConnectionError.DisconnectIdle then translateString(var10, { RBX_NUM = tostring(20) }) else translateString(var10)

        if var11 ~= "" then
            return var11
        elseif bool3 then
            return (translateString("InGame.ConnectionError.UnknownError"))
        end

        return rbxStr
    end
end

local function updateErrorPrompt(arg1, connectionError, connectionError2)
    if connectionError == Enum.ConnectionError.DisconnectLuaKick then
        local errorDetails = GuiService:GetErrorDetails()

        if errorDetails and errorDetails.moderatorType == "roblox" then
            local robloxExperienceKickContent = buildRobloxExperienceKickContent(arg1, errorDetails, translateString)
            showFeatureRestrictionDirect(robloxExperienceKickContent.abuseVector, robloxExperienceKickContent.moderationDetail, {
                onDismiss = func4,
                titleOverride = robloxExperienceKickContent.options.titleOverride,
                bodyOverride = robloxExperienceKickContent.options.bodyOverride
            })

            TelemetryService:LogCounter(config, { customFields = { selectedItem = "RobloxExperienceKick" } }, 1)

            return
        end
    end

    local var10 = stateTransit(connectionError2, connectionError, NONE)
    if var10 ~= NONE then
        onExit(NONE)
        NONE = var10
        onEnter(var10)
        if bool6 then
            if var10 == tbl1.AUTO_RECONNECTING then
                scheduleAutoReconnect()
            else
                cancelAutoReconnect()
            end
        end
    end

    if connectionError == Enum.ConnectionError.PlacelaunchCreatorBan then
        arg1 = getCreatorBanString(arg1)
    elseif connectionError2 == Enum.ConnectionError.TeleportErrors and NONE ~= tbl1.TELEPORT_FAILED then
        arg1 = getErrorString(nil, connectionError, true)
    else
        arg1 = getErrorString(arg1, connectionError)
    end

    if NONE == tbl1.RECONNECT_DISABLED then
        arg1 = var3
    end

    if bool6 and NONE == tbl1.AUTO_RECONNECTING then
        if tbl4.baseMessage == nil then
            tbl4.baseMessage = arg1
            tbl4.errorCode = connectionError
        end
        renderAutoReconnectPrompt()
        return
    end

    if not var6 then
        return
    end

    if GetFFlagDisplayChannelNameOnErrorPrompt() then
        var6:onErrorChanged(arg1, connectionError, true)
        return
    end
    var6:onErrorChanged(arg1, connectionError)
end

local function onScreenSizeChanged()
    if not var6 then
        return
    end
    local absoluteSizeX = RobloxGui.AbsoluteSize.X
    local absoluteSizeY = RobloxGui.AbsoluteSize.Y
    if AbsoluteSizeX ~= absoluteSizeX or AbsoluteSizeY ~= absoluteSizeY then
        AbsoluteSizeX = absoluteSizeX
        AbsoluteSizeY = absoluteSizeY
        var6:resizeWidthAndHeight(AbsoluteSizeX, AbsoluteSizeY)
    end
end

RobloxGui:GetPropertyChangedSignal("AbsoluteSize"):connect(onScreenSizeChanged)
updateErrorPrompt(GuiService:GetErrorMessage(), GuiService:GetErrorCode(), (GuiService:GetErrorType()))

GuiService.ErrorMessageChanged:connect(function() -- name: onErrorMessageChanged
    local errorMessage = GuiService:GetErrorMessage()
    local connectionError = GuiService:GetErrorCode()
    local connectionError2 = GuiService:GetErrorType()
    updateErrorPrompt(errorMessage, connectionError, connectionError2)
end)
if bool2 then
    local errorTestSets = require(RobloxGui.Modules.ErrorTestSets)
    for k, errorTestSet in pairs(errorTestSets) do
        for _, value in pairs(errorTestSet) do
            updateErrorPrompt("Should show localized strings, please file a jira ticket for missing translation.", value, k)

            wait(2)
            if bool6 then
                cancelAutoReconnect()
            end

            NONE = tbl1.NONE
        end
    end
end

if engineFeature2 then
    GuiService.CoreGuiRenderOverflowed:Connect(function()
        for _, child in pairs(CoreGui:GetChildren()) do
            if child:IsA("ScreenGui") and child.Name ~= "RobloxPromptGui" then
                child.Enabled = false
            end
        end
    end)
end

if bool8 then
    coroutine.wrap(function()
        require(CorePackages.Workspace.Packages.GenericChallenges).Middleware.InitExperienceChallengeInterceptor()
    end)()
end
