-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local CrossExperience = script:FindFirstAncestor("CrossExperience")
local dependencies = require(CrossExperience.dependencies)

local _Types = require(CrossExperience.Types)
local Communication = require(CrossExperience.Communication)
local Constants = require(CrossExperience.Constants)
local Actions = require(CrossExperience.Actions)
local Models = require(CrossExperience.Models)
local Utils = require(CrossExperience.Utils)
local EventQueue = require(CrossExperience.Utils.EventQueue)

local createPersistenceMiddleware = require(CrossExperience.Middlewares.createPersistenceMiddleware)

local bool1 = game:DefineFastFlag("EnableCrossExpEventLogging", false)

local SharedFlags = dependencies.SharedFlags
local FFlagPartyVoiceBlockSync = SharedFlags.FFlagPartyVoiceBlockSync
local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua

local Cryo = dependencies.Cryo

local num1 = 0
local _origin = HttpService:GenerateGUID(false)

local module = {}
module.__index = module

function module.new(experienceType, bool2: boolean)
    local tbl1 = {
        observers = {},
        experienceType = experienceType,
        isSubscribed = false,
        eventQueue = EventQueue.new(bool2)
    }
    setmetatable(tbl1, module)
    return tbl1
end

local function func1(arg1) -- Luacid: Inlined by compiler; 11 call sites recovered
    return {
        userId = tonumber(arg1.userId) or -1,
        isLocalUser = arg1.isLocalUser
    }
end

function module.notify(_, arg1, arg2)
    arg2 = arg2 or {}

    num1 += 1
    arg2._seq = num1
    arg2._origin = _origin
    Communication.notify(arg1, arg2)
end

function module:removeObserver(str2: string, arg1)
    Communication.removeObserver(self.experienceType, arg1, str2)
end

function module:addObserver(event, func2: (...any) -> (...any))
    local id = Communication.addObserver(self.experienceType, event, function(arg1)
        self.eventQueue:process(event, arg1, func2)
    end)
    table.insert(self.observers, { id = id, event = event })
end

local persistenceMiddleware = createPersistenceMiddleware({ storeKey = Constants.STORAGE_CEV_STORE_KEY })

