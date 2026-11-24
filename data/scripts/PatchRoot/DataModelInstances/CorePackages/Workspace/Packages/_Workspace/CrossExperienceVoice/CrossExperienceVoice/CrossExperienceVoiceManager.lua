-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local ExperienceService = game:GetService("ExperienceService")
local HttpService = game:GetService("HttpService")
local MemStorageService = game:GetService("MemStorageService")
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")
local dependencies = require(CrossExperienceVoice.dependencies)

local Promise = dependencies.Promise

local CrossExperience = dependencies.CrossExperience
local Communication = CrossExperience.Communication
local SharedFlags = dependencies.SharedFlags
local LuauPolyfill = dependencies.LuauPolyfill
local Constants = require(CrossExperienceVoice.Common.Constants)
local CrossExperienceVoiceAnalytics = require(CrossExperienceVoice.CrossExperienceVoiceAnalytics)
local Logger = require(CrossExperienceVoice.Logger)
local Flags = require(CrossExperienceVoice.Flags)

local createPersistenceMiddleware = CrossExperience.Middlewares.createPersistenceMiddleware

local module = {}
module.__index = module

local getFFlagJoinCrossExpVoiceWithPartyId = SharedFlags.getFFlagJoinCrossExpVoiceWithPartyId
local getFFlagEnableCrossExpVoiceMemoryCheck = SharedFlags.getFFlagEnableCrossExpVoiceMemoryCheck
local GetFFlagEnableCrossExperienceVoiceCaptureMute = SharedFlags.GetFFlagEnableCrossExperienceVoiceCaptureMute
local FStringTimeoutLoadingLocalPlayerInBackgroundDM = SharedFlags.FStringTimeoutLoadingLocalPlayerInBackgroundDM
local engineFeature = game:GetEngineFeature("AudioFocusManagement")
local engineFeature2 = game:GetEngineFeature("RecordJoinAttemptIdForCEV")

local FIntPartyVoiceJoinRequestPulseCheckTimeout = SharedFlags.FIntPartyVoiceJoinRequestPulseCheckTimeout

local BACKGROUND_DM_STATUS = CrossExperience.Constants.BACKGROUND_DM_STATUS
local AUDIO_FOCUS_MANAGEMENT = CrossExperience.Constants.AUDIO_FOCUS_MANAGEMENT
local LOCAL_PLAYER_LOADING_TIMEOUT_ENUM = CrossExperience.Constants.LOCAL_PLAYER_LOADING_TIMEOUT_ENUM

local CEV_JOIN_ATTEMPT_ID_KEY = CrossExperience.Constants.CEV_JOIN_ATTEMPT_ID_KEY

local persistenceMiddleware = createPersistenceMiddleware({ storeKey = CrossExperience.Constants.STORAGE_CEV_STORE_KEY })

local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local FFlagFixCrossExperienceVoiceExecutePrint = SharedFlags.FFlagFixCrossExperienceVoiceExecutePrint

local str1 = game:DefineFastString("CrossExpVoicePlaceId", tostring(Constants.DEFAULT_EXPERIENCE_PLACE_ID))

local function func1() end

local function func2() -- Luacid: Inlined by compiler; 3 call sites recovered
    return if game.PlaceId == 0 then CrossExperience.Constants.EXPERIENCE_TYPE_LUAAPP else CrossExperience.Constants.EXPERIENCE_TYPE_UGC
end

