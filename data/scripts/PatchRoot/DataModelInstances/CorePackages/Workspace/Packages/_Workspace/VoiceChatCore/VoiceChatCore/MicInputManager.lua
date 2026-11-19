-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:30:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local VoiceChatService = game:GetService("VoiceChatService")
local CoreGui = game:GetService("CoreGui")
local FFlagUseAudioDeviceInputAddedSignal = require(scriptParentParent.SharedFlags).FFlagUseAudioDeviceInputAddedSignal

local Constants = require(script.Parent.Constants)
local Flags = script.Parent.Flags
local Promise = require(scriptParentParent.Promise)
local PermissionsProtocol = require(scriptParentParent.PermissionsProtocol).PermissionsProtocol

local GetFFlagJoinWithoutMicPermissions = require(scriptParentParent.SharedFlags).GetFFlagJoinWithoutMicPermissions
local GetFFlagLocalMutedNilFix = require(scriptParentParent.SharedFlags).GetFFlagLocalMutedNilFix
local GetFFlagDebugVoiceChatMicPermissionCliBypass = require(Flags.GetFFlagDebugVoiceChatMicPermissionCliBypass)
local FFlagExpChatDictation = require(scriptParentParent.SharedFlags).FFlagExpChatDictation
local var1 = require(Flags.GetFFlagUseAudioAnalyzerForLocalMetering2)()
local GetFFlagMicConsumerRegistry = require(Flags.GetFFlagMicConsumerRegistry)
local FFlagMicRegistryIgnoreDefaultVoiceDevice = require(Flags.FFlagMicRegistryIgnoreDefaultVoiceDevice)

local PERMISSION_STATE = Constants.PERMISSION_STATE
local MIN_VOICE_CHAT_API_VERSION_LOCAL_MIC_ACTIVITY = Constants.MIN_VOICE_CHAT_API_VERSION_LOCAL_MIC_ACTIVITY

local module = {}
module.__index = module

function module.new(tbl1)
    local self = setmetatable({}, module)

    self.log = tbl1.log
    self.callbacks = tbl1.callbacks

    self.localMuted = nil
    self.isTalking = false
    self.permissionState = if GetFFlagJoinWithoutMicPermissions() then PERMISSION_STATE.IDLE else nil
    self.muteChanged = Instance.new("BindableEvent")
    self.talkingChanged = Instance.new("BindableEvent")

    self.permissionPromise = nil
    self.isPlayerWatchingAd = false
    self._connections = {}
    self.localMeteringTask = nil

    if GetFFlagMicConsumerRegistry() then
        self._consumers = {}
        self._consumerCount = 0
        self.hasConsumersChanged = Instance.new("BindableEvent")
        self._activeConsumerType = nil
        self._levelDetectionTask = nil
        self._hasShownPrivacyToast = false
        self._hasShownPermDeniedToast = false
        self._micIndicatorReady = false
        self._developerDeviceConnections = {}
        self._developerAudioInstancesFolder = nil
        self.levelChanged = Instance.new("BindableEvent")
        self._lastLevel = 0
    end

    return self
end