function module:subscribe(arg1, arg2)
    if self.isSubscribed then
        return
    end

    self.isSubscribed = true

    if arg2 and bool1 then
        arg2:info("{}: Subscribing to the CEV Store", self.experienceType)
    end

    self:addObserver(Constants.EVENTS.PARTY_VOICE_GAME_JOIN_FAILED, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Experience Party Voice Game Join Failed: {}", self.experienceType, arg3.state)
        end

        arg1:dispatch(Actions.VoiceStatusChanged({ status = Constants.VOICE_STATUS.ERROR_RCC_CONNECTING }))
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_STATUS_CHANGED, function(arg3)
        if arg2 and bool1 then
            arg2:info(
                "{}: Experience Voice Status Changed: {}, {}, {}, {}",
                self.experienceType,
                arg3.status,
                arg3.detail,
                arg3.voiceChannelId,
                arg3.voiceSessionId
            )
        end

        if arg3.status == Constants.VOICE_STATUS.VOICE_CONNECTED then
            if not arg3.voiceChannelId and arg2 then
                arg2:warning("Voice channel id is expected")
            end
            if not arg3.voiceSessionId then
                arg2:warning("Voice session id is expected")
            end
        end

        arg1:dispatch(
            Actions.VoiceStatusChanged(
                {
                    status = arg3.status,
                    voiceChannelId = arg3.voiceChannelId,
                    voiceSessionId = arg3.voiceSessionId
                }
            )
        )
    end)
    self:addObserver(Constants.EVENTS.PARTY_VOICE_EXPERIENCE_JOINED, function(arg3)
        if arg2 and bool1 then
            arg2:info(
                "{}: Experience joined JobID: {}, GameID: {}, PlaceId: {}",
                self.experienceType,
                arg3.jobId,
                arg3.gameId,
                arg3.placeId
            )
        end

        local backgroundStateSnapshot = self:getBackgroundStateSnapshot()

        if backgroundStateSnapshot and backgroundStateSnapshot.Participants then
            arg3 = Cryo.Dictionary.join(arg3, backgroundStateSnapshot.Participants)
        end
        arg1:dispatch(Actions.ExperienceJoined(arg3))
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_PARTICIPANT_AUDIO_FOCUS_CHANGED, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant Audio Focus Changed {} = {}", self.experienceType, arg3.userId, arg3.contextId)
        end

        arg1:dispatch(
            Actions.ParticipantAudioFocusChanged({ userId = arg3.userId, contextId = arg3.contextId, contextIds = arg3.contextIds })
        )
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_PARTICIPANT_ADDED, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant added {}", self.experienceType, arg3.userId)
        end
        local var1 = Models.ParticipantModel.format({
            userId = arg3.userId,
            isLocalUser = arg3.isLocalUser,
            username = arg3.username,
            displayname = arg3.displayname,
            isActive = false,
            isMuted = false,
            isMutedLocally = false,
            isVoiceChangerActive = not FFlagEnablePartyVoiceChangersInLua and nil,
            isVoiceChangerHearMyselfActive = not FFlagEnablePartyVoiceChangersInLua and nil,
            selectedVoicePack = if FFlagEnablePartyVoiceChangersInLua then arg3.selectedVoicePack else nil
        })
        arg1:dispatch(Actions.ParticipantAdded(var1))
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_PARTICIPANT_REMOVED, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant removed {}", self.experienceType, arg3.userId)
        end
        arg1:dispatch(Actions.ParticipantRemoved((func1(arg3))))
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_PARTICIPANT_IS_ACTIVE, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant is active {}", self.experienceType, arg3.userId)
        end
        arg1:dispatch(Actions.ParticipantIsActive((func1(arg3))))
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_PARTICIPANT_IS_INACTIVE, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant is inactive {}", self.experienceType, arg3.userId)
        end
        arg1:dispatch(Actions.ParticipantIsInactive((func1(arg3))))
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_PARTICIPANT_WAS_MUTED, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant is was muted {}", self.experienceType, arg3.userId)
        end
        arg1:dispatch(Actions.ParticipantWasMuted((func1(arg3))))
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_PARTICIPANT_WAS_UNMUTED, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant is was unmuted {}", self.experienceType, arg3.userId)
        end
        arg1:dispatch(Actions.ParticipantWasUnmuted((func1(arg3))))
    end)

    if FFlagEnablePartyVoiceChangersInLua then
        self:addObserver(Constants.EVENTS.PARTY_VOICE_CHANGER_WAS_ENABLED, function(arg3)
            if arg2 and bool1 then
                arg2:info("{}: Participant voice changer was enabled {}", self.experienceType, arg3.userId)
            end
            arg1:dispatch(Actions.VoiceChangerWasEnabled((func1(arg3))))
        end)

        self:addObserver(Constants.EVENTS.PARTY_VOICE_CHANGER_WAS_DISABLED, function(arg3)
            if arg2 and bool1 then
                arg2:info("{}: Participant voice changer was disabled {}", self.experienceType, arg3.userId)
            end
            arg1:dispatch(Actions.VoiceChangerWasDisabled((func1(arg3))))
        end)

        self:addObserver(Constants.EVENTS.PARTY_VOICE_PACK_WAS_SET, function(arg3)
            if arg2 and bool1 then
                arg2:info("{}: Participant {} voice pack was set to {}", self.experienceType, arg3.userId, arg3.voicePackName)
            end

            arg1:dispatch(
                Actions.VoicePackWasSet(
                    {
                        userId = tonumber(arg3.userId) or -1,
                        isLocalUser = arg3.isLocalUser,
                        voicePackName = arg3.voicePackName
                    }
                )
            )
        end)
        self:addObserver(Constants.EVENTS.PARTY_VOICE_CHANGER_FEEDBACK_WAS_ENABLED, function(arg3)
            if arg2 and bool1 then
                arg2:info("{}: Participant voice changer feedback was enabled {}", self.experienceType, arg3.userId)
            end

            arg1:dispatch(Actions.VoiceChangerFeedbackWasEnabled((func1(arg3))))
        end)

        self:addObserver(Constants.EVENTS.PARTY_VOICE_CHANGER_FEEDBACK_WAS_DISABLED, function(arg3)
            if arg2 and bool1 then
                arg2:info("{}: Participant voice changer feedback was disabled {}", self.experienceType, arg3.userId)
            end

            arg1:dispatch(Actions.VoiceChangerFeedbackWasDisabled((func1(arg3))))
        end)
    end

    self:addObserver(Constants.EVENTS.MUTE_PARTY_VOICE_PARTICIPANT, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant is muted locally {}", self.experienceType, arg3.userId)
        end
        arg1:dispatch(Actions.MuteParticipant((func1(arg3))))
    end)

    self:addObserver(Constants.EVENTS.UNMUTE_PARTY_VOICE_PARTICIPANT, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant is unmuted locally {}", self.experienceType, arg3.userId)
        end
        arg1:dispatch(Actions.UnmuteParticipant((func1(arg3))))
    end)

    if not FFlagPartyVoiceBlockSync then
        return
    end

    self:addObserver(Constants.EVENTS.PARTY_VOICE_BLOCK_PARTICIPANT, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant was blocked {} from party voice", self.experienceType, arg3.userId)
        end
    end)

    self:addObserver(Constants.EVENTS.PARTY_VOICE_UNBLOCK_PARTICIPANT, function(arg3)
        if arg2 and bool1 then
            arg2:info("{}: Participant was unblocked {} from party voice", self.experienceType, arg3.userId)
        end
    end)
end

function module:getBackgroundStateSnapshot()
    local var1 = persistenceMiddleware.restore()

    if not (var1 and var1.Squad and var1.Squad.CrossExperienceVoice) then
        return nil
    end

    return {
        Experience = var1.Squad.CrossExperienceVoice.Experience,
        Participants = {
            participants = Utils.stringMapToNumberMap(var1.Squad.CrossExperienceVoice.Participants.participants),
            activeUserIds = var1.Squad.CrossExperienceVoice.Participants.activeUserIds,
            publicVoiceFocusedUserIds = Utils.stringMapToNumberMap(var1.Squad.CrossExperienceVoice.Participants.publicVoiceFocusedUserIds)
        }
    }
end

function module:restoreStateFromBackground(arg1, arg2)
    local backgroundStateSnapshot = self:getBackgroundStateSnapshot()
    if not backgroundStateSnapshot then
        return
    end

    if arg2 and bool1 then
        arg2:info(
            "{}: Restoring state from background {}",
            self.experienceType,
            HttpService:JSONEncode(backgroundStateSnapshot)
        )
    end

    arg1:dispatch(Actions.RestoreState(backgroundStateSnapshot))
end

function module:unsubscribe(arg1, arg2)
    if arg2 and bool1 then
        arg2:info("{}: Unsubscribing from the CEV Store", self.experienceType)
    end
    arg1:dispatch(Actions.ExperienceLeft())
    for _, observer in ipairs(self.observers) do
        self:removeObserver(observer.id, observer.event)
    end
    self.isSubscribed = false
    self.observers = {}
    self.eventQueue:reset()
end

return module