function module.new()
    local tbl1 = {
        joinRequestPulseCheckId = nil,
        connections = {},
        isInitialized = false,
        isConnected = false,
        shouldIgnoreMemoryWarning = false,
        hasExperienceStarted = false,
        observersInitialized = false,
        currentCevJoinAttemptId = nil,
        ExperienceJoined = Instance.new("BindableEvent"),
        ExperienceJoinFailed = Instance.new("BindableEvent"),
        ExperienceLeft = Instance.new("BindableEvent"),
        JoinFeasibilityCheckPerformed = Instance.new("BindableEvent"),
        JoinRequestPulseCheck = Instance.new("BindableEvent"),
        JoinRequested = Instance.new("BindableEvent"),
        JoinRequestSubmitted = Instance.new("BindableEvent"),
        MemoryLow = Instance.new("BindableEvent"),
        VoiceEuModalConsented = Instance.new("BindableEvent"),
        VoiceEuModalRefused = Instance.new("BindableEvent"),
        cevEventManager = CrossExperience.EventManager.new(func2(), false),
        voiceAnalytics = CrossExperienceVoiceAnalytics.default,
        isActiveDM = true
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module:logPartyVoiceTimeout()
    self.voiceAnalytics:logPartyVoiceTimeout(self.currentPartyId)
end

function module:initialize()
    self.voiceAnalytics:initialize(self.cevEventManager)

    if self.isInitialized == true then
        return
    end

    table.insert(self.connections, ExperienceService:RegisterForExperienceJoin(function()
        if func2() == CrossExperience.Constants.EXPERIENCE_TYPE_LUAAPP then
            self.isActiveDM = false
        end
    end))

    table.insert(self.connections, ExperienceService:RegisterForExperienceLeave(function()
        if func2() == CrossExperience.Constants.EXPERIENCE_TYPE_LUAAPP then
            self.isActiveDM = true
        end
    end))

    local connections = self.connections
    local onCrossExperienceStarted = ExperienceService.OnCrossExperienceStarted

    table.insert(connections, onCrossExperienceStarted:Connect(function(_: string, _)
        self.voiceAnalytics:logPartyVoiceOnCrossExperienceStartedSignalReceived(self.hasExperienceStarted, self.isActiveDM)

        if self.hasExperienceStarted then
            return
        end

        if self.observersInitialized then
            Logger:info("Observers already initialized, skipping duplicate setup")
            return
        end

        self.observersInitialized = true
        Logger:info("Initializing observers for the first time")

        self.cevEventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_STATUS_CHANGED, function(arg1)
            self.voiceAnalytics:logPartyVoiceStateChangeHandlerRun(self.isActiveDM, arg1)
            if not self.isActiveDM then
                return
            end

            if Flags.FFlagFireErrorRCCTimeoutSignal and arg1.status == CrossExperience.Constants.VOICE_STATUS.ERROR_RCC_TIMEOUT then
                self.voiceAnalytics:logPartyVoiceTimeout(self.currentPartyId)
            elseif Flags.FFlagPartyVoiceLogActiveDM then
                local var1 = if self.isActiveDM then CrossExperience.Constants.EXPERIENCE_TYPE_LUAAPP else CrossExperience.Constants.EXPERIENCE_TYPE_UGC

                if arg1.status == CrossExperience.Constants.VOICE_STATUS.VOICE_CONNECTED then
                    self.voiceAnalytics:logPartyVoiceConnectedState(arg1, self.currentPartyId, var1)
                end

                self.voiceAnalytics:logPartyVoiceStatusChanged(arg1, self.currentPartyId, var1)
            else
                if arg1.status == CrossExperience.Constants.VOICE_STATUS.VOICE_CONNECTED then
                    self.voiceAnalytics:logPartyVoiceConnectedState(arg1, self.currentPartyId, "")
                end

                self.voiceAnalytics:logPartyVoiceStatusChanged(arg1, self.currentPartyId, "")
            end

            if FStringTimeoutLoadingLocalPlayerInBackgroundDM ~= LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable
                and arg1.status == CrossExperience.Constants.VOICE_STATUS.ERROR_BACKGROUND_DM_LOAD_LOCALPLAYER_TIMEOUT
                or arg1.status == CrossExperience.Constants.VOICE_STATUS.ERROR_VOICE_DISCONNECTED
                or Flags.FFlagFireErrorRCCTimeoutSignal and arg1.status == CrossExperience.Constants.VOICE_STATUS.ERROR_RCC_TIMEOUT
            then
                self:leave()
            end
        end)

        self.cevEventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_GAME_JOIN_FAILED, function(arg1)
            self.ExperienceJoinFailed:Fire()
            local num1 = if Players.LocalPlayer then Players.LocalPlayer.UserId else 0
            local var1 = if arg1 and arg1.state then "PARTY_VOICE_GAME_JOIN_FAILED:" .. tostring(arg1.state) else "PARTY_VOICE_GAME_JOIN_FAILED:-1"
            self.voiceAnalytics:logPartyVoiceJoinFailure(self.currentPartyId, var1, num1)
        end)

        if getFFlagEnableCrossExpVoiceMemoryCheck() then
            self.cevEventManager:addObserver(CrossExperience.Constants.EVENTS.PARTY_VOICE_MEMORY_LOW, function()
                self:ignoreMemoryWarning()
                if not self.shouldIgnoreMemoryWarning then
                    self.MemoryLow:Fire()
                    self.shouldIgnoreMemoryWarning = true
                end
            end)
        end
        self.ExperienceJoined:Fire()
        self.hasExperienceStarted = true
    end))

    local connections2 = self.connections
    local onCrossExperienceStopped = ExperienceService.OnCrossExperienceStopped

    table.insert(connections2, onCrossExperienceStopped:Connect(function(_: string, _)
        self:disconnect()
        self.ExperienceLeft:Fire()
        self:resetCEVMemStorage()
    end))

    local connections3 = self.connections
    local robloxEventReceived = NotificationService.RobloxEventReceived

    table.insert(connections3, robloxEventReceived:Connect(function(eventData)
        if eventData.detailType == "SignOut" then
            self:onUserLogout()
        end
    end))

    self.isInitialized = true