local function isIgnoredAudioInput(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    return arg1:IsDescendantOf(CoreGui)
end

local function isLocalDefaultVoiceDevice(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer

    return not (localPlayer == nil or VoiceChatService.EnableDefaultVoice ~= true)
        and localPlayer:FindFirstChildOfClass("AudioDeviceInput") == arg1
end

function module:SetMicActive(bool1: boolean, context: string?)
    if self.localMuted == nil then
        self.log:trace("SetMicActive context: {} - Voice not connected yet", context)
        return
    end

    if self.localMuted == not bool1 then
        return
    end

    self.log:trace("SetMicActive active: {} context: {}", bool1, context)

    if GetFFlagJoinWithoutMicPermissions() then
        if self.permissionState == PERMISSION_STATE.PENDING_MIC then
            self.log:debug("In pending mic mode, requesting permission")
            self.callbacks.emitGetPermissions(function(arg1)
                local tbl1 = self
                tbl1.permissionState = if arg1.hasMicPermissions then PERMISSION_STATE.LISTEN_AND_TALK else PERMISSION_STATE.LISTEN_ONLY

                self.log:debug("Got permissions, setting state to {}", self.permissionState)
                self:SetMicActive(bool1, context)
            end, { PermissionsProtocol.Permissions.MICROPHONE_ACCESS }, false)
            return
        end

        if self.permissionState == PERMISSION_STATE.LISTEN_ONLY then
            self.log:debug("User tried to unmute despite being in listen only mode")
            self.callbacks.emitOnPermissionRequested()
            return
        end
    end

    if self.isPlayerWatchingAd then
        self.log:trace("User is watching an ad, skipping mic state change")
        return
    end

    if VoiceChatService.UseNewAudioApi then
        self.localMuted = not bool1
        self.log:trace("Setting self mute to {} context: {}", bool1, context)
        local sendMuteEvent = self.callbacks.getSendMuteEvent()
        if sendMuteEvent then
            sendMuteEvent:FireServer(bool1)
            local active = bool1 and (not GetFFlagMicConsumerRegistry() or self._micIndicatorReady)
            for value in self.callbacks.getAudioDevices() do
                if value.Player and value.Player == Players.LocalPlayer then
                    value.Active = active
                end
            end
            if GetFFlagMicConsumerRegistry() then
                for _, _consumer in self._consumers do
                    if _consumer.device and _consumer.consumerType ~= "VoiceChat" then
                        _consumer.device.Active = active
                    end
                end
            end
            self.muteChanged:Fire(self.localMuted)
        else
            self.log:error("Could not find SendMuteEvent")
        end
    else
        local service = self.callbacks.getService()
        self.log:trace("Setting self mute to {} context: {}", not bool1, context)

        service:PublishPause(not bool1)
        self.localMuted = not bool1
        self.muteChanged:Fire(self.localMuted)
    end

    if self.localMuted then
        if GetFFlagMicConsumerRegistry() and self._lastLevel ~= 0 then
            self._lastLevel = 0
            self.levelChanged:Fire(0)
        end
    else
        self.talkingChanged:Fire(self.isTalking)
        self.callbacks.emitOnShowDataConsentToast()
    end

    if context then
        self.callbacks.reportVoiceMuteSelf(
            self.callbacks.getJoinWithVoiceMuteData({ context = context, muted = self.localMuted })
        )
    end

    self:_assertDeviceStateConsistency()
end

function module:SetLocalMuted(localMuted: boolean?)
    self.localMuted = localMuted
end

function module:SyncLocalAudioDeviceActive()
    if not VoiceChatService.UseNewAudioApi then
        return
    end

    local active = self.localMuted == false and (not GetFFlagMicConsumerRegistry() or self._micIndicatorReady)

    for value in self.callbacks.getAudioDevices() do
        if value.Player and value.Player == Players.LocalPlayer then
            value.Active = active
        end
    end
    self:_assertDeviceStateConsistency()
end

function module:SetupEarlyAudioDeviceGuard()
    local function shouldDeactivate(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        local bool1 = VoiceChatService.UseNewAudioApi and not (FFlagExpChatDictation and isIgnoredAudioInput(arg1))
        return bool1 and arg1.Player == Players.LocalPlayer and arg1.Active and self.localMuted == nil
    end

    local function guardDevice(arg1)
        if shouldDeactivate(arg1) then
            arg1.Active = false
        end

        local connection = arg1:GetPropertyChangedSignal("Player"):Connect(function()
            if shouldDeactivate(arg1) then
                arg1.Active = false
            end
        end)
        table.insert(self._connections, connection)

        local connection2 = arg1:GetPropertyChangedSignal("Active"):Connect(function()
            if shouldDeactivate(arg1) then
                arg1.Active = false
            end
        end)
        table.insert(self._connections, connection2)
    end

    local connection = if FFlagUseAudioDeviceInputAddedSignal then SoundService.AudioDeviceInputAdded:Connect(function(audioDeviceInput: AudioDeviceInput)
        guardDevice(audioDeviceInput)
    end) else SoundService.AudioInstanceAdded:Connect(function(instance: Instance)
        if instance:IsA("AudioDeviceInput") then
            guardDevice(instance)
        end
    end)

    table.insert(self._connections, connection)

    for _, descendant in game:GetDescendants() do
        if descendant:IsA("AudioDeviceInput") then
            guardDevice(descendant)
        end
    end
end

function module:SetAndSyncActive(arg1, active: boolean)
    arg1.Active = active
    local sendMuteEvent = self.callbacks.getSendMuteEvent()
    if sendMuteEvent and arg1.Player == Players.LocalPlayer then
        sendMuteEvent:FireServer(active)
    end
end

function module:RequestMicPermission()
    if GetFFlagDebugVoiceChatMicPermissionCliBypass() then
        self.permissionState = PERMISSION_STATE.LISTEN_AND_TALK
        return Promise.resolve()
    end
    if self.permissionPromise then
        self.log:trace("PermissionProtocol already invoked")
        return self.permissionPromise
    end
    local tbl1 = { PermissionsProtocol.Permissions.MICROPHONE_ACCESS }

    self.permissionPromise = self.callbacks.requestPermissions(tbl1):andThen(function(arg1)
        self.callbacks.recordExperienceJoinMicPerm(arg1)
        if not (arg1 or arg1.status) then
            self.log:debug("No permission response, rejecting access")
            self.callbacks.reportJoinFailed("noPermissionResponse", nil)
            if self.callbacks.getPassInitErrorInPromiseReject() then
                return Promise.reject({ code = "INIT_ERROR_NO_PERM_RESPONSE" })
            end
            return Promise.reject()
        end
        self.log:debug("Permission status {}", arg1.status)

        local bool1 = arg1.status == PermissionsProtocol.Status.AUTHORIZED
        if self.callbacks.getPassInitErrorInPromiseReject() and not bool1 then
            return Promise.reject({ code = "INIT_ERROR_PERM_NOT_GRANTED" })
        end
        return bool1 and Promise.resolve() or Promise.reject()
    end):andThen(function()
        self.callbacks.emitOnRequestMicPermissionResolved()
        return Promise.resolve()
    end):catch(function()
        self.callbacks.emitOnRequestMicPermissionRejected()
        if self.callbacks.getPassInitErrorInPromiseReject() then
            return Promise.reject({ code = "INIT_ERROR_MIC_PERM_REJECTED" })
        end
        return Promise.reject()
    end)
    return self.permissionPromise
end

function module:UpdateLocalMetering()
    self.isTalking = self.callbacks.isSignalActive(Players.LocalPlayer.UserId)
    if self.localMuted == false then
        self.talkingChanged:Fire(self.isTalking)
    end
end

function module:SetupMicActivityListener(arg1)
    if var1 and VoiceChatService.UseNewAudioApi then
        if not self.localMeteringTask then
            self.localMeteringTask = task.spawn(function()
                while true do
                    self:UpdateLocalMetering()
                    task.wait()
                end
            end)
        end

        return
    end

    if not (arg1:GetVoiceChatApiVersion() >= MIN_VOICE_CHAT_API_VERSION_LOCAL_MIC_ACTIVITY) then
        return
    end

    local connection = arg1.PlayerMicActivitySignalChange:Connect(function(arg2)
        self.callbacks.onVoiceCapturedDuringVideoCapture(arg2.isActive)
        self.isTalking = arg2.isActive
        if GetFFlagLocalMutedNilFix() then
            if self.localMuted == false then
                self.talkingChanged:Fire(self.isTalking)
            end
        elseif not self.localMuted then
            self.talkingChanged:Fire(self.isTalking)
        end
    end)

    table.insert(self._connections, connection)
end

function module:SetAdMuteBlocked(isPlayerWatchingAd: boolean)
    self.isPlayerWatchingAd = isPlayerWatchingAd
end

function module:RegisterConsumer(tbl1): boolean
    if not GetFFlagMicConsumerRegistry() then
        return false
    end

    if self._consumers[tbl1.id] then
        self.log:trace("Consumer already registered: {}", tbl1.id)
        return true
    end

    local bool1 = tbl1.consumerType == "VoiceChat"
    if self.permissionState == PERMISSION_STATE.LISTEN_ONLY and bool1 then
        self.log:debug("RegisterConsumer rejected for {}: voice chat permission denied", tbl1.id)
        if not self._hasShownPermDeniedToast and self.callbacks.emitOnMicPermissionDeniedToast then
            self._hasShownPermDeniedToast = true
            self.callbacks.emitOnMicPermissionDeniedToast()
        end
        return false
    end

    local bool2

    if bool1 and tbl1.device then
        local str1 = "dev_" .. tostring(tbl1.device:GetDebugId())
        bool2 = self._consumers[str1] ~= nil
        if bool2 then
            self:UnregisterConsumer(str1, true)
        end
    else
        bool2 = false
    end

    self._consumers[tbl1.id] = tbl1
    local _consumerCount = self._consumerCount
    self._consumerCount += 1

    self:_updateActiveConsumerType()

    if _consumerCount == 0 and not bool2 then
        self._micIndicatorReady = false
    end
    self.hasConsumersChanged:Fire(self._consumerCount)

    if tbl1.device then
        local _micIndicatorReady = self.localMuted == false and self._micIndicatorReady

        if tbl1.device.Active ~= _micIndicatorReady then
            tbl1.device.Active = _micIndicatorReady
        end
    end

    self.log:trace("Consumer registered: {} type={} count={}", tbl1.id, tbl1.consumerType, self._consumerCount)
    self:_assertDeviceStateConsistency()
    return true
end

function module:UnregisterConsumer(str1: string, bool1: boolean?)
    if not GetFFlagMicConsumerRegistry() then
        return
    end

    local _consumer = self._consumers[str1]
    if not _consumer then
        return
    end

    if _consumer.wire then
        _consumer.wire:Destroy()
    end
    if _consumer.analyzer then
        _consumer.analyzer:Destroy()
    end

    if _consumer.device and _consumer.device.Active then
        _consumer.device.Active = false
    end

    self._consumers[str1] = nil
    self._consumerCount -= 1

    self:_updateActiveConsumerType()

    if self._consumerCount == 0 and not bool1 then
        self.localMuted = nil
        self._micIndicatorReady = false
        self:_stopLevelDetectionTask()
    end
    if not bool1 then
        self.hasConsumersChanged:Fire(self._consumerCount)
    end

    self.log:trace("Consumer unregistered: {} count={}", str1, self._consumerCount)
end

function module:SetMicIndicatorReady(_micIndicatorReady: boolean)
    if not GetFFlagMicConsumerRegistry() or self._micIndicatorReady == _micIndicatorReady then
        return
    end

    self._micIndicatorReady = _micIndicatorReady
    local active = _micIndicatorReady and self.localMuted == false
    for _, _consumer in self._consumers do
        if _consumer.device and _consumer.device.Active ~= active then
            _consumer.device.Active = active
        end
    end

    self:_assertDeviceStateConsistency()
end

function module:GetConsumerCount()
    return if GetFFlagMicConsumerRegistry() then self._consumerCount else 0
end

function module:HasConsumer(str1: string): boolean
    return if GetFFlagMicConsumerRegistry() then self._consumers[str1] ~= nil else false
end

function module:GetActiveConsumerType()
    return if GetFFlagMicConsumerRegistry() then self._activeConsumerType else nil
end

function module:_updateActiveConsumerType()
    self._activeConsumerType = nil
    for _, _consumer in self._consumers do
        if _consumer.consumerType == "VoiceChat" then
            self._activeConsumerType = "VoiceChat"
            self:_stopLevelDetectionTask()
            return
        end
        if self._activeConsumerType == nil then
            self._activeConsumerType = _consumer.consumerType
        end
    end

    if self._activeConsumerType and self._activeConsumerType ~= "VoiceChat" then
        self:_startLevelDetectionTask()
    end
end

function module:_startLevelDetectionTask()
    if self._levelDetectionTask then
        return
    end
    self._levelDetectionTask = task.spawn(function()
        while true do
            self:_updateCustomLevelDetection()
            task.wait()
        end
    end)
end

function module:_stopLevelDetectionTask()
    if self._levelDetectionTask then
        task.cancel(self._levelDetectionTask)
        self._levelDetectionTask = nil
    end
end

function module:_updateCustomLevelDetection()
    if self.localMuted ~= false then
        return
    end

    local num1 = 0
    for _, _consumer in self._consumers do
        if not _consumer.analyzer then
            continue
        end

        local peakLevel = _consumer.analyzer.PeakLevel
        if not (peakLevel > 0) then
            continue
        end

        local num2 = math.log10(peakLevel) * 20
        if not (num2 > -36) then
            continue
        end

        local num3 = math.clamp((num2 - -36) / 36, 0, 1)
        if num1 < num3 then
            num1 = num3
        end
    end

    local _lastLevel = math.clamp(math.floor(num1 * 100 / 20 + 0.5) * 20, 0, 100)

    self.isTalking = _lastLevel > 0
    self.talkingChanged:Fire(self.isTalking)

    if GetFFlagMicConsumerRegistry() and _lastLevel ~= self._lastLevel then
        self._lastLevel = _lastLevel
        self.levelChanged:Fire(_lastLevel)
    end
end

function module:_isVoiceChatDevice(device)
    for _, _consumer in self._consumers do
        if _consumer.consumerType ~= "VoiceChat" then
            continue
        end

        if _consumer.device == device then
            return true
        end
        if _consumer.device == nil and device.Player == Players.LocalPlayer then
            _consumer.device = device
            device.Active = self.localMuted == false and self._micIndicatorReady
            return true
        end
    end

    return false
end

function module:_isDeveloperDevice(arg1): boolean
    return not isIgnoredAudioInput(arg1)
        and not self:_isVoiceChatDevice(arg1)
        and not (FFlagMicRegistryIgnoreDefaultVoiceDevice and isLocalDefaultVoiceDevice(arg1))
        and arg1.Player == Players.LocalPlayer
end

function module:_getDeveloperAudioInstancesFolder()
    if self._developerAudioInstancesFolder then
        return self._developerAudioInstancesFolder
    end

    local micConsumerRegistry = Instance.new("Folder")
    micConsumerRegistry.Name = "MicConsumerRegistry"
    micConsumerRegistry.Parent = CoreGui
    self._developerAudioInstancesFolder = micConsumerRegistry
    return micConsumerRegistry
end

function module:_registerDeveloperDevice(arg1)
    local id = "dev_" .. tostring(arg1:GetDebugId())

    if self._consumers[id] then
        return
    end

    local var2 = self:_getDeveloperAudioInstancesFolder()
    local audioAnalyzer = Instance.new("AudioAnalyzer")
    audioAnalyzer.Parent = var2

    local wire = Instance.new("Wire")
    wire.SourceInstance = arg1
    wire.TargetInstance = audioAnalyzer
    wire.Parent = var2

    if not self:RegisterConsumer(
        {
            id = id,
            consumerType = "DeveloperAudioDevice",
            device = arg1,
            analyzer = audioAnalyzer,
            wire = wire
        }
    ) then
        wire:Destroy()
        audioAnalyzer:Destroy()
    end
end

function module:_unregisterDeveloperDevice(arg1)
    self:UnregisterConsumer("dev_" .. tostring(arg1:GetDebugId()))
end

function module:SetupDeveloperDeviceTracking()
    if not GetFFlagMicConsumerRegistry() then
        return
    end

    local function onDeviceAdded(arg1)
        if self._developerDeviceConnections[arg1] or isIgnoredAudioInput(arg1) then
            return
        end

        if self:_isDeveloperDevice(arg1) then
            self:_registerDeveloperDevice(arg1)
        end

        local tbl1 = {}

        table.insert(tbl1, (arg1:GetPropertyChangedSignal("Player"):Connect(function()
            if self:_isDeveloperDevice(arg1) then
                self:_registerDeveloperDevice(arg1)
                return
            end
            self:_unregisterDeveloperDevice(arg1)
        end)))
        table.insert(tbl1, (arg1.AncestryChanged:Connect(function(_: Instance, parent: Instance)
            if parent == nil then
                self:_unregisterDeveloperDevice(arg1)
                local _developerDeviceConnection = self._developerDeviceConnections[arg1]
                if _developerDeviceConnection then
                    for _, value in _developerDeviceConnection do
                        value:Disconnect()
                    end
                    self._developerDeviceConnections[arg1] = nil
                end
            elseif FFlagMicRegistryIgnoreDefaultVoiceDevice then
                if self:_isDeveloperDevice(arg1) then
                    self:_registerDeveloperDevice(arg1)
                    return
                end
                self:_unregisterDeveloperDevice(arg1)
            end
        end)))

        self._developerDeviceConnections[arg1] = tbl1
    end

    local connection = if FFlagUseAudioDeviceInputAddedSignal then SoundService.AudioDeviceInputAdded:Connect(function(audioDeviceInput: AudioDeviceInput)
        onDeviceAdded(audioDeviceInput)
    end) else SoundService.AudioInstanceAdded:Connect(function(instance: Instance)
        if instance:IsA("AudioDeviceInput") then
            onDeviceAdded(instance)
        end
    end)

    table.insert(self._connections, connection)

    for _, descendant in game:GetDescendants() do
        if descendant:IsA("AudioDeviceInput") then
            onDeviceAdded(descendant)
        end
    end
end

function module:SetMicActiveForAllConsumers(bool1: boolean, str1: string?)
    if not GetFFlagMicConsumerRegistry() then
        return
    end

    if bool1 then
        if self.isPlayerWatchingAd then
            self.log:trace("SetMicActiveForAllConsumers: blocked by ad-mute")
            return
        end

        if GetFFlagJoinWithoutMicPermissions() then
            if self.permissionState == PERMISSION_STATE.LISTEN_ONLY then
                self.log:debug("SetMicActiveForAllConsumers: permission denied")
                if not self._hasShownPermDeniedToast and self.callbacks.emitOnMicPermissionDeniedToast then
                    self._hasShownPermDeniedToast = true
                    self.callbacks.emitOnMicPermissionDeniedToast()
                end
                return
            end

            if self.permissionState == PERMISSION_STATE.PENDING_MIC then
                self.log:debug("SetMicActiveForAllConsumers: requesting permission")
                self.callbacks.emitGetPermissions(function(arg1)
                    local tbl1 = self
                    tbl1.permissionState = if arg1.hasMicPermissions then PERMISSION_STATE.LISTEN_AND_TALK else PERMISSION_STATE.LISTEN_ONLY

                    self:SetMicActiveForAllConsumers(bool1, str1)
                end, { PermissionsProtocol.Permissions.MICROPHONE_ACCESS }, false)

                return
            end
        end
    end

    local _micIndicatorReady = bool1 and self._micIndicatorReady
    for _, _consumer in self._consumers do
        if _consumer.device then
            _consumer.device.Active = _micIndicatorReady
        end
    end

    self.localMuted = not bool1
    self.muteChanged:Fire(self.localMuted)

    if bool1 and not self._hasShownPrivacyToast then
        local bool2 = false
        for _, _consumer in self._consumers do
            if _consumer.consumerType == "VoiceChat" then
                bool2 = true
                break
            end
        end

        if not bool2 and self.callbacks.emitOnMicFirstUnmutePrivacy then
            self._hasShownPrivacyToast = true
            self.callbacks.emitOnMicFirstUnmutePrivacy()
        end
    end

    if bool1 then
        self.talkingChanged:Fire(self.isTalking)
        self.callbacks.emitOnShowDataConsentToast()
    elseif self._lastLevel ~= 0 then
        self._lastLevel = 0
        self.levelChanged:Fire(0)
    end

    self:_assertDeviceStateConsistency()
end

function module:Disconnect()
    for _, _connection in self._connections do
        _connection:Disconnect()
    end
    self._connections = {}
    if self.localMeteringTask then
        task.cancel(self.localMeteringTask)
        self.localMeteringTask = nil
    end

    if not GetFFlagMicConsumerRegistry() then
        return
    end

    self:_stopLevelDetectionTask()
    for _, _developerDeviceConnection in self._developerDeviceConnections do
        for _, value in _developerDeviceConnection do
            value:Disconnect()
        end
    end
    self._developerDeviceConnections = {}
    for _, _consumer in self._consumers do
        if _consumer.wire then
            _consumer.wire:Destroy()
        end
        if _consumer.analyzer then
            _consumer.analyzer:Destroy()
        end
    end
    self._consumers = {}
    self._consumerCount = 0
    if self._developerAudioInstancesFolder then
        self._developerAudioInstancesFolder:Destroy()
        self._developerAudioInstancesFolder = nil
    end
end

function module:_assertDeviceStateConsistency()
    local var2 = self.localMuted == false and (not GetFFlagMicConsumerRegistry() or self._micIndicatorReady)

    for value in self.callbacks.getAudioDevices() do
        if value.Player and value.Player == Players.LocalPlayer and value.Active ~= var2 then
            self.log:warning(
                "MicManager consistency: device.Active={} expected={} localMuted={}",
                value.Active,
                var2,
                self.localMuted
            )
        end
    end

    if not GetFFlagMicConsumerRegistry() then
        return
    end

    for _, _consumer in self._consumers do
        if _consumer.device and _consumer.device.Active ~= var2 then
            self.log:warning(
                "MicManager consistency (consumer {}): device.Active={} expected={} localMuted={}",
                _consumer.id,
                _consumer.device.Active,
                var2,
                self.localMuted
            )
        end
    end

    if self._consumerCount == 0 and self.localMuted ~= nil then
        self.log:warning("MicManager consistency: no consumers but localMuted={}", self.localMuted)
    end
end

return module
