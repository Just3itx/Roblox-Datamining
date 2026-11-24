-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local dependencies = require(CrossExperienceVoice.dependencies)
local Players = game:GetService("Players")

local Analytics = require(CrossExperienceVoice.Analytics)
local Flags = require(CrossExperienceVoice.Flags)
local LoggingProtocol = dependencies.LoggingProtocol

local CrossExperience = dependencies.CrossExperience
local getMemStorageKey = CrossExperience.Utils.getMemStorageKey

local module = {}
module.__index = module

local CEV_JOIN_ATTEMPT_ID_KEY = CrossExperience.Constants.CEV_JOIN_ATTEMPT_ID_KEY

function module.new()
    local tbl1 = {
        previousStatus = nil,
        connections = {},
        isInitialized = false,
        eventManager = nil,
        analytics = Analytics.Analytics()
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:initialize(eventManager)
    self.eventManager = eventManager
    self.isInitialized = true
end

function module:fireCEVAnalyticsEvent(str1: string, arg1)
    local var1 = arg1 or {}
    var1.cevJoinAttemptId = getMemStorageKey(CEV_JOIN_ATTEMPT_ID_KEY)
    var1.clientTimeStamp = os.time()
    self.analytics.fireAnalyticsEvent(str1, var1)
end

function module:logPartyVoiceTimeout(partyId: string?)
    if not self.isInitialized then
        return
    end

    self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceStateChanged, {
        partyId = partyId or "",
        status = CrossExperience.Constants.VOICE_STATUS.ERROR_RCC_TIMEOUT,
        previousStatus = self.previousStatus or "",
        userId = if Players.LocalPlayer then Players.LocalPlayer.UserId else 0
    })
end

function module:logPartyVoiceStatusChanged(arg1, partyId: string?, activeDm: string?)
    if not self.isInitialized then
        return
    end

    if self.previousStatus ~= arg1.status then
        if Flags.FFlagEnablePartyVoiceStatusChangedDetailAnalytics then
            if Flags.FFlagPartyVoiceLogActiveDM then
                self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceStateChanged, {
                    partyId = partyId or "",
                    status = arg1.status,
                    detail = arg1.detail or "",
                    previousStatus = self.previousStatus or "",
                    voiceChannelId = arg1.voiceChannelId,
                    voiceSessionId = arg1.voiceSessionId,
                    userId = arg1.userId,
                    activeDm = activeDm or ""
                })
            else
                self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceStateChanged, {
                    partyId = partyId or "",
                    status = arg1.status,
                    detail = arg1.detail or "",
                    previousStatus = self.previousStatus or "",
                    voiceChannelId = arg1.voiceChannelId,
                    voiceSessionId = arg1.voiceSessionId,
                    userId = arg1.userId,
                    activeDm = ""
                })
            end
        else
            self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceStateChanged, {
                partyId = partyId or "",
                status = arg1.status,
                previousStatus = self.previousStatus or "",
                voiceChannelId = arg1.voiceChannelId,
                voiceSessionId = arg1.voiceSessionId,
                userId = arg1.userId
            })
        end
    end

    self.previousStatus = arg1.status
end

function module:logPartyVoiceConnectedState(arg1, partyId: string?, activeDm: string?)
    if not self.isInitialized then
        return
    end

    if Flags.FFlagPartyVoiceLogActiveDM then
        self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceConnectedParticipantsOnJoin, {
            userId = if arg1.userId then arg1.userId else 0,
            partyId = partyId or "",
            status = if arg1.status then arg1.status else "",
            voiceChannelId = if arg1.voiceChannelId then arg1.voiceChannelId else "",
            voiceSessionId = if arg1.voiceSessionId then arg1.voiceSessionId else "",
            voicePlaySessionId = if arg1.voicePlaySessionId then arg1.voicePlaySessionId else "",
            participants = if arg1.participants then arg1.participants else "",
            numberActive = arg1.numberActive or 0,
            activeDm = activeDm or ""
        })
    else
        self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceConnectedParticipantsOnJoin, {
            userId = if arg1.userId then arg1.userId else 0,
            partyId = partyId or "",
            status = if arg1.status then arg1.status else "",
            voiceChannelId = if arg1.voiceChannelId then arg1.voiceChannelId else "",
            voiceSessionId = if arg1.voiceSessionId then arg1.voiceSessionId else "",
            voicePlaySessionId = if arg1.voicePlaySessionId then arg1.voicePlaySessionId else "",
            participants = if arg1.participants then arg1.participants else "",
            numberActive = arg1.numberActive or 0,
            activeDm = ""
        })
    end

    self:logLaunchFlowEndEvent()