end

function module:onUserLogout()
    if self.hasExperienceStarted then
        self:leave()
    end
    if self.isConnected then
        self:disconnect()
        self.ExperienceLeft:Fire()
        self:resetCEVMemStorage()
    end
end

function module:getIsConnected()
    return self.isConnected
end

function module:setAsDisconnected()
    self.isConnected = false
    self.hasExperienceStarted = false
    if self.ExperienceLeft then
        self.ExperienceLeft:Fire()
    end
end

function module:setAsConnected()
    if not self.isInitialized then
        self:initialize()
    end
    self.isConnected = true
    self.hasExperienceStarted = true
    self.ExperienceJoined:Fire()
end

function module:getIsBackgroundDMActive()
    return Promise.new(function(callback, callback2)
        Communication.execute(CrossExperience.Constants.COMMUNICATIONS.EXECUTE_GET_BACKGROUND_DM_STATE, {}, function(arg1)
            callback(arg1.status == BACKGROUND_DM_STATUS.ACTIVE or arg1.status == BACKGROUND_DM_STATUS.BACKGROUND)
        end, function()
            callback2()
        end)
    end)
end

function module.getPartyVoiceDebugStats(_)
    if not Flags.FFlagVoiceDebugConsoleV2 then
        return Promise.resolve({})
    end

    return Promise.new(function(callback, callback2)
        Communication.execute(CrossExperience.Constants.COMMUNICATIONS.EXECUTE_GET_PARTY_VOICE_DEBUG_STATS, {}, function(arg1)
            callback(arg1)
        end, function()
            callback2()
        end)
    end)
end

function module:performJoinFeasibilityCheck()
    if not getFFlagEnableCrossExpVoiceMemoryCheck() then
        return true
    end
    local success, result = pcall(function(): PerformanceControlService
        return game:GetService("PerformanceControlService")
    end)

    if not (success and result) then
        self.JoinFeasibilityCheckPerformed:Fire(false)
        return false
    end

    local success2, result2 = pcall(function()
        return result:IsCrossExperienceLaunchFeasible(CrossExperience.Constants.EXPERIENCE_TYPE_VOICE)
    end)

    if success2 then
        self.JoinFeasibilityCheckPerformed:Fire(result2)
        return result2
    end

    if FFlagFixCrossExperienceVoiceExecutePrint then
        Logger:warning("performJoinFeasibilityCheck() - failed to check feasibility", result2)
    else
        Logger:warn("performJoinFeasibilityCheck() - failed to check feasibility", result2)
    end
    self.JoinFeasibilityCheckPerformed:Fire(false)
    return false
end

function module:ignoreMemoryWarning()
    if not getFFlagEnableCrossExpVoiceMemoryCheck() then
        return
    end

    Communication.execute(CrossExperience.Constants.COMMUNICATIONS.EXECUTE_PARTY_VOICE_IGNORE_LOW_MEMORY, {}, func1, func1)
end

function module:join(tbl1)
    if tbl1.shouldIgnoreMemoryWarning then
        self.shouldIgnoreMemoryWarning = true
    end

    if not self.isInitialized then
        self:initialize()
    end

    local var1 = tonumber(str1)

    if self.isConnected and not tbl1.force then
        if FFlagFixCrossExperienceVoiceExecutePrint then
            Logger:info("CrossExperienceVoiceManager:join() - already connected, returning early.")
        else
            print("CrossExperienceVoiceManager:join() - already connected, returning early.")
        end
        self.JoinRequestSubmitted:Fire(true)
        return
    end

    if game:GetEngineFeature("CEVGetBackgroundState") then
        local var2, var3 = self:getIsBackgroundDMActive():await()
        if var2 and var3 and not tbl1.force then
            self:setAsConnected()
            self.JoinRequestSubmitted:Fire(true)
            return
        end
    end

    self.currentCevJoinAttemptId = HttpService:GenerateGUID(false)

    pcall(function()
        MemStorageService:SetItem(CEV_JOIN_ATTEMPT_ID_KEY, self.currentCevJoinAttemptId)
    end)

    self.voiceAnalytics:logPartyVoiceJoinAttempt({
        isConnected = self.isConnected,
        targetPlaceId = var1,
        partyId = tbl1.partyId,
        userId = if Players.LocalPlayer then Players.LocalPlayer.UserId else 0,
        activeDm = if self.isActiveDM then CrossExperience.Constants.EXPERIENCE_TYPE_LUAAPP else CrossExperience.Constants.EXPERIENCE_TYPE_UGC
    })

    self.JoinRequested:Fire()
    if FIntPartyVoiceJoinRequestPulseCheckTimeout > 0 then
        if self.joinRequestPulseCheckId then
            clearTimeout(self.joinRequestPulseCheckId)
            self.joinRequestPulseCheckId = nil
        end
        self.joinRequestPulseCheckId = setTimeout(function()
            self.JoinRequestPulseCheck:Fire()
        end, FIntPartyVoiceJoinRequestPulseCheckTimeout)
    end

    self.isConnected = true

    if getFFlagJoinCrossExpVoiceWithPartyId() then
        if not (tbl1 and tbl1.partyId) then
            if FFlagFixCrossExperienceVoiceExecutePrint then
                Logger:warning("CrossExperienceVoiceManager:join() - params.partyId is required to join cross experience voice")
            else
                Logger:warn("CrossExperienceVoiceManager:join() - params.partyId is required to join cross experience voice")
            end

            self.isConnected = false
            self.currentPartyId = nil
            self.JoinRequestSubmitted:Fire(self.isConnected)
            return
        end

        self.currentPartyId = tbl1.partyId
        local success, result = pcall(function()
            Logger:info("CrossExperienceVoiceManager:join() - starting cross experience voice with partyId " .. tbl1.partyId)

            ExperienceService:StartCrossExperience(
                CrossExperience.Constants.EXPERIENCE_TYPE_VOICE,
                {
                    partyId = tbl1.partyId,
                    placeId = var1,
                    joinAttemptId = if engineFeature2 then self.currentCevJoinAttemptId else nil
                }
            )
        end)
        if not success then
            if FFlagFixCrossExperienceVoiceExecutePrint then
                Logger:warning("Failed to join cross experience voice with partyId " .. tbl1.partyId, result)
            else
                Logger:warn("Failed to join cross experience voice with partyId " .. tbl1.partyId, result)
            end
            local num1 = if Players.LocalPlayer then Players.LocalPlayer.UserId else 0
            self.voiceAnalytics:logPartyVoiceJoinFailure(tbl1.partyId, result, num1)
            self.currentPartyId = nil
        end
    else
        local success, result = pcall(function()
            Logger:info("CrossExperienceVoiceManager:join() - starting cross experience voice")
            ExperienceService:StartCrossExperience(
                CrossExperience.Constants.EXPERIENCE_TYPE_VOICE,
                {
                    placeId = var1,
                    joinAttemptId = if engineFeature2 then self.currentCevJoinAttemptId else nil
                }
            )
        end)
        if not success then
            if FFlagFixCrossExperienceVoiceExecutePrint then
                Logger:warning("Failed to join cross experience voice: ", result)
            else
                Logger:warn("Failed to join cross experience voice: ", result)
            end
            self.isConnected = false
            self.currentPartyId = nil
        end
    end

    self.JoinRequestSubmitted:Fire(self.isConnected)
end

function module.changeInputDevice(_, deviceName: string, deviceGuid: string)
    Communication.execute(
        CrossExperience.Constants.COMMUNICATIONS.EXECUTE_CHANGE_PARTY_VOICE_INPUT_DEVICE,
        { deviceName = deviceName, deviceGuid = deviceGuid },
        func1,
        func1
    )
end

function module.changeOutputDevice(_, deviceName: string, deviceGuid: string)
    Communication.execute(
        CrossExperience.Constants.COMMUNICATIONS.EXECUTE_CHANGE_PARTY_VOICE_OUTPUT_DEVICE,
        { deviceName = deviceName, deviceGuid = deviceGuid },
        func1,
        func1
    )
end

function module:muteVoiceParticipant(userId: number)
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.MUTE_PARTY_VOICE_PARTICIPANT, { userId = userId })

    self.voiceAnalytics:logPartyVoiceMuteParticipant(self.currentPartyId, userId)
end

function module:unmuteVoiceParticipant(userId: number)
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.UNMUTE_PARTY_VOICE_PARTICIPANT, { userId = userId })

    self.voiceAnalytics:logPartyVoiceUnmuteParticipant(self.currentPartyId, userId)