end

function module:logPartyVoiceJoinAttempt(arg1)
    if not self.isInitialized then
        return
    end
    if Flags.FFlagPartyVoiceLogActiveDM then
        local partyVoiceJoinAttempt = Analytics.EventNames.PartyVoiceJoinAttempt
        local tbl1 = {
            userId = if arg1.userId then arg1.userId else 0,
            partyId = if arg1.partyId then arg1.partyId else "",
            targetPlaceId = if arg1.targetPlaceId then arg1.targetPlaceId else 0,
            isConnected = if arg1.isConnected then arg1.isConnected else false,
            activeDm = if arg1.activeDm then arg1.activeDm else ""
        }
        self:fireCEVAnalyticsEvent(partyVoiceJoinAttempt, tbl1)
    else
        local partyVoiceJoinAttempt = Analytics.EventNames.PartyVoiceJoinAttempt
        local tbl1 = {
            userId = if arg1.userId then arg1.userId else 0,
            partyId = if arg1.partyId then arg1.partyId else "",
            targetPlaceId = if arg1.targetPlaceId then arg1.targetPlaceId else 0,
            isConnected = if arg1.isConnected then arg1.isConnected else false,
            activeDm = ""
        }
        self:fireCEVAnalyticsEvent(partyVoiceJoinAttempt, tbl1)
    end

    self:logLaunchFlowBeginEvent()
end

function module:logLaunchFlowBeginEvent()
    LoggingProtocol.default:logEvent("party_voice_launch_flow_begin")
end

function module:logLaunchFlowEndEvent()
    LoggingProtocol.default:logEvent("party_voice_launch_flow_end")
end

function module:logPartyVoiceJoinFailure(partyId: string, errorMessage: string?, userId: number?)
    if not self.isInitialized then
        return
    end

    self:fireCEVAnalyticsEvent(
        Analytics.EventNames.PartyVoiceJoinFailure,
        {
            partyId = partyId,
            errorMessage = errorMessage or "",
            userId = userId or 0
        }
    )
end

function module:logPartyVoiceUnmuteParticipant(partyId: string, userId: number)
    if not self.isInitialized then
        return
    end

    self:fireCEVAnalyticsEvent(
        Analytics.EventNames.PartyVoiceUnmuteParticipant,
        {
            partyId = partyId,
            userId = userId or 0
        }
    )
end

function module:logPartyVoiceMuteParticipant(partyId: string, userId: number)
    if not self.isInitialized then
        return
    end

    self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceMuteParticipant, { partyId = partyId, userId = userId or 0 })
end

function module:logPartyVoiceBlockParticipant(partyId: string, userId: number)
    if not self.isInitialized then
        return
    end

    self:fireCEVAnalyticsEvent(Analytics.EventNames.PartyVoiceBlockParticipant, { partyId = partyId, userId = userId or 0 })
end

function module:logPartyVoiceUnblockParticipant(partyId: string, userId: number)
    if not self.isInitialized then
        return
    end

    self:fireCEVAnalyticsEvent(
        Analytics.EventNames.PartyVoiceUnblockParticipant,
        {
            partyId = partyId,
            userId = userId or 0
        }
    )
end

function module:logPartyVoiceOnCrossExperienceStartedSignalReceived(hasExperienceStarted: boolean, isActiveDm: boolean)
    if not self.isInitialized then
        return
    end
    self:fireCEVAnalyticsEvent(
        Analytics.EventNames.PartyVoiceOnCrossExperienceStartedSignalReceived,
        { hasExperienceStarted = hasExperienceStarted, isActiveDM = isActiveDm }
    )
end

function module:logPartyVoiceStateChangeHandlerRun(isActiveDm: boolean, arg1)
    if not self.isInitialized then
        return
    end
    self:fireCEVAnalyticsEvent(
        Analytics.EventNames.PartyVoiceStateChangeHandlerRun,
        {
            isActiveDM = isActiveDm,
            status = arg1.status,
            detail = arg1.detail or ""
        }
    )
end

function module:reset()
    self.previousStatus = nil
end

module.default = module.new()
return module