end

function module:enableVoiceChanger(userId: number)
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.ENABLE_PARTY_VOICE_CHANGER, { userId = userId })
end

function module:disableVoiceChanger(userId: number)
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.DISABLE_PARTY_VOICE_CHANGER, { userId = userId })
end

function module:setVoicePack(voicePackName: string)
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.SET_PARTY_VOICE_PACK, { voicePackName = voicePackName })
end

function module:enableHearMyself(userId: number)
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.ENABLE_PARTY_VOICE_CHANGER_FEEDBACK, { userId = userId })
end

function module:disableHearMyself(userId: number)
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.DISABLE_PARTY_VOICE_CHANGER_FEEDBACK, { userId = userId })
end

function module:blockVoiceParticipant(userId: number)
    if self.isConnected then
        self.cevEventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_BLOCK_PARTICIPANT, { userId = userId })

        self.voiceAnalytics:logPartyVoiceBlockParticipant(self.currentPartyId, userId)
    end
end

function module:unblockVoiceParticipant(userId: number)
    if self.isConnected then
        self.cevEventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_UNBLOCK_PARTICIPANT, { userId = userId })

        self.voiceAnalytics:logPartyVoiceUnblockParticipant(self.currentPartyId, userId)
    end
end

function module:dumpDebugData()
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.DEBUG_COMMAND, { name = "dump_session" })
end

function module:leave()
    ExperienceService:StopCrossExperience(CrossExperience.Constants.EXPERIENCE_TYPE_VOICE, {})

    if self.joinRequestPulseCheckId then
        clearTimeout(self.joinRequestPulseCheckId)
        self.joinRequestPulseCheckId = nil
    end

    self.voiceAnalytics:reset()
end

function module:rejoinVoice()
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_RECONNECT_REQUESTED, {})
end

function module:resetCEVMemStorage()
    self.currentCevJoinAttemptId = nil
    pcall(function()
        MemStorageService:RemoveItem(CEV_JOIN_ATTEMPT_ID_KEY)
    end)
end

function module:disconnect()
    self.isConnected = false
    self.currentPartyId = nil
    self.hasExperienceStarted = false
    self.shouldIgnoreMemoryWarning = false

    Logger:info("Disconnecting, resetting observers")
    self.observersInitialized = false

    if self.joinRequestPulseCheckId then
        clearTimeout(self.joinRequestPulseCheckId)
        self.joinRequestPulseCheckId = nil
    end

    persistenceMiddleware.clean()
end

function module.getAudioFocusService(_)
    if not engineFeature then
        return nil
    end

    local success, result = pcall(function(): AudioFocusService
        return game:GetService("AudioFocusService")
    end)
    return success and result or nil
end

function module.getCurrentAudioContext(arg1)
    local audioFocusService = arg1:getAudioFocusService()
    if audioFocusService == nil then
        return -1
    end

    return audioFocusService:GetFocusedContextId()
end

function module.toggleAudioFocus(arg1)
    local audioFocusService = arg1:getAudioFocusService()
    if audioFocusService == nil then
        return
    end

    local registeredContexts = audioFocusService:GetRegisteredContexts()
    local bool1 = false
    local bool2 = false
    for k, _ in pairs(registeredContexts) do
        if k == AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID then
            bool1 = true
        end

        if k == AUDIO_FOCUS_MANAGEMENT.UGC.CONTEXT_ID then
            bool2 = true
        end
    end

    if not (bool1 and bool2) then
        return
    end

    audioFocusService:AcquireFocus(
        audioFocusService:GetFocusedContextId() == AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID
            and AUDIO_FOCUS_MANAGEMENT.UGC.CONTEXT_ID
            or AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID
    )
end

function module:muteAll(context: string?)
    if not GetFFlagEnableCrossExperienceVoiceCaptureMute() then
        return
    end
    if self.isConnected then
        self.cevEventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_MUTE_ALL, { context = context })
    end
end

function module:unmuteAll(context: string?)
    if not GetFFlagEnableCrossExperienceVoiceCaptureMute() then
        return
    end
    if self.isConnected then
        self.cevEventManager:notify(CrossExperience.Constants.EVENTS.PARTY_VOICE_UNMUTE_ALL, { context = context })
    end
end

function module:signalCevReadinessSync()
    if not game:GetEngineFeature("CevReadinessSync") then
        return
    end
    self.cevEventManager:notify(CrossExperience.Constants.EVENTS.FOREGROUND_UI_READY, {})
end

module.default = module.new()
return module
